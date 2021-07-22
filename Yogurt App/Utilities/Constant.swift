//
//  Constant.swift
//  GoToWork
//
//  Created by INNOVATIVE ITERATION on 11/09/20.
//  Copyright © 2020 INNOVATIVE ITERATION. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import Foundation
import MobileCoreServices

class Constant: NSObject
{
    static let SCREEN_WIDTH  = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate //: AppDelegate
    static let userDefault = UserDefaults.standard
//    static var user_id     = Constant.userDefault.string(forKey: Constant.USER_ID)
//    static let user_name   = Constant.userDefault.string(forKey: Constant.USER_NAME)
    static let uuid        = UIDevice.current.identifierForVendor?.uuidString
    
    //Mark:
    static let backgoundColor   : UIColor   = UIColor.white
    static let theme_color      : UIColor   = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1) //UIColor(red: 248.0/255.0, green: 160.0/255.0, blue: 10.0/255.0, alpha: 1.0)
    static let logo_White       : UIImage = UIImage(named: "fpEmail")!
    static let logo_Colored     : UIImage = UIImage(named: "fpEmail")!
        
    // MARK:-  String
    //=====================================================================================================
  
    static let accpetRequestAlert       = "Sure you want to accept this request?"
    static let declineRequestMessage    = "Sure you want to decline this request?"
    static let noInternet               = "Please check your internet Connectivity"
    static let chooseSource             = "Please select an image source"
    static let noCamera                 = "No camera detected on device"
    static let caseAssigned             = "You have succesfully assigned your case to"
    static let selectTime               = "Please select time"
    static let selectDay                = "Please select a day"
    static let noData                   = "No records found" //"No Records Available" //notValidNumber
//    static let lostConnection           = "Connection lost"
//    static let sureToLogout             = "Are you sure you want to signout?" //"No Notifications found"
//    static let sureToSubscribe          = "Sure you want to subscribe this membership plan?"
//    static let notValidNumber           = "Not a valid number!"
//    static let sureToCancel             = "Sure you want to cancel?"
//    static let sureToDelete             = "Are you sure you want to delete this document?"
//    static let addMoreAmount            = "You have to add minimun $50.00 at registration time into your wallet."
//    static let setProfile               = "Please set profile to access all features."
//    
//    static let placeholderUnableToGetData     = "Unable to get data"
//    static let placeholderUnableToGetLocation = "Unable to get your location."
//    static let placeholderNoDataFound         = "No data found"
//    static let placeholderNoNotification      = "No notifications yet"
//    static let placeholderLoadingData         = "One moment please\nLoading data..."
//    
//    static let pleaseSetPickUpLocation = "Please set pickup location."
//    static let pleaseSetDropOffLocation = "Please set dropoff location."
}

struct TrimError: Error
{
    let description: String
    let underlyingError: Error?
    
    init(_ description: String, underlyingError: Error? = nil) {
        self.description = "TrimVideo: " + description
        self.underlyingError = underlyingError
    }
}


extension Bundle
{
    // Name of the app - title under the icon.
    var displayName: String?
    {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? object(forInfoDictionaryKey: "CFBundleName") as? String
    }
}


extension UIApplication
{
    
    var visibleViewController: UIViewController?
    {
        guard let rootViewController = keyWindow?.rootViewController else { return nil }
        return getVisibleViewController(rootViewController)
    }
    
    private func getVisibleViewController(_ rootViewController: UIViewController) -> UIViewController?
    {
        
        if let presentedViewController = rootViewController.presentedViewController {
            return getVisibleViewController(presentedViewController)
        }
        
        if let navigationController = rootViewController as? UINavigationController {
            return navigationController.visibleViewController
        }
        
        if let tabBarController = rootViewController as? UITabBarController {
            return tabBarController.selectedViewController
        }
        
        return rootViewController
    }
}


extension UINavigationController
{
    
    func containsViewController(ofKind kind: AnyClass) -> Bool
    {
        return self.viewControllers.contains(where: { $0.isKind(of: kind) })
    }
    
    func popToVC(ofKind kind: AnyClass, pushController: UIViewController)
    {
        if containsViewController(ofKind: kind)
        {
            for controller in self.viewControllers
            {
                if controller.isKind(of: kind)
                {
                    popToViewController(controller, animated: true)
                    break
                }
            }
        }
    }
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
      if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
        popToViewController(vc, animated: animated)
      }
    }
    
    // navigationController?.popToViewController(ofClass: SomeViewController.self)
    
    /*
     func popPushToVC(ofKind kind: AnyClass, pushController: UIViewController)
     {
     if containsViewController(ofKind: kind)
     {
     for controller in self.viewControllers
     {
     if controller.isKind(of: kind)
     {
     popToViewController(controller, animated: true)
     break
     }
     }
     }
     else
     {
     pushViewController(pushController, animated: true)
     }
     }
     */
    
}

extension String {
    func fromUTCToLocalDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var formattedString = self.replacingOccurrences(of: "Z", with: "")
        if let lowerBound = formattedString.range(of: ".")?.lowerBound {
            formattedString = "\(formattedString[..<lowerBound])"
        }

        guard let date = dateFormatter.date(from: formattedString) else {
            return self
        }

        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
    func fromUTCToLocalDateTimeWithAMPM() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var formattedString = self.replacingOccurrences(of: "Z", with: "")
        if let lowerBound = formattedString.range(of: ".")?.lowerBound {
            formattedString = "\(formattedString[..<lowerBound])"
        }

        guard let date = dateFormatter.date(from: formattedString) else {
            return self
        }

        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss a"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
    func fromUTCToLocalDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var formattedString = self.replacingOccurrences(of: "Z", with: "")
        if let lowerBound = formattedString.range(of: ".")?.lowerBound {
            formattedString = "\(formattedString[..<lowerBound])"
        }

        guard let date = dateFormatter.date(from: formattedString) else {
            return self
        }

        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
    func fromUTCToLocalTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var formattedString = self.replacingOccurrences(of: "Z", with: "")
        if let lowerBound = formattedString.range(of: ".")?.lowerBound {
            formattedString = "\(formattedString[..<lowerBound])"
        }

