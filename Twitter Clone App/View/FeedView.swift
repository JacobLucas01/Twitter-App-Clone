//
//  FeedView.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 6/20/22.
//

import SwiftUI
import Kingfisher

struct FeedView: View {
    
    @State var isShowingNewTweetView = false
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Text("Feed")
                    .font(.system(size: 22, weight: .semibold))
                    .padding(10)
                Divider()
            }
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    ForEach(viewModel.tweets) { tweet in
                        VStack {
                            NavigationLink {
                                TweetDetailView(tweet: tweet)
                            } label: {
                                TweetCell(tweet: tweet)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                }
                HStack {
                    Spacer()
                    Button { self.isShowingNewTweetView.toggle() } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding()
                            .background(Color(.systemBlue))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .padding()
                    .fullScreenCover(isPresented: $isShowingNewTweetView) {
                        NewTweetsView(isPresented: $isShowingNewTweetView)
                    }
                }
                .offset(y: -60)
            }
            .navigationBarHidden(true)
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
