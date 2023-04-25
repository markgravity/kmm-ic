//
//  PrimaryDimmedBackground.swift
//  KMMIC
//
//  Created by MarkG on 18/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct PrimaryDimmedBackground: View {

    private var isAnimated: Bool

    var body: some View {
        ZStack {
            R.image.appBackground.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .blur(radius: 20.0, opaque: true)
            LinearGradient(
                gradient: Gradient(
                    colors: [.black.opacity(0.2), .black]
                ),
                startPoint: .top,
                endPoint: .bottom
            )
            .opacity(isAnimated ? 1.0 : 0.0)
        }
        .ignoresSafeArea()
    }

    init(isAnimated: Bool = true) {
        self.isAnimated = isAnimated
    }
}

struct PrimaryDimmedBackground_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryDimmedBackground()
    }
}
