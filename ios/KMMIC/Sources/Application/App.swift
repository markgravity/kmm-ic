// swiftlint:disable:this file_name
//
//  App.swift
//  KMMIC
//
//  Created by MarkG on 10/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Shared
import SwiftUI

@main
struct KMMApp: App {

    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            NavigatorStack()
        }
    }

    init() {
        DIKt.doInit()
    }
}
