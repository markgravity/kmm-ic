//
//  HomeScreenSpec.swift
//  KMMICKIFUITests
//
//  Created by MarkG on 18/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Factory
import Nimble
import Quick

@testable import KMMIC

final class HomeScreenSpec: QuickSpec {

    override func spec() {

        describe("a Home screen") {

            var navigator: NavigatorMock!
            var viewModel: HomeViewModelMock!
            var didSetScreen = false

            beforeEach {
                guard !didSetScreen else { return }
                didSetScreen = true
                navigator = .init()
                viewModel = .init()
                viewModel.underlyingSurveys = [.init(survey: .dummy)]

                Container.shared.homeViewModel.register {
                    viewModel
                }
                self.app().setScreen(screen: .home, navigator: navigator)
                self.tester().waitForAnimationsToFinish(withTimeout: 5.0, stabilizationTime: 10.0)
            }

            it("triggers viewModel to call fetch") {
                expect(viewModel.fetchCalled).toEventually(beTrue())
            }

            context("when swiping from top to bottom") {

                beforeEach {
                    self.tester().swipeView(withViewID: .home(.surveys), in: .down)
                }

                it("triggers viewModel to call refresh") {
                    expect(viewModel.refreshCalled).toEventually(beTrue())
                }
            }

            context("when viewModel.isLoading is true") {

                beforeEach {
                    viewModel.underlyingIsLoading = true
                    viewModel.objectWillChange.send()
                }

                it("show the skeleton loading") {
                    self.tester().waitForView(withViewID: .home(.skeletonLoading))
                }
            }

            context("when viewModel.isLoading is false") {

                beforeEach {
                    viewModel.underlyingIsLoading = false
                    viewModel.objectWillChange.send()
                }

                it("show the surveys") {
                    self.tester().waitForView(withViewID: .home(.surveys))
                }

                it("show the header") {
                    self.tester().waitForView(withViewID: .home(.header))
                }
            }

            context("when viewModel.isRefreshing is true") {

                beforeEach {
                    viewModel.underlyingIsRefreshing = true
                    viewModel.objectWillChange.send()
                    self.tester().waitForAnimationsToFinish()
                }

                afterEach {
                    viewModel.underlyingIsRefreshing = false
                    viewModel.objectWillChange.send()
                    self.tester().waitForAnimationsToFinish()
                }

                it("shows Progress HUD") {
                    self.tester().waitForView(withViewID: .general(.progressHUD))
                }
            }
        }
    }
}
