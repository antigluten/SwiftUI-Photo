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
    
    var images = [UIImage]()
    
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
                self.images.append(image)
                
                if index == fetchResults.count - 1 {
                    DispatchQueue.main.async {
                        self.objectWillChange.send()
                    }
                }
            }
        }
    }
}
