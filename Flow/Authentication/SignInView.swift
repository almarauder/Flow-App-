//
//  SignInView.swift
//  Flow
//
//  Created by Darking Almas on 07.11.2025.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        guard !email.isEmpty , !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}

struct SignInView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignInView: Bool
    
    @State private var isPasswordVisible = false
    @State private var showForgotPasswordView = false
    
    var body: some View {
        ZStack {
            Color("MainMobileColor")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text("С Возвращением!")
                    .font(.system(size: 40))
                    .bold()
                    .foregroundStyle(Color.white)
                    .padding(.top, 50)
                    .padding(.bottom, 50)

                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Почта или номер телефона")
                            .font(.system(size: 20))
                            .bold()
                        
                        TextField("Email", text: $viewModel.email)
                            .padding()
                            .textContentType(.emailAddress)
                            .background(Color(red: 0.95, green: 0.95, blue: 0.96))
                            .cornerRadius(12)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Пароль")
                            .font(.system(size: 20))
                            .bold()
                        
                        HStack {
                            if isPasswordVisible {
                                TextField("", text: $viewModel.password)
                            } else {
                                SecureField("••••••••", text: $viewModel.password)
                                    .font(.system(size: 20))
                            }
                            
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding()
                        .background(Color(red: 0.95, green: 0.95, blue: 0.96))
                        .cornerRadius(12)
                    }

                    HStack {
                        Spacer()
                        Button(action: {
                            // Forgot password
                        }) {
                            Text("Забыли Пароль?")
                                .bold()
                                .foregroundStyle(Color.gray)
                                .underline()
                        }
                    }
                    .padding(.top, 8)

                    Button(action: {
                        Task {
                            do {
                                try await viewModel.signIn()
                                showSignInView = false
                                return
                            } catch {
                                print(error)
                            }
                        }
                    }) {
                        Text("Вход")
                            .frame(alignment: .center)
                            .font(.system(size: 17, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 207)
                            .padding(.vertical, 14)
                            .background(Color("MainMobileColor"))
                            .clipShape(Capsule())
                    }
                    .frame(maxWidth: .infinity , alignment: .center)
                    .padding(.top, 35)
                    
                    Spacer()
                }
                .padding(.horizontal, 32)
                .padding(.top, 40)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .ignoresSafeArea(edges: .bottom)
                
                
            }
        }
    }
}

// Custom rounded top corners only
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = 0.0
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInView(showSignInView: .constant(false))
        }
    }
}
