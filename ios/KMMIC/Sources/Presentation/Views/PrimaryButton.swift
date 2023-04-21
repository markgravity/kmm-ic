//
//  PrimaryButton.swift
//  KMMIC
//
//  Created by MarkG on 18/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct PrimaryButton: View {

    private let title: String
    private let action: () -> Void
    @Environment(\.isEnabled) private var isEnabled

    var body: some View {
        Button(title, action: action)
            .font(.boldBody)
            .frame(maxWidth: .infinity, maxHeight: 56.0)
            .background(isEnabled ? Color.white : Color.gray)
            .foregroundColor(Color.black)
            .cornerRadius(10.0)
            .animation(.easeIn(duration: 0.3), value: isEnabled)
    }

    init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}

struct PrimaryButton_Previews: PreviewProvider {

    static var previews: some View {
        ZStack {
            Color.black
            PrimaryButton("Tap me") {}
        }
        .ignoresSafeArea()
    }
}
