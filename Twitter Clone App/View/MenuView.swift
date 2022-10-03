//
//  MenuView.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 9/11/22.
//

import SwiftUI

struct MenuView: View {
    @Binding var page: Int
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 0) {
                Divider()
                HStack {
                    
                    Button {
                        page = 0
                    } label: {
                        if page == 0 {
                            Image(systemName: "house")
                                .font(.title2)
                                .foregroundColor(Color(.label))
                        } else {
                            Image(systemName: "house")
                                .font(.title2)
                                .foregroundColor(Color(.systemGray3))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    Button {
                        page = 1
                    } label: {
                        if page == 1 {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(Color(.label))
                        } else {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(Color(.systemGray3))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    Button {
                        page = 2
                    } label: {
                        if page == 2 {
                            Image(systemName: "message")
                                .font(.title2)
                                .foregroundColor(Color(.label))
                        } else {
                            Image(systemName: "message")
                                .font(.title2)
                                .foregroundColor(Color(.systemGray3))
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.vertical, 18)            }
            .background(colorScheme == .dark ? Color.black : Color.white)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(page: .constant(3))
    }
}

