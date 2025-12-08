//
//  AuthenticationManager.swift
//  Flow
//
//  Created by Darking Almas on 09.11.2025.
//

import Foundation
import FirebaseAuth

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    
    private init() { }
    
    func createUser() {
        Auth.auth().create
    }
    
}
