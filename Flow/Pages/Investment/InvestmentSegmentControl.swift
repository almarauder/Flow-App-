//
//  InvestmentSegmentControl.swift
//  Flow
//
//  Created by Adilet Toktarbay on 12.12.2025.
//

// InvestmentSegmentControl.swift

import SwiftUI

// Здесь нужно импортировать InvestmentsView, чтобы использовать Segment
// Для избежания циклической зависимости, перенесем Segment в ViewModel или создадим отдельный файл

struct InvestmentSegmentControl: View {
    let segments: [String]
    // Привязка должна быть к Int, если InvestmentsView.Segment находится в другом месте
    // Для простоты используем Int, предполагая, что 0=All, 1=Deposit, 2=Market
    @Binding var selectedIndex: Int
    
    private var mainColor: Color {
        if UIColor(named: "MainMobileColor") != nil {
            return Color("MainMobileColor")
        } else {
            return .blue
        }
    }
    
    private func segmentButton(title: String, index: Int) -> some View {
        Button(action: {
            selectedIndex = index
        }) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(selectedIndex == index ? .white : .black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(
                    Group {
                        if selectedIndex == index {
                            mainColor
                                .opacity(0.9)
                                .cornerRadius(20)
                        } else {
                            Color.clear
                        }
                    }
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(segments.indices, id: \.self) { idx in
                segmentButton(title: segments[idx], index: idx)
            }
        }
        .padding(6)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(red: 0.82, green: 0.93, blue: 0.98))
        )
        .frame(height: 40)
    }
}
