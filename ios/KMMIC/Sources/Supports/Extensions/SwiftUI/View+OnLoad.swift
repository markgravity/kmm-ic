//
//  View+OnLoad.swift
//  KMMIC
//
//  Created by MarkG on 28/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

private struct ViewDidLoadModifier: ViewModifier {

    @State private var viewDidLoad = false
    let action: (() -> Void)?

    func body(content: Content) -> some View {
        content
            .onAppear {
                if viewDidLoad == false {
                    viewDidLoad = true
                    action?()
                }
            }
    }
}

extension View {

    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(action: action))
    }
}
