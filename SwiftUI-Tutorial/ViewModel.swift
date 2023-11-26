//
//  ViewModel.swift
//  SwiftUI-Tutorial
//
//  Created by va-gusev on 25.11.2023.
//

import Foundation
import UIKit
import Photos

final class ViewModel: ObservableObject {
    
    var images = [ImageInfoWrapper]() {
        didSet {
            objectWillChange.send()
        }
    }
    
    var isEnabled = false
    
    init() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            if case .authorized = status {
                self.isEnabled = true
            }
        }
    }
    
    func loadPhotos(width: CGFloat) {
        guard isEnabled else {
            return
        }
        
        let size = (width - 32) / 4
        let scale = UIScreen.main.scale
        let targetSize = CGSize(width: size * scale, height: size * scale)
        
        let options = PHFetchOptions()
        let fetchResults = PHAsset.fetchAssets(with: .image, options: options)
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.isNetworkAccessAllowed = false
        requestOptions.resizeMode = .exact
        requestOptions.deliveryMode = .highQualityFormat
        
        var images = [ImageInfoWrapper]()

        fetchResults.enumerateObjects { [weak self] asset, index, pointer in
            guard let self else {
                return
            }
            PHImageManager.default().requestImage(
                for: asset,
                targetSize: targetSize,
                contentMode: .aspectFill,
                options: requestOptions
            ) { image, info in
                guard let image else { return }
                let info = ImageInfoWrapper(image: image, index: index)
                images.append(info)
                
                if index == fetchResults.count - 1 {
                    self.images.removeAll()
                    self.images = images
                    DispatchQueue.main.async {
                        self.objectWillChange.send()
                    }
                }
            }
        }
    }
}

struct ImageInfoWrapper {
    var image: UIImage
    var index: Int
    var show: Bool = false
    var zIndex: Double = 0
}
