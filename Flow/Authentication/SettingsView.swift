//
//  BudgetPageView.swift
//  Flow
//
//  Created by Darking Almas on 09.11.2025.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}

struct SettingsView : View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body : some View {
        List {
            Button("Log out") {
                Task {
                    do {
                        try viewModel.signOut()
                    } catch {
                        print(error)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSignInView: .constant(false)) 
        }
    }
}
