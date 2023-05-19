//
//  NavigatorStack.swift
//  KMMIC
//
//  Created by MarkG on 20/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Factory
import FlowStacks
import SwiftUI

struct NavigatorStack: View {

    @InjectedObject(\.navigator) var navigator: Navigator

    var body: some View {
        NavigationView {
            Router($navigator.routes) { screen, _ in
                switch screen {
                case .splash:
                    SplashScreen()
                case .login:
                    LoginScreen()
                case .home:
                    HomeScreen()
                case let .surveyDetail(viewModel):
                    SurveyDetailScreen()
                        .environmentObject(viewModel)
                        // FIXME: Navigator is not found if we don't add this
                        .environmentObject(navigator)
                case let .surveyQuestion(viewModel):
                    SurveyQuestionScreen(viewModel: viewModel)
                        .environmentObject(navigator)
                case .thank:
                    ThankScreen()
                        .environmentObject(navigator)
                }
            }
            .environmentObject(navigator)
        }
    }
}
