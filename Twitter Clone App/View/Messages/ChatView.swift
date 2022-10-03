//
//  ChatView.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 6/22/22.
//

import SwiftUI

struct ChatView: View {
    
    let user: User
    
    @State var messageText = ""
    @ObservedObject var viewModel: ChatViewModel
    
    @Environment(\.presentationMode) var present
    
    init(user: User) {
        self.user = user
        self.viewModel = ChatViewModel(user: user)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text(user.username)
                    .font(.system(size: 18, weight: .semibold))
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
            }
            Divider()
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(viewModel.messages) { message in
                        MessageView(message: message)
                            .padding(.vertical, 6)
                    }
                }
            }
            MessageInputView(messageText: $messageText, action: sendMessage)
                .padding()
        }
        .navigationBarHidden(true)
    }
    
    func sendMessage() {
        viewModel.sendMessages(messageText)
        messageText = ""
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: User(dictionary: ["":""]))
    }
}
