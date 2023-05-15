//
//  DropdownAnswerView.swift
//  KMMIC
//
//  Created by MarkG on 09/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct DropdownAnswerView: View {

    let options: [Option]
    @Binding var selection: Option?

    var body: some View {
        Picker("", selection: $selection) {
            ForEach(options) { option in
                let font = selection == option
                    ? Font.boldLarge
                    : Font.regularLarge
                Text(option.text)
                    .font(font)
                    .foregroundColor(Color.white)
                    .tag(option as Option?)
                if option != options.last {
                    Divider()
                        .frame(minHeight: 0.5)
                        .background(Color.white)
                }
            }
        }
        .pickerStyle(.wheel)
        .padding(20.0)
    }
}

extension DropdownAnswerView {

    struct Option: Identifiable, Equatable, Hashable {

        let id: String
        let text: String
    }
}
