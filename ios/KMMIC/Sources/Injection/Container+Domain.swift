//
//  Container+Domain.swift
//  KMMIC
//
//  Created by MarkG on 20/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Factory
import Shared

extension Container {

    var loginUseCase: Factory<LoginUseCase> {
        Factory(self) { LoginUseCaseImpl() }
    }
}