//
//  LoginScreen.swift
//  KMMIC
//
//  Created by MarkG on 18/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct LoginScreen: View {

    @State var email: String = ""
    @State private var isAnimated = false

    var body: some View {
        ZStack {
            PrimaryDimmedBackground(isAnimated: isAnimated)
            R.image.logoWhite.image
                .offset(x: 0.0, y: isAnimated ? -230.0 : 0.0)
            VStack {
                PrimaryTextField(
                    R.string.localizable.loginScreenEmailTextFieldTitle(),
                    text: $email
                )
                .padding(.bottom, 20.0)
                PrimaryTextField(
                    R.string.localizable.loginScreenPasswordTextFieldTitle(),
                    text: $email,
                    isSecured: true
                ) {
                    Button(R.string.localizable.loginScreenForgotButtonTitle()) {
                        // TODO: Show ForgotPassword screen
                    }
                    .foregroundColor(.white.opacity(0.5))
                }
                .padding(.bottom, 20.0)
                PrimaryButton(R.string.localizable.loginScreenLoginButtonTitle()) {
                    // TODO: Login
                }
                .frame(height: 56.0)
            }
            .opacity(isAnimated ? 1.0 : 0.0)
            .padding(.horizontal, 24.0)
        }
        .animation(.easeInOut(duration: 0.8), value: isAnimated)
        .onAppear {
            isAnimated = true
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {

    static var previews: some View {
        LoginScreen()
    }
}
