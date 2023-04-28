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

    @Environment(\.presentationMode) var presentation
    @StateObject var viewModel: SurveyDetailViewModel

    var body: some View {
        ZStack {
            DarkBackground(url: viewModel.survey.coverImageURL)
            VStack(alignment: .leading) {
                Text(viewModel.survey.title)
                    .font(.boldTitle)
                    .padding(.bottom, 16.0)
                    .foregroundColor(.white)
                Text(viewModel.survey.description)
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
            .padding([.top, .horizontal], 20.0)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentation.wrappedValue.dismiss()
                } label: {
                    R.image.backAccentIcon.image
                }
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

struct SurveyDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        SurveyDetailScreen(
            viewModel: .init(
                survey: .init(
                    id: "",
                    title: "",
                    description: "",
                    isActive: true,
                    coverImageUrl: ""
                )
            )
        )
    }
}
