//
//  EmojiAnswerView.swift
//  KMMIC
//
//  Created by MarkG on 08/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct EmojiAnswerView: View {

    let emojis: [String]
    var highlightStyle: EmojiHighlightStyle = .leftItems

    @Binding var selected: Int

    var body: some View {
        HStack(spacing: 16.0) {
            Spacer()
            ForEach(0 ..< emojis.count, id: \.self) { index in
                Button {
                    selected = index
                } label: {
                    Text(emojis[index])
                        .font(.boldTitle)
                        .opacity(isHighlighted(for: index) ? 1.0 : 0.5)
                }
            }
            Spacer()
        }
    }

    func isHighlighted(for index: Int) -> Bool {
        switch highlightStyle {
        case .leftItems: return index <= selected
        case .one: return index == selected
        }
    }
}

extension EmojiAnswerView {

    enum EmojiHighlightStyle {

        case leftItems
        case one
    }
}
