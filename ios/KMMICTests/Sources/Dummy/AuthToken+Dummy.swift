//
//  AuthToken+Dummy.swift
//  KMMIC
//
//  Created by MarkG on 20/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Shared

@testable import KMMIC

extension AuthToken {

    static let dummy = AuthToken(
        accessToken: "access_token",
        tokenType: "token_type",
        expiresIn: 1,
        refreshToken: "refresh_token",
        createdAt: 1
    )
}
