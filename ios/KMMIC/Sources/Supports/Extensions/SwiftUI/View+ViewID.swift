//
//  View+ViewID.swift
//  KMMIC
//
//  Created by MarkG on 12/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

extension View {

    func accessibility(_ viewID: ViewID) -> some View {
        accessibilityIdentifier(viewID())
    }
}
