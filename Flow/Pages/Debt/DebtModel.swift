//
//  DebtModel.swift
//  Flow
//
//  Created by Darking Almas on 17.12.2025.
//

import SwiftUI

struct Debt: Identifiable {
    let id = UUID()
    let name: String
    let totalAmount: Int
    let remainingAmount: Int
    let color: Color
}

