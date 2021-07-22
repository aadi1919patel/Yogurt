//
//  Extensions.swift
//  Yogurt App
//
//  Created by Aditya on 05/05/21.
//

import Foundation

@IBDesignable
class RoundedCornerView: UIView {

    var cornerRadiusValue : CGFloat = 0
    var corners : UIRectCorner = []

    @IBInspectable public var cornerRadius : CGFloat {
        get {
            return cornerRadiusValue
        }
        set {
            cornerRadiusValue = newValue
        }
    }

    @IBInspectable public var topLeft : Bool {
        get {
            return corners.contains(.topLeft)
        }
        set {
            setCorner(newValue: newValue, for: .topLeft)
        }
    }

    @IBInspectable public var topRight : Bool {
        get {
            return corners.contains(.topRight)
        }
        set {
            setCorner(newValue: newValue, for: .topRight)
        }
    }

    @IBInspectable public var bottomLeft : Bool {
        get {
            return corners.contains(.bottomLeft)
        }
        set {
            setCorner(newValue: newValue, for: .bottomLeft)
        }
    }

    @IBInspectable public var bottomRight : Bool {
        get {
            return corners.contains(.bottomRight)
        }
        set {
            setCorner(newValue: newValue, for: .bottomRight)
        }
    }

    func setCorner(newValue: Bool, for corner: UIRectCorner) {
        if newValue {
            addRectCorner(corner: corner)
        } else {
            removeRectCorner(corner: corner)
        }
    }

    func addRectCorner(corner: UIRectCorner) {
        corners.insert(corner)
        updateCorners()
    }

    func removeRectCorner(corner: UIRectCorner) {
        if corners.contains(corner) {
            corners.remove(corner)
            updateCorners()
        }
    }

    func updateCorners() {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadiusValue, height: cornerRadiusValue))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

}

extension UIDevice {
    var iPhoneX: Bool { UIScreen.main.nativeBounds.height == 2436 }
    var iPhone: Bool { UIDevice.current.userInterfaceIdiom == .phone }
    var iPad: Bool { UIDevice().userInterfaceIdiom == .pad }
    enum ScreenType: String {
        case iPhones_4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_6Plus_6sPlus_7Plus_8Plus_Simulators = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus Simulators"
        case iPhones_X_XS_12MiniSimulator = "iPhone X or iPhone XS or iPhone 12 Mini Simulator"
        case iPhone_XR_11 = "iPhone XR or iPhone 11"
        case iPhone_XSMax_ProMax = "iPhone XS Max or iPhone Pro Max"
        case iPhone_11Pro = "iPhone 11 Pro"
        case iPhone_12Mini = "iPhone 12 Mini"
        case iPhone_12_12Pro = "iPhone 12 or iPhone 12 Pro"
        case iPhone_12ProMax = "iPhone 12 Pro Max"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 1136: return .iPhones_5_5s_5c_SE
        case 1334: return .iPhones_6_6s_7_8
        case 1792: return .iPhone_XR_11
        case 1920: return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2208: return .iPhones_6Plus_6sPlus_7Plus_8Plus_Simulators
        case 2340: return .iPhone_12Mini
        case 2426: return .iPhone_11Pro
        case 2436: return .iPhones_X_XS_12MiniSimulator
        case 2532: return .iPhone_12_12Pro
        case 2688: return .iPhone_XSMax_ProMax
        case 2778: return .iPhone_12ProMax
        default: return .unknown
        }
    }
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11, *) {
            var cornerMask = CACornerMask()
            if(corners.contains(.topLeft)){
                cornerMask.insert(.layerMinXMinYCorner)
            }
            if(corners.contains(.topRight)){
                cornerMask.insert(.layerMaxXMinYCorner)
            }
            if(corners.contains(.bottomLeft)){
                cornerMask.insert(.layerMinXMaxYCorner)
            }
            if(corners.contains(.bottomRight)){
                cornerMask.insert(.layerMaxXMaxYCorner)
            }
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cornerMask

        } else {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}
