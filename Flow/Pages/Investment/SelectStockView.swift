import SwiftUI

struct SelectableStock: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let ticker: String
    let flag: String // simple emoji flag for demo
    let currentPriceUSD: Double
}

struct SelectStockView: View {
    let onPick: (String, Double) -> Void // returns (name, currentPriceUSD)
    @Environment(\.dismiss) private var dismiss

    @State private var query: String = ""

    // Mock catalog. Later this can be replaced with API results.
    @State private var catalog: [SelectableStock] = [
        SelectableStock(name: "Agilent Technologies Inc.", ticker: "A", flag: "🇺🇸", currentPriceUSD: 153.50),
        SelectableStock(name: "Alcoa Corporation", ticker: "AA", flag: "🇺🇸", currentPriceUSD: 41.74),
        SelectableStock(name: "AO \"Банк Астаны\"", ticker: "ABBN", flag: "🇰🇿", currentPriceUSD: 1.62),
        SelectableStock(name: "ASIA BROADBAND INC", ticker: "AABB", flag: "🇺🇸", currentPriceUSD: 0.50),
        SelectableStock(name: "AAREAL BANK AG", ticker: "AABN", flag: "🇩🇪", currentPriceUSD: 1.50),
        SelectableStock(name: "American Airlines", ticker: "AALA", flag: "🇺🇸", currentPriceUSD: 13.98),
        SelectableStock(name: "AO \"Казахтелеком\"", ticker: "KZTK", flag: "🇰🇿", currentPriceUSD: 90.00)
    ]

    private var filtered: [SelectableStock] {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return catalog }
        return catalog.filter { $0.name.localizedCaseInsensitiveContains(query) || $0.ticker.localizedCaseInsensitiveContains(query) }
    }

    private var mainColor: Color {
        if UIColor(named: "MainMobileColor") != nil { return Color("MainMobileColor") } else { return .blue }
    }

    var body: some View {
        ZStack {
            mainColor.ignoresSafeArea()
            VStack(spacing: 0) {
                header
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(filtered) { stock in
                            Button {
                                onPick("\(stock.name) (\(stock.ticker))", stock.currentPriceUSD)
                                dismiss()
                            } label: {
                                HStack(alignment: .center) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(stock.name)
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.black)
                                        HStack(spacing: 6) {
                                            Text(stock.ticker)
                                                .font(.system(size: 13, weight: .medium))
                                                .foregroundColor(.gray)
                                            Text(stock.flag)
                                        }
                                    }
                                    Spacer()
                                    Text(String(format: "%.2f $", stock.currentPriceUSD))
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundColor(.black)
                                }
                                .padding(14)
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.white.opacity(0.6), lineWidth: 1)
                                )
                                .cornerRadius(12)
                            }
                        }
                    }
                    .padding(16)
                }
            }
        }
    }

    private var header: some View {
        VStack(spacing: 12) {
            HStack {
                Button { dismiss() } label: {
                    Image(systemName: "xmark").font(.system(size: 18, weight: .bold)).foregroundColor(.white)
                }
                Spacer()
                Text("Выберите акцию")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                Color.clear.frame(width: 24, height: 24)
            }
            .padding(.horizontal, 20)

            HStack {
                Image(systemName: "magnifyingglass").foregroundColor(.gray)
                TextField("Поиск акций", text: $query)
                    .textInputAutocapitalization(.never)
            }
            .padding(10)
            .background(Color.white)
            .cornerRadius(12)
            .padding(.horizontal, 20)
            .padding(.bottom, 8)
        }
        .padding(.top, 12)
        .padding(.bottom, 8)
    }
}
