//
//  DarkBackground.swift
//  KMMIC
//
//  Created by MarkG on 27/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import NukeUI
import SwiftUI

struct DarkBackground: View {

    let url: URL?

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                LazyImage(url: url) {
                    if let image = $0.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                width: geometry.size.width,
                                height: geometry.size.height
                            )
                    } else {
                        EmptyView()
                    }
                }
            }
            .ignoresSafeArea()

            ClearDarkLinearGradient()
        }
    }
}

struct DarkBackground_Previews: PreviewProvider {
    static var previews: some View {
        DarkBackground(url: nil)
    }
}
