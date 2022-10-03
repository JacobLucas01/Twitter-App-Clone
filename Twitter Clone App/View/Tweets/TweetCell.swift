//
//  TweetCell.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 6/20/22.
//

import SwiftUI
import Kingfisher

struct TweetCell: View {
    
    let tweet: Tweet
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 12) {
                KFImage(URL(string: tweet.profileImageURL))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
                    .padding(.leading)
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(tweet.fullname)
                        .font(.system(size: 14, weight: .semibold))
                        Text("@\(tweet.username)")
                            .foregroundColor(.gray)
                    }
                    Text(tweet.caption)
                }
                Spacer(minLength: 0)
            }
            .padding(.bottom)
            .padding(.trailing)
            TweetActionsView(tweet: tweet)
            
            Divider()
        }
        .padding(.top)
        .padding(.leading, -16)
    }
}

struct TweetCell_Previews: PreviewProvider {
    static var caption: String = ""
    static var previews: some View {
        TweetCell(tweet: Tweet(dictionary: ["" : caption]))
    }
}
