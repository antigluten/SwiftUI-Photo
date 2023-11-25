//
//  ContentView.swift
//  SwiftUI-Tutorial
//
//  Created by va-gusev on 22.11.2023.
//

import SwiftUI
import Photos

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ScrollView(.vertical) {
                    let width = size(width: proxy.size.width)
                    LazyVGrid(columns: columns(width: proxy.size.width)) {
                        ForEach(0..<viewModel.images.count, id: \.self) { index in
                            NavigationLink {
                                ImageView(image: viewModel.images[index])
                            } label: {
                                let image = viewModel.images[index]
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: width, height: width, alignment: .center)
                                    .border(Color.clear)
                                    .clipped()
                            }
                        }
                    }.onAppear {
                        viewModel.loadPhotos(width: proxy.size.width)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    func columns(width: CGFloat) -> [GridItem] {
        return (0 ..< 4).map { _ in
            return GridItem(.fixed(size(width: width)), spacing: 0, alignment: .center)
        }
    }
    
    func size(width: CGFloat) -> CGFloat {
        return (width - 32) / 4
    }
}

#Preview {
    ContentView()
}
