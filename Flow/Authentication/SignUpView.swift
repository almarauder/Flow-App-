//
//  SignUpView.swift
//  Flow
//
//  Created by Darking Almas on 07.11.2025.
//

import SwiftUI

@MainActor
final class SignUpModelView: ObservableObject {
    
    @Published var Name = ""
    @Published var Surname = ""
    @Published var PhoneNumber = ""
    @Published var Email = ""
    @Published var Password = ""
    @Published var PasswordConfirm = ""
    
    func signUp() async throws {
        guard !Email.isEmpty , !Password.isEmpty else {
            print("No email or password found.")
            return
        }
        guard Password == PasswordConfirm && !Password.isEmpty else {
            print("Password does not match")
            return
        }
        
        try await AuthenticationManager.shared.createUser(email: Email, password: Password)
    }
    
}

struct SignUpView: View {
    @StateObject private var viewModel = SignUpModelView()
    @State private var isPasswordVisible = false
    @State private var isPasswordConfirmVisible = false
    @State private var agreeToTerms = false
    
    @State private var showSignIn = false
    @State private var showTerms = false
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("MainMobileColor")
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Text("Добро Пожаловать!")
                        .font(.system(size: 32))
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.top, 50)
                        .padding(.bottom, 50)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 24) {
                            Group {
                                fieldView(title: "Имя", text: $viewModel.Name, placeholder: "Имя")
                                fieldView(title: "Фамилия", text: $viewModel.Surname, placeholder: "Фамилия")
                                fieldView(title: "Номер Телефона", text: $viewModel.PhoneNumber, placeholder: "+7 (")
                                fieldView(title: "Почта", text: $viewModel.Email, placeholder: "Email")
                            }
                            
                            passwordField(title: "Пароль", text: $viewModel.Password)
                            passwordField(title: "Подтверждение Пароль", text: $viewModel.PasswordConfirm)

                            HStack(alignment: .top, spacing: 12) {
                                Button(action: {
                                    agreeToTerms.toggle()
                                }) {
                                    Image(systemName: agreeToTerms ? "checkmark.square.fill" : "square")
                                        .foregroundColor(Color("MainMobileColor"))
                                        .font(.system(size: 20))
                                }
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Соглашаюсь с условиями")
                                        .font(.system(size: 15))
                                        .foregroundColor(.black)
                                    
                                    Button(action: {
                                        // Open terms
                                    }) {
                                        Text("Пользовательского соглашения")
                                            .font(.system(size: 15))
                                            .foregroundColor(Color("MainMobileColor"))
                                            .underline()
                                    }
                                }
                            }
                            .padding(.top, 8)
                            .frame(maxWidth: .infinity)

                            Button(action : {
                                // Sign Up
                            }) {
                                Text("Регистрация")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(width: 207 , height: 50 , alignment: .center)
                                    .background(Color("MainMobileColor"))
                                    .cornerRadius(25)
                            }
                            .frame(maxWidth: .infinity)
                            
                            Button(action: {
                                showSignIn = true
                            }) {
                                Text("Аккаунт уже имеется")
                                    .font(.system(size: 15))
                                    .foregroundColor(.gray)
                                    .underline()
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 8)
                            .padding(.bottom, 30)
                        }
                        .padding(.horizontal, 32)
                        .padding(.top, 40)
                        .background(.white)
                        .cornerRadius(30, corners: [.topLeft, .topRight])
                        .padding(.top, 60)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .cornerRadius(30, corners: [.topLeft, .topRight])
                    .ignoresSafeArea(edges: .bottom)
                    
                    .navigationDestination(isPresented: $showSignIn) {
                        SignInView(showSignInView: $showSignInView)
                    }
                }
            }
        }
    }
    
    private func fieldView(title: String, text: Binding<String>, placeholder: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 20))
                .bold()
            TextField(placeholder, text: text)
                .padding()
                .background(Color(red: 0.95, green: 0.95, blue: 0.96))
                .cornerRadius(12)
        }
    }
    
    private func passwordField(title: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 20))
                .bold()
            HStack {
                if isPasswordVisible {
                    TextField("", text: text)
                } else {
                    SecureField("••••••••", text: text)
                        .font(.system(size: 20))
                }
                Button {
                    isPasswordVisible.toggle()
                } label: {
                    Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                        .foregroundStyle(.gray)
                }
            }
            .padding()
            .background(Color(red: 0.95, green: 0.95, blue: 0.96))
            .cornerRadius(12)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignUpView(showSignInView: .constant(false))
        }
    }
}
