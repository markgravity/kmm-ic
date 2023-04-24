//
//  HomeViewModel.swift
//  KMMIC
//
//  Created by MarkG on 24/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Combine
import Factory

final class HomeViewModel: ObservableObject {

    @Injected(\.getCurrentUserUseCase) private var getCurrentUserUseCase
    @Injected(\.dateHelper) private var dateHelper

    @Published var todayDateString: String = ""
    @Published var userAvatar: URL?

    init() {
        todayDateString = DateFormatter.wideNameDayMonth
            .string(from: dateHelper.today).uppercased()
        getCurrentUserUseCase()
            .receive(on: RunLoop.main)
            .map { URL(string: $0.avatarUrl) }
            .replaceError(with: nil)
            .assign(to: &$userAvatar)
    }
}
