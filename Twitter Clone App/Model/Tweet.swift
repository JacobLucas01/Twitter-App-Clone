//
//  Tweet.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 9/5/22.
//

import Foundation
import Firebase

struct Tweet: Identifiable {
    let id: String
    let username: String
    let profileImageURL: String
    let fullname: String
    let caption: String
    let likes: Int
    let uid: String
    let timestamp: Timestamp
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageURL = dictionary["profile_image_url"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["like"] as? Int ?? 0
        self.uid = dictionary["uid"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: timestamp.dateValue(), to: Date()) ?? ""
    }
    
    var detailedTimestampString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a · MM/dd/yyyy"
        return formatter.string(from: timestamp.dateValue())
    }
}
