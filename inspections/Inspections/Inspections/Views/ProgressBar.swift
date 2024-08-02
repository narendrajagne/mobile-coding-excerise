//
//  ProgressBar.swift
//  Inspections
//
//  Created by ERP on 28/07/2024.
//

import SwiftUI

struct ProgressBar: View {
    var value: Double
    var total: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 20)
                    .foregroundColor(Color.gray.opacity(0.3))

                RoundedRectangle(cornerRadius: 10)
                    .frame(width: geometry.size.width * CGFloat(value / total), height: 20)
                    .foregroundColor(.green)
                    .animation(.linear, value: 1.0)
            }
        }
        .frame(height: 20)
        .padding(.horizontal)
    }
}

#Preview {
    ProgressBar(value: 1.0, total: 8.0)
}
