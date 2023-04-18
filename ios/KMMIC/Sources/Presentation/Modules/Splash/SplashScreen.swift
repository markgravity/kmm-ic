//
//  LandingScreen.swift
//  KMMIC
//
//  Created by MarkG on 13/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct SplashScreen: View {

    @State private var isLoaded = false

    var body: some View {
        ZStack {
            R.image.appBackground.image
                .resizable()
                .aspectRatio(contentMode: .fill)
            R.image.logoWhite.image
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .opacity(isLoaded ? 1 : 0)
        }
        .ignoresSafeArea()
        .animation(.easeIn(duration: 1.0).delay(0.5), value: isLoaded)
        .onAppear {
            isLoaded.toggle()
        }
    }
}

struct LandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
