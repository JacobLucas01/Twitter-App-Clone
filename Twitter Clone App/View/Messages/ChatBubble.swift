//
//  ChatBubble.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 6/22/22.
//

import SwiftUI

struct ChatBubble: Shape {
    var isFromCurrentUser: Bool
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight, isFromCurrentUser ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 18, height: 18))
        return(Path(path.cgPath))
    }
}

struct ChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        ChatBubble(isFromCurrentUser: false)
    }
}
