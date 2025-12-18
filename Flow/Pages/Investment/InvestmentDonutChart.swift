//
//  InvestmentDonutChart.swift
//  Flow
//
//  Created by Adilet Toktarbay on 12.12.2025.
//

// InvestmentDonutChart.swift

import SwiftUI

struct InvestmentDonutChart: View {
    let total: Double
    let deposit: Double
    let market: Double
    // Используем Int для сегмента
    let segmentIndex: Int
    let mainColor: Color
    let centerText: String
    
    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            ZStack {
                Group {
                    // All (index 0)
                    if segmentIndex == 0 {
                        InvestmentDonutSlice(startAngle: .degrees(0), endAngle: .degrees(360 * (total == 0 ? 0 : deposit / total)))
                            .foregroundStyle(Color.red)
                        InvestmentDonutSlice(startAngle: .degrees(360 * (total == 0 ? 0 : deposit / total)), endAngle: .degrees(360))
                            .foregroundStyle(Color.orange)
                    }
                    // Deposit (index 1)
                    else if segmentIndex == 1 {
                        InvestmentDonutSlice(startAngle: .degrees(0), endAngle: .degrees(360))
                            .foregroundStyle(Color.red)
                    }
                    // Market (index 2)
                    else if segmentIndex == 2 {
                        InvestmentDonutSlice(startAngle: .degrees(0), endAngle: .degrees(360))
                            .foregroundStyle(Color.orange)
                    }
                }
                .rotationEffect(.degrees(-90))
                .frame(width: size, height: size)

                let thicknessFraction: CGFloat = 0.18
                let innerDiameter: CGFloat = size * (1 - 2 * thicknessFraction)

                Circle()
                    .fill(Color.white)
                    .frame(width: innerDiameter, height: innerDiameter)

                Text(centerText)
                    .font(.system(size: max(10, innerDiameter * 0.32), weight: .semibold))
                    .foregroundColor(.black)
                    .lineLimit(1)
                    .minimumScaleFactor(0.3)
                    .allowsTightening(true)
                    .frame(width: innerDiameter * 0.9)
            }
            .frame(width: size, height: size)
        }
    }
}

struct InvestmentDonutSlice: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        let thickness: CGFloat = rect.width * 0.18
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = rect.width / 2
        
        var path = Path()
        path.addArc(center: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        path.addArc(center: center,
                    radius: radius - thickness,
                    startAngle: endAngle,
                    endAngle: startAngle,
                    clockwise: true)
        path.closeSubpath()
        return path
    }
}
