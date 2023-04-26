//
//  ClearDarkLinearGradient.swift
//  KMMIC
//
//  Created by MarkG on 26/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct ClearDarkLinearGradient: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .background(
                LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
            )
            .opacity(0.6)
            .ignoresSafeArea()
    }
}

struct ClearDarkLinearGradient_Previews: PreviewProvider {
    static var previews: some View {
        ClearDarkLinearGradient()
    }
}
