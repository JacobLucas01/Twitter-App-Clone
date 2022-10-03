//
//  ConversationView.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 6/21/22.
//

import SwiftUI

struct ConversationView: View {
    
    @State var user: User?
    @State var showChat = false
    @State var isShowingNewMessageView = false
    
    @ObservedObject var viewModel = ConversationsViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Text("Conversations")
                    .font(.system(size: 22, weight: .semibold))
                    .padding(10)
                Divider()
            }
            ZStack(alignment: .bottomTrailing) {
                if let user = user {
                    NavigationLink(destination: LazyView(ChatView(user: user)), isActive: $showChat, label: {})
                }
                ScrollView {
                    ForEach(viewModel.recentMessages) { message in
                        NavigationLink {
                            LazyView(ChatView(user: message.user))
                        } label: {
                            ConversationCell(user: message.user)
                        }
                    }
                }
                HStack {
                    Spacer()
                    Button {
                        self.isShowingNewMessageView.toggle()
                    } label: {
                        Image(systemName: "envelope")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 28, height: 28)
                            .padding()
                    }
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
                }
                .offset(y: -60)
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $isShowingNewMessageView) {
            self.showChat.toggle()
        } content: {
            NewMessageView(show: $isShowingNewMessageView, user: $user)
        }
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView()
    }
}
