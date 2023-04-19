// swiftlint:disable:this file_name
//
//  App.swift
//  KMMIC
//
//  Created by MarkG on 10/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import KMPNativeCoroutinesCombine
import KMPNativeCoroutinesCore
import Shared
import SwiftUI
import Combine

@main
struct KMMApp: App {

    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    var subscription: AnyCancellable?
    var body: some Scene {
        WindowGroup {
            NavigatorStack()
        }
    }

    init() {
        DIKt.doInit()
    }
}
