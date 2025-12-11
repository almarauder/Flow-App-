//
//  CategoryCard.swift
//  Flow
//
//  Created by Darking Almas on 09.12.2025.
//

import SwiftUI

struct CategoryCard: View {
    let icon: String
    let color: Color
    let value: String
    
    var onEdit: (() -> Void)?
    var onDelete: (() -> Void)?
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(color)
                    .frame(width: 70, height: 60)
                
                Image(icon)
                    .foregroundColor(.white)
                    .font(.system(size: 25))
            }
            
            Text(value)
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.black)
                .frame(width: 200)
                .padding(.leading , 20)
            
            Menu {
                Button("Редактировать") { onEdit?() }
                Button("Удалить", role: .destructive) { onDelete?() }
            } label: {
                Image("ShowMore")
                    .padding(.trailing , 12)
            }
        }
        .frame(height: 60)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .stroke(color, lineWidth: 2)
        )
    }
}

protocol CategoryType {
    var color: Color { get }
    var icon: String { get }
    var rawValue: String { get }
}

struct CategoryItem: Identifiable {
    var id = UUID()
    
    var amount: Int
    var date: Date
    var comment: String
    var category: CategoryType
}

struct CategoryButton: View {
    let category: CategoryType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(category.color)
                        .frame(width: 60, height: 60)
                    
                    Image(category.icon)
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                }
                
                Text(category.rawValue)
                    .font(.system(size: 13))
                    .foregroundColor(.white)
            }
            .opacity(isSelected ? 1.0 : 0.6)
            .scaleEffect(isSelected ? 1.05 : 1.0)
        }
    }
}
