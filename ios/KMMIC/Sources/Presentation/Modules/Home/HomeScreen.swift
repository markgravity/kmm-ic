//
//  HomeScreen.swift
//  KMMIC
//
//  Created by MarkG on 21/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Factory
import SwiftUI

struct HomeScreen: View {

    @InjectedObject(\.homeViewModel) var viewModel: HomeViewModel

    var body: some View {
        ZStack(alignment: .top) {
            if viewModel.isLoading {
                HomeSkeleton()
                    .accessibility(.home(.skeletonLoading))
            } else {
                HomeSurveys()
                    .accessibility(.home(.surveys))
                HomeHeader()
                    .padding(.horizontal, 20.0)
                    .padding(.top, 30.0)
                    .accessibility(.home(.header))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .environmentObject(viewModel)
        .progressHUD($viewModel.isRefreshing)
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
