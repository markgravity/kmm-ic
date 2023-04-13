//
//  ProgressHUD.swift
//  KMMIC
//
//  Created by MarkG on 13/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct ProgressHUD: View {

    var body: some View {
        HStack {
            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            .frame(
                width: 50.0,
                height: 50.0
            )
            .background(Color.white)
            .cornerRadius(8.0)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .background(Color.black.opacity(0.3))
        .ignoresSafeArea()
    }
}

struct ProgressHUD_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Image(R.image.appBackground.name)
                .resizable()
                .aspectRatio(contentMode: .fill)
            ProgressHUD()
        }
        .ignoresSafeArea()
    }
}
