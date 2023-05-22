//
//  FormAnswerView.swift
//  KMMIC
//
//  Created by MarkG on 09/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct FormAnswerView: View {

    @EnvironmentObject private var viewModel: SurveyQuestionViewModel

    @State private var data: Set<FieldData> = []

    private var fields: [Field] {
        let displayType = viewModel.surveyQuestionUIModel.displayType
        let answers = viewModel.surveyQuestionUIModel.answers

        return answers.map {
            var type: FormAnswerView.FieldType = .textField
            if displayType == .textarea {
                type = .textarea
            }

            return FormAnswerView.Field(
                id: $0.id,
                placeholder: $0.placeholder,
                type: type
            )
        }
    }

    var body: some View {
        VStack(spacing: 16.0) {
            ForEach(fields) { field in
                switch field.type {
                case .textField:
                    PrimaryTextField(field.placeholder, text: text(of: field))
                        .padding(.horizontal, 12.0)
                case .textarea:
                    Textarea(placeholder: field.placeholder, text: text(of: field))
                        .frame(maxHeight: 170.0)
                }
            }
        }
        .onChange(of: data) { data in
            viewModel.setAnswerInputs(
                data.map {
                    .init(id: $0.id, content: $0.content)
                }
            )
        }
    }

    func text(of field: Field) -> Binding<String> {
        return Binding<String>(
            get: {
                data.first {
                    $0.id == field.id
                }?.content ?? ""
            },
            set: {
                if let fieldData = data.first(where: {
                    $0.id == field.id
                }) {
                    data.remove(fieldData)
                }
                data.insert(
                    .init(id: field.id, content: $0)
                )
            }
        )
    }
}

extension FormAnswerView {

    enum FieldType {

        case textField
        case textarea
    }

    struct Field: Identifiable, Equatable, Hashable {

        let id: String
        let placeholder: String
        let type: FieldType
    }

    struct FieldData: Hashable, Equatable {

        let id: String
        let content: String?
    }
}
