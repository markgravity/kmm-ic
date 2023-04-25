//
//  ArrowButton.swift
//  KMMIC
//
//  Created by MarkG on 25/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct ArrowButton: View {

    let action: () -> Void

    var body: some View {
        ZStack {
            Circle()
                .fill(.white)
            R.image.arrowIcon.image
        }
        .frame(width: 56.0, height: 56.0)
    }
}

struct ArrowButton_Previews: PreviewProvider {
    static var previews: some View {
        ArrowButton {}
    }
}
