// swiftlint:disable:this file_name
//
//  Rswift+Font.swift
//  KMMIC
//
//  Created by MarkG on 18/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import RswiftResources
import SwiftUI

extension FontResource {

    func font(size: CGFloat) -> Font {
        Font.custom(name, size: size)
    }
}
