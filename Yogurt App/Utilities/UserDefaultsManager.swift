//
//  UserDefaultsManager.swift
//  GoToWork
//
//  Created by INNOVATIVE ITERATION on 25/09/20.
//  Copyright © 2020 INNOVATIVE ITERATION. All rights reserved.
//

import Foundation

enum UserDefaultsKeys : String {
    case TimerDate
    case SelectMaker
    case SelectMakerDescription
    case FCMToken
    case id
    
}

extension UserDefaults {

    //MARK:- Save DEVICETOKEN
    func setTimerDate(value: String) {
        set(value, forKey: UserDefaultsKeys.TimerDate.rawValue)
    }
    
    func getTimerDate() -> String {
        return string(forKey: UserDefaultsKeys.TimerDate.rawValue) ?? ""
    }
    
   
    func setSelectMaker(value: String) {
        set(value, forKey: UserDefaultsKeys.SelectMaker.rawValue)
    }
    
    func getSelectMaker() -> String {
        return string(forKey: UserDefaultsKeys.SelectMaker.rawValue) ?? ""
    }
    func setSelectMakerDescription(value: String) {
        set(value, forKey: UserDefaultsKeys.SelectMakerDescription.rawValue)
    }
    
    func getSelectMakerDescription() -> String {
        return string(forKey: UserDefaultsKeys.SelectMakerDescription.rawValue) ?? ""
    }
    
    //MARK:- FCM Token
    func setFCMTokenData(value: Any) {
        set(value, forKey: UserDefaultsKeys.FCMToken.rawValue)
        synchronize()
    }
    
    func getFCMTokenData() -> String {
        return string(forKey: UserDefaultsKeys.FCMToken.rawValue) ?? ""
    }
    //MARK:- FCM Token
    func setIDData(value: Any) {
        set(value, forKey: UserDefaultsKeys.id.rawValue)
        synchronize()
    }
    
    func getIDData() -> String {
        return string(forKey: UserDefaultsKeys.id.rawValue) ?? ""
    }
    
    
    func clearUserDefaultsValues() {

        Constant.userDefault.removeObject(forKey: UserDefaultsKeys.TimerDate.rawValue)
        Constant.userDefault.removeObject(forKey: UserDefaultsKeys.SelectMaker.rawValue)
        synchronize()
    }
    static func isFirstLaunch() -> Bool {
            let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
            let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
            if (isFirstLaunch) {
                UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
                UserDefaults.standard.synchronize()
            }
            return isFirstLaunch
        }
 
}


//MARK:- Examples
/*
 Save in UserDefaults where you want
 UserDefaults.standard.setLoggedIn(value: true)          // String
 UserDefaults.standard.setUserID(value: result.User.id!) // String
 
 Retrieve data anywhere in app
 print("ID : \(UserDefaults.standard.getUserID())")
 UserDefaults.standard.getUserID()
 
 Remove Values
 UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.userID)
 */
