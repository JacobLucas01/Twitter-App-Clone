//
//  FeedViewModel.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 9/5/22.
//

import Foundation
import SwiftUI

class FeedViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {
        COLLECTION_TWEETS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            self.tweets = documents.map({ Tweet(dictionary: $0.data())})
        }
    }
}
