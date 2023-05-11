//
//  ArrowButton.swift
//  KMMIC
//
//  Created by MarkG on 25/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct ArrowButton: View {

    @Environment(\.isEnabled) private var isEnabled

    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(isEnabled ? .white : .gray)
                R.image.arrowIcon.image
            }
        }
        .frame(width: 56.0, height: 56.0)
    }
}

struct ArrowButton_Previews: PreviewProvider {
    static var previews: some View {
        ArrowButton {}
    }
}
