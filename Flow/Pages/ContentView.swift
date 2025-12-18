//
//  ContentView.swift
//  Flow
//
//  Created by Darking Almas on 07.11.2025.
//

import SwiftUI

struct Buttons: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.white)
            .clipShape(Capsule())
    }
}

struct ContentView: View {
    @State private var showSignIn = false
    @State private var showSignUp = false
    @State private var showForgotPassword = false
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("MainMobileColor")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30) {
                    VStack(spacing: 20) {
                        Image("MobileIcon")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                            .foregroundStyle(Color.white)
                    }
                    .padding(.top, 100)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Button(action: {
                            showSignIn = true
                        }) {
                            Text("Sign In")
                                .bold()
                                .font(.system(size: 20))
                                .frame(width: 150)
                        }
                        .buttonStyle(Buttons())

                        
                        Button(action: {
                            showSignUp = true
                        }) {
                            Text("Sign Up")
                                .bold()
                                .font(.system(size: 20))
                                .frame(width: 150)
                        }
                        .buttonStyle(Buttons())
                        
                        Button(action: {
                            showForgotPassword = true
                        }) {
                            Text("Forgot Password?")
                                .foregroundStyle(Color.white)
                                .font(.system(size: 20))
                        }
                        .padding(.top, 10)
                    }
                    
                    Spacer()
                }
                .navigationDestination(isPresented: $showSignIn) {
                    SignInView(showSignInView: $showSignInView)
                }
                .navigationDestination(isPresented: $showSignUp) {
                    SignUpView(showSignInView: $showSignInView)
                }
                .navigationDestination(isPresented: $showForgotPassword ) {
                    ForgotPasswordView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView(showSignInView: .constant(false))
        }
    }
}
