//
//  View+PrimaryFieldStyle.swift
//  KMMIC
//
//  Created by MarkG on 09/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

extension View {

    func primaryFieldStyle() -> some View {
        font(.regularBody)
            .foregroundColor(Color.white)
            .padding()
            .background(Color.white.opacity(0.18))
            .cornerRadius(12.0)
    }
}
