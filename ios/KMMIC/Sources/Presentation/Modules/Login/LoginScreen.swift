//
//  LoginScreen.swift
//  KMMIC
//
//  Created by MarkG on 18/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct LoginScreen: View {

    @State private var isAnimated = false

    @EnvironmentObject private var navigator: Navigator
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        ZStack {
            PrimaryDimmedBackground(isAnimated: isAnimated)
            R.image.logoWhite.image
                .offset(x: 0.0, y: isAnimated ? -230.0 : 0.0)
            VStack {
                PrimaryTextField(
                    R.string.localizable.loginScreenEmailTextFieldTitle(),
                    text: $viewModel.email
                )
                .keyboardType(.emailAddress)
                .padding(.bottom, 20.0)
                PrimaryTextField(
                    R.string.localizable.loginScreenPasswordTextFieldTitle(),
                    text: $viewModel.password,
                    isSecured: true
                ) {
                    Button(R.string.localizable.loginScreenForgotButtonTitle()) {
                        // TODO: Show ForgotPassword screen
                    }
                    .foregroundColor(.white.opacity(0.5))
                }
                .padding(.bottom, 20.0)
                PrimaryButton(R.string.localizable.loginScreenLoginButtonTitle()) {
                    viewModel.login()
                }
                .disabled(!viewModel.isAllValidated)
                .frame(height: 56.0)
            }
            .opacity(isAnimated ? 1.0 : 0.0)
            .padding(.horizontal, 24.0)
        }
        .ignoresSafeArea()
        .alert($viewModel.alertDescription)
        .progressHUD($viewModel.isLoading)
        .animation(.easeInOut(duration: 0.8), value: isAnimated)
        .onAppear {
            isAnimated = true
        }
        .onChange(of: viewModel.didLogin) {
            guard $0 else { return }
            navigator.show(screen: .home, by: .root)
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {

    static var previews: some View {
        LoginScreen()
    }
}
