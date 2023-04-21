//
//  HomeHeader.swift
//  KMMIC
//
//  Created by MarkG on 21/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

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
                // swiftlint:disable line_length
                NetworkImage(url: .init(string: "https://thumbs.dreamstime.com/z/vector-illustration-avatar-dummy-logo-collection-image-icon-stock-isolated-object-set-symbol-web-137160339.jpg")) {
                    $0
                        .resizable()
                        .cornerRadius(18.0)
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
