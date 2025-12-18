// AddDepositView.swift

import SwiftUI

struct AddDepositView: View {
    let onSave: (DepositItem) -> Void
    var initialDeposit: DepositItem? = nil
    
    @Environment(\.presentationMode) var presentationMode
    
    // State-переменные для полей
    @State private var name: String = ""
    // @State private var totalAmount: String = "" // УДАЛЕНО
    @State private var investmentAmount: String = ""
    @State private var interestRate: String = ""
    @State private var startDate: Date = Date()
    // @State private var termMonths: String = "" // УДАЛЕНО
    
    @State private var endDate: Date? = nil
    @State private var hasEndDate: Bool = false
    
    private var isFormValid: Bool {
        return !name.isEmpty &&
               (Double(investmentAmount.cleanNumber) ?? 0) > 0 &&
               (Double(interestRate.cleanNumber) ?? 0) > 0
    }
    
    var body: some View {
        ZStack {
            Color("MainMobileColor").ignoresSafeArea()
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text("Депозит")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    // placeholder to balance header
                    Color.clear.frame(width: 24, height: 24)
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 12)

                // Form content
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Название")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                        TextField("Наименование банка", text: $name)
                            .textInputAutocapitalization(.words)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)

                        Text("Сумма")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                        TextField("Сумма вложения", text: $investmentAmount)
                            .keyboardType(.decimalPad)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)

                        Text("Процентная ставка:")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                        TextField("Процентная ставка", text: $interestRate)
                            .keyboardType(.decimalPad)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)

                        Text("Дата вложения:")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                        HStack {
                            DatePicker("", selection: $startDate, displayedComponents: .date)
                                .labelsHidden()
                                .tint(Color("MainMobileColor"))
                            Spacer()
                            Image(systemName: "calendar")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)

                        // Toggle optional close date remains as-is visually minimal
                        Toggle("Добавить дату закрытия", isOn: $hasEndDate.animation())
                            .tint(.white)
                            .foregroundColor(.white)

                        if hasEndDate {
                            HStack {
                                DatePicker("", selection: $endDate.nonOptionalBinding(defaultValue: Calendar.current.date(byAdding: .year, value: 1, to: Date()) ?? Date()), displayedComponents: .date)
                                    .labelsHidden()
                                    .tint(Color("MainMobileColor"))
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                        }

                        // Primary button
                        Button(action: {
                            if isFormValid {
                                let newID = initialDeposit?.id ?? UUID()
                                let amount = Double(investmentAmount.cleanNumber) ?? 0
                                let newItem = DepositItem(
                                    id: newID,
                                    name: name,
                                    totalAmount: amount,
                                    investmentAmount: amount,
                                    interestRate: Double(interestRate.cleanNumber) ?? 0,
                                    startDate: startDate,
                                    endDate: hasEndDate ? endDate : nil,
                                    termMonths: ""
                                )
                                onSave(newItem)
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            Text("Добавить")
                                .font(.system(size: 17, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white.opacity(0.9))
                                .foregroundColor(Color("MainMobileColor"))
                                .cornerRadius(12)
                        }
                        .disabled(!isFormValid)
                        .padding(.top, 8)
                    }
                    .padding(20)
                }
            }
        }
        .onAppear {
            if let deposit = initialDeposit {
                name = deposit.name
                investmentAmount = String(format: "%.0f", deposit.investmentAmount)
                interestRate = String(format: "%.1f", deposit.interestRate)
                startDate = deposit.startDate
                endDate = deposit.endDate
                hasEndDate = deposit.endDate != nil
            }
        }
    }
}

// MARK: - Helper Extensions (Оставить без изменений, они нужны для cleanNumber и Binding)
extension String {
    var cleanNumber: String {
        self.replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: " ", with: "")
    }
}

extension Binding where Value == Date? {
    func nonOptionalBinding(defaultValue: Date) -> Binding<Date> {
        Binding<Date>(
            get: { self.wrappedValue ?? defaultValue },
            set: { self.wrappedValue = $0 }
        )
    }
}
