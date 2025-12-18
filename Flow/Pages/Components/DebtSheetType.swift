//
//  DebtSheetType.swift
//  Flow
//
//  Created by Darking Almas on 17.12.2025.
//

import SwiftUI

enum DebtSheetType: Identifiable {
    case debts
    case debtors

    var id: Int {
        switch self {
        case .debts: return 0
        case .debtors: return 1
        }
    }
}

