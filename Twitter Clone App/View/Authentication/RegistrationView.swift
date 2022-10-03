//
//  RegistrationView.swift
//  Twitter Clone
//
//  Created by Jacob Lucas on 7/12/22.
//

import SwiftUI

struct RegistrationView: View {
    
    @State var email = ""
    @State var password = ""
    @State var fullname = ""
    @State var username = ""
    @State var showImagePicker = false
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    @EnvironmentObject var viewModel: AuthViewModel
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    func loadImage() {
        guard let selectedImage = selectedUIImage else { return }
        image = Image(uiImage: selectedImage)
    }
    
    var body: some View {
        ZStack {
            VStack {
                Button {
                    self.showImagePicker.toggle()
                } label: {
                    ZStack {
                        if let image = image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                                .opacity(0.5)
                        }
                    }
                }
                .padding(.bottom, 28)
                .sheet(isPresented: $showImagePicker) {
                    self.loadImage()
                } content: {
                    ImagePicker(image: $selectedUIImage)
                }
                
                VStack(spacing: 20) {
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
                        TextField("full name", text: $fullname)
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
                        TextField("username", text: $username)
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
                .padding(.bottom, 28)
                Button {
                    guard let image = selectedUIImage else { return }
                    viewModel.register(email: email, password: password, username: username, fullname: fullname, profileImage: image)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                            .frame(width: UIScreen.main.bounds.width - 30, height: 46)
                        Text("Sign Up")
                            .font(.system(size: 18, weight: .medium))
                    }
                }
            }
            VStack {
                Spacer()
                HStack {
                    Text("Have an account? Sign In")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.blue)
                }
                .padding(.bottom)
                .onTapGesture {
                    mode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
