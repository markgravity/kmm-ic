// swiftlint:disable:this file_name
//
//  Animation+Completion.swift
//  KMMIC
//
//  Created by MarkG on 20/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct AnimationObserverModifier<Value: VectorArithmetic>: AnimatableModifier {

    private let observedValue: Value
    private let onChange: ((Value) -> Void)?
    private let onComplete: (() -> Void)?

    var animatableData: Value {
        didSet {
            notifyProgress()
        }
    }

    init(
        for observedValue: Value,
        onChange: ((Value) -> Void)?,
        onComplete: (() -> Void)?
    ) {
        self.observedValue = observedValue
        self.onChange = onChange
        self.onComplete = onComplete
        animatableData = observedValue
    }

    func body(content: Content) -> some View {
        content
    }

    private func notifyProgress() {
        DispatchQueue.main.async {
            onChange?(animatableData)
            if animatableData == observedValue {
                onComplete?()
            }
        }
    }
}

extension View {

    func animationObserver<Value: VectorArithmetic>(
        for value: Value,
        onChange: ((Value) -> Void)? = nil,
        onComplete: (() -> Void)? = nil
    ) -> some View {
        modifier(
            AnimationObserverModifier(
                for: value,
                onChange: onChange,
                onComplete: onComplete
            )
        )
    }
}
