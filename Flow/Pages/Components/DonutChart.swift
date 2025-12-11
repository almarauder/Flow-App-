//
//  DonutChart.swift
//  Flow
//
//  Created by Darking Almas on 09.12.2025.
//

import SwiftUI

struct ChartSegment {
    let color: Color
    let percentage: Double
}

struct DonutChart: View {
    let segments: [ChartSegment]
    
    var body: some View {
        ZStack {
            ForEach(0..<segments.count, id: \.self) { index in
                DonutSlice(
                    startAngle: startAngle(for: index),
                    endAngle: endAngle(for: index),
                    color: segments[index].color
                )
            }
        }
    }
    
    func startAngle(for index: Int) -> Angle {
        let previousPercentages = segments[0..<index].reduce(0) { $0 + $1.percentage }
        return Angle(degrees: previousPercentages * 360 - 90)
    }
    
    func endAngle(for index: Int) -> Angle {
        let percentages = segments[0...index].reduce(0) { $0 + $1.percentage }
        return Angle(degrees: percentages * 360 - 90)
    }
}

struct DonutSlice: View {
    let startAngle: Angle
    let endAngle: Angle
    let color: Color
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                let radius = min(geometry.size.width, geometry.size.height) / 2
                let innerRadius = radius * 0.6
                
                path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                path.addLine(to: CGPoint(
                    x: center.x + innerRadius * cos(CGFloat(endAngle.radians)),
                    y: center.y + innerRadius * sin(CGFloat(endAngle.radians))
                ))
                path.addArc(center: center, radius: innerRadius, startAngle: endAngle, endAngle: startAngle, clockwise: true)
                path.closeSubpath()
            }
            .fill(color)
        }
    }
}
