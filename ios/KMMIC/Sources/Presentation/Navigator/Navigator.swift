//
//  Navigator.swift
//  KMMIC
//
//  Created by MarkG on 20/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import FlowStacks
import SwiftUI

class Navigator: ObservableObject {
    @Published var routes: Routes<Screen> = [.root(.splash)]

    func show(screen: Screen, by transition: Transition) {
        switch transition {
        case .root:
            routes = [.root(screen, embedInNavigationView: true)]
        case .push:
            routes.push(screen)
        case .presentSheet:
            routes.presentSheet(screen)
        case .presentCover:
            routes.presentCover(screen, embedInNavigationView: true)
        }
    }

    func goBack() {
        routes.goBack()
    }

    func goBackToRoot() {
        routes.goBackToRoot()
    }

    func pop() {
        routes.pop()
    }

    func dismiss() {
        routes.dismiss()
    }

    func steps(routes: (inout Routes<Screen>) -> Void) {
        RouteSteps.withDelaysIfUnsupported(self, \.routes) { routes(&$0) }
    }
}

// MARK: Navigator.Transition

extension Navigator {

    enum Transition {

        case root
        case push
        case presentSheet
        case presentCover
    }
}
