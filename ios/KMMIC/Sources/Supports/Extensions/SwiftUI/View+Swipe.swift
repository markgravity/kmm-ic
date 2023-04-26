//
//  View+Swipe.swift
//  KMMIC
//
//  Created by MarkG on 26/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

extension DragGesture.Value {

    struct Direction: OptionSet {

        let rawValue: Int

        static let left = Direction(rawValue: 1 << 0)
        static let right = Direction(rawValue: 1 << 1)
        // swiftlint:disable identifier_name
        static let up = Direction(rawValue: 1 << 2)
        // swiftlint:enable identifier_name
        static let down = Direction(rawValue: 1 << 3)

        static let horizontal: Direction = [.left, .right]

        static let all: Direction = [.left, .right, .up, .down]
    }
}

extension DragGesture.Value {

    func detectDirection(_ tolerance: Double) -> Direction? {
        if startLocation.x < location.x - tolerance { return .left }
        if startLocation.x > location.x + tolerance { return .right }
        if startLocation.y > location.y + tolerance { return .up }
        if startLocation.y < location.y - tolerance { return .down }
        return nil
    }
}

extension View {

    func swipe(
        _ direction: DragGesture.Value.Direction = .all,
        tolerance: Double = 24.0,
        action: @escaping (DragGesture.Value.Direction) -> Void
    ) -> some View {
        simultaneousGesture(
            DragGesture()
                .onEnded { value in
                    guard let detectedDirection = value.detectDirection(tolerance),
                          direction.contains(detectedDirection) else { return }
                    action(detectedDirection)
                }
        )
    }
}
