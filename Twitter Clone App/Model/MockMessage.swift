//
//  MockMessage.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 6/22/22.
//

import Foundation

struct MockMessage: Identifiable {
    let id: Int
    let imageName: String
    let messageText: String
    let isCurrentUser: Bool
}

let MOCK_MESSAGE: [MockMessage] = [
    .init(id: 0, imageName: "person.crop.circle.fill", messageText: "Hey, what's up?", isCurrentUser: false),
    .init(id: 1, imageName: "person.crop.circle.fill", messageText: "Nothing much, wby?", isCurrentUser: true),
    .init(id: 2, imageName: "person.crop.circle.fill", messageText: "Chilling 🥶", isCurrentUser: false),
    .init(id: 3, imageName: "person.crop.circle.fill", messageText: "Nice", isCurrentUser: true)
]
