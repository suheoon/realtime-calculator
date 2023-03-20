//
//  ImageCacheManager.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/03/10.
//

import UIKit

class ImageCacheManager {
    
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
