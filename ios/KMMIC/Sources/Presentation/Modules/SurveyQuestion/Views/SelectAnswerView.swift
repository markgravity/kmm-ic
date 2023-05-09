//
//  SelectAnswerView.swift
//  KMMIC
//
//  Created by MarkG on 09/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct SelectAnswerView: View {

    let options: [Option]
    let selections: Binding<Set<Option>>

    var body: some View {
        ScrollView {
            VStack {
                ForEach(options) { option in
                    Button(
                        action: {
                            if selections.wrappedValue.contains(option) {
                                selections.wrappedValue.remove(option)
                            } else {
                                selections.wrappedValue.insert(option)
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
    }

    @ViewBuilder
    func optionView(of option: Option) -> some View {
        let isSelected = selections.wrappedValue.contains(option)
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
