//
//  ProgressHUD.swift
//  KMMIC
//
//  Created by MarkG on 13/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

private struct ProgressHUDModifier: ViewModifier {

    let isPresented: Binding<Bool>

    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content.overlay {
                ProgressHUD(isPresented: isPresented)
            }
        } else {
            ZStack {
                content
                ProgressHUD(isPresented: isPresented)
            }
            .ignoresSafeArea()
        }
    }
}

struct ProgressHUD: View {

    @Binding var isPresented: Bool

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
        .opacity(isPresented ? 1.0 : 0.0)
        .animation(.easeIn(duration: 0.3), value: isPresented)
    }
}

extension View {

    func progressHUD(_ isPresented: Binding<Bool>) -> some View {
        modifier(ProgressHUDModifier(isPresented: isPresented))
    }
}

struct ProgressHUD_Previews: PreviewProvider {
    static var previews: some View {
        Image(R.image.appBackground.name)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .progressHUD(.constant(true))
    }
}
