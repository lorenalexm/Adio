//
//  GradientBackground.swift
//  Adio
//
//  Created by Alex Loren on 11/17/22.
//

import SwiftUI

struct GradientBackground<Content: View>: View {
    // MARK: - Properties.
    let content: Content
    var gradientColors: [Color]
    
    // MARK: - Initializer.
    init(gradientColors: [Color] = [.background, .backgroundDarker], @ViewBuilder _ content: () -> Content) {
        self.gradientColors = gradientColors
        self.content = content()
    }
    
    // MARK: - View declaration.
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Gradient(colors: gradientColors))
                .ignoresSafeArea()
            
            content
        }
    }
}

struct GradientBackground_Previews: PreviewProvider {
    static var previews: some View {
        GradientBackground {
            Text("Hello, world!")
                .font(.system(size: 48, weight: .black, design: .default))
                .foregroundColor(.text)
        }
    }
}
