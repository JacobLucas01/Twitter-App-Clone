//
//  NewMessageView.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 6/23/22.
//

import SwiftUI

struct NewMessageView: View {
    
    @State var searchText = ""
    @Binding var show: Bool
    @Binding var user: User?
    @ObservedObject var viewModel = SearchViewModel(config: .newMessage)
    
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText)
                .padding()
            VStack(alignment: .leading) {
                ForEach(searchText.isEmpty ? viewModel.users : viewModel.filteredUsers(searchText)) { user in
                    HStack { Spacer() }
                    Button {
                        self.show.toggle()
                        self.user = user
                    } label: {
                        UserCell(user: user)
                    }
                }
            }
            .padding(.leading)
        }
    }
}
