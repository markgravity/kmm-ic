//
//  HomeSurveys.swift
//  KMMIC
//
//  Created by MarkG on 25/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import NukeUI
import SwiftUI

struct HomeSurveys: View {

    private var bottomContent: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            Spacer()
            HStack(spacing: 10.0) {
                ForEach(0 ... 2, id: \.self) { index in
                    Circle()
                        .fill(index == 0 ? .white : .white.opacity(0.2))
                        .frame(width: 8.0, height: 8.0)
                }
                .padding(.bottom, 26.0)
            }

            Text("Working from home Check-In")
                .font(.boldTitle)
                .lineLimit(2)
                .padding(.bottom, 16.0)
                .foregroundColor(.white)
            HStack {
                Text("We would like to know how you feel about our work from home")
                    .font(.regularBody)
                    .foregroundColor(.white.opacity(0.7))
                    .lineLimit(2)
                Spacer(minLength: 20.0)
                ArrowButton {
                    // TODO: Show Survey Detail screen
                }
            }
        }
        .padding(.horizontal, 20.0)
    }

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                LazyImage(url: .init(string: "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_")) {
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

            bottomContent
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct HomeSurveys_Previews: PreviewProvider {
    static var previews: some View {
        HomeSurveys()
    }
}
