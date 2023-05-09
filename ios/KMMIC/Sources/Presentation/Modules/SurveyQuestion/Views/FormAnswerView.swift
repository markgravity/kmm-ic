//
//  FormAnswerView.swift
//  KMMIC
//
//  Created by MarkG on 09/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct FormAnswerView: View {

    let fields: [Field]
    let data: Binding<Set<FieldData>>

    var body: some View {
        VStack(spacing: 16.0) {
            ForEach(fields) { field in
                PrimaryTextField(field.placeholder, text: text(of: field))
                    .padding(.horizontal, 12.0)
            }
        }
    }

    func text(of field: Field) -> Binding<String> {
        return Binding<String>(
            get: {
                data.wrappedValue.first {
                    $0.id == field.id
                }?.content ?? ""
            },
            set: {
                if let fieldData = data.wrappedValue.first(where: {
                    $0.id == field.id
                }) {
                    data.wrappedValue.remove(fieldData)
                }
                data.wrappedValue.insert(
                    .init(id: field.id, content: $0)
                )
            }
        )
    }
}

extension FormAnswerView {

    struct Field: Identifiable, Equatable, Hashable {

        let id: String
        let placeholder: String
    }

    struct FieldData: Hashable {

        let id: String
        let content: String?
    }
}
