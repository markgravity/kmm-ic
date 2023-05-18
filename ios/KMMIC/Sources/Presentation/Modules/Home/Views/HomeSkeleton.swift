//
//  HomeSkeleton.swift
//  KMMIC
//
//  Created by MarkG on 17/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SkeletonUI
import SwiftUI

struct HomeSkeleton: View {

    var body: some View {
        Color.black
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
        VStack {
            header
            content
        }
        .padding(.horizontal, 20.0)
    }

    var header: some View {
        VStack(alignment: .leading) {
            skeletonTextView(width: 118.0)
                .padding(.top, 20.0)
            HStack {
                skeletonTextView(width: 90.0)
                Spacer()
                Text(nil)
                    .skeleton(
                        with: true,
                        size: CGSize(width: 36.0, height: 36.0)
                    )
                    .shape(type: .circle)
            }
        }
    }

    var content: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 16.0) {
                skeletonTextView(width: 40.0)
                skeletonTextView(width: 140.0, lines: 2)
                skeletonTextView(width: min(geometry.size.width - 40.0, 300.0), lines: 2)
            }
            .offset(y: geometry.size.height - 180.0)
        }
    }

    @ViewBuilder
    func skeletonTextView(width: CGFloat, lines: Int = 1) -> some View {
        Text(nil)
            .skeleton(
                with: true,
                size: CGSize(
                    width: width,
                    height: (20.0 * CGFloat(lines)) + (6.0 * (CGFloat(lines) - 1.0))
                )
            )
            .shape(type: .capsule)
            .multiline(lines: lines, scales: [1: 0.5], spacing: 6.0)
    }
}
