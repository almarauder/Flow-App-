import SwiftUI

struct StockDetailsCard: View {
    @ObservedObject var viewModel: InvestmentsViewModel
    let stock: StockItem
    var onEdit: ((StockItem) -> Void)? = nil

    private var mainColor: Color { Color("MainMobileColor") }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Circle().fill(Color.orange).frame(width: 10, height: 10)
                Text(stock.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                Spacer()
                Menu {
                    Button("Редактировать") { onEdit?(stock) }
                    Button("Удалить", role: .destructive) { viewModel.deleteStock(stock) }
                } label: {
                    Image(systemName: "ellipsis").foregroundColor(.gray).padding(5)
                }
            }

            row("Общая сумма", viewModel.formattedAmountFromUSD(stock.totalValue))
            row("Куплено по цене", viewModel.formattedPricePerUnitFromUSD(stock.buyPrice))
            row("Текущая цена", viewModel.formattedPricePerUnitFromUSD(stock.currentPrice))

            HStack {
                Text("Разница:").foregroundColor(.gray)
                Spacer()
                let diffPerUnit = stock.buyPrice - stock.currentPrice
                Text(viewModel.formattedPricePerUnitFromUSD(diffPerUnit))
                    .foregroundColor(diffPerUnit >= 0 ? .green : .red)
                    .bold()
            }
            .font(.system(size: 14))

            row("Штук", String(format: "%.1f шт.", stock.quantity))
            row("Дата открытия", DateFormatter.simpleDate.string(from: stock.openDate))
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }

    private func row(_ title: String, _ value: String) -> some View {
        HStack {
            Text("\(title):").foregroundColor(.gray)
            Spacer()
            Text(value).foregroundColor(.black).bold()
        }
        .font(.system(size: 14))
    }
}
