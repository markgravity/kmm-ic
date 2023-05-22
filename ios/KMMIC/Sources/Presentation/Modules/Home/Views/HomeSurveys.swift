//
//  HomeSurveys.swift
//  KMMIC
//
//  Created by MarkG on 25/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Factory
import NukeUI
import SwiftUI

struct HomeSurveys: View {

    @EnvironmentObject private var viewModel: HomeViewModel
    @InjectedObject(\.navigator) private var navigator: Navigator

    private var pageControl: some View {
        HStack(spacing: 10.0) {
            ForEach(0 ... viewModel.surveys.count - 1, id: \.self) { index in
                Circle()
                    .fill(index == viewModel.selectedSurveyIndex ? .white : .white.opacity(0.2))
                    .frame(width: 8.0, height: 8.0)
            }
            .padding(.bottom, 26.0)
        }
    }

    private var bottomContent: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            Spacer()

            pageControl

            if let survey = viewModel.selectedSurvey {
                Text(survey.title)
                    .font(.boldTitle)
                    .lineLimit(2)
                    .padding(.bottom, 16.0)
                    .foregroundColor(.white)
                HStack {
                    Text(survey.description)
                        .font(.regularBody)
                        .foregroundColor(.white.opacity(0.7))
                        .lineLimit(2)
                    Spacer(minLength: 20.0)
                    ArrowButton {
                        guard let survey = viewModel.selectedSurvey?.survey else { return }
                        let viewModel = SurveyDetailViewModel(survey: survey)
                        navigator.show(
                            screen: .surveyDetail(viewModel: viewModel),
                            by: .push
                        )
                    }
                }
            }
        }
        .padding(.horizontal, 20.0)
    }

    var body: some View {
        Group {
            if !viewModel.surveys.isEmpty {
                ZStack {
                    DarkBackground(url: viewModel.selectedSurvey?.coverImageURL)
                        .ignoresSafeArea()
                    bottomContent
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .swipe(.horizontal) { direction in
            switch direction {
            case .left where viewModel.canSelectPreviousSurvey:
                withAnimation(.linear(duration: 0.25)) {
                    self.viewModel.selectPreviousSurvey()
                }
            case .right where viewModel.canSelectNextSurvey:
                withAnimation(.linear(duration: 0.25)) {
                    self.viewModel.selectNextSurvey()
                }
            default: break
            }
        }
    }
}

struct HomeSurveys_Previews: PreviewProvider {
    static var previews: some View {
        HomeSurveys()
    }
}
