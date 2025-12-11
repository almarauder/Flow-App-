//
//  TabItem.swift
//  Flow
//
//  Created by Darking Almas on 09.12.2025.
//

import SwiftUI 

struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 15, weight: isSelected ? .semibold : .regular))
                .foregroundColor(isSelected ? .white : .black)
                .padding(.vertical, 20)

                .frame(maxWidth: 100)
                .background(isSelected ? Color(red: 0.27, green: 0.55, blue: 0.76) : Color.clear)
                .cornerRadius(20)
        }
    }
}

struct TabItem: View {
    let title: String
    let selected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: selected ? .semibold : .regular))
                .foregroundColor(selected ? .white : .black)
                .frame(width: 90, height: 40)
                .background(selected ? Color("MainMobileColor") : Color.clear)
                .cornerRadius(20)
        }
    }
}
