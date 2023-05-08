//
//  SurveyQuestionScreen.swift
//  KMMIC
//
//  Created by MarkG on 08/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct SurveyQuestionScreen: View {

    var body: some View {
        ZStack {
            DarkBackground(url: URL(string: "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_"))
            VStack(alignment: .leading) {
                Text("1/5")
                    .font(.boldMedium)
                    .foregroundColor(.white.opacity(0.5))
                    .padding(.bottom, 8.0)
                Text("How fulfilled did you feel during this WFH period?")
                    .font(.boldLargeTitle)
                    .foregroundColor(.white)
                Spacer()
                HStack {
                    Spacer()
                    ArrowButton {}
                }
            }
            .padding(.horizontal, 20.0)
            .padding(.top, 32.0)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // TODO: Show confirm alert
                } label: {
                    R.image.closeIcon.image
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct SurveyQuestionScreen_Previews: PreviewProvider {

    static var previews: some View {
        SurveyQuestionScreen()
    }
}
