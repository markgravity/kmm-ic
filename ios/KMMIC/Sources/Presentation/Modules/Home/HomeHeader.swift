//
//  HomeHeader.swift
//  KMMIC
//
//  Created by MarkG on 21/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import NukeUI
import SwiftUI

struct HomeHeader: View {

    var body: some View {
        // TODO: Update with real data
        HStack {
            VStack(alignment: .leading, spacing: 4.0) {
                Text("Monday, JUNE 15")
                    .font(.boldSmall)
                    .foregroundColor(.white)
                Text(R.string.localizable.homeScreenTodayText)
                    .font(.boldLargeTitle)
                    .foregroundColor(.white)
            }
            Spacer()
            ZStack {
                Circle()
                    .fill(Color.black)
                LazyImage(url: .init(string: "https://thumbs.dreamstime.com/z/37160339.jpg")) {
                    if let image = $0.image {
                        image
                            .resizable()
                            .cornerRadius(18.0)
                    } else {
                        EmptyView()
                    }
                }
            }
            .frame(width: 36.0, height: 36.0)
        }
    }
}

struct HomeHeader_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeader()
    }
}
