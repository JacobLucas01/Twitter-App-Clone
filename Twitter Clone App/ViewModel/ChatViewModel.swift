//
//  ChatViewModel.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 9/8/22.
//

import Foundation
import Firebase

class ChatViewModel: ObservableObject {
    
    let user: User
    @Published var messages = [Message]()
    
    init(user: User) {
        self.user = user
        fetchMessages()
    }
    
    func fetchMessages() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let query = COLLECTION_MESSAGES.document(uid).collection(user.id)
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            changes.forEach { change in
                let messageData = change.document.data()
                guard let fromID = messageData["from_id"] as? String else { return }
                
                COLLECTION_USERS.document(fromID).getDocument { snapshot, _ in
                    guard let data = snapshot?.data() else { return }
                    let user = User(dictionary: data)
                    self.messages.append(Message(user: user, dictionary: messageData))
                    self.messages.sort(by: {$0.timestamp.dateValue() < $1.timestamp.dateValue()})
                }
            }
        }
    }
    
    func sendMessages(_ messageText: String) {
        guard let currentUID = AuthViewModel.shared.userSession?.uid else { return }
        let currentUserRef = COLLECTION_MESSAGES.document(currentUID).collection(user.id).document()
        let receivingUserRef = COLLECTION_MESSAGES.document(user.id).collection(currentUID)
        let receivingRecentRef = COLLECTION_MESSAGES.document(user.id).collection("recent_messages")
        let currentRecentRef = COLLECTION_MESSAGES.document(currentUID).collection("recent_messages")
        let messageID = currentUserRef.documentID
        
        let data: [String: Any] = [
            "text" : messageText,
            "id" : messageID,
            "from_id" : currentUID,
            "current_id" : user.id,
            "timestamp" : Timestamp(date: Date())
        ]
        
        currentUserRef.setData(data)
        receivingUserRef.document(messageID).setData(data)
        receivingRecentRef.document(currentUID).setData(data)
        currentRecentRef.document(user.id).setData(data)
    }
}
