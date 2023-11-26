//
//  ImageItemContainerView.swift
//  SwiftUI-Tutorial
//
//  Created by va-gusev on 26.11.2023.
//

import Foundation
import SwiftUI

struct ContainerInfo {
    var index: Int
    var zIndex: Int
}

struct ImageItemContainerView: View {
    
    var namespace: Namespace.ID
    
    var containerInfo: ContainerInfo
    var image: UIImage?
    @EnvironmentObject var model: Model

    var body: some View {
        VStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "image\(containerInfo.index)", in: namespace)
            }
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                model.openDetail = true
                model.selectedIndex = containerInfo.index
            }
        }
    }
}

#Preview {
    @Namespace var namespace
    let containerInfo = ContainerInfo(index: 0, zIndex: 0)
    return ImageItemContainerView(namespace: namespace,
                                  containerInfo: containerInfo)
    .environmentObject(Model())
}
