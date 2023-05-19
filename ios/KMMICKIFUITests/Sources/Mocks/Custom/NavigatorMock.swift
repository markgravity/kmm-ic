//  NavigatorMock.swift
//  KMMICKIFUITests
//
//  Created by MarkG on 15/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

// swift-format-ignore-file
import FlowStacks
import Foundation

@testable import KMMIC

// swiftlint:disable type_contents_order
class NavigatorMock: Navigator {

    // MARK: - show

    var showScreenByCallsCount = 0
    var showScreenByCalled: Bool {
        showScreenByCallsCount > 0
    }

    var showScreenByReceivedArguments: (screen: Navigator.Screen, transition: Navigator.Transition)?
    var showScreenByReceivedInvocations: [(screen: Navigator.Screen, transition: Navigator.Transition)] = []
    var showScreenByClosure: ((Navigator.Screen, Navigator.Transition) -> Void)?

    override func show(screen: Navigator.Screen, by transition: Navigator.Transition) {
        showScreenByCallsCount += 1
        showScreenByReceivedArguments = (screen: screen, transition: transition)
        showScreenByReceivedInvocations.append((screen: screen, transition: transition))
        showScreenByClosure?(screen, transition)
    }

    // MARK: - goBack

    var goBackCallsCount = 0
    var goBackCalled: Bool {
        goBackCallsCount > 0
    }

    var goBackClosure: (() -> Void)?

    override func goBack() {
        goBackCallsCount += 1
        goBackClosure?()
    }

    // MARK: - goBackToRoot

    var goBackToRootCallsCount = 0
    var goBackToRootCalled: Bool {
        goBackToRootCallsCount > 0
    }

    var goBackToRootClosure: (() -> Void)?

    override func goBackToRoot() {
        goBackToRootCallsCount += 1
        goBackToRootClosure?()
    }

    // MARK: - pop

    var popCallsCount = 0
    var popCalled: Bool {
        popCallsCount > 0
    }

    var popClosure: (() -> Void)?

    override func pop() {
        popCallsCount += 1
        popClosure?()
    }

    // MARK: - dismiss

    var dismissCallsCount = 0
    var dismissCalled: Bool {
        dismissCallsCount > 0
    }

    var dismissClosure: (() -> Void)?

    override func dismiss() {
        dismissCallsCount += 1
        dismissClosure?()
    }

    // MARK: - steps

    var stepsRoutesCallsCount = 0
    var stepsRoutesCalled: Bool {
        stepsRoutesCallsCount > 0
    }

    var stepsRoutesReceivedRoutes: ((inout Routes<Screen>) -> Void)?
    var stepsRoutesReceivedInvocations: [(inout Routes<Screen>) -> Void] = []
    var stepsRoutesClosure: (((inout Routes<Screen>) -> Void) -> Void)?

    override
    func steps(routes: @escaping (inout Routes<Screen>) -> Void) {
        stepsRoutesCallsCount += 1
        stepsRoutesReceivedRoutes = routes
        stepsRoutesReceivedInvocations.append(routes)
        stepsRoutesClosure?(routes)
    }
}

// swiftlint:enable type_contents_order
