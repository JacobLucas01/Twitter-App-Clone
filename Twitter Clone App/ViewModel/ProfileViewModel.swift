//
//  ProfileViewModel.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 9/3/22.
//

import Foundation
import Firebase

class ProfileViewModel: ObservableObject {
    
    @Published var user: User
    @Published var userTweets = [Tweet]()
    @Published var likedTweets = [Tweet]()
    
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
        fetchUserTweets()
        fetchLikedTweets()
        fetchUserStats()
    }
    
    func tweets(forFilter filter: TweetFilterOptions) -> [Tweet] {
        switch filter {
        case .tweets: return userTweets
        case .likes: return likedTweets
        }
    }
}

extension ProfileViewModel {
    
    func follow() {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        
        let followingRef = COLLECTION_FOLLOWING.document(currentUID).collection("user_following")
        let followersRef = COLLECTION_FOLLOWING.document(user.id).collection("user_followers")
        
     followingRef.document(user.id).setData([:]) { _ in
           followersRef.document(currentUID).setData([:]) { _ in
               self.user.isFollowed = true
            }
        }
    }
    
    func unfollow() {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        
        let followingRef = COLLECTION_FOLLOWING.document(currentUID).collection("user_following")
        let followersRef = COLLECTION_FOLLOWING.document(user.id).collection("user_followers")
        
        followingRef.document(user.id).delete() { _ in
            followersRef.document(currentUID).delete() { _ in
                self.user.isFollowed = false
            }
        }
    }
    
    func checkIfUserIsFollowed() {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        guard !user.isCurrentUser else { return }
        let followingRef = COLLECTION_FOLLOWING.document(currentUID).collection("user_following")
        
        followingRef.document(user.id).getDocument { snapshot, _ in
            guard let isFollowed = snapshot?.exists else { return }
            self.user.isFollowed = isFollowed
        }
    }
    
    func fetchUserTweets() {
        COLLECTION_TWEETS.whereField("uid", isEqualTo: user.id).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.userTweets = documents.map({Tweet(dictionary: $0.data())})
            
        }
    }
    
    func fetchLikedTweets() {
        var tweets = [Tweet]()
        COLLECTION_USERS.document(user.id).collection("user_likes").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let tweetIDs = documents.map({ $0.documentID})
            tweetIDs.forEach { id in
                COLLECTION_TWEETS.document(id).getDocument { snapshot, _ in
                    guard let data = snapshot?.data() else { return }
                    let tweet = Tweet(dictionary: data)
                    tweets.append(tweet)
                    guard tweets.count == tweetIDs.count else { return }
                    
                    self.likedTweets = tweets
                }
            }
        }
    }
    
    func fetchUserStats() {
        let followersRef = COLLECTION_FOLLOWERS.document(user.id).collection("user_followers")
        let followingRef = COLLECTION_FOLLOWING.document(user.id).collection("user_following")
        
        followersRef.getDocuments { snapshot, _ in
            guard let followerCount = snapshot?.documents.count else { return }
            
            followingRef.getDocuments { snapshot, _ in
                guard let followingCount = snapshot?.documents.count else { return }
                self.user.stats = UserStats(followers: followerCount, following: followingCount)
            }
        }
    }
}
