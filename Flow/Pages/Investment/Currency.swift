// Unified currency definition for the app
import Foundation

enum AppCurrency: String, CaseIterable, Identifiable {
    case kzt, usd, rub
    var id: String { rawValue }

    var code: String {
        switch self { case .kzt: return "KZT"; case .usd: return "USD"; case .rub: return "RUB" }
    }
    var suffix: String {
        switch self { case .kzt: return "тг"; case .usd: return "$"; case .rub: return "₽" }
    }
    var title: String {
        switch self { case .kzt: return "Тенге (KZT)"; case .usd: return "Доллар (USD)"; case .rub: return "Рубль (RUB)" }
    }
    // KZT -> selected currency (kept for deposits/legacy formatting)
    var rate: Double {
        switch self { case .kzt: return 1.0; case .usd: return 0.0022; case .rub: return 0.20 }
    }
    // USD -> selected currency (used for stocks display)
    var usdMultiplier: Double {
        switch self { case .usd: return 1.0; case .kzt: return 460.0; case .rub: return 90.0 }
    }
}
