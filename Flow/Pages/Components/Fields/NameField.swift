//
//  NameField.swift
//  Flow
//
//  Created by Darking Almas on 17.12.2025.
//

import SwiftUI


struct NameField: View {
    @Binding var person_name: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Имя")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            TextField("Введите имя", text: $person_name)
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
