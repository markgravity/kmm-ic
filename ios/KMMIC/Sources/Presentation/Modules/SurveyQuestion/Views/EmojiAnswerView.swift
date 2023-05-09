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

    @Binding var selectedIndex: Int

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
            }
            Spacer()
        }
    }

    func isHighlighted(for index: Int) -> Bool {
        switch highlightStyle {
        case .leftItems: return index <= selectedIndex
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