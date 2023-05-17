//
//  LoginViewModel.swift
//  KMMIC
//
//  Created by MarkG on 20/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Combine
import Factory

// sourcery: AutoMockable
class LoginViewModel: ObservableObject {

    @Injected(\.loginUseCase) private var loginUseCase

    private var cancellableBag = Set<AnyCancellable>()

    @Published var email = ""
    @Published var password = ""
    @Published var isAllValidated = false
    @Published var isLoading = false
    @Published var didLogin = false
    @Published var alertDescription: AlertDescription?

    init() {
        Publishers.CombineLatest($email, $password)
            .map { !$0.0.isEmpty && !$0.1.isEmpty }
            .assign(to: &$isAllValidated)
    }

    func login() {
        isLoading = true

        loginUseCase(email: email, password: password)
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                guard let self else { return }
                self.isLoading = false
                switch result {
                case let .failure(error):
                    self.alertDescription = error.alertDescription
                case .finished: break
                }
            } receiveValue: { [weak self] _ in
                guard let self else { return }
                self.didLogin = true
                self.isLoading = false
            }
            .store(in: &cancellableBag)
    }
}
