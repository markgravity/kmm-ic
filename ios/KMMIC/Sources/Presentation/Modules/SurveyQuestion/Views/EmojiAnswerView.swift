//
//  EmojiAnswerView.swift
//  KMMIC
//
//  Created by MarkG on 08/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct EmojiAnswerView: View {

    @EnvironmentObject private var viewModel: SurveyQuestionViewModel

    private var emojis: [String] {
        let displayType = viewModel.surveyQuestionUIModel.displayType
        return SurveyQuestionUIModel.emojisForQuestionDisplayType(displayType)
    }

    private var highlightStyle: EmojiHighlightStyle {
        let displayType = viewModel.surveyQuestionUIModel.displayType
        return displayType == .smiley ? .one : .leftItems
    }

    @State private var selectedIndex: Int? {
        didSet {
            guard let index = selectedIndex,
                  let answer = viewModel.surveyQuestionUIModel.answers[safe: index]
            else { return }
            viewModel.setAnswerInput(for: answer.id, with: nil)
        }
    }

    var body: some View {
        HStack(spacing: 16.0) {
            Spacer()
            ForEach(0 ..< emojis.count, id: \.self) { index in
                Button {
                    selectedIndex = index
                } label: {
                    Text(emojis[index])
                        .font(.boldTitle)
                        .opacity(isHighlighted(for: index) ? 1.0 : 0.5)
                }
                .tag(index as Int?)
            }
            Spacer()
        }
    }

    func isHighlighted(for index: Int) -> Bool {
        switch highlightStyle {
        case .leftItems: return index <= selectedIndex ?? -1
        case .one: return index == selectedIndex
        }
    }
}

extension EmojiAnswerView {

    enum EmojiHighlightStyle {

        case leftItems
        case one
    }
}
