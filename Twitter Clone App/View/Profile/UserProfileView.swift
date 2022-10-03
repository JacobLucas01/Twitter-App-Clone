//
//  UserProfile.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 6/23/22.
//

import SwiftUI

struct UserProfileView: View {
    
    let user: User
    @State var selectedFilter: TweetFilterOptions = .tweets
    @ObservedObject var viewModel: ProfileViewModel
    
    @Environment(\.presentationMode) var present
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }
    
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
            ScrollView {
                VStack {
                    ProfileHeaderView(viewModel: viewModel)
                        .padding()
                    
                    FilterButtonView(selectedOption: $selectedFilter)
                        .padding()
                    
                    ForEach(viewModel.tweets(forFilter: selectedFilter)) { tweet in
                        TweetCell(tweet: tweet)
                            .padding(30)
                    }
                    .padding(.vertical)
                }
                .navigationBarHidden(true)
            }
        }
    }
}
