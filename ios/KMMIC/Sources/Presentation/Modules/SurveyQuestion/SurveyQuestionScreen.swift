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
    @State var formData = Set<FormAnswerView.FieldData>()

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
        case .textfield, .textarea:
            let fields: [FormAnswerView.Field] = answers.map {
                var type: FormAnswerView.FieldType = .textField
                if displayType == .textarea {
                    type = .textarea
                }

                return FormAnswerView.Field(
                    id: $0.id,
                    placeholder: $0.inputMaskPlaceholder.string,
                    type: type
                )
            }
            FormAnswerView(fields: fields, data: $formData)
        default:
            EmptyView()
        }
    }
}
