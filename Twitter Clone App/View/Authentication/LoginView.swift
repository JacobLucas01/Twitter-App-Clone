//
//  LoginView.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 6/29/22.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack(spacing: 20) {
                        HStack {
                            Text("Welcome back.")
                                .font(.system(size: 23, weight: .medium))
                                .padding(.horizontal)
                                .padding(.vertical)
                            Spacer()
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 1)
                                .frame(width: UIScreen.main.bounds.width - 30, height: 46)
                                .foregroundColor(.gray)
                                .opacity(0.5)
                            TextField("email", text: $email)
                                .cornerRadius(4)
                                .padding(.horizontal, 28)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 1)
                                .frame(width: UIScreen.main.bounds.width - 30, height: 46)
                                .foregroundColor(.gray)
                                .opacity(0.5)
                            SecureField("password", text: $password)
                                .cornerRadius(4)
                                .padding(.horizontal, 28)
                        }
                    }
                    HStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("Forgot Password")
                                .font(.system(size: 16, weight: .medium))
                        }
                    }
                    .padding()
                    Button {
                        viewModel.login(withEmail: email, password: password)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 1)
                                .frame(width: UIScreen.main.bounds.width - 30, height: 46)
                            Text("Login")
                                .font(.system(size: 18, weight: .medium))
                        }
                    }
                }
                VStack {
                    Spacer()
                    NavigationLink {
                        RegistrationView().navigationBarHidden(true)
                    } label: {
                        Text("Don't have an account? Sign Up")
                            .font(.system(size: 16, weight: .medium))
                    }
                    .padding(.bottom)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
