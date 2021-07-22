//
//  Webservices.swift
//  GoToWork
//
//  Created by INNOVATIVE ITERATION on 11/09/20.
//  Copyright © 2020 INNOVATIVE ITERATION. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration
import Alamofire
import SwiftyJSON

enum HttpResponseStatusCode : Int {
    case ok = 200
    case badRequest = 400
    case noAuthorization = 401
}

let reachability = Reachability()!

class WebServices: NSObject
{
    var operationQueue = OperationQueue()
    
    func CallGlobalAPI(url:String, headers:NSDictionary, parameters:NSDictionary, httpMethod:String, progressView:Bool, uiView:UIView, networkAlert:Bool, responseDict:@escaping (_ jsonResponce:Any?, _ strErrorMessage:String) -> Void) {
        
        print("URL: \(url)")
        print("Headers: \n\(headers)")
        print("Parameters: \n\(parameters)")
        
        if progressView == true {
            self.ProgressViewShow(uiView:uiView)
        }
        let operation = BlockOperation.init {
            DispatchQueue.global(qos: .background).async {
                if self.internetChecker(reachability: Reachability()!) {
                    if (httpMethod == "POST") {
                        var req = URLRequest(url: try! url.asURL())
                        req.httpMethod = "POST"
                        req.allHTTPHeaderFields = headers as? [String:String]
                        req.setValue("application/json", forHTTPHeaderField: "content-type")
                        req.httpBody = try! JSONSerialization.data(withJSONObject: parameters)
                        req.timeoutInterval = 30
                        AF.request(req).responseJSON { response in
                            switch (response.result)
                            {
                            case .success:
                                if((response.value) != nil) {
                                    let jsonResponce = response.data //JSON(response.value!)
                                    print("Responce: \n\(JSON(response.value!))")
                                    DispatchQueue.main.async {
                                        self.ProgressViewHide(uiView: uiView)
                                        responseDict(jsonResponce,"")
                                    }
                                }
                                break
                            case .failure(let error):
                                let message : String
                                if let httpStatusCode = response.response?.statusCode {
                                    switch(httpStatusCode) {
                                    case 400:
                                        self.ProgressViewHide(uiView: uiView)
                                        message = "Something Went Wrong..Try Again"
                                    case 401:
                                        self.ProgressViewHide(uiView: uiView)
                                        message = "Something Went Wrong..Try Again"
                                        DispatchQueue.main.async {
                                            self.ProgressViewHide(uiView: uiView)
                                            responseDict([:],message)
                                        }
                                    default:
                                        
                                        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8)
                                        {
                                            print("error utf8 : ",utf8Text)
                                        }
                                        
                                        print("error",error.localizedDescription)
                                        
                                        self.ProgressViewHide(uiView: uiView)
                                        break
                                    }
                                } else {
                                    message = error.localizedDescription
                                    let jsonError = JSON(response.error!)
                                    DispatchQueue.main.async {
                                        self.ProgressViewHide(uiView: uiView)
                                        //responseDict(jsonError,"")
                                        responseDict([:],message)
                                    }
                                }
                                break
                            }
                        }
                    }
                    else if (httpMethod == "GET") {
                        var req = URLRequest(url: try! url.asURL())
                        req.httpMethod = "GET"
                        req.allHTTPHeaderFields = headers as? [String:String]
                        req.setValue("application/json", forHTTPHeaderField: "content-type")
                        req.timeoutInterval = 30
                        AF.request(req).responseJSON { response in
                            switch (response.result)
                            {
                            case .success:
                                if((response.value) != nil) {
                                    let jsonResponce = JSON(response.value!)
                                    DispatchQueue.main.async {
                                        self.ProgressViewHide(uiView: uiView)
                                        responseDict(jsonResponce,"")
                                    }
                                }
                                break
                            case .failure(let error):
                                let message : String
                                if let httpStatusCode = response.response?.statusCode {
                                    switch(httpStatusCode) {
                                    case 400:
                                        message = "Something Went Wrong..Try Again"
                                    case 401:
                                        message = "Something Went Wrong..Try Again"
                                        DispatchQueue.main.async {
                                            self.ProgressViewHide(uiView: uiView)
                                            responseDict([:],message)
                                        }
                                    default: break
                                    }
                                } else {
                                    message = error.localizedDescription
                                    let jsonError = JSON(response.error!)
                                    DispatchQueue.main.async {
                                        self.ProgressViewHide(uiView: uiView)
                                        //responseDict(jsonError,"")
                                        responseDict([:],message)
                                    }
                                }
                                break
                            }
                        }
                    }
                }
                else {
                    self.ProgressViewHide(uiView: uiView)
                    if networkAlert == true {
                        DispatchQueue.main.async {
                            Utils.showNYAlertViewWithTitle(title: "Error!", detail: Constant.noInternet)
                        }
                        
                    }
                }
            }
        }
        operation.queuePriority = .normal
        operationQueue.addOperation(operation)
    }
    
    func CallGlobalAPIForm(url:String, headers:NSDictionary, parameters:String, httpMethod:String, progressView:Bool, uiView:UIView, networkAlert:Bool, responseDict:@escaping (_ jsonResponce:Any?, _ strErrorMessage:String) -> Void) {
        
        print("URL: \(url)")
        print("Headers: \n\(headers)")
        print("Parameters: \n\(parameters)")
        
        if progressView == true {
            self.ProgressViewShow(uiView:uiView)
        }
        let operation = BlockOperation.init {
            DispatchQueue.global(qos: .background).async {
                if self.internetChecker(reachability: Reachability()!) {
                    if (httpMethod == "POST") {
                        var req = URLRequest(url: try! url.asURL())
                        req.httpMethod = "POST"
                     //   req.allHTTPHeaderFields = headers as? [String:String]
                        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
                        req.httpBody = parameters.data(using: .utf8)
                        req.timeoutInterval = 30
                        AF.request(req).responseJSON { response in
                            switch (response.result)
                            {
                            case .success:
                                if((response.value) != nil) {
                                    let jsonResponce = response.data
                                        //JSON(response.value!)
                                    //print("Responce: \n\(jsonResponce)")
                                    print("Responce: \n\(JSON(response.value!))")
                                    DispatchQueue.main.async {
                                        self.ProgressViewHide(uiView: uiView)
                                        responseDict(jsonResponce,"")
                                    }
                                }
                                break
                            case .failure(let error):
                                let message : String
                                if let httpStatusCode = response.response?.statusCode {
                                    switch(httpStatusCode) {
                                    case 400:
                                        self.ProgressViewHide(uiView: uiView)
                                        message = "Something Went Wrong..Try Again"
                                    case 401:
                                        self.ProgressViewHide(uiView: uiView)
                                        message = "Something Went Wrong..Try Again"
                                        DispatchQueue.main.async {
                                            self.ProgressViewHide(uiView: uiView)
                                            responseDict([:],message)
                                        }
                                    default:
                                        
                                        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8)
                                        {
                                            print("error utf8 : ",utf8Text)
                                        }
                                        
                                        print("error",error.localizedDescription)
                                        
                                        self.ProgressViewHide(uiView: uiView)
                                        
                                        break
                                    }
                                } else {
                                    message = error.localizedDescription
                                    let jsonError = JSON(response.error!)
                                    DispatchQueue.main.async {
                                        self.ProgressViewHide(uiView: uiView)
                                        //responseDict(jsonError,"")
                                        responseDict([:],message)
                                    }
                                }
                                break
                            }
                        }
                    }
                    else if (httpMethod == "GET") {
                        var req = URLRequest(url: try! url.asURL())
                        req.httpMethod = "GET"
                        req.allHTTPHeaderFields = headers as? [String:String]
                        req.setValue("application/json", forHTTPHeaderField: "content-type")
                        req.timeoutInterval = 30
                        AF.request(req).responseJSON { response in
                            switch (response.result)
                            {
                            case .success:
                                if((response.value) != nil) {
                                    let jsonResponce = JSON(response.value!)
                                    DispatchQueue.main.async {
                                        self.ProgressViewHide(uiView: uiView)
                                        responseDict(jsonResponce,"")
                                    }
                                }
                                break
                            case .failure(let error):
                                let message : String
                                if let httpStatusCode = response.response?.statusCode {
                                    switch(httpStatusCode) {
                                    case 400:
                                        message = "Something Went Wrong..Try Again"
                                    case 401:
                                        message = "Something Went Wrong..Try Again"
                                        DispatchQueue.main.async {
                                            self.ProgressViewHide(uiView: uiView)
                                            responseDict([:],message)
                                        }
                                    default: break
                                    }
                                } else {
                                    message = error.localizedDescription
                                    let jsonError = JSON(response.error!)
                                    DispatchQueue.main.async {
                                        self.ProgressViewHide(uiView: uiView)
                                        responseDict(jsonError,"")
                                    }
                                }
                                break
                            }
                        }
                    }
                }
                else {
                    self.ProgressViewHide(uiView: uiView)
                    if networkAlert == true {
                        DispatchQueue.main.async {
                            Utils.showNYAlertViewWithTitle(title: "Error!", detail: Constant.noInternet)
                        }
                    }
                }
            }
        }
        operation.queuePriority = .normal
        operationQueue.addOperation(operation)
    }

    
    func multipartWebService(method:HTTPMethod, URLString:String, parameters:[String: Any], fileData:Data!, fileUrl:URL?, headers:HTTPHeaders, keyName:String, completion: @escaping (_ response:AnyObject?, _ error: NSError?) -> ()){
        
        print("Fetching WS : \(URLString)")
        print("With parameters : \(parameters)")
        
        if  !NetworkReachabilityManager()!.isReachable {
            DispatchQueue.main.async {
                Utils.showNYAlertViewWithTitle(title: "Error!", detail: Constant.noInternet)
            }
            return
        }
        
        AF.upload(multipartFormData: { MultipartFormData in
            for (key, value) in parameters {
                MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            let name = self.randomString(length: 8)
            if let data = fileData {
                MultipartFormData.append(data, withName: keyName, fileName: "user_\(name).jpeg", mimeType: "image/jpeg")
            }
        }, to: URLString, method: .post, headers: headers)
            .responseJSON { (response) in
                if let statusCode = response.response?.statusCode {
                    if  statusCode == HttpResponseStatusCode.noAuthorization.rawValue {
                        DispatchQueue.main.async {
                            Utils.showNYAlertViewWithTitle(title: "Error!", detail: "Something went wrong.. Try again.")
                        }
                        return
                    }
                }
                if let error = response.error {
                    completion(nil, error as NSError?)
                }
                else {
                    guard let data = response.data
                        else {
                        DispatchQueue.main.async {
                            Utils.showNYAlertViewWithTitle(title: "Error!", detail: "Something went wrong.. Try again.")
                        }
                            return
                    }
                    do {
                        let unparsedObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject
                        completion(unparsedObject, nil)
                    }
                    catch let exception as NSError {
                        completion(nil, exception)
                    }
                }
        }
    }
    
    func multipartWebServiceArray(method:HTTPMethod, URLString:String, parameters:[String: Any], fileData:[Data], fileUrl:URL?, headers:HTTPHeaders, keyName:String,mediaType:String, completion: @escaping (_ response:AnyObject?, _ error: NSError?) -> ()){
        
        print("Fetching WS : \(URLString)")
        print("With parameters : \(parameters)")
        
        if  !NetworkReachabilityManager()!.isReachable {
            DispatchQueue.main.async {
                Utils.showNYAlertViewWithTitle(title: "Error!", detail: Constant.noInternet)
            }
            return
        }
        
        AF.upload(multipartFormData: { MultipartFormData in
            for (key, value) in parameters {
                MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            if mediaType == "image"{
            for data in fileData {
                let name = self.randomString(length: 8)
                MultipartFormData.append(data, withName: keyName, fileName: "img_\(name).jpeg", mimeType: "image/jpeg")
            }
            } else {
                for data in fileData {
                    let name = self.randomString(length: 8)
                    MultipartFormData.append(data, withName: keyName, fileName: "Video_\(name).mp4", mimeType: "video/mp4")
                }
            }
        }, to: URLString, method: .post, headers: headers)
            .responseJSON { (response) in
                if let statusCode = response.response?.statusCode {
                    if  statusCode == HttpResponseStatusCode.noAuthorization.rawValue {
                        DispatchQueue.main.async {
                            Utils.showNYAlertViewWithTitle(title: "Error!", detail: "Something went wrong.. Try again.")
                        }
                        return
                    }
                }
                if let error = response.error {
                    completion(nil, error as NSError?)
                }
                else {
                    guard let data = response.data
                        else {
                        DispatchQueue.main.async {
                            Utils.showNYAlertViewWithTitle(title: "Error!", detail: "Something went wrong.. Try again.")
                        }
                            return
                    }
                    do {
                        let unparsedObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject
                        completion(unparsedObject, nil)
                    }
                    catch let exception as NSError {
                        completion(nil, exception)
                    }
                }
        }
    }
    
    func randomString(length: Int) -> String {
        
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
    
    func internetChecker(reachability: Reachability) -> Bool {
        var check:Bool = false
        if reachability.connection == .wifi {
            check = true
        }
        else if reachability.connection == .cellular {
            check = true
        }
        else {
            check = false
        }
        return check
    }
    
    func ProgressViewShow(uiView:UIView) {
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
    }
    
    func ProgressViewHide(uiView:UIView) {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
}


