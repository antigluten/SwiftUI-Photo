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

    @Namespace var namespace
    
    @EnvironmentObject var model: Model

    var body: some View {
        ZStack { 
            GeometryReader { proxy in
                if model.openDetail {
                    detail
                }
                
                ScrollView(.vertical) {
                    Text("Photos")
                        .font(.title.weight(.bold))
                    
                    LazyVGrid(columns: columns(width: proxy.size.width),
                              spacing: 10) {
                        ForEach(viewModel.images.indices, id: \.self) { index in
                            let containerInfo = ContainerInfo(index: index,
                                                              zIndex: 0)
                            ImageItemContainerView(namespace: namespace,
                                                   containerInfo: containerInfo,
                                                   image: viewModel.images[index].image)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .scrollIndicators(.never)
                .onAppear {
                    viewModel.loadPhotos(width: proxy.size.width)
                }
            }
        }
    }
    
    var detail: some View {
        ForEach(viewModel.images.indices, id: \.self) { index in
            if index == model.selectedIndex {
                let containerInfo = ContainerInfo(index: index, zIndex: 0)
                ImageDetailView(namespace: namespace,
                                containerInfo: containerInfo,
                                image: viewModel.images[index].image)
            }
        }
    }
        
    func columns(width: CGFloat) -> [GridItem] {
        let numberOfColumns: CGFloat = 3
        let size = size(width: width, numberOfColumns: numberOfColumns)
        return (0 ..< Int(numberOfColumns)).map { _ in
            return GridItem(.fixed(size),
                            spacing: 10,
                            alignment: .center)
        }
    }
    
    func size(width: CGFloat, numberOfColumns: CGFloat = 3) -> CGFloat {
        return (width - 32) / numberOfColumns - 10
    }
}

#Preview {
    ContentView()
        .environmentObject(Model())
}
