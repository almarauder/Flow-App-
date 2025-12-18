import Foundation

struct StockItem: Identifiable {
    var id = UUID()
    var name: String
    var buyPrice: Double
    var currentPrice: Double
    var quantity: Double
    var openDate: Date

    var totalValue: Double { buyPrice * quantity }
    var difference: Double { buyPrice - currentPrice }
}