        guard let date = dateFormatter.date(from: formattedString) else {
            return self
        }

        dateFormatter.dateFormat = "HH:mm a"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
}
extension UITabBarController
{
    
    private struct AssociatedKeys
    {
        // Declare a global var to produce a unique address as the assoc object handle
        static var orgFrameView:     UInt8 = 0
        static var movedFrameView:   UInt8 = 1
    }
    
    var orgFrameView:CGRect?
    {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.orgFrameView) as? CGRect }
        set { objc_setAssociatedObject(self, &AssociatedKeys.orgFrameView, newValue, .OBJC_ASSOCIATION_COPY) }
    }
    
    var movedFrameView:CGRect?
    {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.movedFrameView) as? CGRect }
        set { objc_setAssociatedObject(self, &AssociatedKeys.movedFrameView, newValue, .OBJC_ASSOCIATION_COPY) }
    }
    
    override open func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        
        if let movedFrameView = movedFrameView {
            view.frame = movedFrameView
        }
    }
    
    func setTabBarVisible(visible:Bool, animated:Bool)
    {
        //since iOS11 we have to set the background colour to the bar color it seams the navbar seams to get smaller during animation; this visually hides the top empty space...
        view.backgroundColor =  self.tabBar.barTintColor
        // bail if the current state matches the desired state
        if (tabBarIsVisible() == visible) { return }
        
        //we should show it
        if visible
        {
            tabBar.isHidden = false
            
            UIView.animate(withDuration: animated ? 0.3 : 0.0) {
                
                //restore form or frames
                self.view.frame = self.orgFrameView!
                
                //errase the stored locations so that...
                self.orgFrameView = nil
                self.movedFrameView = nil
                
                //...the layoutIfNeeded() does not move them again!
                self.view.layoutIfNeeded()
            }
        }
            //we should hide it
        else
        {
            
            //safe org positions
            orgFrameView   = view.frame
            movedFrameView = view.frame
            
            // get a frame calculation ready
            let offsetY = self.tabBar.frame.size.height
            movedFrameView = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height + offsetY)
            
            //animate
            UIView.animate(withDuration: animated ? 0.3 : 0.0, animations: {
                self.view.frame = self.movedFrameView!
                self.view.layoutIfNeeded()
            }) {
                (_) in
                self.tabBar.isHidden = true
            }
        }
    }
    
    func tabBarIsVisible() ->Bool
    {
        return orgFrameView == nil
    }
}


extension AVAsset
{
    var screenSize: CGSize?
    {
        if let track = tracks(withMediaType: .video).first
        {
            let size = __CGSizeApplyAffineTransform(track.naturalSize, track.preferredTransform)
            return CGSize(width: abs(size.width), height: abs(size.height))
        }
        return nil
    }
    
    var getAspectRatio: CGFloat
    {
        if let mediasize = self.screenSize
        {
            let mediaAspectRatio = CGFloat(mediasize.height / mediasize.width)
            return mediaAspectRatio
        }
        
        return 0.75
    }
    
    
    
    func assetByTrimming(startTime: CMTime, endTime: CMTime) throws -> AVAsset
    {
        let timeRange = CMTimeRangeFromTimeToTime(start: startTime, end: endTime)
        let composition = AVMutableComposition()
        do {
            for track in tracks {
                let compositionTrack = composition.addMutableTrack(withMediaType: track.mediaType,
                                                                   preferredTrackID: track.trackID)
                try compositionTrack?.insertTimeRange(timeRange, of: track, at: CMTime.zero)
            }
        } catch let error {
            throw TrimError("Error during composition", underlyingError: error)
        }
        
        // Reaply correct transform to keep original orientation.
        if let videoTrack = self.tracks(withMediaType: .video).last,
            let compositionTrack = composition.tracks(withMediaType: .video).last {
            compositionTrack.preferredTransform = videoTrack.preferredTransform
        }
        
        return composition
    }
    
    /// Export the video
    ///
    /// - Parameters:
    ///   - destination: The url to export
    ///   - videoComposition: video composition settings, for example like crop
    ///   - removeOldFile: remove old video
    ///   - completion: resulting export closure
    /// - Throws: YPTrimError with description
    func export(to destination: URL,
                videoComposition: AVVideoComposition? = nil,
                removeOldFile: Bool = false,
                completion: @escaping () -> Void) throws {
        guard let exportSession = AVAssetExportSession(asset: self, presetName: AVAssetExportPresetHighestQuality) else {
            throw TrimError("Could not create an export session")
        }
        
        exportSession.outputURL = destination
        exportSession.outputFileType = .mov
        exportSession.shouldOptimizeForNetworkUse = true
        exportSession.videoComposition = videoComposition
        
        if removeOldFile { try FileManager.default.removeFileIfNecessary(at: destination) }
        
        exportSession.exportAsynchronously(completionHandler: completion)
        
        if let error = exportSession.error {
            throw TrimError("error during export", underlyingError: error)
        }
    }
    
}


extension FileManager
{
    func removeFileIfNecessary(at url: URL) throws
    {
        guard fileExists(atPath: url.path) else { return }
        
        do {
            try removeItem(at: url)
        } catch let error {
            throw TrimError("Couldn't remove existing destination file: \(error)")
        }
    }
}



