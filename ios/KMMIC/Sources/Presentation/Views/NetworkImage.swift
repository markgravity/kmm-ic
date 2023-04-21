//
//  NetworkImage.swift
//  KMMIC
//
//  Created by MarkG on 21/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SDWebImageSwiftUI
import SwiftUI

struct NetworkImage<Content: View>: View {

    @StateObject private var imageManager: ImageManager = .init()

    let url: URL?
    let content: (Image) -> Content

    var body: some View {
        Group {
            if let image = imageManager.image {
                content(Image(uiImage: image))
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
        .onAppear { self.imageManager.load(url: url) }
        .onDisappear { self.imageManager.cancel() }
    }

    init(url: URL?) where Content == Image {
        self.url = url
        content = { $0 }
    }

    init(url: URL?, content: @escaping (Image) -> Content) {
        self.url = url
        self.content = content
    }
}
