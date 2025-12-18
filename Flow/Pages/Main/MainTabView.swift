//
//  MainTabView.swift
//  Flow
//
//  Created by Darking Almas on 16.12.2025.
//

import SwiftUI
import FirebaseAuth

struct MainTabView: View {
    @State private var selectedTab: String = "Бюджет"
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            switch selectedTab {
            case "Бюджет":
                BudgetView(selectedBottomTab: $selectedTab)
            case "Долги":
                DebtsPageView(selectedBottomTab: $selectedTab)
            case "Инвестиции":
                InvestmentsView(selectedBottomTab: $selectedTab)
            case "Профиль":
                ProfileView(selectedBottomTab: $selectedTab, showSignInView: $showSignInView)
            default:
                BudgetView(selectedBottomTab: $selectedTab)
            }
        }
    }
}

struct ProfileView: View {
    @Binding var selectedBottomTab: String
    @Binding var showSignInView: Bool

    var body: some View {
        VStack {
            Text("Profile")
            Button("Sign Out") {
                try? Auth.auth().signOut()
                showSignInView = true
            }
        }
    }
}

