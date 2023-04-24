//
//  View+Alert.swift
//  KMMIC
//
//  Created by MarkG on 20/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Foundation
import Shared
import SwiftUI

extension View {

    func alert(_ alertDescription: Binding<AlertDescription?>) -> some View {
        alert(item: alertDescription) {
            Alert(
                title: Text($0.title),
                message: Text($0.message)
            )
        }
    }
}

extension Error {

    var alertDescription: AlertDescription {
        let userInfo = (self as NSError).userInfo
        let title = R.string.localizable.alertWarningTitle()
        if userInfo.keys.contains("KotlinException"),
           let apiError = userInfo["KotlinException"] as? ApiError {
            return .init(title: title, message: apiError.message.string)
        }

        return .init(title: title, message: (self as NSError).localizedDescription)
    }
}
