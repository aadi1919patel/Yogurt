//
//  Constant.swift
//  GoToWork
//
//  Created by INNOVATIVE ITERATION on 11/09/20.
//  Copyright © 2020 INNOVATIVE ITERATION. All rights reserved.
//


import UIKit
//import GoogleMobileAds
//import FTPopOverMenu_Swift
import NYAlertViewController
import Alamofire

class Utils: NSObject
{
    static var instance = Utils()
    
    class func getAppName() -> String
    {
        let infoDictionary  : NSDictionary  = (Bundle.main.infoDictionary as NSDictionary?)!
        let appName         : NSString      = infoDictionary.object(forKey: "CFBundleName") as! NSString
        return appName as String
    }
    
    class func getAppVersion() -> String
    {
        let infoDictionary  : NSDictionary = (Bundle.main.infoDictionary as NSDictionary?)!
        let appName         : NSString     = infoDictionary.object(forKey: "CFBundleShortVersionString") as! NSString
        return appName as String
    }
    
    
    /*
     func setUpWeChatStylePopoverMenu()
     {
     let config = FTConfiguration.shared
     config.backgoundTintColor = UIColor.white
     config.borderColor        = UIColor.lightGray
     config.menuWidth          = 180
     config.menuSeparatorColor = UIColor.clear
     config.menuRowHeight      = 44
     config.cornerRadius       = 8
     config.localShadow        = false
     config.globalShadow       = true
     config.shadowAlpha        = 0.6
     }
     */
    
    
    
    class func assignbackground(_ sender: UIView)
    {
        let background = UIImage(named: "splash_bg")
        
        
        //let blurEffect = UIBlurEffect(style: .dark)
        //let blurView = UIVisualEffectView(effect: blurEffect)
        
        var imageView: UIImageView!
        imageView               = UIImageView(frame: sender.bounds)
        imageView.contentMode   =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image         = background
        imageView.center        = sender.center
        
        //sender.addSubview(blurView)
        //sender.bringSubview(toFront: blurView)
        sender.addSubview(imageView)
        sender.sendSubviewToBack(imageView)
        
    }
    
    // MARK : - Google Video Ads Function
    /*class func createAndLoadRewardedAd() -> GADRewardedAd {
     let rewardedAd = GADRewardedAd(adUnitID: Constant.rewardedAdUnitID)
     rewardedAd.load(GADRequest()) { error in
     if let error = error {
     print("Loading failed: \(error)")
     } else {
     print("Loading Succeeded")
     }
     }
     return rewardedAd
     }*/
    
    class func getCurrentTime() -> String
    {
        let date        = Date()
        let calender    = Calendar.current
        let components  = calender.dateComponents([.hour,.minute,.second], from: date)
        var hour        = String()
        var minutes     = String()
        
        if components.hour! < 10
        {
            hour = String("0\(components.hour!)")
        }
        else
        {
            hour = String("\(components.hour!)")
        }
        
        if components.minute! < 10
        {
            minutes = String("0\(components.minute!)")
        }
        else
        {
            minutes = String("\(components.minute!)")
        }
        
        let currentTime = "\(hour):\(minutes)"
        return currentTime
    }
    
    class func getcurrentDate() -> String
    {
        let date        = Date()
        let calender    = Calendar.current
        let components  = calender.dateComponents([.day,.month,.year], from: date)
        var day         = String()
        var month       = String()
        
        if components.day! < 10
        {
            day = String("0\(components.day!)")
        }
        else
        {
            day = String("\(components.day!)")
        }
        
        if components.month! < 10
        {
            month = String("0\(components.month!)")
        }
        else
        {
            month = String("\(components.month!)")
        }
        
        let todayDate = "\(components.year!)/\(month)/\(day)"
        return todayDate
    }
    
    class func getTodaysDay() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayName: String = dateFormatter.string(from: Date())
        
