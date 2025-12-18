//
//  AddStockView.swift
//  Flow
//
//  Created by Adilet Toktarbay on 12.12.2025.
//


import SwiftUI

struct AddStockView: View {
    let onSave: (Double) -> Void
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var amount: String = ""
    @State private var pricePerUnit: String = ""
    @State private var purchaseDate: Date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Добавить акцию")) {
                    TextField("Название", text: $name)
                    TextField("Количество", text: $amount)
                        .keyboardType(.numberPad)
                    TextField("Цена за единицу", text: $pricePerUnit)
                        .keyboardType(.decimalPad)
                    DatePicker("Дата покупки", selection: $purchaseDate, displayedComponents: .date)
                }
            }
            .navigationTitle("Новая акция")
            .navigationBarItems(leading: Button("Отмена") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Сохранить") {
                let qty = Double(amount.cleanNumber) ?? 0
                let price = Double(pricePerUnit.cleanNumber) ?? 0
                let value = max(0, qty * price)
                onSave(value)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

// Предполагается, что cleanNumber доступен через extension String
