//
//  SurveyQuestionScreen.swift
//  KMMIC
//
//  Created by MarkG on 08/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct SurveyQuestionScreen: View {

    @StateObject var viewModel: SurveyQuestionViewModel

    // TODO: Remove these dummy states
    @State var selectionOption: DropdownAnswerView.Option?

    var body: some View {
        ZStack {
            DarkBackground(url: viewModel.surveyQuestionUIModel.coverImageURL)
            VStack(alignment: .leading) {
                Text(viewModel.surveyQuestionUIModel.step)
                    .font(.boldMedium)
                    .foregroundColor(.white.opacity(0.5))
                    .padding(.bottom, 8.0)
                Text(viewModel.surveyQuestionUIModel.title)
                    .font(.boldLargeTitle)
                    .foregroundColor(.white)
                Spacer()
                answerView
                Spacer()
                HStack {
                    Spacer()
                    ArrowButton {}
                }
            }
            .padding(.horizontal, 20.0)
            .padding(.top, 32.0)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // TODO: Show confirm alert
                } label: {
                    R.image.closeIcon.image
                }
            }
        }
        .navigationBarBackButtonHidden()
    }

    @ViewBuilder var answerView: some View {
        // TODO: Update selected to view model
        let displayType = viewModel.surveyQuestionUIModel.displayType
        let answers = viewModel.surveyQuestionUIModel.answers

        switch displayType {
        case .heart, .star, .smiley:
            let emojis = SurveyQuestionUIModel.emojisForQuestionDisplayType(displayType)
            let highlightStyle: EmojiAnswerView.EmojiHighlightStyle = displayType == .smiley ? .one : .leftItems
            EmojiAnswerView(
                emojis: emojis,
                highlightStyle: highlightStyle,
                selectedIndex: .constant(0)
            )
        case .dropdown:
            let options = answers.map {
                DropdownAnswerView.Option(id: $0.id, text: $0.text.string)
            }
            DropdownAnswerView(options: options, selection: $selectionOption)
        default:
            EmptyView()
        }
    }
}