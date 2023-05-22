//
//  SurveyQuestionScreen.swift
//  KMMIC
//
//  Created by MarkG on 08/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Factory
import SwiftUI

struct SurveyQuestionScreen: View {

    @InjectedObject(\.navigator) var navigator: Navigator

    @StateObject var viewModel: SurveyQuestionViewModel

    var body: some View {
        ZStack {
            DarkBackground(url: viewModel.surveyQuestionUIModel.coverImageURL)
                .accessibility(.surveyQuestion(.backgroundImage))
            VStack(alignment: .leading) {
                Text(viewModel.surveyQuestionUIModel.step)
                    .font(.boldMedium)
                    .foregroundColor(.white.opacity(0.5))
                    .padding(.bottom, 8.0)
                    .accessibility(.surveyQuestion(.stepText))
                Text(viewModel.surveyQuestionUIModel.title)
                    .font(.boldLargeTitle)
                    .foregroundColor(.white)
                    .accessibility(.surveyQuestion(.questionText))
                Spacer()
                answerView
                    .environmentObject(viewModel)
                Spacer()
                bottomButton
            }
            .padding(.horizontal, 20.0)
            .padding(.top, 32.0)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.showExitAlert()
                } label: {
                    R.image.closeIcon.image
                }
                .accessibility(.surveyQuestion(.backButton))
            }
        }
        .navigationBarBackButtonHidden()
        .alert(isPresented: $viewModel.isExitAlertPresented, content: { exitAlert })
        .alert($viewModel.alertDescription)
        .progressHUD($viewModel.isLoading)
        .onChange(of: viewModel.didSubmitSurvey) {
            guard $0 else { return }
            navigator.show(screen: .thank, by: .push)
        }
    }

    @ViewBuilder var answerView: some View {
        let displayType = viewModel.surveyQuestionUIModel.displayType

        switch displayType {
        case .heart, .star, .smiley:
            EmojiAnswerView()
                .accessibility(.surveyQuestion(.emojiAnswer))
        case .dropdown:
            DropdownAnswerView()
                .accessibility(.surveyQuestion(.dropdownAnswer))
        case .textfield, .textarea:
            FormAnswerView()
                .accessibility(.surveyQuestion(.formAnswer))
        case .choice:
            SelectAnswerView()
                .frame(maxHeight: 170.0)
                .accessibility(.surveyQuestion(.selectAnswer))
        case .nps:
            NPSAnswerView()
                .accessibility(.surveyQuestion(.npsAnswer))
        default:
            EmptyView()
        }
    }

    @ViewBuilder var bottomButton: some View {
        HStack {
            Spacer()
            if viewModel.isLast {
                PrimaryButton(R.string.localizable.surveyQuestionScreenSubmitButtonTitle()) {
                    viewModel.submitSurvey()
                }
                .frame(width: 120.0)
                .accessibility(.surveyQuestion(.submitButton))
            } else {
                ArrowButton {
                    guard let nextViewModel = viewModel.getNextViewModel() else { return }
                    navigator.show(screen: .surveyQuestion(viewModel: nextViewModel), by: .push)
                }
                .accessibility(.surveyQuestion(.nextButton))
            }
        }
        .disabled(!viewModel.isAllValid)
    }

    var exitAlert: Alert {
        Alert(
            title: Text(R.string.localizable.alertWarningTitle()),
            message: Text(R.string.localizable.surveyQuestionScreenExitAlertMessage()),
            primaryButton: .default(Text(R.string.localizable.alertYesButtonTitle())) { navigator.pop() },
            secondaryButton: .cancel(Text(R.string.localizable.alertCancelButtonTitle())) {}
        )
    }
}
