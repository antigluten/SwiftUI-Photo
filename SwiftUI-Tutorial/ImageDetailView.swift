//
//  ImageDetailView.swift
//  SwiftUI-Tutorial
//
//  Created by va-gusev on 26.11.2023.
//

import Foundation
import SwiftUI

class Model: ObservableObject {
    @Published var openDetail = false
    @Published var selectedIndex = 0
}

struct ImageDetailView: View {
    
    var namespace: Namespace.ID
    var containerInfo: ContainerInfo
    var image: UIImage?
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        VStack(alignment: .leading) {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "image\(containerInfo.index)", in: namespace)
            }
        }
        .zIndex(1)
        .padding(20)
        .onTapGesture {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                model.openDetail = false
                model.selectedIndex = containerInfo.index
            }
        }
    }
}

#Preview {
    @Namespace var namespace
    let containerInfo = ContainerInfo(index: 0, zIndex: 0)
    return ImageDetailView(namespace: namespace, containerInfo: containerInfo)
        .environmentObject(Model())
}
