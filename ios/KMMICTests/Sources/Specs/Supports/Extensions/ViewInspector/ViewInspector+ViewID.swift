//
//  ViewInspector+ViewID.swift
//  KMMIC
//
//  Created by MarkG on 19/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Foundation
import SwiftUI
import ViewInspector

@testable import KMMIC

extension InspectableView {

    func find<V>(_ customViewType: V.Type, withViewID viewID: ViewID) throws -> InspectableView<ViewType.View<V>>
        where V: SwiftUI.View {
        try find(customViewType) {
            try $0.accessibilityIdentifier() == viewID()
        }
    }

    func find(viewWithViewID viewID: ViewID) throws -> InspectableView<ViewType.ClassifiedView> {
        try find(viewWithAccessibilityIdentifier: viewID())
    }
}
