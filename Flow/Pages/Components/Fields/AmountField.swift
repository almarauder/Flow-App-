//
//  AmountField.swift
//  Flow
//
//  Created by Darking Almas on 09.12.2025.
//

import SwiftUI

struct AmountField: View {
    @Binding var amount: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Сумма")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            TextField("Введите сумму", text: $amount)
                .font(.system(size: 16))
                .keyboardType(.numberPad)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.9))
                )
        }
    }
}