extension CALayer
{
    func makeSnapshot() -> UIImage?
    {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(frame.size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        render(in: context)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        return screenshot
    }
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat, width: CGFloat)
    {
        let border = CALayer()
        
        switch edge
        {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.bounds.height - thickness, width: width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.bounds.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: width - thickness, y: 0, width: thickness, height: self.bounds.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
    
    func addShadow(shadowWidth: CGFloat, shadowHeight: CGFloat, shadowOpacity: Float, shadowRadius: CGFloat, shadowColor: UIColor)
    {
        self.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
        self.shadowOpacity = shadowOpacity
        self.shadowRadius = shadowRadius
        self.shadowColor = shadowColor.cgColor
        self.masksToBounds = false
        
        if cornerRadius != 0
        {
            addShadowWithRoundedCorners()
        }
    }
    
    func roundCorners(radius: CGFloat)
    {
        self.cornerRadius = radius
        
        if shadowOpacity != 0
        {
            addShadowWithRoundedCorners()
        }
    }
    
    private func addShadowWithRoundedCorners() {
        if let contents = self.contents {
            masksToBounds = false
            sublayers?.filter{ $0.frame.equalTo(self.bounds) }
                .forEach{ $0.roundCorners(radius: self.cornerRadius) }
            self.contents = nil
            if let sublayer = sublayers?.first,
                sublayer.name == "prShadowLayer" {
                
                sublayer.removeFromSuperlayer()
            }
            let contentLayer = CALayer()
            contentLayer.name = "prShadowLayer"
            contentLayer.contents = contents
            contentLayer.frame = bounds
            contentLayer.cornerRadius = cornerRadius
            contentLayer.masksToBounds = true
            insertSublayer(contentLayer, at: 0)
            
        }
    }

}



extension NSMutableAttributedString
{
    func setColor(color: UIColor, forText stringValue: String)
    {
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}


extension UIViewController
{
    func setStatusBarColor(color: UIColor)
    {
        if #available(iOS 13.0, *)
        {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = color
            view.addSubview(statusbarView)
            
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
        }
        else
        {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = color
        }
    }
    
    func setBackgroundImage(imageName: String)
    {
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, false, 0)
        UIGraphicsGetCurrentContext()!.interpolationQuality = CGInterpolationQuality.high
        UIImage(named: imageName)?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
    }
    
    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

extension UISearchBar
{
//    var textField: UITextField?
//    {
//        func findInView(_ view: UIView) -> UITextField?
//        {
//            for subview in view.subviews
//            {
//                if let textField = subview as? UITextField
//                {
//                    return textField
//                }
//                else if let v = findInView(subview)
//                {
//                    return v
//                }
//            }
//            
//            return nil
//        }
//        
//        return findInView(self)
//    }
}

extension UILabel
{
    func textDropShadow(color: UIColor , radius: CGFloat, opacity: Float)
    {
        self.layer.shadowColor   = color.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowRadius  = radius
        self.layer.shadowOpacity = opacity
        
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}

extension UITextField
{
    
    func setBottomLine(withColor color: UIColor, linewidth: CGFloat)
    {
        
        self.borderStyle      = UITextField.BorderStyle.none
        self.backgroundColor  = UIColor.clear
        let hwidth: CGFloat   = linewidth
        
        /*
         if let lineView = self.viewWithTag(10000)
         {
         lineView.removeFromSuperview()
         }
         */
        
        let borderLine = UIView(frame: CGRect(x: 0, y: self.frame.height - hwidth, width: self.frame.width, height: hwidth))
        //borderLine.tag = 10000
        borderLine.backgroundColor = color
        
        self.addSubview(borderLine)
    }
    
    func setBottomBorder(bkcolor: UIColor, underlineColor: UIColor, bHeight: CGFloat)
    {
        self.borderStyle = .none
        
        self.layer.backgroundColor = bkcolor.cgColor
        self.layer.masksToBounds   = false
        self.layer.shadowColor     = underlineColor.cgColor
        self.layer.shadowOffset    = CGSize(width: 0.0, height: bHeight)
        self.layer.shadowOpacity   = 1.0
        self.layer.shadowRadius    = 0.0
    }
    
    func setTextFieldAppearance(backgoundColor: UIColor, borderColor: UIColor, borderWidth: CGFloat, cornorRadius: CGFloat, shadowColor: UIColor, shadowOffset: CGSize, shadowRadius: CGFloat, shadowOpacity: Float )
    {
        
        //Basic texfield Setup
        self.borderStyle     = .none
        self.backgroundColor = backgoundColor // Use anycolor that give you a 2d look.
        
        //To apply corner radius
        self.layer.cornerRadius = cornorRadius
        
        //To apply border
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
        //To apply Shadow
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius  = shadowRadius
        self.layer.shadowOffset  = shadowOffset
        self.layer.shadowColor   = shadowColor.cgColor
        
        //To apply padding
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height))
        self.leftView     = paddingView
        self.leftViewMode = UITextField.ViewMode.always
        
        
    }
    
    func setRightPaddingToTextFields(paddingImageName: String) -> Void
    {
        self.rightViewMode = .always
        
        let paddingView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.height, height: self.frame.size.height))
        paddingView.image       = UIImage(named: paddingImageName)
        paddingView.contentMode = .center
        
        self.rightView    = paddingView
    }
    
    func setPlaceholderColor(_ color: UIColor)
    {
        // Color
        var attributes: [NSAttributedString.Key: Any] = [.foregroundColor: color]
        var range = NSRange(location: 0, length: 1)
        
        // Font
        if let text = attributedText, text.length > 0, let attrs = attributedText?.attributes(at: 0, effectiveRange: &range), let font = attrs[.font]
        {
            attributes[.font] = font
        }
        else if let font = font
        {
            attributes[.font] = font
        }
        
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: attributes)
    }
    
}


extension UITextView
{
    func numberOfCharactersThatFitTextView() -> Int
    {
        
        //let visRect = self.convert(self.bounds, to: self.subviews.)
        
        let layoutManager = self.layoutManager
        let container = self.textContainer
        
        let glyphRange = layoutManager.glyphRange(forBoundingRect: self.bounds, in: container)
        let charRange = layoutManager.characterRange(forGlyphRange: glyphRange, actualGlyphRange: nil)
        return Int(charRange.length)
        
        /*
         let fontRef = CTFontCreateWithName(font!.fontName as CFString, font!.pointSize, nil)
         let attributes = [kCTFontAttributeName : fontRef]
         let attributedString = NSAttributedString(string: text!, attributes: attributes as [NSAttributedString.Key : Any])
         let frameSetterRef = CTFramesetterCreateWithAttributedString(attributedString as CFAttributedString)
         
         var characterFitRange: CFRange = CFRange()
         
         CTFramesetterSuggestFrameSizeWithConstraints(frameSetterRef, CFRangeMake(0, 0), nil, CGSize(width: bounds.size.width, height: bounds.size.height), &characterFitRange)
         return Int(characterFitRange.length)
         
         */
        
    }
    
