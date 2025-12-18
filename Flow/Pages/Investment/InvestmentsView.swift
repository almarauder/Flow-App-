import SwiftUI

struct InvestmentsView: View {
    
    @StateObject private var viewModel = InvestmentsViewModel()
    @Binding var selectedBottomTab: String
    
    // MARK: - Segment Definitions
    
    enum Segment: Int, CaseIterable {
        case all = 0
        case deposit
        case market
        
        var title: String {
            switch self {
            case .all: return "Все"
            case .deposit: return "Депозит"
            case .market: return "Фондовый рынок"
            }
        }
    }
    
    @State private var selectedSegmentIndex: Int = Segment.all.rawValue
    @State private var showAddSheet: Bool = false
    
    enum InvestmentsSheetRoute: Identifiable {
        case select
        case add(prefilled: StockItem)
        
        var id: String {
            switch self {
            case .select: return "select"
            case .add: return "add"
            }
        }
    }
    
    @State private var sheetRoute: InvestmentsSheetRoute? = nil
    
    private var selectedSegment: Segment {
        Segment(rawValue: selectedSegmentIndex) ?? .all
    }
    
    private var mainColor: Color {
        if UIColor(named: "MainMobileColor") != nil {
            return Color("MainMobileColor")
        } else {
            return .blue
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                header
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        
                        InvestmentSegmentControl(
                            segments: Segment.allCases.map(\.title),
                            selectedIndex: $selectedSegmentIndex
                        )
                        .padding(.top, 10)
                        
                        InvestmentDonutChart(
                            total: viewModel.totalValue,
                            deposit: viewModel.depositValue,
                            market: viewModel.marketValue,
                            segmentIndex: selectedSegmentIndex,
                            mainColor: mainColor,
                            centerText: {
                                switch selectedSegment {
                                case .all:
                                    return viewModel.formattedDisplayValue(viewModel.totalDisplayValue)
                                case .deposit:
                                    return viewModel.formattedDisplayValue(viewModel.depositDisplayValue)
                                case .market:
                                    return viewModel.formattedDisplayValue(viewModel.marketDisplayValue)
                                }
                            }()
                        )
                        .frame(width: 200, height: 200)
                        
                        if selectedSegment == .all {
                            SimpleInvestmentKey()
                        }
                        
                        summaryContent
                        
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 120) // space for BottomTab
                    .id(viewModel.selectedCurrency.id)
                    .background(Color.white)
                }
                .background(Color.white)
            }
            
            // Floating Add Button
            if selectedSegment != .all {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            if selectedSegment == .market {
                                sheetRoute = .select
                            } else {
                                showAddSheet = true
                            }
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .bold))
                                .frame(width: 56, height: 56)
                                .background(mainColor)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .shadow(radius: 6)
                        }
                        .padding(.trailing, 24)
                        .padding(.bottom, 110)
                    }
                }
            }
            
            // Bottom Tab Bar
            bottomTabBar
        }
        .edgesIgnoringSafeArea(.top)
        .sheet(isPresented: $showAddSheet) {
            if selectedSegment == .deposit {
                AddDepositView { newItem in
                    viewModel.addNewDeposit(item: newItem)
                }
            }
        }
        .sheet(item: $sheetRoute) { route in
            switch route {
            case .select:
                SelectStockView { name, currentPriceUSD in
                    let prefilled = StockItem(
                        name: name,
                        buyPrice: 0,
                        currentPrice: currentPriceUSD,
                        quantity: 0,
                        openDate: Date()
                    )
                    DispatchQueue.main.async {
                        sheetRoute = .add(prefilled: prefilled)
                    }
                }
                
            case .add(let prefilled):
                AddStockSheet(onSave: { item in
                    var edited = item
                    edited.id = prefilled.id
                    
                    if viewModel.stocks.contains(where: { $0.id == prefilled.id }) {
                        viewModel.editStock(edited)
                    } else {
                        viewModel.addStock(edited)
                    }
                    
                    sheetRoute = nil
                }, initial: prefilled)
            }
        }
    }
    
    // MARK: - Summary Content
    
    private var summaryContent: some View {
        VStack(spacing: 16) {
            
            if selectedSegment == .all {
                SummaryCard(
                    title: "Общий депозит",
                    percent: viewModel.depositPercent,
                    amount: viewModel.depositDisplayValue,
                    progressBorderColor: .red,
                    currency: viewModel.selectedCurrency
                )
                
                SummaryCard(
                    title: "Фондовый рынок",
                    percent: viewModel.marketPercent,
                    amount: viewModel.marketDisplayValue,
                    progressBorderColor: .orange,
                    currency: viewModel.selectedCurrency
                )
            }
            
            if selectedSegment == .deposit {
                ForEach(viewModel.deposits) { deposit in
                    DepositDetailsCard(viewModel: viewModel, deposit: deposit)
                }
            }
            
            if selectedSegment == .market {
                ForEach(viewModel.stocks) { stock in
                    StockDetailsCard(
                        viewModel: viewModel,
                        stock: stock,
                        onEdit: { s in
                            sheetRoute = .add(prefilled: s)
                        }
                    )
                }
            }
        }
    }
    
    // MARK: - Header
    
    private var header: some View {
        ZStack {
            mainColor
                .ignoresSafeArea(edges: .top)
            
            VStack {
                Spacer(minLength: 20)
                
                Text("Инвестиции")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
            }
            .frame(height: 120)
            
            HStack {
                Image("MobileIcon")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            HStack {
                Spacer()
                Menu {
                    ForEach(AppCurrency.allCases) { cur in
                        Button(cur.title) {
                            viewModel.selectedCurrency = cur
                        }
                    }
                } label: {
                    HStack(spacing: 6) {
                        Text(viewModel.selectedCurrency.code)
                            .font(.system(size: 14, weight: .semibold))
                        Image(systemName: "chevron.down")
                            .font(.system(size: 12, weight: .semibold))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.white.opacity(0.2))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
            }
            .padding(.horizontal, 20)
        }
        .frame(height: 120)
        .padding(.top , 30)
    }

    
    // MARK: - Bottom Tab Bar
    
    private var bottomTabBar: some View {
        VStack {
            Spacer()
            HStack(spacing: 0) {
                BottomTab(icon: "Budget", label: "Бюджет", isSelected: selectedBottomTab == "Бюджет") {
                    selectedBottomTab = "Бюджет"
                }
                BottomTab(icon: "Debts", label: "Долги", isSelected: selectedBottomTab == "Долги") {
                    selectedBottomTab = "Долги"
                }
                BottomTab(icon: "Investment", label: "Инвестиции", isSelected: selectedBottomTab == "Инвестиции") {
                    selectedBottomTab = "Инвестиции"
                }
                BottomTab(icon: "Profile", label: "Профиль", isSelected: selectedBottomTab == "Профиль") {
                    selectedBottomTab = "Профиль"
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 15)
            .background(
                RoundedRectangle(cornerRadius: 35)
                    .fill(Color(red: 0.82, green: 0.93, blue: 0.98))
            )
            .padding(.horizontal, 30)
        }
    }
}

// MARK: - Simple Investment Key

struct SimpleInvestmentKey: View {
    var body: some View {
        HStack(spacing: 20) {
            HStack(spacing: 5) {
                Circle()
                    .fill(Color.red)
                    .frame(width: 10, height: 10)
                Text("Депозит")
                    .font(.system(size: 14))
            }
            
            HStack(spacing: 5) {
                Circle()
                    .fill(Color.orange)
                    .frame(width: 10, height: 10)
                Text("Фондовый")
                    .font(.system(size: 14))
            }
        }
        .padding(.vertical, 10)
    }
}

// MARK: - Preview

struct InvestmentsView_Previews: PreviewProvider {
    @State static var selectedTab = "Инвестиции"
    
    static var previews: some View {
        InvestmentsView(selectedBottomTab: $selectedTab)
    }
}
