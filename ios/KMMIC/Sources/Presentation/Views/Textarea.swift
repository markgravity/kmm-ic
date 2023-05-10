//
//  Textarea.swift
//  KMMIC
//
//  Created by MarkG on 09/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct Textarea: View {

    let placeholder: String?

    @Binding var text: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder.string)
                    .foregroundColor(Color.primary.opacity(0.25))
                    .padding()
                    .padding(.leading, 2.0)
                    .padding(.top, 4.0)
            }
            if #available(iOS 16.0, *) {
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .primaryFieldStyle()
            } else {
                TextEditor(text: $text)
                    .primaryFieldStyle()
            }
        }
        .onAppear {
            UITextView.appearance().backgroundColor = .clear
        }
        .onDisappear {
            UITextView.appearance().backgroundColor = nil
        }
    }
}
