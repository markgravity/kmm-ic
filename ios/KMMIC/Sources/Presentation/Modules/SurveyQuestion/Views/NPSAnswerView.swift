//
//  NPSAnswerView.swift
//  KMMIC
//
//  Created by MarkG on 09/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

private let numberOfItems = 10

struct NPSAnswerView: View {

    @Binding var selection: Int?

    var body: some View {
        VStack(spacing: 16.0) {
            HStack(spacing: 0.0) {
                ForEach(1 ... numberOfItems, id: \.self) { index in
                    Button {
                        selection = index
                    } label: {
                        Text("\(index)")
                            .font(
                                isHighlight(for: index) ? .boldLarge : .regularLarge
                            )
                            .foregroundColor(.white)
                    }
                    .frame(width: 34.0)
                    .opacity(isHighlight(for: index) ? 1.0 : 0.5)
                    if index != numberOfItems {
                        Divider()
                            .background(Color.white)
                    }
                }
            }
            .frame(height: 56.0)
            .cornerRadius(10.0)
            .overlay(RoundedRectangle(cornerRadius: 10.0).stroke(.white, lineWidth: 1.0))
            bottomView
        }
    }

    @ViewBuilder var bottomView: some View {
        HStack {
            let selection = selection ?? -1
            let leftRangeAlpha = (selection < numberOfItems / 2) ? 1.0 : 0.5
            let isInvalidIndex = selection < 0

            Text(R.string.localizable.surveyQuestionScreenNpsUnlike())
                .foregroundColor(.white)
                .opacity(isInvalidIndex ? 0.5 : leftRangeAlpha)
                .font(.boldBody)
            Spacer()
            Text(R.string.localizable.surveyQuestionScreenNpsLike())
                .foregroundColor(.white)
                .opacity(isInvalidIndex ? 0.5 : 1.5 - leftRangeAlpha)
                .font(.boldBody)
        }
        .frame(width: 345.0)
    }

    func isHighlight(for index: Int) -> Bool {
        index <= (selection ?? -1)
    }
}
