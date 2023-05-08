//
//  Font+App.swift
//  KMMIC
//
//  Created by MarkG on 21/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

extension Font {

    private enum Neuzei {

        case regular
        case bold

        var name: String {
            switch self {
            case .regular:
                return R.font.neuzeitSLTStdBook.name
            case .bold:
                return R.font.neuzeitSLTStdBookHeavy.name
            }
        }
    }

    /// Weight: 800, Size: 13.0
    static let boldSmall: Font = .neuzei(.bold, size: 13.0)

    /// Weight: 400, Size: 13.0
    static let regularSmall: Font = .neuzei(size: 13.0)

    /// Weight: 800, Size: 15.0
    static let boldMedium: Font = .neuzei(.bold, size: 15.0)

    /// Weight: 400, Size: 17.0
    static let regularBody: Font = .neuzei()

    /// Weight: 400, Size: 20.0
    static let regularLarge: Font = .neuzei(size: 20.0)

    /// Weight: 400, Size: 11.0
    static let regularTiny: Font = .neuzei(size: 11.0)

    /// Weight: 800, Size: 17.0
    static let boldBody: Font = .neuzei(.bold)

    /// Weight: 800, Size: 20.0
    static let boldLarge: Font = .neuzei(.bold, size: 20.0)

    /// Weight: 800, Size: 28.0
    static let boldTitle: Font = .neuzei(.bold, size: 28.0)

    /// Weight: 800, Size: 34.0
    static let boldLargeTitle: Font = .neuzei(.bold, size: 34.0)

    private static func neuzei(_ weigth: Neuzei = .regular, size: CGFloat = 17.0) -> Font {
        return Font.custom(weigth.name, size: size)
    }
}
