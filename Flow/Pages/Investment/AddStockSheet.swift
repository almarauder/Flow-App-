import SwiftUI

struct AddStockSheet: View {
    let onSave: (StockItem) -> Void
    var initial: StockItem? = nil
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var buyPrice: String = ""
    @State private var currentPrice: String = ""
    @State private var quantity: String = ""
    @State private var openDate: Date = Date()

    private var isValid: Bool {
        !name.isEmpty && (Double(buyPrice.cleanNumber) ?? 0) > 0 && (Double(currentPrice.cleanNumber) ?? 0) > 0 && (Double(quantity.cleanNumber) ?? 0) > 0
    }

    var body: some View {
        ZStack {
            Color("MainMobileColor").ignoresSafeArea()
            VStack(spacing: 0) {
                HStack {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark").font(.system(size: 18, weight: .bold)).foregroundColor(.white)
                    }
                    Spacer()
                    Text("Акция").font(.system(size: 22, weight: .bold)).foregroundColor(.white)
                    Spacer()
                    Color.clear.frame(width: 24, height: 24)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        label("Название")
                        TextField("Название компании", text: $name)
                            .padding().background(Color.white).cornerRadius(10)

                        label("Куплено по цене")
                        HStack {
                            TextField("Цена покупки", text: $buyPrice)
                                .keyboardType(.decimalPad)
                            Spacer(minLength: 8)
                            Text("$")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)

                        label("Текущая цена")
                        HStack {
                            TextField("Текущая цена", text: $currentPrice)
                                .keyboardType(.decimalPad)
                            Spacer(minLength: 8)
                            Text("$")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)

                        label("Сколько штук")
                        TextField("Количество", text: $quantity)
                            .keyboardType(.decimalPad)
                            .padding().background(Color.white).cornerRadius(10)

                        label("Дата открытия")
                        HStack {
                            DatePicker("", selection: $openDate, displayedComponents: .date)
                                .labelsHidden().tint(Color("MainMobileColor"))
                            Spacer()
                            Image(systemName: "calendar").foregroundColor(.white)
                        }
                        .padding().background(Color.white).cornerRadius(10)

                        Button {
                            guard isValid else { return }
                            let item = StockItem(
                                name: name,
                                buyPrice: Double(buyPrice.cleanNumber) ?? 0,
                                currentPrice: Double(currentPrice.cleanNumber) ?? 0,
                                quantity: Double(quantity.cleanNumber) ?? 0,
                                openDate: openDate
                            )
                            onSave(item)
                            dismiss()
                        } label: {
                            Text("Добавить")
                                .font(.system(size: 17, weight: .semibold))
                                .frame(maxWidth: .infinity).padding()
                                .background(Color.white.opacity(0.9))
                                .foregroundColor(Color("MainMobileColor")).cornerRadius(12)
                        }.disabled(!isValid).padding(.top, 8)
                    }
                    .padding(20)
                }
            }
        }
        .onAppear {
            if let s = initial {
                name = s.name
                buyPrice = String(format: "%.2f", s.buyPrice)
                currentPrice = String(format: "%.2f", s.currentPrice)
                quantity = String(format: "%.2f", s.quantity)
                openDate = s.openDate
            }
        }
    }

    private func label(_ text: String) -> some View {
        Text(text).font(.system(size: 14, weight: .semibold)).foregroundColor(.white)
    }
}
