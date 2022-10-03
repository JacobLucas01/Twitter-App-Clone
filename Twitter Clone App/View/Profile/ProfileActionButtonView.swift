//
//  ProfileActionButtonView.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 6/23/22.
//

import SwiftUI

struct ProfileActionButtonView: View {
    
    @ObservedObject var auth = AuthViewModel()
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        if viewModel.user.isCurrentUser {
            HStack {
                Button {
                    auth.signOut()
                    auth.userSession = nil
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                            .frame(width: 160, height: 38)
                            .foregroundColor(.blue)
                        Text("Sign Out")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.blue)
                    }
                }
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                            .frame(width: 160, height: 38)
                            .foregroundColor(.purple)
                        Text("Edit Profile")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.purple)
                    }
                }
            }
        } else {
            HStack {
                Button {
                    viewModel.user.isFollowed ? viewModel.unfollow() : viewModel.follow()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                            .frame(width: 160, height: 38)
                            .foregroundColor(.blue)
                        Text(viewModel.user.isFollowed ? "Following" : "Follow")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.blue)
                    }
                }
                NavigationLink {
                    ChatView(user: viewModel.user)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                            .frame(width: 160, height: 38)
                            .foregroundColor(.purple)
                        Text("Message")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.purple)
                    }
                }
            }
        }
    }
}
