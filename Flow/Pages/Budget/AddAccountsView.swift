//
//  AddAccountsView.swift
//  Flow
//
//  Created by Darking Almas on 10.12.2025.
//

import SwiftUI

struct AddAccountsView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var cashAccount: Int
    @Binding var bankAccount: Int
    @Binding var totalAccount: Int
    
    @State private var selectedDate = Date()
    @State private var amount = ""
    @State private var comment = ""
    @State private var selectedCategory: AccountsCategory?
    @State private var showDatePicker = false
    
    enum AccountsCategory: String, CaseIterable , CategoryType {
        case cash = "Наличные"
        case bank = "Kaspi Bank"
        
        var icon: String {
            switch self {
            case .cash: return "Debts"
            case .bank: return "KaspiBank"
            }
        }
        
        var color: Color {
            switch self {
            case .cash: return Color(red: 0.2, green: 0.78, blue: 0.35)
            case .bank: return Color(red: 0.96, green: 0.26, blue: 0.21)
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
                        
                        Text("Добавить Счет")
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
                                    ForEach(AccountsCategory.allCases, id: \.self) { category in
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
                                addAccount()
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
    
    func addAccount() {
        guard let accountAmount = Int(amount),
              accountAmount > 0,
              let category = selectedCategory else {
            return
        }
        
        switch category {
        case .cash:
            cashAccount += accountAmount
        case .bank:
            bankAccount += accountAmount
            
            totalAccount = cashAccount + bankAccount
            
            dismiss()
        }
    }
}
