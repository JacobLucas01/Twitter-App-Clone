//
//  DetailView.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 9/5/22.
//

import SwiftUI
import Kingfisher

struct TweetDetailView: View {
    
    let tweet: Tweet
    
    @Environment(\.presentationMode) var present
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    present.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(Color(.label))
                }
                Spacer()
            }
            .padding()
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    KFImage(URL(string: tweet.profileImageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                    VStack(alignment: .leading, spacing: 4) {
                        Text(tweet.fullname)
                            .font(.system(size: 14, weight: .semibold))
                        Text("@\(tweet.username)")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                }
                Text(tweet.caption)
                    .font(.system(size: 22))
                Divider()
                TweetActionsView(tweet: tweet)
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var caption: String = "j"
    static var previews: some View {
        TweetDetailView(tweet: Tweet(dictionary: ["caption" : caption]))
    }
}