    func visibleRangeOfTextView() -> NSRange
    {
        let bounds = self.bounds
        let origin = CGPoint(x: 10, y: 10)
        guard let startCharacterRange = self.characterRange(at: origin) else {
            return NSRange(location: 0, length: 0)
        }
        
        let startPosition = startCharacterRange.start
        let endPoint = CGPoint(x: bounds.maxX,
                               y: bounds.maxY)
        guard let endCharacterRange = self.characterRange(at: endPoint) else {
            return NSRange(location: 0, length: 0)
        }
        
        let endPosition = endCharacterRange.end
        
        let startIndex = self.offset(from: self.beginningOfDocument, to: startPosition)
        let endIndex = self.offset(from: startPosition, to: endPosition)
        return NSRange(location: startIndex, length: endIndex)
    }
    
    /// Modifies the top content inset to center the text vertically.
    ///
    /// Use KVO on the UITextView contentSize and call this method inside observeValue(forKeyPath:of:change:context:)
    func alignTextVerticallyInContainer()
    {
        
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
        
        
        /*
         var topCorrect = (self.bounds.size.height - self.contentSize.height * self.zoomScale) / 2
         topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
         self.contentInset.top = topCorrect
         */
    }
}


extension UIView
{
    func makeSnapshot() -> UIImage?
    {
        if #available(iOS 10.0, *)
        {
            let renderer = UIGraphicsImageRenderer(size: frame.size)
            return renderer.image { _ in drawHierarchy(in: bounds, afterScreenUpdates: true) }
        }
        else
        {
            return layer.makeSnapshot()
        }
    }
    
    func setAspectRatio(_ ratio: CGFloat) -> NSLayoutConstraint
    {
        return NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: ratio, constant: 0)
    }
//
//
//    func roundCorners(_ corners: UIRectCorner, radius: CGFloat)
//    {
//        if #available(iOS 11.0, *)
//        {
//            clipsToBounds       = true
//            layer.cornerRadius  = radius
//            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
//        }
//        else
//        {
//            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//            let mask = CAShapeLayer()
//            mask.path = path.cgPath
//
//            layer.mask = mask
//        }
//    }
    
    
    func roundCornersToTop(cornerRadius: Double)
    {
        let path            = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer       = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path  = path.cgPath
        self.layer.mask     = maskLayer
    }
    
    func addShadow(shadowColor: UIColor ,shadowWidth:CGFloat, shadowHeight: CGFloat, shadowRadius: CGFloat, shadowOpacity: Float, clipsBounds : Bool = false)
    {
        self.clipsToBounds       = clipsBounds
        self.layer.shadowOffset  = CGSize(width: shadowWidth, height: shadowHeight)
        self.layer.shadowRadius  = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowColor   = shadowColor.cgColor
    }
    
    func addShadowToView(shadowColor: UIColor, shadowOpacity: CGFloat, shadowWidth: CGFloat, shadowHeight: CGFloat, shadowRadius: CGFloat)
    {
        self.layer.shadowColor   = shadowColor.cgColor
        self.layer.shadowOpacity = Float(shadowOpacity)
        self.layer.shadowOffset  = CGSize(width: shadowWidth, height: shadowHeight)
        self.layer.shadowRadius  = shadowRadius
        self.layer.shadowPath    = UIBezierPath(rect: self.bounds).cgPath
        self.layer.masksToBounds = false
    }
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float)
    {
        layer.masksToBounds = false
        layer.shadowOffset  = offset
        layer.shadowColor   = color.cgColor
        layer.shadowRadius  = radius
        layer.shadowOpacity = opacity
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor       = nil
        layer.backgroundColor =  backgroundCGColor
    }
    
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2)
    {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue               = toValue
        animation.duration              = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode              = CAMediaTimingFillMode.forwards
        self.layer.add(animation, forKey: nil)
    }
    
    func rotate360Degrees(duration: CFTimeInterval = 4)
    {
        let rotateAnimation                     = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue               = 0.0
        rotateAnimation.toValue                 = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion   = false
        rotateAnimation.duration                = duration
        rotateAnimation.repeatCount             = Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    
    func addDashBorder(_ color: UIColor)
    {
        let color = color.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.name = "DashBorder"
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = .round
        shapeLayer.lineDashPattern = [2,4]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 4).cgPath
        
        self.layer.masksToBounds = false
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func setBorder(bkcolor: UIColor, underlineColor: UIColor)
    {
        self.layer.backgroundColor  = bkcolor.cgColor
        self.layer.masksToBounds    = false
        self.layer.shadowColor      = underlineColor.cgColor
        self.layer.shadowOffset     = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity    = 1.0
        self.layer.shadowRadius     = 0.0
    }
    
    
    
    enum ViewSide
    {
        case Left, Right, Top, Bottom
    }
    
    func addBorder(toSide side: ViewSide , withColor color: CGColor, andThickness thickness: CGFloat)
    {
        
        let border = CALayer()
        border.backgroundColor = color
        
        switch side
        {
        case .Left: border.frame    = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame   = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame     = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame  = CGRect(x: frame.minX, y: frame.maxY - thickness, width: frame.width, height: thickness); break
        }
        
        layer.addSublayer(border)
    }
    
    func startShimmering()
    {
        //let light = UIColor.init(white: 0, alpha: 0.1).cgColor
        let light = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
        let dark  = UIColor.black.cgColor
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors     = [dark, light, dark]
        gradient.frame      = CGRect(x: -self.bounds.size.width, y: 0, width: 3*self.bounds.size.width, height: self.bounds.size.height)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint   = CGPoint(x: 1.0, y: 0.525)
        gradient.locations  = [0.4, 0.5, 0.6]
        self.layer.mask = gradient
        
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "locations")
        animation.fromValue   = [0.0, 0.1, 0.2]
        animation.toValue     = [0.8, 0.9, 1.0]
        animation.duration    = 2.0
        animation.repeatCount = Float.infinity
        
        gradient.add(animation, forKey: "shimmer")
    }
    
    func stopShimmering()
    {
        self.layer.mask = nil
    }
    
    
    
    /// Flip view horizontally.
    func flipX() {
        transform = CGAffineTransform(scaleX: -transform.a, y: transform.d)
    }
    
    /// Flip view vertically.
    func flipY() {
        transform = CGAffineTransform(scaleX: transform.a, y: -transform.d)
    }
    
    func fadeIn(duration: TimeInterval = 0.2, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
            self.alpha = 0.0

            UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.isHidden = false
                self.alpha = 1.0
            }, completion: completion)
        }

    func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.isHidden = true
            self.alpha = 0.0
        }, completion: completion)
    }
    
    func animShow() {
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
                       }, completion: nil)
        self.isHidden = false
    }
    
    func animHide() {
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()
                        
                       },  completion: {(_ completed: Bool) -> Void in
                        self.isHidden = true
                       })
    }
    
    func shadow(Vw : UIView)
        {
            Vw.layer.masksToBounds = false
            Vw.layer.shadowColor =  UIColor.gray.cgColor
            Vw.layer.shadowOffset = CGSize(width: 0, height: 1)
            Vw.layer.shadowRadius = 5.0
            Vw.layer.shadowOpacity = 15.0
            Vw.layer.cornerRadius = 5.0
        }
    
}


