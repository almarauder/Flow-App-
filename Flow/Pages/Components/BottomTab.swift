//
//  BottomTab.swift
//  Flow
//
//  Created by Darking Almas on 09.12.2025.
//

import SwiftUI

struct BottomTab: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(icon)
                    .renderingMode(.template)
                    .foregroundColor(isSelected ? .white : .black)
                    .font(.system(size: 26))
                
                Text(label)
                    .font(.system(size: 10))
                    .multilineTextAlignment(.center)
            }
            .foregroundColor(isSelected ? .white : .black)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .padding(.horizontal, 8)
            .background(isSelected ? Color("MainMobileColor") : Color.clear)
            .cornerRadius(25)
        }
    }
}
