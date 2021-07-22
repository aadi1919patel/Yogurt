//
//  MySingleton.swift
//  GoToWork
//

//  Created by INNOVATIVE ITERATION on 11/09/20.
//  Copyright © 2020 INNOVATIVE ITERATION. All rights reserved.
//

import UIKit
import Foundation

//import LGSideMenuController.LGSideMenuController
//import LGSideMenuController.UIViewController_LGSideMenuController

let _sharedManager: MySingleton = { MySingleton() }()

class MySingleton: NSObject
{
    var screenRect: CGRect
    var screenWidth: CGFloat
    let screenHeight: CGFloat
    
    var safeAreaInsetsTop: CGFloat
    var safeAreaInsetsBottom: CGFloat
    
    var hasTopNotch: Bool {
        if #available(iOS 11.0,  *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
    //========================= APPLICATION SPECIFIC SETTINGS ================//
    
    //========================= SIDE MENU SETTINGS ================//
    
    var floatLeftSideMenuWidth: CGFloat?
    var floatRightSideMenuWidth: CGFloat?
    
    //var leftViewPresentationStyle: LGSideMenuPresentationStyle?
    //var rightViewPresentationStyle: LGSideMenuPresentationStyle?
    
    //========================= NAVIGATION BAR SETTINGS ================/
    var navigationBarBackgroundColor: UIColor?
    var navigationBarTitleColor: UIColor?
    var navigationBarTitleFont: UIFont?
    var navigationBarTitleSmallFont: UIFont?
    
    //========================= THEME GLOBAL COLORS SETTINGS ================//
    var themeGlobalPurpleColor: UIColor?
    var themeGlobalBlueColor: UIColor?
    var themeGlobalLightBlueColor: UIColor?
    var themeGlobalGreenColor: UIColor?
    var themeGlobalLightGreenColor: UIColor?
    var themeGlobalRedColor: UIColor?
    var themeGlobalPinkColor: UIColor?
    var themeGlobalYellowColor: UIColor?
    var themeGlobalWhiteColor: UIColor?
    var themeGlobalDarkBlackColor: UIColor?
    var themeGlobalBlackColor: UIColor?
    var themeGlobalDarkGreyColor: UIColor?
    var themeGlobalGreyColor: UIColor?
    var themeGlobalLightGreyColor: UIColor?
    var themeGlobalLightestGreyColor: UIColor?
    var themeGlobalSeperatorGreyColor: UIColor?
    var themeGlobalSideMenuSeperatorColor: UIColor?
    var themeGlobalBottomBackgroundGreyColor: UIColor?
    
    var themeGlobalSelectionBackgroundColor: UIColor?
    
    var themeGlobalGraphBackgroundColor: UIColor?
    var themeGlobalGraphLocalColor: UIColor?
    var themeGlobalGraphGlobalColor: UIColor?
    
    var textfieldPlaceholderColor: UIColor?
    var textfieldTextColor: UIColor?
    var textfieldDisabledTextColor: UIColor?
    var textfieldFloatingLabelTextColor: UIColor?
    var textfieldBottomSeparatorColor: UIColor?
    
    //Text color
    var themeDarkTextColor: UIColor?
    var themeDark1TextColor: UIColor?
    var themeLightGreyTextColor: UIColor?
    var themeLightGreyRegularColor: UIColor?
    var themeLightGrey1TextColor: UIColor?
    
    //========================= THEME GLOBAL CUSTOM COLORS SETTINGS ================//
    var themeGlobalOrangeColor: UIColor?
    var themeGlobalFacebookColor: UIColor?
    var themeGlobalGoogleColor: UIColor?
    
    var themeGlobalBackgroundColor: UIColor?
    var themeGlobalButtonDissabledColor: UIColor?
    
    var themeGlobalDissabledColor: UIColor?
    var themeGlobalIndicatedColor: UIColor?
    var themeGlobalPossibleColor: UIColor?
    var themeGlobalContradicatedColor: UIColor?
    
    var themeGlobalOptionNoramlColor: UIColor?
    var themeGlobalOptionPossibleColor: UIColor?
    var themeGlobalOptionCriticalColor: UIColor?
    
    //========================= FLOAT VALUES SETTINGS ================//
    var floatButtonCornerRadius: CGFloat?
    
    //========================= THEME REGULAR FONTS SETTING ================//
    var themeFontFourSizeRegular: UIFont?
    var themeFontFiveSizeRegular: UIFont?
    var themeFontSixSizeRegular: UIFont?
    var themeFontSevenSizeRegular: UIFont?
    var themeFontEightSizeRegular: UIFont?
    var themeFontNineSizeRegular: UIFont?
    var themeFontTenSizeRegular: UIFont?
    var themeFontElevenSizeRegular: UIFont?
    var themeFontTwelveSizeRegular: UIFont?
    var themeFontThirteenSizeRegular: UIFont?
    var themeFontFourteenSizeRegular: UIFont?
    var themeFontFifteenSizeRegular: UIFont?
    var themeFontSixteenSizeRegular: UIFont?
    var themeFontSeventeenSizeRegular: UIFont?
    var themeFontEighteenSizeRegular: UIFont?
    var themeFontNineteenSizeRegular: UIFont?
    var themeFontTwentySizeRegular: UIFont?
    var themeFontTwentyOneSizeRegular: UIFont?
    var themeFontTwentyTwoSizeRegular: UIFont?
    var themeFontTwentyThreeSizeRegular: UIFont?
    var themeFontTwentyFourSizeRegular: UIFont?
    var themeFontTwentyFiveSizeRegular: UIFont?
    var themeFontTwentySixSizeRegular: UIFont?
    var themeFontTwentySevenSizeRegular: UIFont?
    var themeFontTwentyEightSizeRegular: UIFont?
    var themeFontTwentyNineSizeRegular: UIFont?
    var themeFontThirtySizeRegular: UIFont?
    var themeFontThirtyOneSizeRegular: UIFont?
    var themeFontThirtyTwoSizeRegular: UIFont?
    var themeFontThirtyThreeSizeRegular: UIFont?
    var themeFontThirtyFourSizeRegular: UIFont?
    var themeFontThirtyFiveSizeRegular: UIFont?
    var themeFontThirtySixSizeRegular: UIFont?
    var themeFontThirtySevenSizeRegular: UIFont?
    var themeFontThirtyEightSizeRegular: UIFont?
    var themeFontThirtyNineSizeRegular: UIFont?
    var themeFontFourtySizeRegular: UIFont?
    var themeFontFourtyOneSizeRegular: UIFont?
    var themeFontFourtyTwoSizeRegular: UIFont?
    var themeFontFourtyThreeSizeRegular: UIFont?
    var themeFontFourtyFourSizeRegular: UIFont?
    var themeFontFourtyFiveSizeRegular: UIFont?
    var themeFontFourtySixSizeRegular: UIFont?
    var themeFontFourtySevenSizeRegular: UIFont?
    var themeFontFourtyEightSizeRegular: UIFont?
    
    //========================= THEME LIGHT FONTS SETTING ================//
    var themeFontFourSizeLight: UIFont?
    var themeFontFiveSizeLight: UIFont?
    var themeFontSixSizeLight: UIFont?
    var themeFontSevenSizeLight: UIFont?
    var themeFontEightSizeLight: UIFont?
    var themeFontNineSizeLight: UIFont?
    var themeFontTenSizeLight: UIFont?
    var themeFontElevenSizeLight: UIFont?
    var themeFontTwelveSizeLight: UIFont?
    var themeFontThirteenSizeLight: UIFont?
    var themeFontFourteenSizeLight: UIFont?
    var themeFontFifteenSizeLight: UIFont?
    var themeFontSixteenSizeLight: UIFont?
    var themeFontSeventeenSizeLight: UIFont?
    var themeFontEighteenSizeLight: UIFont?
    var themeFontNineteenSizeLight: UIFont?
    var themeFontTwentySizeLight: UIFont?
    var themeFontTwentyOneSizeLight: UIFont?
    var themeFontTwentyTwoSizeLight: UIFont?
    var themeFontTwentyThreeSizeLight: UIFont?
    var themeFontTwentyFourSizeLight: UIFont?
    var themeFontTwentyFiveSizeLight: UIFont?
    var themeFontTwentySixSizeLight: UIFont?
    var themeFontTwentySevenSizeLight: UIFont?
    var themeFontTwentyEightSizeLight: UIFont?
    var themeFontTwentyNineSizeLight: UIFont?
    var themeFontThirtySizeLight: UIFont?
    var themeFontThirtyOneSizeLight: UIFont?
    var themeFontThirtyTwoSizeLight: UIFont?
    var themeFontThirtyThreeSizeLight: UIFont?
    var themeFontThirtyFourSizeLight: UIFont?
    var themeFontThirtyFiveSizeLight: UIFont?
    var themeFontThirtySixSizeLight: UIFont?
    var themeFontThirtySevenSizeLight: UIFont?
    var themeFontThirtyEightSizeLight: UIFont?
    var themeFontThirtyNineSizeLight: UIFont?
    var themeFontFourtySizeLight: UIFont?
    var themeFontFourtyOneSizeLight: UIFont?
    var themeFontFourtyTwoSizeLight: UIFont?
    var themeFontFourtyThreeSizeLight: UIFont?
    var themeFontFourtyFourSizeLight: UIFont?
    var themeFontFourtyFiveSizeLight: UIFont?
    var themeFontFourtySixSizeLight: UIFont?
    var themeFontFourtySevenSizeLight: UIFont?
    var themeFontFourtyEightSizeLight: UIFont?
    
    //========================= THEME MEDIUM FONTS SETTING ================//
    var themeFontFourSizeMedium: UIFont?
    var themeFontFiveSizeMedium: UIFont?
    var themeFontSixSizeMedium: UIFont?
    var themeFontSevenSizeMedium: UIFont?
    var themeFontEightSizeMedium: UIFont?
    var themeFontNineSizeMedium: UIFont?
    var themeFontTenSizeMedium: UIFont?
    var themeFontElevenSizeMedium: UIFont?
    var themeFontTwelveSizeMedium: UIFont?
    var themeFontThirteenSizeMedium: UIFont?
    var themeFontFourteenSizeMedium: UIFont?
    var themeFontFifteenSizeMedium: UIFont?
    var themeFontSixteenSizeMedium: UIFont?
    var themeFontSeventeenSizeMedium: UIFont?
    var themeFontEighteenSizeMedium: UIFont?
    var themeFontNineteenSizeMedium: UIFont?
    var themeFontTwentySizeMedium: UIFont?
    var themeFontTwentyOneSizeMedium: UIFont?
    var themeFontTwentyTwoSizeMedium: UIFont?
    var themeFontTwentyThreeSizeMedium: UIFont?
    var themeFontTwentyFourSizeMedium: UIFont?
    var themeFontTwentyFiveSizeMedium: UIFont?
    var themeFontTwentySixSizeMedium: UIFont?
    var themeFontTwentySevenSizeMedium: UIFont?
    var themeFontTwentyEightSizeMedium: UIFont?
    var themeFontTwentyNineSizeMedium: UIFont?
    var themeFontThirtySizeMedium: UIFont?
    var themeFontThirtyOneSizeMedium: UIFont?
    var themeFontThirtyTwoSizeMedium: UIFont?
    var themeFontThirtyThreeSizeMedium: UIFont?
    var themeFontThirtyFourSizeMedium: UIFont?
    var themeFontThirtyFiveSizeMedium: UIFont?
    var themeFontThirtySixSizeMedium: UIFont?
    var themeFontThirtySevenSizeMedium: UIFont?
    var themeFontThirtyEightSizeMedium: UIFont?
    var themeFontThirtyNineSizeMedium: UIFont?
    var themeFontFourtySizeMedium: UIFont?
    var themeFontFourtyOneSizeMedium: UIFont?
    var themeFontFourtyTwoSizeMedium: UIFont?
    var themeFontFourtyThreeSizeMedium: UIFont?
    var themeFontFourtyFourSizeMedium: UIFont?
    var themeFontFourtyFiveSizeMedium: UIFont?
    var themeFontFourtySixSizeMedium: UIFont?
    var themeFontFourtySevenSizeMedium: UIFont?
    var themeFontFourtyEightSizeMedium: UIFont?
    
    //========================= THEME BOLD FONTS SETTING ================//
    var themeFontFourSizeBold: UIFont?
    var themeFontFiveSizeBold: UIFont?
    var themeFontSixSizeBold: UIFont?
    var themeFontSevenSizeBold: UIFont?
    var themeFontEightSizeBold: UIFont?
    var themeFontNineSizeBold: UIFont?
    var themeFontTenSizeBold: UIFont?
    var themeFontElevenSizeBold: UIFont?
    var themeFontTwelveSizeBold: UIFont?
    var themeFontThirteenSizeBold: UIFont?
    var themeFontFourteenSizeBold: UIFont?
    var themeFontFifteenSizeBold: UIFont?
    var themeFontSixteenSizeBold: UIFont?
    var themeFontSeventeenSizeBold: UIFont?
    var themeFontEighteenSizeBold: UIFont?
    var themeFontNineteenSizeBold: UIFont?
    var themeFontTwentySizeBold: UIFont?
    var themeFontTwentyOneSizeBold: UIFont?
    var themeFontTwentyTwoSizeBold: UIFont?
    var themeFontTwentyThreeSizeBold: UIFont?
    var themeFontTwentyFourSizeBold: UIFont?
    var themeFontTwentyFiveSizeBold: UIFont?
    var themeFontTwentySixSizeBold: UIFont?
    var themeFontTwentySevenSizeBold: UIFont?
    var themeFontTwentyEightSizeBold: UIFont?
    var themeFontTwentyNineSizeBold: UIFont?
    var themeFontThirtySizeBold: UIFont?
    var themeFontThirtyOneSizeBold: UIFont?
    var themeFontThirtyTwoSizeBold: UIFont?
    var themeFontThirtyThreeSizeBold: UIFont?
    var themeFontThirtyFourSizeBold: UIFont?
    var themeFontThirtyFiveSizeBold: UIFont?
    var themeFontThirtySixSizeBold: UIFont?
    var themeFontThirtySevenSizeBold: UIFont?
    var themeFontThirtyEightSizeBold: UIFont?
    var themeFontThirtyNineSizeBold: UIFont?
    var themeFontFourtySizeBold: UIFont?
    var themeFontFourtyOneSizeBold: UIFont?
    var themeFontFourtyTwoSizeBold: UIFont?
    var themeFontFourtyThreeSizeBold: UIFont?
    var themeFontFourtyFourSizeBold: UIFont?
    var themeFontFourtyFiveSizeBold: UIFont?
    var themeFontFourtySixSizeBold: UIFont?
    var themeFontFourtySevenSizeBold: UIFont?
    var themeFontFourtyEightSizeBold: UIFont?
    
    //========================= THEME ITALIC FONTS SETTING ================//
    var themeFontFourteenSizeItalic: UIFont?
    
    //========================= ALERT VIEW SETTINGS ================//
    var alertViewTitleFont: UIFont?
    var alertViewMessageFont: UIFont?
    var alertViewButtonTitleFont: UIFont?
    var alertViewCancelButtonTitleFont: UIFont?
    
    var alertViewTitleColor: UIColor?
    var alertViewContentColor: UIColor?
    var alertViewLeftButtonFontColor: UIColor?
    var alertViewBackGroundColor: UIColor?
    var alertViewLeftButtonBackgroundColor: UIColor?
    var alertViewRightButtonBackgroundColor: UIColor?
    
    //MARK:- ========================= OTHER CUSTOM METHODS ================//
    
    class func sharedManager() -> MySingleton
    {
        return _sharedManager
    }
    
    override init()
    {
        /*
        for family in UIFont.familyNames {
            print("\(family)")

            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
        */
        
        screenRect = UIScreen.main.bounds
        screenWidth = screenRect.width
        screenHeight = screenRect.height
        
        if #available(iOS 11.0,  *)
        {
//            safeAreaInsetsTop = (UIApplication.shared.delegate?.window??.safeAreaInsets.top)! - 20
//            safeAreaInsetsBottom = (UIApplication.shared.delegate?.window??.safeAreaInsets.bottom)!
            safeAreaInsetsTop = 20
            safeAreaInsetsBottom = 0
        }
        else
        {
            safeAreaInsetsTop = 20
            safeAreaInsetsBottom = 0
        }
        
        //MARK:- ========================= APPLICATION SPECIFIC SETTINGS ================//
        
        //MARK:- ========================= SIDE MENU SETTINGS ================//
        
        floatLeftSideMenuWidth = (screenWidth/10) * 7
        floatRightSideMenuWidth = (screenWidth/10) * 7
        
        //leftViewPresentationStyle = LGSideMenuPresentationStyle.slideBelow
        //rightViewPresentationStyle = LGSideMenuPresentationStyle.scaleFromBig
                
        //MARK:- ========================= NAVIGATION BAR SETTINGS ================/
        navigationBarBackgroundColor = .white // UIColor(rgb: 0xFFFFFF)
        navigationBarTitleColor = #colorLiteral(red: 0.2039215686, green: 0.262745098, blue: 0.337254902, alpha: 1) //UIColor(rgb: 0x1E262D)
        
        if screenWidth == 320
        {
            navigationBarTitleFont = UIFont(name: "Montserrat-Bold", size: 18)
            navigationBarTitleSmallFont = UIFont(name: "Montserrat-Bold", size: 14)
        }
        else if screenWidth == 375
        {
            navigationBarTitleFont = UIFont(name: "Montserrat-Bold", size: 18)
            navigationBarTitleSmallFont = UIFont(name: "Montserrat-Bold", size: 14)
        }
        else if screenWidth == 414
        {
            navigationBarTitleFont = UIFont(name: "Montserrat-Bold", size: 18)
            navigationBarTitleSmallFont = UIFont(name: "Montserrat-Bold", size: 14)
        }
        else
        {
            navigationBarTitleFont = UIFont(name: "Montserrat-Bold", size: 16)
            navigationBarTitleSmallFont = UIFont(name: "Montserrat-Bold", size: 14)
        }
        
        //MARK:- ========================= THEME GLOBAL COLORS SETTINGS ================
        themeGlobalPurpleColor               = UIColor(rgb : 0xff6666)
        themeGlobalBlueColor                 = UIColor(rgb : 0x0047B5)
        themeGlobalLightBlueColor            = #colorLiteral(red      : 0.09411764706, green      : 0.5803921569, blue      : 0.9960784314, alpha      : 1)
        themeGlobalGreenColor                = UIColor(rgb : 0x82BB5D)
        themeGlobalLightGreenColor           = UIColor(rgb : 0xA1D57A)
        themeGlobalRedColor                  = UIColor(rgb : 0xD0021B)
        themeGlobalPinkColor                 = UIColor(rgb : 0xff5577)
        themeGlobalYellowColor               = UIColor(rgb : 0xffba01)
        themeGlobalWhiteColor                = UIColor(rgb : 0xFFFFFF)
        themeGlobalDarkBlackColor            = UIColor(rgb : 0x000000)
        themeGlobalBlackColor                = UIColor(rgb : 0x485461)
        themeGlobalDarkGreyColor             = UIColor(rgb : 0x1E262D)
        themeGlobalGreyColor                 = UIColor(rgb : 0x808080)
        themeGlobalLightGreyColor            = UIColor(rgb : 0xefefef)
        themeGlobalLightestGreyColor         = UIColor(rgb : 0xF2F2F2)
        themeGlobalSeperatorGreyColor        = UIColor(rgb : 0xDCDCDC)
        themeGlobalSideMenuSeperatorColor    = UIColor(rgb : 0x868686)
        themeGlobalBottomBackgroundGreyColor = UIColor(rgb : 0xF8F8F8)
        
        themeGlobalSelectionBackgroundColor = UIColor(rgb: 0x4BCFFA)
        
        textfieldPlaceholderColor       = UIColor(rgb: 0x485461).withAlphaComponent(0.5)//909090)//0x9FA0A1
        textfieldTextColor              = UIColor(rgb: 0x0253DD)
        textfieldDisabledTextColor      = UIColor(rgb: 0x9FA0A1)
        textfieldFloatingLabelTextColor = UIColor(rgb: 0x2A4A7D)
        textfieldBottomSeparatorColor   = UIColor(rgb: 0x9FA0A1)
        
        //MARK:- ========================= THEME REGULAR FONTS SETTING ================//
        themeFontFourSizeRegular        = UIFont(name: "Montserrat-Regular", size: 4) //UIFont.systemFont(ofSize: 4, weight: .regular)
        themeFontFiveSizeRegular        = UIFont(name: "Montserrat-Regular", size: 5)
        themeFontSixSizeRegular         = UIFont(name: "Montserrat-Regular", size: 6)
        themeFontSevenSizeRegular       = UIFont(name: "Montserrat-Regular", size: 7)
        themeFontEightSizeRegular       = UIFont(name: "Montserrat-Regular", size: 8)
        themeFontNineSizeRegular        = UIFont(name: "Montserrat-Regular", size: 9)
        themeFontTenSizeRegular         = UIFont(name: "Montserrat-Regular", size: 10)
        themeFontElevenSizeRegular      = UIFont(name: "Montserrat-Regular", size: 11)
        themeFontTwelveSizeRegular      = UIFont(name: "Montserrat-Regular", size: 12)
        themeFontThirteenSizeRegular    = UIFont(name: "Montserrat-Regular", size: 13)
        themeFontFourteenSizeRegular    = UIFont(name: "Montserrat-Regular", size: 14)
        themeFontFifteenSizeRegular     = UIFont(name: "Montserrat-Regular", size: 15)
        themeFontSixteenSizeRegular     = UIFont(name: "Montserrat-Regular", size: 16)
        themeFontSeventeenSizeRegular   = UIFont(name: "Montserrat-Regular", size: 17)
        themeFontEighteenSizeRegular    = UIFont(name: "Montserrat-Regular", size: 18)
        themeFontNineteenSizeRegular    = UIFont(name: "Montserrat-Regular", size: 19)
        themeFontTwentySizeRegular      = UIFont(name: "Montserrat-Regular", size: 20)
        themeFontTwentyOneSizeRegular   = UIFont(name: "Montserrat-Regular", size: 21)
        themeFontTwentyTwoSizeRegular   = UIFont(name: "Montserrat-Regular", size: 22)
        themeFontTwentyThreeSizeRegular = UIFont(name: "Montserrat-Regular", size: 23)
        themeFontTwentyFourSizeRegular  = UIFont(name: "Montserrat-Regular", size: 24)
        themeFontTwentyFiveSizeRegular  = UIFont(name: "Montserrat-Regular", size: 25)
        themeFontTwentySixSizeRegular   = UIFont(name: "Montserrat-Regular", size: 26)
        themeFontTwentySevenSizeRegular = UIFont(name: "Montserrat-Regular", size: 27)
        themeFontTwentyEightSizeRegular = UIFont(name: "Montserrat-Regular", size: 28)
        themeFontTwentyNineSizeRegular  = UIFont(name: "Montserrat-Regular", size: 29)
        themeFontThirtySizeRegular      = UIFont(name: "Montserrat-Regular", size: 30)
        themeFontThirtyOneSizeRegular   = UIFont(name: "Montserrat-Regular", size: 31)
        themeFontThirtyTwoSizeRegular   = UIFont(name: "Montserrat-Regular", size: 32)
        themeFontThirtyThreeSizeRegular = UIFont(name: "Montserrat-Regular", size: 33)
        themeFontThirtyFourSizeRegular  = UIFont(name: "Montserrat-Regular", size: 34)
        themeFontThirtyFiveSizeRegular  = UIFont(name: "Montserrat-Regular", size: 35)
        themeFontThirtySixSizeRegular   = UIFont(name: "Montserrat-Regular", size: 36)
        themeFontThirtySevenSizeRegular = UIFont(name: "Montserrat-Regular", size: 37)
        themeFontThirtyEightSizeRegular = UIFont(name: "Montserrat-Regular", size: 38)
        themeFontThirtyNineSizeRegular  = UIFont(name: "Montserrat-Regular", size: 39)
        themeFontFourtySizeRegular      = UIFont(name: "Montserrat-Regular", size: 40)
        themeFontFourtyOneSizeRegular   = UIFont(name: "Montserrat-Regular", size: 41)
        themeFontFourtyTwoSizeRegular   = UIFont(name: "Montserrat-Regular", size: 42)
        themeFontFourtyThreeSizeRegular = UIFont(name: "Montserrat-Regular", size: 43)
        themeFontFourtyFourSizeRegular  = UIFont(name: "Montserrat-Regular", size: 44)
        themeFontFourtyFiveSizeRegular  = UIFont(name: "Montserrat-Regular", size: 45)
        themeFontFourtySixSizeRegular   = UIFont(name: "Montserrat-Regular", size: 46)
        themeFontFourtySevenSizeRegular = UIFont(name: "Montserrat-Regular", size: 47)
        themeFontFourtyEightSizeRegular = UIFont(name: "Montserrat-Regular", size: 48)
        
        //MARK:- ========================= THEME LIGHT FONTS SETTING ================//
        themeFontFourSizeLight        = UIFont(name: "Montserrat-Light", size: 4)
        themeFontFiveSizeLight        = UIFont(name: "Montserrat-Light", size: 5)
        themeFontSixSizeLight         = UIFont(name: "Montserrat-Light", size: 6)
        themeFontSevenSizeLight       = UIFont(name: "Montserrat-Light", size: 7)
        themeFontEightSizeLight       = UIFont(name: "Montserrat-Light", size: 8)
        themeFontNineSizeLight        = UIFont(name: "Montserrat-Light", size: 9)
        themeFontTenSizeLight         = UIFont(name: "Montserrat-Light", size: 10)
        themeFontElevenSizeLight      = UIFont(name: "Montserrat-Light", size: 11)
        themeFontTwelveSizeLight      = UIFont(name: "Montserrat-Light", size: 12)
        themeFontThirteenSizeLight    = UIFont(name: "Montserrat-Light", size: 13)
        themeFontFourteenSizeLight    = UIFont(name: "Montserrat-Light", size: 14)
        themeFontFifteenSizeLight     = UIFont(name: "Montserrat-Light", size: 15)
        themeFontSixteenSizeLight     = UIFont(name: "Montserrat-Light", size: 16)
        themeFontSeventeenSizeLight   = UIFont(name: "Montserrat-Light", size: 17)
        themeFontEighteenSizeLight    = UIFont(name: "Montserrat-Light", size: 18)
        themeFontNineteenSizeLight    = UIFont(name: "Montserrat-Light", size: 19)
        themeFontTwentySizeLight      = UIFont(name: "Montserrat-Light", size: 20)
        themeFontTwentyOneSizeLight   = UIFont(name: "Montserrat-Light", size: 21)
        themeFontTwentyTwoSizeLight   = UIFont(name: "Montserrat-Light", size: 22)
        themeFontTwentyThreeSizeLight = UIFont(name: "Montserrat-Light", size: 23)
        themeFontTwentyFourSizeLight  = UIFont(name: "Montserrat-Light", size: 24)
        themeFontTwentyFiveSizeLight  = UIFont(name: "Montserrat-Light", size: 25)
        themeFontTwentySixSizeLight   = UIFont(name: "Montserrat-Light", size: 26)
        themeFontTwentySevenSizeLight = UIFont(name: "Montserrat-Light", size: 27)
        themeFontTwentyEightSizeLight = UIFont(name: "Montserrat-Light", size: 28)
        themeFontTwentyNineSizeLight  = UIFont(name: "Montserrat-Light", size: 29)
        themeFontThirtySizeLight      = UIFont(name: "Montserrat-Light", size: 30)
        themeFontThirtyOneSizeLight   = UIFont(name: "Montserrat-Light", size: 31)
        themeFontThirtyTwoSizeLight   = UIFont(name: "Montserrat-Light", size: 32)
        themeFontThirtyThreeSizeLight = UIFont(name: "Montserrat-Light", size: 33)
        themeFontThirtyFourSizeLight  = UIFont(name: "Montserrat-Light", size: 34)
        themeFontThirtyFiveSizeLight  = UIFont(name: "Montserrat-Light", size: 35)
        themeFontThirtySixSizeLight   = UIFont(name: "Montserrat-Light", size: 36)
        themeFontThirtySevenSizeLight = UIFont(name: "Montserrat-Light", size: 37)
        themeFontThirtyEightSizeLight = UIFont(name: "Montserrat-Light", size: 38)
        themeFontThirtyNineSizeLight  = UIFont(name: "Montserrat-Light", size: 39)
        themeFontFourtySizeLight      = UIFont(name: "Montserrat-Light", size: 40)
        themeFontFourtyOneSizeLight   = UIFont(name: "Montserrat-Light", size: 41)
        themeFontFourtyTwoSizeLight   = UIFont(name: "Montserrat-Light", size: 42)
        themeFontFourtyThreeSizeLight = UIFont(name: "Montserrat-Light", size: 43)
        themeFontFourtyFourSizeLight  = UIFont(name: "Montserrat-Light", size: 44)
        themeFontFourtyFiveSizeLight  = UIFont(name: "Montserrat-Light", size: 45)
        themeFontFourtySixSizeLight   = UIFont(name: "Montserrat-Light", size: 46)
        themeFontFourtySevenSizeLight = UIFont(name: "Montserrat-Light", size: 47)
        themeFontFourtyEightSizeLight = UIFont(name: "Montserrat-Light", size: 48)
        
        //MARK:- ========================= THEME MEDIUM FONTS SETTING ================//
        
        themeFontFourSizeMedium        = UIFont(name: "futuramediumcondensedbt", size: 4)
        themeFontFiveSizeMedium        = UIFont(name: "futuramediumcondensedbt", size: 5)
        themeFontSixSizeMedium         = UIFont(name: "futuramediumcondensedbt", size: 6)
        themeFontSevenSizeMedium       = UIFont(name: "futuramediumcondensedbt", size: 7)
        themeFontEightSizeMedium       = UIFont(name: "futuramediumcondensedbt", size: 8)
        themeFontNineSizeMedium        = UIFont(name: "futuramediumcondensedbt", size: 9)
        themeFontTenSizeMedium         = UIFont(name: "futuramediumcondensedbt", size: 10)
        themeFontElevenSizeMedium      = UIFont(name: "futuramediumcondensedbt", size: 11)
        themeFontTwelveSizeMedium      = UIFont(name: "futuramediumcondensedbt", size: 12)
        themeFontThirteenSizeMedium    = UIFont(name: "futuramediumcondensedbt", size: 13)
        themeFontFourteenSizeMedium    = UIFont(name: "futuramediumcondensedbt", size: 14)
        themeFontFifteenSizeMedium     = UIFont(name: "futuramediumcondensedbt", size: 15)
        themeFontSixteenSizeMedium     = UIFont(name: "futuramediumcondensedbt", size: 16)
        themeFontSeventeenSizeMedium   = UIFont(name: "futuramediumcondensedbt", size: 17)
        themeFontEighteenSizeMedium    = UIFont(name: "futuramediumcondensedbt", size: 18)
        themeFontNineteenSizeMedium    = UIFont(name: "futuramediumcondensedbt", size: 19)
        themeFontTwentySizeMedium      = UIFont(name: "futuramediumcondensedbt", size: 20)
        themeFontTwentyOneSizeMedium   = UIFont(name: "futuramediumcondensedbt", size: 21)
        themeFontTwentyTwoSizeMedium   = UIFont(name: "futuramediumcondensedbt", size: 22)
        themeFontTwentyThreeSizeMedium = UIFont(name: "futuramediumcondensedbt", size: 23)
        themeFontTwentyFourSizeMedium  = UIFont(name: "futuramediumcondensedbt", size: 24)
        themeFontTwentyFiveSizeMedium  = UIFont(name: "futuramediumcondensedbt", size: 25)
        themeFontTwentySixSizeMedium   = UIFont(name: "futuramediumcondensedbt", size: 26)
        themeFontTwentySevenSizeMedium = UIFont(name: "futuramediumcondensedbt", size: 27)
        themeFontTwentyEightSizeMedium = UIFont(name: "futuramediumcondensedbt", size: 28)
        themeFontTwentyNineSizeMedium  = UIFont(name: "futuramediumcondensedbt", size: 29)
        themeFontThirtySizeMedium      = UIFont(name: "futuramediumcondensedbt", size: 30)
        themeFontThirtyOneSizeMedium   = UIFont(name: "futuramediumcondensedbt", size: 31)
        themeFontThirtyTwoSizeMedium   = UIFont(name: "futuramediumcondensedbt", size: 32)
        themeFontThirtyThreeSizeMedium = UIFont(name: "futuramediumcondensedbt", size: 33)
        themeFontThirtyFourSizeMedium  = UIFont(name: "futuramediumcondensedbt", size: 34)
        themeFontThirtyFiveSizeMedium  = UIFont(name: "futuramediumcondensedbt", size: 35)
        themeFontThirtySixSizeMedium   = UIFont(name: "futuramediumcondensedbt", size: 36)
        themeFontThirtySevenSizeMedium = UIFont(name: "futuramediumcondensedbt", size: 37)
        themeFontThirtyEightSizeMedium = UIFont(name: "futuramediumcondensedbt", size: 38)
        themeFontThirtyNineSizeMedium  = UIFont(name: "futuramediumcondensedbt", size: 39)
        themeFontFourtySizeMedium      = UIFont(name: "futuramediumcondensedbt", size: 40)
        themeFontFourtyOneSizeMedium   = UIFont(name: "futuramediumcondensedbt", size: 41)
        themeFontFourtyTwoSizeMedium   = UIFont(name: "futuramediumcondensedbt", size: 42)
        themeFontFourtyThreeSizeMedium = UIFont(name: "futuramediumcondensedbt", size: 43)
        themeFontFourtyFourSizeMedium  = UIFont(name: "futuramediumcondensedbt", size: 44)
        themeFontFourtyFiveSizeMedium  = UIFont(name: "futuramediumcondensedbt", size: 45)
        themeFontFourtySixSizeMedium   = UIFont(name: "futuramediumcondensedbt", size: 46)
        themeFontFourtySevenSizeMedium = UIFont(name: "futuramediumcondensedbt", size: 47)
        themeFontFourtyEightSizeMedium = UIFont(name: "futuramediumcondensedbt", size: 48)
        
        //MARK:- ========================= THEME BOLD FONTS SETTING ================//
        themeFontFourSizeBold        = UIFont(name: "Montserrat-Bold", size: 4)
        themeFontFiveSizeBold        = UIFont(name: "Montserrat-Bold", size: 5)
        themeFontSixSizeBold         = UIFont(name: "Montserrat-Bold", size: 6)
        themeFontSevenSizeBold       = UIFont(name: "Montserrat-Bold", size: 7)
        themeFontEightSizeBold       = UIFont(name: "Montserrat-Bold", size: 8)
        themeFontNineSizeBold        = UIFont(name: "Montserrat-Bold", size: 9)
        themeFontTenSizeBold         = UIFont(name: "Montserrat-Bold", size: 10)
        themeFontElevenSizeBold      = UIFont(name: "Montserrat-Bold", size: 11)
        themeFontTwelveSizeBold      = UIFont(name: "Montserrat-Bold", size: 12)
        themeFontThirteenSizeBold    = UIFont(name: "Montserrat-Bold", size: 13)
        themeFontFourteenSizeBold    = UIFont(name: "Montserrat-Bold", size: 14)
        themeFontFifteenSizeBold     = UIFont(name: "Montserrat-Bold", size: 15)
        themeFontSixteenSizeBold     = UIFont(name: "Montserrat-Bold", size: 16)
        themeFontSeventeenSizeBold   = UIFont(name: "Montserrat-Bold", size: 17)
        themeFontEighteenSizeBold    = UIFont(name: "Montserrat-Bold", size: 18)
        themeFontNineteenSizeBold    = UIFont(name: "Montserrat-Bold", size: 19)
        themeFontTwentySizeBold      = UIFont(name: "Montserrat-Bold", size: 20)
        themeFontTwentyOneSizeBold   = UIFont(name: "Montserrat-Bold", size: 21)
        themeFontTwentyTwoSizeBold   = UIFont(name: "Montserrat-Bold", size: 22)
        themeFontTwentyThreeSizeBold = UIFont(name: "Montserrat-Bold", size: 23)
        themeFontTwentyFourSizeBold  = UIFont(name: "Montserrat-Bold", size: 24)
        themeFontTwentyFiveSizeBold  = UIFont(name: "Montserrat-Bold", size: 25)
        themeFontTwentySixSizeBold   = UIFont(name: "Montserrat-Bold", size: 26)
        themeFontTwentySevenSizeBold = UIFont(name: "Montserrat-Bold", size: 27)
        themeFontTwentyEightSizeBold = UIFont(name: "Montserrat-Bold", size: 28)
        themeFontTwentyNineSizeBold  = UIFont(name: "Montserrat-Bold", size: 29)
        themeFontThirtySizeBold      = UIFont(name: "Montserrat-Bold", size: 30)
        themeFontThirtyOneSizeBold   = UIFont(name: "Montserrat-Bold", size: 31)
        themeFontThirtyTwoSizeBold   = UIFont(name: "Montserrat-Bold", size: 32)
        themeFontThirtyThreeSizeBold = UIFont(name: "Montserrat-Bold", size: 33)
        themeFontThirtyFourSizeBold  = UIFont(name: "Montserrat-Bold", size: 34)
        themeFontThirtyFiveSizeBold  = UIFont(name: "Montserrat-Bold", size: 35)
        themeFontThirtySixSizeBold   = UIFont(name: "Montserrat-Bold", size: 36)
        themeFontThirtySevenSizeBold = UIFont(name: "Montserrat-Bold", size: 37)
        themeFontThirtyEightSizeBold = UIFont(name: "Montserrat-Bold", size: 38)
        themeFontThirtyNineSizeBold  = UIFont(name: "Montserrat-Bold", size: 39)
        themeFontFourtySizeBold      = UIFont(name: "Montserrat-Bold", size: 40)
        themeFontFourtyOneSizeBold   = UIFont(name: "Montserrat-Bold", size: 41)
        themeFontFourtyTwoSizeBold   = UIFont(name: "Montserrat-Bold", size: 42)
        themeFontFourtyThreeSizeBold = UIFont(name: "Montserrat-Bold", size: 43)
        themeFontFourtyFourSizeBold  = UIFont(name: "Montserrat-Bold", size: 44)
        themeFontFourtyFiveSizeBold  = UIFont(name: "Montserrat-Bold", size: 45)
        themeFontFourtySixSizeBold   = UIFont(name: "Montserrat-Bold", size: 46)
        themeFontFourtySevenSizeBold = UIFont(name: "Montserrat-Bold", size: 47)
        themeFontFourtyEightSizeBold = UIFont(name: "Montserrat-Bold", size: 48)
        
        //MARK:- ========================= THEME ITALIC FONTS SETTING ================//
        //
        
        //MARK:- ========================= ALERT VIEW SETTINGS ================//
        alertViewTitleFont             = UIFont(name: "Montserrat-Bold", size: 18)
        alertViewMessageFont           = UIFont(name: "Montserrat-Regular", size: 14)
        alertViewButtonTitleFont       = UIFont(name: "Montserrat-Bold", size: 16)
        alertViewCancelButtonTitleFont = UIFont(name: "Montserrat-Bold", size: 16)
        
        alertViewTitleColor                 = UIColor(rgb: 0x0092DD)
        alertViewContentColor               = UIColor(rgb: 0x455469)
        alertViewLeftButtonFontColor        = UIColor(rgb: 0xFFFFFF)
        alertViewBackGroundColor            = UIColor(rgb: 0xFFFFFF)
        alertViewLeftButtonBackgroundColor  = UIColor(rgb: 0x0253DD)
        alertViewRightButtonBackgroundColor = UIColor(rgb: 0x0092DD)
        
        //MARK:- ========================= OTHER CUSTOM METHODS ================//
        super.init()
    }
}


