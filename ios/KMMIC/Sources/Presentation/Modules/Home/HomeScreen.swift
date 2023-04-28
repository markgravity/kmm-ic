//
//  HomeScreen.swift
//  KMMIC
//
//  Created by MarkG on 21/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct HomeScreen: View {

    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        ZStack(alignment: .top) {
            HomeSurveys()
            HomeHeader()
                .padding(.horizontal, 20.0)
                .padding(.top, 30.0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .environmentObject(viewModel)
        .progressHUD($viewModel.isLoading)
        .onLoad {
            viewModel.fetch()
        }
        .swipe(.down, tolerance: 100.0) { _ in
            viewModel.refresh()
        }
        .alert($viewModel.alertDescription)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
