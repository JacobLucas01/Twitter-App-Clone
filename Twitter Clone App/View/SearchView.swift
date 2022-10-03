//
//  SearchView.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 6/21/22.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText = ""
    
    @ObservedObject var viewModel = SearchViewModel(config: .search)
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Text("Search")
                    .font(.system(size: 22, weight: .semibold))
                    .padding(10)
                Divider()
            }
            ScrollView {
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                    .padding(.top)
                VStack(alignment: .leading) {
                    ForEach(searchText.isEmpty ? viewModel.users : viewModel.filteredUsers(searchText)) { user in
                        HStack { Spacer() }
                        NavigationLink(destination: LazyView(UserProfileView(user: user)), label: {
                            ConversationCell(user: user)
                        })
                    }
                }
                .padding(.leading)
                .navigationBarHidden(true)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
