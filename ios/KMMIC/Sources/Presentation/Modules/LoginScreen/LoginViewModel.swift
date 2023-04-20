//
//  LoginViewModel.swift
//  KMMIC
//
//  Created by MarkG on 20/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Combine
import Factory

final class LoginViewModel: ObservableObject {

    @Injected(\.loginUseCase) private var loginUseCase

    private var cancellableBag = Set<AnyCancellable>()

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isAllValidated: Bool = false
    @Published var isLoading: Bool = false
    @Published var didLogin: Bool = false
    @Published var alertDescription: AlertDescription?

    func login() {
        isLoading = true
        loginUseCase.callAsPublisher(email: email, password: password)
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
