//
//  AddDebtsView.swift
//  Flow
//
//  Created by Darking Almas on 17.12.2025.
//

import SwiftUI

struct AddDebtsView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var debts: [Debt]
    
    @State private var selectedDate = Date()
    @State private var amount = ""
    @State private var person_name = ""
    @State private var comment = ""
    @State private var showDatePicker = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color("MainMobileColor").ignoresSafeArea()

                VStack(spacing: 0) {
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(.white)
                        }

                        Spacer()

                        Text("Добавить Долги")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)

                        Spacer()

                        Color.clear.frame(width: 24, height: 24)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 30)

                    ScrollView {
                        VStack(alignment: .leading, spacing: 25) {
                            VStack(alignment: .leading, spacing: 10) {
                                NameField(person_name: $person_name)
                                AmountField(amount: $amount)

                                DatePickerField(
                                    selectedDate: $selectedDate,
                                    showDatePicker: $showDatePicker
                                )
                                
                                DatePickerField(
                                    selectedDate: $selectedDate,
                                    showDatePicker: $showDatePicker
                                )

                                CommentField(comment: $comment)
                            }

                            Button(action: { addDebts() }) {
                                Text("Добавить")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(Color("MainMobileColor"))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 18)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color(red: 0.82, green: 0.93, blue: 0.98))
                                    )
                            }
                            .padding(.top, 20)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
    }

    func addDebts() {
        let digits = amount.filter { $0.isNumber }
        guard let debtAmount = Int(digits), !person_name.isEmpty else { return }

        let newDebt = Debt(
            name: person_name,
            totalAmount: debtAmount,
            remainingAmount: debtAmount,
            color: .orange
        )

        debts.append(newDebt)
        dismiss()
    }
}
