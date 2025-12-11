//
//  LegendItem.swift
//  Flow
//
//  Created by Darking Almas on 10.12.2025.
//

import SwiftUI

struct LegendItem: View {
    let color: Color
    let text: String
    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
            Text(text)
                .font(.system(size: 16))
        }
    }
}
