//
//  UploadTweetViewModel.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 9/5/22.
//

import Foundation
import SwiftUI

class UploadTweetViewModel: ObservableObject {
    
    @Binding var isPresented: Bool
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    func uploadTweet(caption: String) {
        guard let user = AuthViewModel.shared.user else { return }
        let docRef = COLLECTION_TWEETS.document()
        print("DEBUG: Upload tweet")
        
        let data: [String: Any] = [
            "uid": user.id,
            "caption": caption,
            "fullname": user.fullname,
            "username": user.username,
            "profile_image_url": user.profileImageURL,
            "like": 0,
            "id": docRef.documentID
        ]
        
        docRef.setData(data) { _ in
            self.isPresented = false
        }
    }
}
