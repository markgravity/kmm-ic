//
//  LandingScreen.swift
//  KMMIC
//
//  Created by MarkG on 13/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Factory
import SwiftUI

struct SplashScreen: View {

    @InjectedObject(\.navigator) var navigator: Navigator
    @State private var logoOpacity = 0.0

    var body: some View {
        ZStack {
            R.image.appBackground.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .accessibility(.splash(.background))
            R.image.logoWhite.image
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .opacity(logoOpacity)
                .accessibility(.splash(.logo))
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeIn(duration: 1.0).delay(0.5)) {
                logoOpacity = 1.0
            }
        }
        .animationObserver(for: logoOpacity, onComplete: {
            navigator.show(screen: .login, by: .root)
        })
    }
}

struct LandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
