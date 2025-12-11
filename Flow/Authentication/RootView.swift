//
//  RootView.swift
//  Flow
//
//  Created by Darking Almas on 09.11.2025.
//

import SwiftUI
import Firebase

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    @State private var showSignUpView: Bool = false 
    
    var body: some View {
        ZStack {
            NavigationStack {
                BudgetView(showSignInView: $showSignInView)
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil ? true : false 
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                ContentView(showSignInView: $showSignInView, showSignUpView: $showSignUpView)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
