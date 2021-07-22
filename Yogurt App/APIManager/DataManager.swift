//
//  DataManager.swift
//  GoToWork
//
//  Created by Innovative on 10/12/20.
//  Copyright © 2020 INNOVATIVE ITERATION. All rights reserved.
//

import UIKit

var dataManager = DataManager()

class DataManager: NSObject {
    
    var boolIsNavigateFromTabbar: Bool = false
    var mutArrayAllCountryList: NSArray? = nil
    var arrayCardProviderID: NSMutableArray? = nil
    var strDefaultChatProfileImage: String? = ""
    var boolIsAppLaunch: Bool = false
    
    
}
