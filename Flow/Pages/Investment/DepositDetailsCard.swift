// DepositDetailsCard.swift

import SwiftUI

struct DepositDetailsCard: View {
    @ObservedObject var viewModel: InvestmentsViewModel
    @State var deposit: DepositItem
    
    @State private var isDetailsExpanded: Bool = true // Кнопка для скрытия критериев
    @State private var showingActionSheet = false
    @State private var showingEditSheet = false
    @State private var showingTopUpSheet = false
    
    private var mainColor: Color {
        if UIColor(named: "MainMobileColor") != nil {
            return Color("MainMobileColor")
        } else {
            return .blue
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            // Заголовок с названием и троеточием
            HStack {
                Circle().fill(Color.red).frame(width: 10, height: 10)
                Text(deposit.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                Spacer()
                
                Menu {
                    Button("Пополнить") { showingTopUpSheet = true }
                    Button("Редактировать") { showingEditSheet = true }
                    Button("Удалить", role: .destructive) {
                        viewModel.deleteDeposit(item: deposit)
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                        .padding(5)
                }
            }
            
            // Общая сумма
            Text("Общая сумма: **\(viewModel.formattedAmount(deposit.totalAmount))**")
                .font(.system(size: 14))
                .foregroundColor(.black)
            
            // Кнопка-переключатель для скрытия деталей
            HStack {
                Text(isDetailsExpanded ? "Скрыть подробности" : "Показать подробности")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(mainColor)
                Spacer()
                Image(systemName: isDetailsExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(mainColor)
            }
            .onTapGesture {
                withAnimation {
                    isDetailsExpanded.toggle()
                }
            }
            
            // Детальные критерии (скрываемая часть)
            if isDetailsExpanded {
                VStack(alignment: .leading, spacing: 6) {
                    
                    detailRow(title: "Сумма вложения", value: viewModel.formattedAmount(deposit.investmentAmount))
                    
                    detailRow(title: "Процентная ставка", value: "\(String(format: "%.1f", deposit.interestRate))%")
                    
                    detailRow(title: "Дата открытия", value: deposit.startDate, formatter: DateFormatter.simpleDate)
                    
                    if let endDate = deposit.endDate {
                        detailRow(title: "Дата закрытия", value: endDate, formatter: DateFormatter.simpleDate)
                    }
                }
                .padding(.top, 4)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        
        // Sheets для действий
        .sheet(isPresented: $showingTopUpSheet) {
            DepositTopUpView(viewModel: viewModel, deposit: $deposit)
        }
        .sheet(isPresented: $showingEditSheet) {
            // Исправленная передача параметров
            DepositEditView(viewModel: viewModel, deposit: $deposit)
        }
    }
    
    // Вспомогательная функция для строки деталей
    private func detailRow(title: String, value: String) -> some View {
        HStack {
            Text("\(title):").foregroundColor(.gray)
            Spacer()
            Text(value).foregroundColor(.black).bold()
        }
        .font(.system(size: 14))
    }
    
    private func detailRow(title: String, value: Date, formatter: DateFormatter) -> some View {
        detailRow(title: title, value: formatter.string(from: value))
    }
}

// MARK: - Вспомогательные View для пополнения и редактирования

struct DepositTopUpView: View {
    @ObservedObject var viewModel: InvestmentsViewModel
    @Binding var deposit: DepositItem
    @Environment(\.presentationMode) var presentationMode
    
    @State private var amount: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Пополнить \(deposit.name)")
                    .font(.title2).bold()
                
                TextField("Сумма пополнения", text: $amount)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                Button("Пополнить") {
                    // ИСПРАВЛЕНИЕ: Используем cleanNumber
                    if let value = Double(amount.cleanNumber), value > 0 {
                        viewModel.topUpDeposit(item: deposit, amount: value)
                    }
                    presentationMode.wrappedValue.dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Spacer()
            }
            .padding(20)
            .navigationBarItems(leading: Button("Закрыть") { presentationMode.wrappedValue.dismiss() })
        }
    }
}

struct DepositEditView: View {
    @ObservedObject var viewModel: InvestmentsViewModel
    // ИСПРАВЛЕНО: Используем @Binding для двусторонней связи
    @Binding var deposit: DepositItem
    
    var body: some View {
        // ИСПРАВЛЕНО: Правильный вызов AddDepositView
        AddDepositView(onSave: { updatedItem in
            viewModel.editDeposit(item: updatedItem)
        }, initialDeposit: deposit)
    }
}

// MARK: - Date Formatter Helper

extension DateFormatter {
    static let simpleDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
}
