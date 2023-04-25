//
//  AppTextField.swift
//  KMMIC
//
//  Created by MarkG on 18/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct PrimaryTextField: View {

    @Binding private var text: String
    private let title: String
    private let isSecured: Bool
    private let rightContent: AnyView?

    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(title)
                        .font(R.font.neuzeitSLTStdBook.font(size: 17.0))
                        .foregroundColor(.white.opacity(0.3))
                }
                makeTextField()
                    .font(R.font.neuzeitSLTStdBook.font(size: 17.0))
                    .foregroundColor(Color.white)
            }
            if let rightContent {
                rightContent
            }
        }
        .padding()
        .background(Color.white.opacity(0.18))
        .cornerRadius(12.0)
    }

    init(
        _ title: String,
        text: Binding<String>,
        isSecured: Bool = false
    ) {
        self.title = title
        _text = text
        self.isSecured = isSecured
        rightContent = nil
    }

    init<Content: View>(
        _ title: String,
        text: Binding<String>,
        isSecured: Bool = false,
        rightContent: () -> Content
    ) {
        self.title = title
        _text = text
        self.isSecured = isSecured
        self.rightContent = AnyView(rightContent())
    }

    private func makeTextField() -> some View {
        Group {
            if isSecured {
                SecureField("", text: $text)
            } else {
                TextField("", text: $text)
            }
        }
    }
}

struct AppTextField_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryTextField("Email", text: .constant(""))
    }
}
