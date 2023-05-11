//
//  SelectAnswerView.swift
//  KMMIC
//
//  Created by MarkG on 09/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct SelectAnswerView: View {

    @EnvironmentObject private var viewModel: SurveyQuestionViewModel

    @State private var selections = Set<Option>()

    private var options: [Option] {
        let answers = viewModel.surveyQuestionUIModel.answers
        return answers.map {
            SelectAnswerView.Option(id: $0.id, text: $0.text)
        }
    }

    var body: some View {
        ScrollView {
            VStack {
                ForEach(options) { option in
                    Button(
                        action: {
                            if selections.contains(option) {
                                selections.remove(option)
                            } else {
                                selections.insert(option)
                            }
                        },
                        label: { optionView(of: option) }
                    )
                    .frame(height: 56.0)
                    if option != options.last {
                        Divider()
                            .background(Color.white)
                    }
                }
            }
            .padding(.horizontal, 60.0)
        }
        .onChange(of: selections) { data in
            viewModel.setAnswerInputs(
                data.map {
                    .init(id: $0.id, content: nil)
                }
            )
        }
    }

    @ViewBuilder
    func optionView(of option: Option) -> some View {
        let isSelected = selections.contains(option)
        HStack {
            Text(option.text)
                .foregroundColor(isSelected ? .white : .white.opacity(0.5))
                .font(
                    isSelected ? .boldLarge : .regularLarge
                )
                .multilineTextAlignment(.leading)
            Spacer()
            if isSelected {
                R.image.selectedIcon.image
            } else {
                R.image.unselectedIcon.image
            }
        }
    }
}

extension SelectAnswerView {

    struct Option: Identifiable, Equatable, Hashable {

        let id: String
        let text: String
    }
}
