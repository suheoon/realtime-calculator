//
//  CALayerExtension.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/02/25.
//

import UIKit

extension CALayer {
    func applyShadow(
        color: UIColor,
        alpha: Float,
        x: CGFloat,
        y: CGFloat,
        blur: CGFloat
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
    }
}
