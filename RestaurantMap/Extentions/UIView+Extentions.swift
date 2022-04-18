//
//  UIView+Extention.swift
//  RestaurantMap
//
//  Created by Viet Phan on 14/04/2022.
//

import UIKit

extension UIView {
    
    @IBInspectable open var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set(newCornerRadius) {
            layer.cornerRadius = newCornerRadius
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable open var borderColor: UIColor {
        get {
            if let borderColor = layer.borderColor {
                return UIColor(cgColor: borderColor)
            } else {
                return .clear
            }
        }
        
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable open var shadowColor: UIColor {
        get {
            if let shadowColor = layer.shadowColor {
                return UIColor(cgColor: shadowColor)
            } else {
                return .clear
            }
        }
        
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable open var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable open var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable open var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable open var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        
        set {
            layer.masksToBounds = newValue
        }
    }
    
    @IBInspectable open var shouldRasterize: Bool {
        get {
            return layer.shouldRasterize
        }
        
        set {
            layer.shouldRasterize = newValue
        }
    }
}
