//
//  AddExpenseView.swift
//  Flow
//
//  Created by Darking Almas on 09.12.2025.
//

import SwiftUI

struct AddExpenseView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var foodExpense: Int
    @Binding var transportExpense: Int
    @Binding var communalExpense: Int
    @Binding var totalExpense: Int
    
    @State private var selectedDate = Date()
    @State private var amount = ""
    @State private var comment = ""
    @State private var selectedCategory: ExpenseCategory?
    @State private var showDatePicker = false
    
    enum ExpenseCategory: String, CaseIterable , CategoryType {
        case food = "Еда"
        case transport = "Транспорт"
        case rent = "Аренда"
        case gifts = "Подарки"
        
        var icon: String {
            switch self {
            case .food: return "Food"
            case .transport: return "Transport"
            case .rent: return "Rent"
            case .gifts: return "Gift"
            }
        }
        
        var color: Color {
            switch self {
            case .food: return Color(red: 1.0, green: 0.75, blue: 0.0)
            case .transport: return Color(red: 0.47, green: 0.40, blue: 0.73)
            case .rent: return Color(red: 0.54, green: 0.46, blue: 0.22)
            case .gifts: return Color.orange
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("MainMobileColor")
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        Text("Добавить Расход")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Color.clear
                            .frame(width: 24, height: 24)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 30)

                    ScrollView {
                        VStack(alignment: .leading, spacing: 25) {
                            VStack(alignment: .leading, spacing: 10) {
                                DatePickerField(
                                    selectedDate: $selectedDate,
                                    showDatePicker: $showDatePicker
                                )
                                
                                AmountField(amount: $amount)
                                
                                CommentField(comment: $comment)
                            }

                            VStack(alignment: .leading, spacing: 15) {
                                Text("Выберите категорию!")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                                
                                HStack(spacing: 20) {
                                    ForEach(ExpenseCategory.allCases, id: \.self) { category in
                                        CategoryButton(
                                            category: category,
                                            isSelected: selectedCategory == category
                                        ) {
                                            selectedCategory = category
                                        }
                                    }
                                }
                            }

                            Button(action: {
                                addExpense()
                            }) {
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
    
    func addExpense() {
        guard let expenseAmount = Int(amount),
              expenseAmount > 0,
              let category = selectedCategory else {
            return
        }
        
        switch category {
        case .food:
            foodExpense += expenseAmount
        case .transport:
            transportExpense += expenseAmount
        case .rent:
            communalExpense += expenseAmount
        case .gifts:
            break
        }
        
        totalExpense = foodExpense + transportExpense + communalExpense
        
        dismiss()
    }
}
