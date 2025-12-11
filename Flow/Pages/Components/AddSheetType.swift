//
//  AddSheetType.swift
//  Flow
//
//  Created by Darking Almas on 09.12.2025.
//

import SwiftUI

enum AddSheetType: Identifiable {
    case expense, income, account
    var id: Int { hashValue }
}

