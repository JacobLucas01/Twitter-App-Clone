//
//  NewTweetsView.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 6/25/22.
//

import SwiftUI
import Kingfisher

struct NewTweetsView: View {
    
    @State var captionText: String = ""
    
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: UploadTweetViewModel
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        self.viewModel = UploadTweetViewModel(isPresented: isPresented)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    if let user = AuthViewModel.shared.user {
                        KFImage(URL(string: user.profileImageURL))
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: 64, height: 64)
                            .cornerRadius(32)
                    }
                    TextArea("What's Happening?", text: $captionText)
                    Spacer()
                }
                .padding()
                .navigationBarItems(leading: Button(action: {
                    self.isPresented.toggle()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.blue)
                }), trailing: Button(action: {
                    viewModel.uploadTweet(caption: captionText)
                }, label: {
                    Text("Tweet")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }))
                Spacer()
            }
        }
    }
}

struct NewTweetsView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetsView(isPresented: .constant(false))
    }
}
