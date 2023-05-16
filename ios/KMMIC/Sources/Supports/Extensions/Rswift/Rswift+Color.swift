// swiftlint:disable:this file_name
//
//  Rswift+Color.swift
//  KMMIC
//
//  Created by MarkG on 15/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import RswiftResources
import SwiftUI

extension ColorResource {

    func callAsFunction() -> Color {
        Color(name)
    }
}