extension UIScrollView
{
    var content_x: CGFloat
    {
        set(f) { contentOffset.x = f }
        get { return contentOffset.x }
    }
    
    var content_y: CGFloat
    {
        set(f) { contentOffset.y = f }
        get { return contentOffset.y }
    }
}


extension UIImage
{
    
    var isPortrait:  Bool    { return size.height > size.width }
    var isLandscape: Bool    { return size.width > size.height }
    
    func getImageRatio() -> CGFloat
    {
        let imageRatio = CGFloat(self.size.width / self.size.height)
        return imageRatio
    }
    
//    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage
//    {
//        let scale    = newHeight / self.size.height
//        let newWidth = self.size.width * scale
//        let newSize  = CGSize(width: newWidth, height: newHeight)
//        if #available(iOS 10.0, *) {
//            let renderer = UIGraphicsImageRenderer(size: newSize)
//        } else {
//            // Fallback on earlier versions
//        }
//
//        return renderer.image { _ in
//            self.draw(in: CGRect(origin: .zero, size: newSize))
//        }
//    }
    
    
    
    //Summon this function VVV
    func resizeImageWithAspect(scaledToMaxWidth width:CGFloat,maxHeight height :CGFloat)->UIImage
    {
        let oldWidth    = self.size.width
        let oldHeight   = self.size.height
        let scaleFactor = (oldWidth > oldHeight) ? width / oldWidth : height / oldHeight
        
        let newHeight = oldHeight * scaleFactor
        let newWidth  = oldWidth * scaleFactor
        let newSize   = CGSize(width: newWidth, height: newHeight)
        
        return imageWithSize(image: self, size: newSize);
    }
    
