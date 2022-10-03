//
//  TweetActionViewModel.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 9/5/22.
//

import Foundation
import Firebase

class TweetActionViewModel: ObservableObject {
    
    let tweet: Tweet
    
    @Published var didLike = false
    
    init(tweet: Tweet) {
        self.tweet = tweet
        checkIfUserLikedTweet()
    }
    
    func likeTweet() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let tweetRef = COLLECTION_TWEETS.document(tweet.id).collection("tweet_likes")
        let userLikesRef = COLLECTION_USERS.document(uid).collection("user_likes")
        
        COLLECTION_TWEETS.document(tweet.id).updateData(["likes": tweet.likes + 1]) { _ in
            tweetRef.document(uid).setData([:]) { _ in
                userLikesRef.document(self.tweet.id).setData([:]) { _ in
                    self.didLike = true
                }
            }
        }
    }
    
    func unlikeTweet() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let tweetRef = COLLECTION_TWEETS.document(tweet.id).collection("tweet_likes")
        let userLikesRef = COLLECTION_USERS.document(uid).collection("user_likes")
        
        COLLECTION_TWEETS.document(tweet.id).updateData(["likes": tweet.likes - 1]) { _ in
            tweetRef.document(uid).delete { _ in
                userLikesRef.document(self.tweet.id).delete { _ in
                    self.didLike = false
                }
            }
        }
        
    }
    
    func checkIfUserLikedTweet() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let userLikesRef = COLLECTION_USERS.document(uid).collection("user_likes").document(tweet.id)
        
        userLikesRef.getDocument { snapshot, _ in
            guard let didLike = snapshot?.exists else { return }
            self.didLike = didLike
        }
    }
}
