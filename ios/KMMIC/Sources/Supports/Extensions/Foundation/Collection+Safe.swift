//
//  Collection+Safe.swift
//  KMMIC
//
//  Created by MarkG on 10/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Foundation

extension Collection {

    /// Returns the element at the given element if any, returns `nil`
    /// otherwise.
    subscript(safe index: Index) -> Iterator.Element? {
        startIndex ..< endIndex ~= index ? self[index] : nil
    }
}
