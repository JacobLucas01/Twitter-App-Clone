//
//  AuthViewModel.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 7/14/22.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage

class AuthViewModel: ObservableObject {
    
    @Published var userSession: Firebase.User?
    @Published var isAuthenticating = false
    @Published var error: Error?
    @Published var user: User?
    
    static let shared = AuthViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to login \(error.localizedDescription)")
                return
            }
            
            self.userSession = result?.user
            self.fetchUser()
        }
    }
    
    func register(email: String, password: String, username: String, fullname: String, profileImage: UIImage) {
        print("DEBUG: Email is \(email)")
        print("DEBUG: password is \(password)")
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child(filename)
        
        storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG: Failed to upload image \(error.localizedDescription)")
                return
            }
            
            storageRef.downloadURL { url, _ in
                guard let profileImageURL = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        print("DEBUG: Error \(error.localizedDescription)")
                        return
                    }
                    
                    guard let user = result?.user else { return }
                    
                    let data = [
                        "email": email,
                        "username": username.lowercased(),
                        "fullname": fullname,
                        "profile_image_url": profileImageURL,
                        "uid": user.uid
                    ]
                    
                    Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                        self.userSession = user
                        self.fetchUser()
                    }
                    
                    print("DEBUG: Successfully signed up user")
                }
            }
        }
    }
    
    func signOut() {
        userSession = nil
        user = nil
        try? Auth.auth().signOut()
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let data = snapshot?.data() else { return }
            self.user = User(dictionary: data)
        }
    }
}
