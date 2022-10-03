//
//  Message.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 9/8/22.
//

import Foundation
import SwiftUI
import Firebase

struct Message: Identifiable {
    let text: String
    let user: User
    let toID: String
    let fromID: String
    let isFromCurrentUser: Bool
    let timestamp: Timestamp
    let id: String
    
    var chatPartnerID: String { return isFromCurrentUser ? toID : fromID }
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        
        self.text = dictionary["text"] as? String ?? ""
        self.toID = dictionary["to_id"] as? String ?? ""
        self.fromID = dictionary["from_id"] as? String ?? ""
        self.isFromCurrentUser = fromID == Auth.auth().currentUser?.uid
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.id = dictionary["id"] as? String ?? ""
    }
}
