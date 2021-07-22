//
//  DataStructures.swift
//  GoToWork
//
//  Created by INNOVATIVE ITERATION on 23/09/20.
//  Copyright © 2020 INNOVATIVE ITERATION. All rights reserved.
//

import Foundation

//MARK:- ******************** MessageStruct ********************
struct MessageStruct: Codable {
    var message: String?
    var code: Int?
    
    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case code = "Code"
    }
}

//MARK:- ******************** LoginStruct ********************

// MARK: - GetScheduleStruct
struct LoginStruct: Codable {
    var message: String?
    var code: Int?
    var data: LoginData?

    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case code = "Code"
        case data = "Data"
    }
}

// MARK: - DataClass
struct LoginData: Codable {
    var user: User?

    enum CodingKeys: String, CodingKey {
        case user = "User"
    }
}

// MARK: - User
struct User: Codable {
    var email, userLoginID, userID, provider: String?
    var createdOn, authToken, name, deviceID: String?
    var userIdentity, updatedOn, deviceToken, deviceType: String?
    var isActive: String?

    enum CodingKeys: String, CodingKey {
        case email = "Email"
        case userLoginID = "UserLoginID"
        case userID = "UserID"
        case provider = "Provider"
        case createdOn = "CreatedOn"
        case authToken = "AuthToken"
        case name = "Name"
        case deviceID = "DeviceID"
        case userIdentity = "UserIdentity"
        case updatedOn = "UpdatedOn"
        case deviceToken = "DeviceToken"
        case deviceType = "DeviceType"
        case isActive = "IsActive"
    }
}
/*
//MARK:- LoginStruct
struct LoginStruct: Codable {
    var status: Int?
    var message: String?
    var data: LoginData?
}

struct LoginData: Codable {
    var id: Int?
    var username, firstName, middleName, lastName, email: String?
    var profileImage: String?
    var dateOfBirth, streetAddress, city, state: String?
    var zipcode: String?
    var qrCode: String?
    var walletAmount: Int?
    var agencyCode: String?
    var countryCode: Int?
    var otpCode : String?
    var countryCodeName, phoneNumber: String?
    var isPhoneVerify, isEmailVerify: Int?
    var createdDate, modifiedDate: String?
    var isDeleted: Int?
    var isBillingSetup: Bool?
    var token: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case firstName = "first_name"
        case middleName = "middle_name"
        case lastName = "last_name"
        case email
        case profileImage = "profile_image"
        case dateOfBirth = "date_of_birth"
        case streetAddress = "street_address"
        case city, state, zipcode
        case qrCode = "qr_code"
        case walletAmount = "wallet_amount"
        case agencyCode = "agency_code"
        case countryCode = "country_code"
        case countryCodeName = "country_code_name"
        case phoneNumber = "phone_number"
        case otpCode = "otp_code"
        case isPhoneVerify = "is_phone_verify"
        case isEmailVerify = "is_email_verify"
        case createdDate = "created_date"
        case modifiedDate = "modified_date"
        case isDeleted = "is_deleted"
        case isBillingSetup = "IS_BILLING_SETUP"
        case token
    }
}
*/

//MARK:- ******************** LogoutStruct ********************

// MARK: - Logoutstruct
struct LogoutStruct: Codable {
    var message: String?
    var code: Int?

    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case code = "Code"
    }
}

//MARK:- ******************** GetDocumentListStruct ********************

// MARK: - GetDocumentListStruct
struct GetDocumentListStruct: Codable {
    var data: [DocumentData]?
    var message: String?
    var code: Int?

    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case message = "Message"
        case code = "Code"
    }
}

struct DocumentData: Codable {
    var voiceID, status, name, readPages: String?
    var documentID, totalPages, languageID: String?

    enum CodingKeys: String, CodingKey {
        case voiceID = "VoiceID"
        case status = "Status"
        case name = "Name"
        case readPages = "ReadPages"
        case documentID = "DocumentID"
        case totalPages = "TotalPages"
        case languageID = "LanguageID"
    }
}

//MARK:- ******************** UploadStruct ********************

// MARK: - UploadStruct
struct UploadStruct: Codable {
    var code: Int?
    var message: String?
    var data: UploadData?

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case message = "Message"
        case data = "Data"
    }
}

struct UploadData: Codable {
    var message: String?

    enum CodingKeys: String, CodingKey {
        case message = "Message"
    }
}

//MARK:- ******************** DeleteDocumentStruct ********************

//MARK:- DeleteDocumentStruct
struct DeleteDocumentStruct: Codable {
    var code: Int?
    var data: DeleteDocumentData?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case data = "Data"
        case message = "Message"
    }
}

struct DeleteDocumentData: Codable {
    var message: String?

    enum CodingKeys: String, CodingKey {
        case message = "Message"
    }
}

//MARK:- ******************** UpdateDocumentNameStruct ********************

//MARK:- UpdateDocumentNameStruct
struct UpdateDocumentNameStruct: Codable {
    var data: UpdateDocumentNameData?
    var message: String?
    var code: Int?

    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case message = "Message"
        case code = "Code"
    }
}

struct UpdateDocumentNameData: Codable {
    var voiceID, documentID, status, name: String?
    var totalPages, languageID, userID: String?

    enum CodingKeys: String, CodingKey {
        case voiceID = "VoiceID"
        case documentID = "DocumentID"
        case status = "Status"
        case name = "Name"
        case totalPages = "TotalPages"
        case languageID = "LanguageID"
        case userID = "UserID"
    }
}

//MARK:- ******************** GetPageHTMLStruct ********************

//MARK:- GetPageHTMLStruct
struct GetPageHTMLStruct: Codable {
    var message: String?
    var code: Int?
    var data: String?

    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case code = "Code"
        case data = "Data"
    }
}

//MARK:- ******************** GetLanguagesStruct ********************

//MARK:- GetLanguagesStruct
struct GetLanguagesStruct: Codable {
    var message: String?
    var data: [GetLanguagesData]?
    var code: Int?

    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case data = "Data"
        case code = "Code"
    }
}

struct GetLanguagesData: Codable {
    var name, localName, languageID: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case localName = "LocalName"
        case languageID = "LanguageID"
    }
}

//MARK:- ******************** GetAllVoicesStruct ********************

//MARK:- GetAllVoicesStruct
struct GetAllVoicesStruct: Codable {
    var code: Int?
    var data: [VoiceData]?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case data = "Data"
        case message = "Message"
    }
}

struct VoiceData: Codable {
    var name, language, voiceID: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case language = "Language"
        case voiceID = "VoiceID"
    }
}

//MARK:- ******************** GetSettingsStruct ********************

// MARK: - GetSettingsStruct
struct GetSettingsStruct: Codable {
    var code: Int?
    var message: String?
    var data: GetSettingsData?

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case message = "Message"
        case data = "Data"
    }
}

struct GetSettingsData: Codable {
    var voiceID, languageID: String?

    enum CodingKeys: String, CodingKey {
        case voiceID = "VoiceID"
        case languageID = "LanguageID"
    }
}

//MARK:- ******************** SetSettingsStruct ********************

// MARK: - SetSettingsStruct
struct SetSettingsStruct: Codable {
    var code: Int?
    var message: String?
    var data: SetSettingsData?

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case message = "Message"
        case data = "Data"
    }
}

// MARK: - DataClass
struct SetSettingsData: Codable {
    var languageID, voiceID: String?

    enum CodingKeys: String, CodingKey {
        case languageID = "LanguageID"
        case voiceID = "VoiceID"
    }
}
