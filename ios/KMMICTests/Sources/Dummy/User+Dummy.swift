//
//  AuthToken+Dummy.swift
//  KMMIC
//
//  Created by MarkG on 20/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Shared

@testable import KMMIC

extension User {

    static let dummy = User(
        email: "email",
        name: "name",
        avatarUrl: "https://secure.gravatar.com/avatar/6733d09432e89459dba795de8312ac2d"
    )
}