        return dayName
    }
    
    class func getCurrentDateTimeInIST() -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone   = NSTimeZone(abbreviation: "IST")! as TimeZone
        
        let date = NSDate()
        let cstTimeZoneStr = formatter.string(from: date as Date)
        
        return cstTimeZoneStr
    }
    
    
    class func getDateInLOCALFormat(_ strDate: String) -> String
    {
        var gmt = NSTimeZone(abbreviation: "IST")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = gmt! as TimeZone
        
        let date: Date? = dateFormatter.date(from: strDate)
        gmt = NSTimeZone.system as NSTimeZone
        dateFormatter.timeZone   = gmt! as TimeZone
        dateFormatter.dateFormat = "d MMM, yyyy"
        var timeStamp: String = dateFormatter.string(from: date!)
        
        if (timeStamp.count) <= 0 {
            timeStamp = ""
        }
        
        return timeStamp
    }
    
    class func getTimeInLOCALFormat(_ strDate: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        var gmt = NSTimeZone(abbreviation: "IST")
        dateFormatter.timeZone = gmt! as TimeZone
        
        let date: Date? = dateFormatter.date(from: strDate)
        gmt = NSTimeZone.system as NSTimeZone
        dateFormatter.timeZone   = gmt! as TimeZone
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.amSymbol   = "am"
        dateFormatter.pmSymbol   = "pm"
        var timeStamp: String    = dateFormatter.string(from: date!)
        
        if (timeStamp.count) <= 0 {
            timeStamp = ""
        }
        
        return timeStamp
    }
    
    class func getTimeIn24HrFormat(_ strDate: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        
        var gmt = NSTimeZone(abbreviation: "IST")
        dateFormatter.timeZone = gmt! as TimeZone
        
        let date: Date? = dateFormatter.date(from: strDate)
        gmt = NSTimeZone.system as NSTimeZone
        dateFormatter.timeZone   = gmt! as TimeZone
        dateFormatter.dateFormat = "HH:mm:ss"
        var timeStamp: String    = dateFormatter.string(from: date!)
        
        if (timeStamp.count) <= 0 {
            timeStamp = ""
        }
        
        return timeStamp
    }
    
    func getFormatedDOB(_ strDate: String, originalFormat: String, responseFormat: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = originalFormat
        
        let date: Date? = dateFormatter.date(from: strDate)
        dateFormatter.dateFormat = responseFormat
        
        var timeStamp: String = dateFormatter.string(from: date!)
        if (timeStamp.count) <= 0 {
            timeStamp = ""
        }
        return timeStamp
    }
    
    // --
    
    class func showProgressHUD() {
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
    }
    
    class func dissmissProgressHUD() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
    class func Toast(message: String, controller: UIViewController) {
        let toastContainer = UIView(frame: CGRect())
        toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastContainer.alpha = 0.0
        toastContainer.layer.cornerRadius = 25;
        toastContainer.clipsToBounds  =  true
        
        let toastLabel = UILabel(frame: CGRect())
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font.withSize(12.0)
        toastLabel.text = message
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        
        toastContainer.addSubview(toastLabel)
        controller.view.addSubview(toastContainer)
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 15)
        let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -15)
        let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
        let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
        toastContainer.addConstraints([a1, a2, a3, a4])
        
        let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 65)
        let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: -65)
        let c3 = NSLayoutConstraint(item: toastContainer, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1, constant: -75)
        controller.view.addConstraints([c1, c2, c3])
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }, completion: {_ in
                toastContainer.removeFromSuperview()
            })
        })
    }
    
    // --
    
    class func showNYAlertViewWithTitle(title: String, detail: String) {
        
        let window = Constant.appDelegate.window
        
        let alertViewController = NYAlertViewController()
        
        //Set a title and message
        alertViewController.title = title
        alertViewController.message = detail
        
        //Customize appearance as desired
        alertViewController.view.tintColor = UIColor.white
        alertViewController.backgroundTapDismissalGestureEnabled = false
        alertViewController.swipeDismissalGestureEnabled = false
        alertViewController.transitionStyle = NYAlertViewControllerTransitionStyle.fade
        
        //alertViewController.titleFont = MySingleton.sharedManager().alertViewTitleFont
        //alertViewController.messageFont = MySingleton.sharedManager().alertViewMessageFont
        //alertViewController.buttonTitleFont = MySingleton.sharedManager().alertViewButtonTitleFont
        //alertViewController.cancelButtonTitleFont = MySingleton.sharedManager().alertViewCancelButtonTitleFont
        
       // alertViewController.buttonColor = UIColor.init(Constant.userDefault.getThemeColor1Data())
        alertViewController.alertViewBackgroundColor = MySingleton.sharedManager().themeGlobalBackgroundColor
        
        // Add alert actions
        let okAction = NYAlertAction(
            title: "Ok",
            style: .default,
            handler: { (action: NYAlertAction!) -> Void in
                // AppDelegate.sharedInstance().window?.topMostController()?.dismiss(animated: true, completion: nil)
                window?.rootViewController?.dismiss(animated: true, completion: nil)
        })
        
        alertViewController.addAction(okAction)
        
        window?.rootViewController?.present(alertViewController, animated: true, completion: nil)
        
        /*
        DispatchQueue.main.async {
            AppDelegate.sharedInstance().window?.topMostController()?.present(alertViewController, animated: true, completion: nil)
        }
        */
    }
    
    class func showNYAlertViewWithAction(title: String, detail: String,Action: NYAlertAction) {
        
        let window = Constant.appDelegate.window
        
        let alertViewController = NYAlertViewController()
        
        //Set a title and message
        alertViewController.title = title
        alertViewController.message = detail
        
        //Customize appearance as desired
        alertViewController.view.tintColor = UIColor.white
        alertViewController.backgroundTapDismissalGestureEnabled = false
        alertViewController.swipeDismissalGestureEnabled = false
        alertViewController.transitionStyle = NYAlertViewControllerTransitionStyle.fade
        
        alertViewController.buttonColor = UIColor.blue
        
        // Add alert actions
        alertViewController.addAction(Action)
        
        DispatchQueue.main.async {
            window?.rootViewController?.present(alertViewController, animated: true, completion: nil)
        }
    }
    
    class func showNYAlertViewWithTwoAction(title: String, detail: String,Action1: NYAlertAction,Action2: NYAlertAction) {
        
        let window = Constant.appDelegate.window
        
        let alertViewController = NYAlertViewController()
        
        //Set a title and message
        alertViewController.title = title
        alertViewController.message = detail
        
        //Customize appearance as desired
        alertViewController.view.tintColor = UIColor.white
        alertViewController.backgroundTapDismissalGestureEnabled = false
        alertViewController.swipeDismissalGestureEnabled = false
        alertViewController.transitionStyle = NYAlertViewControllerTransitionStyle.fade
        
        alertViewController.buttonColor = UIColor.blue
        
        // Add alert actions
        alertViewController.addAction(Action1)
        alertViewController.addAction(Action2)
        
        DispatchQueue.main.async {
            window?.rootViewController?.present(alertViewController, animated: true, completion: nil)
        }
    }
    
    
    //--
    
    class func showAlert(controller: UIViewController, title:String, message:String)
    {
        let alertView = UIAlertController(title: title, message: message, preferredStyle:.alert)
        let btnOK     = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertView.addAction(btnOK)
        controller.present(alertView, animated: true, completion: nil)
    }
    
    func handleCancel(alertView: UIAlertAction!)
    {
        
    }
    
    func queryItems(dictionary: [String:Any]) -> String {
        var components = URLComponents()
        print(components.url!)
        components.queryItems = dictionary.map {
            URLQueryItem(name: $0, value: $1 as? String)
        }
        return (components.url?.absoluteString)!
    }
    
    // --
    
    
    
    // --
    /*
     //MARK:- No data in tableview show this label
     class func showNoDataLabel(width:CGFloat,height:CGFloat) -> UILabel
     {
     let msglbl           = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
     msglbl.text          = "No data available";
     msglbl.textAlignment = NSTextAlignment.center;
     msglbl.font          = UIFont(name: "Poppins-Regular", size: 16)
     msglbl.textColor     = UIColor.black
     msglbl.sizeToFit()
     return msglbl
     }
     
     class func showNoDataLabel(width:CGFloat,height:CGFloat, strAltMsg: String) -> UIView
     {
     
     let noDataView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
     
     let msglbl               = UILabel(frame: CGRect(x: 12, y: 25, width: noDataView.frame.size.width-24, height: height-50))
     msglbl.text          = strAltMsg
     msglbl.textAlignment = .center
     msglbl.font          = UIFont(name: "Poppins-Regular", size: 16.0)
     msglbl.numberOfLines = 0
     msglbl.textColor     = UIColor.lightGray //UIColor(white: 0.9, alpha: 1.0)
     
     noDataView.addSubview(msglbl)
     return noDataView
     }
     */
    // --
    
    
    // --
    
    class func trimString(_ text: String) -> String
    {
        let trimmedString: String = text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmedString
    }
    
    class func validateEmail(_ emailStr: String) -> Bool
    {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest  = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: emailStr)
    }
    
    class func validatePhoneNumber(_ phoneNoStr: String) -> Bool
    {
        //let phoneNoRegex = "^(\\+?)(\\d{10})$"
        
        let phoneNoRegex = "^[0-9+]{0,1}+[0-9]{5,14}$"
        
        let phoneNoTest  = NSPredicate(format: "SELF MATCHES %@", phoneNoRegex)
        return phoneNoTest.evaluate(with: phoneNoStr)
    }
    
    class func validateDuration(_ durationStr: String) -> Bool
    {
        let durationRegex = "[0-9]{2}:[0-9]{2}:[0-9]{2}"
        let durationTest  = NSPredicate(format: "SELF MATCHES %@", durationRegex)
        return durationTest.evaluate(with: durationStr)
    }
    
    class func getAddressString(addressInfo: NSDictionary) -> String
    {
        var addressString     = ""
        let strAdd1           = addressInfo["address1"] as! String
        let strAdd2           = addressInfo["address2"] as! String
        let strAdd3           = addressInfo["address3"] as! String
        let strCity           = addressInfo["city"] as! String
        let strState          = addressInfo["state"] as! String
        let strPincode        = addressInfo["pincode"] as! String
        
        addressString         = "\(strAdd1), \(strAdd2), \(strAdd3), \(strCity), \(strState)-\(strPincode)"
        
        return addressString
    }
    
    // --
    
    
    class func setCustomFontSize(noramlSize: Int) -> CGFloat
    {
        
        //Current runable device/simulator width find
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        
        // basewidth you have set like your base storybord is IPhoneSE this storybord width 320px.
        let baseWidth: CGFloat = 320
        
        let fontSize = CGFloat(noramlSize) * (width / baseWidth)
        
        return fontSize.rounded()
    }
    
    class func findHeight(fromText text: String, maxWidth: CGFloat, font: UIFont) -> CGRect
    {
        let attributes = [NSAttributedString.Key.font: font]
        let rectAmnt: CGRect = text.boundingRect(with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: (attributes as Any as! [NSAttributedString.Key : Any]), context: nil)
        return rectAmnt
    }
    
    
    //Convert the Swift dictionary to JSON String
    class func JSONString(object: Any)  -> String?
    {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            
            let jsonString = String(data: jsonData, encoding: .utf8) ?? ""
            // here "decoded" is of type `Any`, decoded from JSON data
            return jsonString
            // you can now cast it with the right type
            
        } catch {
            print(error.localizedDescription)
        }
        
        return ""
        
    }
    
    // If use raw data then create request and pass parameters in httpBody
    class func createRequest(url : String, dictParams: Parameters) -> URLRequest {
        let urlString      = url
        let url            = URL(string: urlString)!
        var request        = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody   = try JSONSerialization.data(withJSONObject: dictParams)
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        
        return request
    }
    
    
    class func formatNumber(num: Double) ->String
    {
        var thousandNum = num/1000
        var millionNum  = num/1000000
        
        
        if num >= 1000 && num < 1000000
        {
            if(floor(thousandNum) == thousandNum)
            {
                return("\(Int(thousandNum))k")
            }
            
            return("\(thousandNum.roundToPlaces(places: 1))k")
        }
        
        if num > 1000000
        {
            if(floor(millionNum) == millionNum)
            {
                return("\(Int(thousandNum))k")
            }
            
            return ("\(millionNum.roundToPlaces(places: 1))M")
        }
        else
        {
            if(floor(num) == num)
            {
                return ("\(Int(num))")
            }
            
            return ("\(num)")
        }
        
    }
    
    
    class func resizedImage(at url: URL, for size: CGSize) -> UIImage?
    {
        guard let image = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    
    
    //--
    
    class func applyCurvedPath(givenView: UIView, curvedPercent:CGFloat)
    {
        guard curvedPercent <= 1 && curvedPercent >= 0 else{
            return
        }
        
        let shapeLayer = CAShapeLayer(layer: givenView.layer)
        shapeLayer.path = self.pathCurvedForView(givenView: givenView,curvedPercent: curvedPercent).cgPath
        shapeLayer.frame = givenView.bounds
        shapeLayer.masksToBounds = true
        givenView.layer.mask = shapeLayer
    }
    
    private class func pathCurvedForView(givenView: UIView, curvedPercent:CGFloat) -> UIBezierPath
    {
        let arrowPath = UIBezierPath()
        arrowPath.move(to: CGPoint(x:0, y:0))
        arrowPath.addLine(to: CGPoint(x:givenView.bounds.size.width, y:0))
        arrowPath.addLine(to: CGPoint(x:givenView.bounds.size.width, y:givenView.bounds.size.height - (givenView.bounds.size.height*curvedPercent)))
        arrowPath.addQuadCurve(to: CGPoint(x:0, y:givenView.bounds.size.height - (givenView.bounds.size.height*curvedPercent)), controlPoint: CGPoint(x:givenView.bounds.size.width/2, y:givenView.bounds.size.height))
        arrowPath.addLine(to: CGPoint(x:0, y:0))
        arrowPath.close()
        
        return arrowPath
    }
    
    
    //--
    
    
    class func setTextFieldBorder(txtF: UITextField)
    {
        txtF.layer.borderColor  = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        txtF.layer.borderWidth  = 2.0
        txtF.layer.cornerRadius = 6.0
    }
    
    class func setTextViewBorder(tV: UITextView)
    {
        tV.layer.borderColor  = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tV.layer.borderWidth  = 2.0
        tV.layer.cornerRadius = 6.0
    }
    //--
    
    //--
    
    class func setSVprogress()
    {
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setDefaultAnimationType(.native)
        //SVProgressHUD.setFadeInAnimationDuration(0.1)
        
        SVProgressHUD.setMinimumDismissTimeInterval(0.8)
        SVProgressHUD.setMaximumDismissTimeInterval(1.2)
    }
    
    class func callNumber(phoneNumber:String) {

      if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {

        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
      }
        
        //callNumber("7178881234")
    }
    
    class func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    //MARK: -
    
    class func writeToFile(urlString: String) -> URL?
    {
        guard let videoUrl = URL(string: urlString) else { return nil }
        
        do {
            
            let videoData = try Data(contentsOf: videoUrl)
            let fm = FileManager.default
            
            guard let docUrl = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
                print("Unable to reach the documents folder")
                return nil
            }
            
            let localUrl = docUrl.appendingPathComponent(videoUrl.lastPathComponent)
            try videoData.write(to: localUrl)
            return localUrl
            
        } catch  {
            print("could not save data")
            return nil
        }
    }
    
    
    class func removeFileIfExist(url: URL?)
    {
        guard let url = url else { return }
        
        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let filePath = docDir.appendingPathComponent(url.lastPathComponent)
        
        do {
            try FileManager.default.removeItem(at: filePath)
            print("File deleted")
        }
        catch {
            print("Error")
        }
    }
    
    class func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    
   
}

public extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,1", "iPad5,3", "iPad5,4":           return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}
