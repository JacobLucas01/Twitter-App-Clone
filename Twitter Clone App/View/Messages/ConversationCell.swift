//
//  ConversationCell.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 6/21/22.
//

import SwiftUI
import Kingfisher

struct ConversationCell: View {
    
    let user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 12) {
                KFImage(URL(string: user.profileImageURL))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(user.fullname)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(.label))
                    Text(user.username)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(.label))
                }
            }
            .padding()
            Divider()
        }
        .navigationBarHidden(true)
    }
}

