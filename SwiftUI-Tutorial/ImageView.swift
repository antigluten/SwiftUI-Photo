//
//  ImageView.swift
//  SwiftUI-Tutorial
//
//  Created by va-gusev on 25.11.2023.
//

import Foundation

import SwiftUI

struct ImageView: View {
    
    @Namespace var namespace
    @State var show = false
    
    let image: UIImage?
    
    init(image: UIImage? = nil) {
        self.image = image
    }
    
    var body: some View {
        VStack {
            GeometryReader { proxy in
                if let image {
                    let ratio = image.size.width / image.size.height
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: proxy.size.width,
                               height: proxy.size.height / ratio,
                               alignment: .center)
                }
            }
        }
    }
}

#Preview { ImageView() }
