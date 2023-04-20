//
//  NavigatorStack.swift
//  KMMIC
//
//  Created by MarkG on 20/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import FlowStacks
import SwiftUI

struct NavigatorStack: View {

    @StateObject var navigator = Navigator()

    var body: some View {
        NavigationView {
            Router($navigator.routes) { screen, _ in
                switch screen {
                case .splash:
                    SplashScreen()
                case .login:
                    LoginScreen()
                }
            }
            .environmentObject(navigator)
        }
    }
}
