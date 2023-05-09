//
//  SurveyQuestionScreen.swift
//  KMMIC
//
//  Created by MarkG on 08/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct SurveyQuestionScreen: View {

    @StateObject var viewModel: SurveyQuestionViewModel

    var body: some View {
        ZStack {
            DarkBackground(url: viewModel.surveyQuestionUIModel.coverImageURL)
            VStack(alignment: .leading) {
                Text(viewModel.surveyQuestionUIModel.step)
                    .font(.boldMedium)
                    .foregroundColor(.white.opacity(0.5))
                    .padding(.bottom, 8.0)
                Text(viewModel.surveyQuestionUIModel.title)
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
