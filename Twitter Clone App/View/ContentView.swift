//
//  ContentView.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 6/20/22.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    
    @State var page: Int = 0
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
            if viewModel.userSession != nil {
                NavigationView {
                    ZStack {
                        FeedView()
                            .opacity(page == 0 ? 1.0 : 0)
                        SearchView()
                            .opacity(page == 1 ? 1.0 : 0)
                        ConversationView()
                            .opacity(page == 2 ? 1.0 : 0)
                        MenuView(page: $page)
                    }
                }
            } else {
                LoginView()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
