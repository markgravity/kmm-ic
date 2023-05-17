//
//  ViewID.swift
//  KMMIC
//
//  Created by MarkG on 12/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Foundation

enum ViewID {

    case general(General)
    case splash(Splash)
    case login(Login)

    enum General: String {
        case progressHUD = "general.progressHUD"
    }

    enum Splash: String {
        case background = "splash.background"
        case logo = "splash.logo"
    }

    enum Login: String {
        case emailField = "login.emailField"
        case passwordField = "login.passwordField"
        case loginButton = "login.logInButton"
    }

    func callAsFunction() -> String {
        switch self {
        case let .general(general):
            return general.rawValue
        case let .splash(splash):
            return splash.rawValue
        case let .login(login):
            return login.rawValue
        }
    }
}
