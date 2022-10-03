//
//  MessageInputView.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 6/22/22.
//

import SwiftUI

struct MessageInputView: View {
    
    @Binding var messageText: String
    
    var action: () -> Void
    
    var body: some View {
        HStack {
            TextField("message", text: $messageText)
                .textFieldStyle(PlainTextFieldStyle())
                .frame(minHeight: 30)
            Button {
                action()
            } label: {
                Text("Send")
                    .fontWeight(.medium)
            }
        }
    }
}
