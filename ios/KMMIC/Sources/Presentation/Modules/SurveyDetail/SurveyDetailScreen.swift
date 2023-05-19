//
//  SurveyDetailScreen.swift
//  KMMIC
//
//  Created by MarkG on 27/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Factory
import NukeUI
import SwiftUI

struct SurveyDetailScreen: View {

    @EnvironmentObject var navigator: Navigator
    @EnvironmentObject var viewModel: SurveyDetailViewModel

    var body: some View {
        ZStack {
            DarkBackground(url: viewModel.survey.coverImageURL)
                .accessibility(.surveyDetail(.backgroundImage))
            VStack(alignment: .leading) {
                Text(viewModel.survey.title)
                    .font(.boldTitle)
                    .padding(.bottom, 16.0)
                    .foregroundColor(.white)
                    .accessibility(.surveyDetail(.titleText))
                Text(viewModel.survey.description)
                    .font(.regularBody)
                    .foregroundColor(.white.opacity(0.7))
                    .accessibility(.surveyDetail(.descriptionText))
                Spacer()
                HStack {
                    Spacer()
                    PrimaryButton(R.string.localizable.surveyDetailScreenStartButtonTitle()) {
                        guard let surveyQuestionViewModel = viewModel.surveyQuestionViewModel else { return }
                        navigator.show(
                            screen: .surveyQuestion(viewModel: surveyQuestionViewModel),
                            by: .presentCover
                        )
                    }
                    .frame(width: 140.0)
                    .accessibility(.surveyDetail(.startButton))
                }
            }
            .padding([.top, .horizontal], 20.0)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    navigator.goBack()
                } label: {
                    R.image.backAccentIcon.image
                }
                .accessibility(.surveyDetail(.backButton))
            }
        }
        .navigationBarBackButtonHidden()
        .progressHUD($viewModel.isLoading)
        .alert($viewModel.alertDescription)
        .onLoad {
            viewModel.fetch()
        }
    }
}