    private func imageWithSize(image: UIImage,size: CGSize)->UIImage
    {
        if UIScreen.main.responds(to: #selector(NSDecimalNumberBehaviors.scale))
        {
            UIGraphicsBeginImageContextWithOptions(size,false,UIScreen.main.scale);
        }
        else
        {
            UIGraphicsBeginImageContext(size);
        }
        
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    
    
    // image with rounded corners
    func withRoundedCorners(radius: CGFloat? = nil) -> UIImage?
    {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        
        if let radius = radius, radius > 0 && radius <= maxRadius
        {
            cornerRadius = radius
        }
        else
        {
            cornerRadius = maxRadius
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    class func colorForNavBar(color: UIColor) -> UIImage
    {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        //    Or if you need a thinner border :
        //    let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 0.5)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}

extension Int
{
    var boolValue: Bool { return self != 0 }
    
    var roundedWithAbbreviations: String
    {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        
        if million >= 1.0
        {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0
        {
            return "\(round(thousand*10)/10)K"
        }
        else
        {
            return "\(self)"
        }
    }
}


extension Float
{
    func string(fractionDigits:Int) -> String
    {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

extension CGFloat
{
    static func randomFloatNumb() -> CGFloat
    {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension Double
{
    /// Rounds the double to decimal places value
    func roundToPlaces(places:Int) -> Double
    {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
}

extension String
{
    var length: Int
    {
        return (self as NSString).length
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat
    {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox    = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont, minimumTextWrapWidth:CGFloat) -> CGFloat
    {
        var textWidth       : CGFloat = minimumTextWrapWidth
        let incrementWidth  : CGFloat = minimumTextWrapWidth * 0.1
        var textHeight      : CGFloat = self.height(withConstrainedWidth: textWidth, font: font)
        
        //Increase width by 10% of minimumTextWrapWidth until minimum width found that makes the text fit within the specified height
        while textHeight > height
        {
            textWidth += incrementWidth
            textHeight = self.height(withConstrainedWidth: textWidth, font: font)
        }
        
        return ceil(textWidth)
    }
    
    func width(font:UIFont, numberOfLines: Int, height:CGFloat) -> CGFloat
    {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: height))
        label.numberOfLines = numberOfLines
        //label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()
        return label.frame.width
        
    }
    
    
    func toDateTimeWithZone() -> NSDate
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" //2017-12-23T11:55:57.000Z
        
        let dateFromString : NSDate = dateFormatter.date(from: self)! as NSDate
        
        return dateFromString
    }
    
    func toDateTime(format : String) -> NSDate
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format //"HH:mm:ss a"
        
        let dateFromString : NSDate = dateFormatter.date(from: self)! as NSDate
        return dateFromString
    }
    
    func to24DateTime() -> NSDate
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateFromString: NSDate   = dateFormatter.date(from: self)! as NSDate
        return dateFromString
    }
    
    func toYearDate() -> NSDate
    {
        let formatter = DateFormatter()
        formatter.dateFormat   = "yyyy-MM-dd"
        let dateFromString: NSDate = formatter.date(from: self)! as NSDate
        
        return dateFromString
    }
    
    func getDateInLOCALFormat(sTimeZone: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        var gmt = NSTimeZone(abbreviation: "\(sTimeZone)")
        
        dateFormatter.timeZone = gmt! as TimeZone
        let date: Date? = dateFormatter.date(from: self)
        
        gmt = NSTimeZone.system as NSTimeZone
        dateFormatter.timeZone = gmt! as TimeZone
        var timeStamp: String = dateFormatter.string(from: date!)
        
        if (timeStamp.count) <= 0
        {
            timeStamp = ""
        }
        
        return timeStamp
    }
    
    
    func convertDateString(fromDateFormat: String? = "yyyy-MM-dd'T'HH:mm:ss.SSSZ", toDateFormat: String? = "yyyy-MM-dd") -> String?
    {
        return convert(dateString: self, fromDateFormat: fromDateFormat!, toDateFormat: toDateFormat!)
    }
    
    
    func convert(dateString: String, fromDateFormat: String, toDateFormat: String) -> String?
    {
        let fromDateFormatter = DateFormatter()
        fromDateFormatter.dateFormat = fromDateFormat
        
        if let fromDateObject = fromDateFormatter.date(from: dateString)
        {
            let toDateFormatter = DateFormatter()
            toDateFormatter.dateFormat = toDateFormat
            
            let newDateString = toDateFormatter.string(from: fromDateObject)
            return newDateString
        }
        
        return nil
    }
    
    
    func smartContains(_ other: String) -> Bool
    {
        let array : [String] = other.lowercased().components(separatedBy: " ").filter { !$0.isEmpty }
        
        if(array.count != 0)
        {
            return array.reduce(true) { !$0 ? false : (self.lowercased().range(of: $1) != nil ) }
        }
        else
        {
            return false
        }
    }
    
    func capitalizingFirstLetter() -> String
    {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter()
    {
        self = self.capitalizingFirstLetter()
    }
    
    func applyPatternOnNumbers(pattern: String, replacmentCharacter: Character) -> String
    {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        
        for index in 0 ..< pattern.count
        {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(encodedOffset: index)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        
        return pureNumber
    }
    
    func htmlAttributedString(attributes: [NSAttributedString.Key : Any]? = .none, boldString: String? = "", boldStringAttributes: [NSAttributedString.Key : Any]? = .none) -> NSAttributedString?
    {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        
        html.setAttributes(attributes, range: NSRange(0..<html.length))
        
        if !((boldString?.isEmpty)!)
        {
            html.setAttributes(boldStringAttributes, range: NSRange(0..<(boldString?.length)!))
        }
        
        return html
    }
    
    func convertStringToDictionary() -> [String: Any]?
    {
        if let data = self.data(using: .utf8)
        {
            do
            {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            }
            catch
            {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func convertJSONStringToDictionary() -> NSDictionary
    {
        if let data = self.data(using: .utf8)
        {
            do
            {
                return try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            }
            catch
            {
            }
        }
        
        return NSDictionary()
    }
    
    func replace(string:String, replacement:String) -> String
    {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String
    {
        return self.replace(string: " ", replacement: "")
    }
    
    func getDecimalConvertedString() -> String
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        
        let amunt = formatter.string(from: NSNumber(value: (self as NSString).doubleValue))
        
        return (amunt ?? "0.00")
    }
    
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString
    {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        
        guard let characterSpacing = characterSpacing else {return attributedString}
        
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }
}

extension Date
{
    func toString24Set() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let dateFromString = dateFormatter.string(from: self as Date)
        return dateFromString
    }
    
    func dateString(_ format: String = "MMM-dd-YYYY, hh:mm a") -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func dateByAddingYears(_ dYears: Int) -> Date
    {
        var dateComponents = DateComponents()
        dateComponents.year = dYears
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
    
    func formatRelativeString() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.doesRelativeDateFormatting = true
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        
        let calendar = Calendar(identifier: .gregorian)
        
        if calendar.isDateInToday(self)
        {
            dateFormatter.timeStyle = .short
            dateFormatter.dateStyle = .none
        }
        else if calendar.isDateInYesterday(self)
        {
            dateFormatter.timeStyle = .none
            dateFormatter.dateStyle = .medium
        }
        else if calendar.compare(Date(), to: self, toGranularity: .weekOfYear) == .orderedSame
        {
            let weekday = calendar.dateComponents([.weekday], from: self).weekday ?? 0
            return dateFormatter.weekdaySymbols[weekday-1]
        }
        else
        {
            dateFormatter.timeStyle = .none
            dateFormatter.dateStyle = .short
        }
        
        return dateFormatter.string(from: self)
    }
    
    
    
    
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}


extension NSDate
{
    func toStringDate() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy" // "yyyy-MM-dd"
        let dateFromString = dateFormatter.string(from: self as Date)
        return dateFromString
    }
    
    func toString24hourTime() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let dateFromString = dateFormatter.string(from: self as Date)
        return dateFromString
    }
    
    func toString12hourTime() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let dateFromString = dateFormatter.string(from: self as Date)
        return dateFromString
    }
    
    func toString24hourwithSecond() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let dateFromString = dateFormatter.string(from: self as Date)
        return dateFromString
    }
    
    func toStringFullMnthDate() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMMM-yyyy"
        let dateFromString = dateFormatter.string(from: self as Date)
        return dateFromString
    }
    
    func getElapsedInterval() -> String
    {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .hour, .day, .month, .year]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1
        
        var dateString: String?
        
        if self.timeIntervalSince(Date()) > -60*5
        {
            dateString = NSLocalizedString("now", comment: "")
        }
        else
        {
            dateString = String.init(format: NSLocalizedString("%@", comment: ""), locale: .current, formatter.string(from: self as Date, to: Date())!)
        }
        
        return dateString ?? ""
    }
    
    func getPastTime() -> String {
        
        var secondsAgo = Int(Date().timeIntervalSince(self as Date))
        if secondsAgo < 0 {
            secondsAgo = secondsAgo * (-1)
        }
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < minute  {
            if secondsAgo < 2{
                return "just now"
            }else{
                return "\(secondsAgo) secs ago"
            }
        } else if secondsAgo < hour {
            let min = secondsAgo/minute
            if min == 1{
                return "\(min) min ago"
            }else{
                return "\(min) mins ago"
            }
        } else if secondsAgo < day {
            let hr = secondsAgo/hour
            if hr == 1{
                return "\(hr) hr ago"
            } else {
                return "\(hr) hrs ago"
            }
        } else if secondsAgo < week {
            let day = secondsAgo/day
            if day == 1{
                return "\(day) day ago"
            }else{
                return "\(day) days ago"
            }
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "E, MMM d, h:mm a"
            formatter.locale = Locale(identifier: "en_US")
            let strDate: String = formatter.string(from: self as Date)
            return strDate
        }
    }
    
}

extension UIColor
{
    convenience init(red: Int, green: Int, blue: Int)
    {
        assert(red   >= 0 && red   <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue  >= 0 && blue  <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int)
    {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
//    convenience init(hex:Int, alpha:CGFloat = 1.0)
//    {
//        self.init(
//            red:   CGFloat((hex & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((hex & 0x00FF00) >> 8)  / 255.0,
//            blue:  CGFloat((hex & 0x0000FF) >> 0)  / 255.0,
//            alpha: alpha
//        )
//    }
    
    convenience init(hexFromString: String, alpha:CGFloat = 1.0)
    {
        var cString:String  = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
        
        if (cString.hasPrefix("#"))
        {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) == 6)
        {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
//    static func random() -> UIColor
//    {
//        return UIColor(red:   .randomFloatNumb(),
//                       green: .randomFloatNumb(),
//                       blue:  .randomFloatNumb(),
//                       alpha: 1.0)
//    }
    
    func gradientColorFrom(color color1: UIColor, toColor color2: UIColor ,withSize size: CGSize) ->UIColor
    {
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        
        let context     = UIGraphicsGetCurrentContext();
        let colorspace  = CGColorSpaceCreateDeviceRGB();
        let colors      = [color1.cgColor, color2.cgColor] as CFArray;
        let gradient    = CGGradient(colorsSpace: colorspace, colors: colors, locations: nil);
        
        context!.drawLinearGradient(gradient!, start: CGPoint(x:0, y:0), end: CGPoint(x:size.width, y:0), options: CGGradientDrawingOptions(rawValue: UInt32(0)));
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        let finalCColor = UIColor(patternImage: image!);
        return finalCColor;
    }
    
}


extension UIButton
{
    func setBottomBorder(bkcolor: UIColor, underlineColor: UIColor, fontColor : UIColor)
    {
        self.layer.backgroundColor  = bkcolor.cgColor
        self.layer.masksToBounds    = false
        self.layer.shadowColor      = underlineColor.cgColor
        self.layer.shadowOffset     = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity    = 1.0
        self.layer.shadowRadius     = 0.0
        self.setTitleColor(fontColor, for: .normal)
    }
    
    func setButtonStyle(text_color: UIColor)
    {
        self.layer.cornerRadius     = self.frame.size.height/2
        self.layer.borderWidth      = 1
        self.layer.borderColor      = text_color.cgColor
        self.backgroundColor        = UIColor.clear
        self.setTitleColor(text_color, for: .normal)
    }
    
    func setCornerRadius(radius: CGFloat)
    {
        self.layer.cornerRadius  = radius
        self.layer.masksToBounds = true
    }
    
    func setHeartBeatAnimation()
    {
        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: CGFloat(0.1), initialSpringVelocity: CGFloat(6.0), options: UIView.AnimationOptions.allowUserInteraction, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: { Void in()  }
        )
    }
    
}

extension UIActivityIndicatorView
{
    convenience init(activityIndicatorStyle: UIActivityIndicatorView.Style, color: UIColor, placeInTheCenterOf parentView: UIView)
    {
        self.init(style: activityIndicatorStyle)
        center = parentView.center
        self.color = color
        self.hidesWhenStopped = true
        parentView.addSubview(self)
    }
}

extension UITableView
{
    func scroll(to: scrollsTo, animated: Bool)
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            switch to{
            case .top:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.scrollToRow(at: indexPath, at: .top, animated: animated)
                }
                break
            case .bottom:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                    self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                }
                break
            }
        }
    }
    
    enum scrollsTo {
        case top,bottom
    }
    
    func positionedAtBottom() -> Bool
    {
        let height = self.contentSize.height - self.frame.size.height
        
        if self.contentOffset.y < 10 {
            //reach top
            return false
        }
        else if self.contentOffset.y < height/2.0
        {
            //not top and not bottom
            return false
        }
        else
        {
            return true
        }
    }
    
    func showNoDataLabel(_ strAltMsg: String, isScrollable: Bool)
    {
        let noDataView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let msglbl               = UILabel(frame: CGRect(x: 12, y: 25, width: self.bounds.size.width-24, height: self.bounds.size.height-50))
        msglbl.text          = strAltMsg
        msglbl.textAlignment = .center
        msglbl.font          = UIFont(name: "Montserrat-Regular", size: 20.0)
        msglbl.numberOfLines = 0
        msglbl.textColor     = #colorLiteral(red: 0.7882352941, green: 0.7882352941, blue: 0.7882352941, alpha: 1) //UIColor(white: 0.9, alpha: 1.0)
        
        msglbl.translatesAutoresizingMaskIntoConstraints = true
        
        noDataView.addSubview(msglbl)
        noDataView.translatesAutoresizingMaskIntoConstraints = true
        
        self.isScrollEnabled = isScrollable
        self.backgroundView  = noDataView
    }
    
    func removeNoDataLabel()
    {
        self.isScrollEnabled = true
        self.backgroundView  = nil
    }
    
}


extension UITableViewCell
{
    /// Search up the view hierarchy of the table view cell to find the containing table view
    var tableView: UITableView?
    {
        get {
            var table: UIView? = superview
            
            while !(table is UITableView) && table != nil {
                table = table?.superview
            }
            
            return table as? UITableView
        }
    }
}


extension UICollectionView
{
    func showNoDataLabel(_ strAltMsg: String, isScrollable: Bool)
    {
        let noDataView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let msglbl               = UILabel(frame: CGRect(x: 12, y: 25, width: self.bounds.size.width-24, height: self.bounds.size.height-50))
        msglbl.text          = strAltMsg
        msglbl.textAlignment = .center
        msglbl.font          = UIFont(name: "Montserrat-Regular", size: 20.0)
        msglbl.numberOfLines = 0
        msglbl.textColor     = #colorLiteral(red: 0.7882352941, green: 0.7882352941, blue: 0.7882352941, alpha: 1) //UIColor(white: 0.9, alpha: 1.0)
        
        noDataView.addSubview(msglbl)
        
        self.isScrollEnabled = isScrollable
        self.backgroundView  = noDataView
    }
    
    func removeNoDataLabel()
    {
        self.isScrollEnabled = true
        self.backgroundView  = nil
    }
}








extension NSLayoutConstraint
{
    /**
     Change multiplier constraint
     
     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint
    {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem!,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}


extension TimeInterval
{
    func toDate() -> Date?
    {
        //return Date(timeIntervalSince1970: self)
        
        let unixTimeStamp: Double = Double(self) / 1000.0
        let exactDate = Date(timeIntervalSince1970: unixTimeStamp)
        let dateFormatt = DateFormatter();
        dateFormatt.dateFormat = "dd/MM/yyy hh:mm a"
        print(dateFormatt.string(from: exactDate))
        
        return exactDate
        
    }
    
    func stringFromTimeInterval() -> String
    {
        let time = NSInteger(self)
        
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        var formatString = ""
        
        if hours == 0
        {
            if(minutes < 10)
            {
                formatString = "%2d:%0.2d"
            }
            else
            {
                formatString = "%0.2d:%0.2d"
            }
            
            return String(format: formatString,minutes,seconds)
        }
        else
        {
            formatString = "%2d:%0.2d:%0.2d"
            return String(format: formatString,hours,minutes,seconds)
        }
    }
}


//Mark:- Extention for set Color of label fonts
extension NSMutableAttributedString
{
    func SetUpColorforSingleLabel(color: UIColor, forText stringValue: String)
    {
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}


extension DispatchQueue
{
    
    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
    
}

extension PHAsset {
    /*
    func tempCopyMediaFile() -> (url: URL,mimetype: String)? {
        if self.mediaType != .video { return nil }
        guard let resource = PHAssetResource.assetResources(for: self).first else { return nil }
        let fileName = resource.originalFilename
        var writeURL: URL? = nil
        if #available(iOS 10.0, *) {
            writeURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(fileName)")
        } else {
            writeURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent("\(fileName)")
        }
        guard let localURL = writeURL,let mimetype = fileName.MIMEType() else { return nil }
        let options = PHAssetResourceRequestOptions()
        options.isNetworkAccessAllowed = false
        var ret: (url: URL,mimetype: String)? = nil
        PHAssetResourceManager.default().writeData(for: resource, toFile: localURL, options: options, completionHandler: { error in
            if let error = error {
                print(error.localizedDescription)
            }
            ret = (localURL,mimetype)
        })
        return ret
    }
    func videoSize(completion: @escaping ((Int)->Void)) {
        PHImageManager.default().requestAVAsset(forVideo: self, options: nil) { (avasset, audioMix, info) in
            var url: URL? = nil
            if let urlAsset = avasset as? AVURLAsset {
                url = urlAsset.url
            }else if let sandboxKeys = info?["PHImageFileSandboxExtensionTokenKey"] as? String, let path = sandboxKeys.components(separatedBy: ";").last {
                url = URL(fileURLWithPath: path)
            }
            completion(url?.fileSize() ?? -1)
        }
    }
    */
}

extension URL {
    
    func mimeType() -> String {
        let pathExtension = self.pathExtension
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
    
    var containsImage: Bool {
        let mimeType = self.mimeType()
        guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
            return false
        }
        return UTTypeConformsTo(uti, kUTTypeImage)
    }
    
    var containsAudio: Bool {
        let mimeType = self.mimeType()
        guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
            return false
        }
        return UTTypeConformsTo(uti, kUTTypeAudio)
    }
    
    var containsVideo: Bool {
        let mimeType = self.mimeType()
        guard  let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
            return false
        }
        return UTTypeConformsTo(uti, kUTTypeMovie)
    }

    func fileSize() -> Int {
            var fileSize: Double = 0.0
            var fileSizeValue = 0.0
            try? fileSizeValue = (self.resourceValues(forKeys: [URLResourceKey.fileSizeKey]).allValues.first?.value as! Double?)!
            if fileSizeValue > 0.0 {
                fileSize = (Double(fileSizeValue) / (1024 * 1024))
            }
            return Int(fileSize)
        }
    
}

extension Dictionary {
    var queryString: String {
        var output: String = ""
        forEach({ output += "\($0.key)=\($0.value)&" })
        output = String(output.dropLast())
        return output
    }
    
    /*
     let populatedDictionary = ["key1": "value1", "key2": "value2"]
     let urlQuery = populatedDictionary.queryString
     print(urlQuery)
    */
    
}

//MARK:- ************* Extension For UserDefaults *****************
extension UserDefaults {
    
    open func setStruct<T: Codable>(_ value: T?, forKey defaultName: String){
        let data = try? JSONEncoder().encode(value)
        set(data, forKey: defaultName)
    }
    
    open func structData<T>(_ type: T.Type, forKey defaultName: String) -> T? where T : Decodable {
        guard let encodedData = data(forKey: defaultName) else {
            return nil
        }
        
        return try! JSONDecoder().decode(type, from: encodedData)
    }
    
    open func setStructArray<T: Codable>(_ value: [T], forKey defaultName: String){
        let data = value.map { try? JSONEncoder().encode($0) }
        
        set(data, forKey: defaultName)
    }
    
    open func structArrayData<T>(_ type: T.Type, forKey defaultName: String) -> [T] where T : Decodable {
        guard let encodedData = array(forKey: defaultName) as? [Data] else {
            return []
        }
        
        return encodedData.map { try! JSONDecoder().decode(type, from: $0) }
    }
}

