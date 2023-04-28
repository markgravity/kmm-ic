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
            Color.gray
                .ignoresSafeArea()
            HomeHeader()
                .padding(.horizontal, 20.0)
                .padding(.top, 30.0)
        }
        .environmentObject(viewModel)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
