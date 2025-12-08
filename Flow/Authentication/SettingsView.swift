//
//  BudgetPageView.swift
//  Flow
//
//  Created by Darking Almas on 09.11.2025.
//

import SwiftUI

@MainActor
final class BudgetPageViewModel: ObservableObject {
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}

struct BudgetPageView : View {
    
    @StateObject private var viewModel = BudgetPageViewModel()
    @Binding var showSignInView: Bool
    
    var body : some View {
        List {
            Button("Log out") {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }
        }
        .navigationBarTitle("Budget Page")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BudgetPageView(showSignInView: .constant(false))
        }
    }
}
