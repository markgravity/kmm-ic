//
//  SurveyDetailScreen.swift
//  KMMIC
//
//  Created by MarkG on 27/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import NukeUI
import SwiftUI

struct SurveyDetailScreen: View {

    var body: some View {
        ZStack {
            DarkBackground(url: .init(string: "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_l"))
            VStack(alignment: .leading) {
                Text("Wokring from home Check-In")
                    .font(.boldTitle)
                    .padding(.bottom, 16.0)
                    .foregroundColor(.white)
                Text("We would like to know how you feel about our work from home (WFH) experience.")
                    .font(.regularBody)
                    .foregroundColor(.white.opacity(0.7))
                Spacer()
                HStack {
                    Spacer()
                    PrimaryButton(R.string.localizable.surveyDetailScreenStartButtonTitle()) {
                        // TODO: Begin survey
                    }
                    .frame(width: 140.0)
                }
            }
            .padding(.horizontal, 20.0)
            .padding(.top, 20.0)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    // TODO: Navigate back
                } label: {
                    R.image.backAccentIcon.image
                }
            }
        }
    }
}

struct SurveyDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        SurveyDetailScreen()
    }
}
