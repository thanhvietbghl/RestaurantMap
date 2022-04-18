//
//  UIImage+Extention.swift
//  RestaurantMap
//
//  Created by Viet Phan on 15/04/2022.
//

import Foundation
import Kingfisher
import Photos

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func setImage(url: URL?, placeholder: UIImage?, resize: CGSize = .zero, isShowLoading: Bool = true, isForceReload: Bool = false, completion: (() -> Void)? = nil) {
        if isShowLoading {
            self.kf.indicatorType = .activity
        }
        var options: [KingfisherOptionsInfoItem] = [.transition(.fade(0.25))]
        if resize.width != 0 && resize.height != 0 {
            let processor = DownsamplingImageProcessor(size: resize)
            options = [
                .processor(processor),
                .cacheOriginalImage,
                .scaleFactor(UIScreen.main.scale)
            ]
        }
        self.kf.setImage(with: url, placeholder: placeholder, options: options) { _ in
            completion?()
        }
    }
    
    func setImage(url: URL?, placeholderImageName: String, completion: (() -> Void)? = nil) {
        self.setImage(url: url, placeholder: UIImage(named: placeholderImageName), completion: completion)
    }
}
