//
//  ProfileHeader.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 6/23/22.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    
    @State var selectedFilter: TweetFilterOptions = .tweets
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack {
            KFImage(URL(string: viewModel.user.profileImageURL))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .clipShape(Circle())
            Text(viewModel.user.fullname)
                .font(.system(size: 16, weight: .semibold))
                .padding(.top, 8)
            Text("@\(viewModel.user.username)")
                .font(.subheadline)
                .foregroundColor(.gray)
            HStack(spacing: 40) {
                VStack {
                    Text("\(viewModel.user.stats.followers)")
                        .font(.system(size: 16, weight: .bold))
                    Text("Followers")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                VStack {
                    Text("\(viewModel.user.stats.following)")
                        .font(.system(size: 16, weight: .bold))
                    Text("Following")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            ProfileActionButtonView(viewModel: viewModel)
            Spacer()
        }
    }
}

//struct ProfileHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileHeaderView()
//    }
//}
