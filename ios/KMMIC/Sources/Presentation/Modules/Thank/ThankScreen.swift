//
//  ThankScreen.swift
//  KMMIC
//
//  Created by MarkG on 15/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct ThankScreen: View {

    @EnvironmentObject var navigator: Navigator

    var body: some View {
        ZStack {
            R.color.backgroundColor()
                .ignoresSafeArea()

            VStack(alignment: .center) {
                LottieView(fileName: R.file.successLottieJson.filename) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        navigator.steps {
                            $0.dismiss()
                            $0.goBackToRoot()
                        }
                    }
                }
                .frame(width: 200.0, height: 200.0)
                Text(R.string.localizable.thankScreenTitleText())
                    .font(.boldLarge)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
