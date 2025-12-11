//
//  DatePickerField.swift
//  Flow
//
//  Created by Darking Almas on 09.12.2025.
//

import SwiftUI

struct DatePickerField: View {
    @Binding var selectedDate: Date
    @Binding var showDatePicker: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Выберите дату и время")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            Button(action: { showDatePicker = true }) {
                HStack {
                    Text(formatDate(selectedDate))
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: "calendar")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
                .padding()
                .frame(height: 55)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.9))
                )
            }
            .sheet(isPresented: $showDatePicker) {
                VStack {
                    DatePicker(
                        "Выберите дату",
                        selection: $selectedDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .padding()
                    
                    Button("Готово") {
                        showDatePicker = false
                    }
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.top, 10)
                }
                .presentationDetents([.medium])
            }
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "dd.MM.yyyy"
        return f.string(from: date)
    }
}
