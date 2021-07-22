/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A struct for accessing generic password keychain items.
*/

import Foundation

struct KeychainItem {
    // MARK: Types
    
    enum KeychainError: Error {
        case noPassword
        case unexpectedPasswordData
        case unexpectedItemData
        case unhandledError
    }
    
    // MARK: Properties
    
    let service: String
    
    private(set) var account: String
    
    let accessGroup: String?
    
    // MARK: Intialization
    
    init(service: String, account: String, accessGroup: String? = nil) {
        self.service = service
        self.account = account
        self.accessGroup = accessGroup
    }
    
    // MARK: Keychain access
    
    func readItem() throws -> String {
        /*
         Build a query to find the item that matches the service, account and
         access group.
         */
        var query = KeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue
        
        // Try to fetch the existing keychain item that matches the query.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        // Check the return status and throw an error if appropriate.
        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
        guard status == noErr else { throw KeychainError.unhandledError }
        
        // Parse the password string from the query result.
        guard let existingItem = queryResult as? [String: AnyObject],
            let passwordData = existingItem[kSecValueData as String] as? Data,
            let password = String(data: passwordData, encoding: String.Encoding.utf8)
            else {
                throw KeychainError.unexpectedPasswordData
        }
        
        return password
    }
    
    func saveItem(_ password: String) throws {
        // Encode the password into an Data object.
        let encodedPassword = password.data(using: String.Encoding.utf8)!
        
        do {
            // Check for an existing item in the keychain.
            try _ = readItem()
            
            // Update the existing item with the new password.
            var attributesToUpdate = [String: AnyObject]()
            attributesToUpdate[kSecValueData as String] = encodedPassword as AnyObject?
            
            let query = KeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
            
            // Throw an error if an unexpected status was returned.
            guard status == noErr else { throw KeychainError.unhandledError }
        } catch KeychainError.noPassword {
            /*
             No password was found in the keychain. Create a dictionary to save
             as a new keychain item.
             */
            var newItem = KeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
            newItem[kSecValueData as String] = encodedPassword as AnyObject?
            
            // Add a the new item to the keychain.
            let status = SecItemAdd(newItem as CFDictionary, nil)
            
            // Throw an error if an unexpected status was returned.
            guard status == noErr else { throw KeychainError.unhandledError }
        }
    }
    
    func deleteItem() throws {
        // Delete the existing item from the keychain.
        let query = KeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
        let status = SecItemDelete(query as CFDictionary)
        
        // Throw an error if an unexpected status was returned.
        guard status == noErr || status == errSecItemNotFound else { throw KeychainError.unhandledError }
    }
    
    // MARK: Convenience
    
    private static func keychainQuery(withService service: String, account: String? = nil, accessGroup: String? = nil) -> [String: AnyObject] {
        var query = [String: AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service as AnyObject?
        
        if let account = account {
            query[kSecAttrAccount as String] = account as AnyObject?
        }
        
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        }
        
        return query
    }
    
    /*
     For the purpose of this demo app, the user identifier will be stored in the device keychain.
     You should store the user identifier in your account management system.
     */
    static var currentUserIdentifier: String {
        do {
            let storedIdentifier = try KeychainItem(service: "com.moneylife.rticentre", account: "userIdentifier").readItem()
            return storedIdentifier
        } catch {
            return ""
        }
    }
    
    static func deleteUserIdentifierFromKeychain() {
        do {
            try KeychainItem(service: "com.moneylife.rticentre", account: "userIdentifier").deleteItem()
        } catch {
            print("Unable to delete userIdentifier from keychain")
        }
    }
    
//    static func save(key: String, data: Data) -> OSStatus {
//        let query = [
//            kSecClass as String       : kSecClassGenericPassword as String,
//            kSecAttrAccount as String : key,
//            kSecValueData as String   : data ] as [String : Any]
//
//        SecItemDelete(query as CFDictionary)
//
//        return SecItemAdd(query as CFDictionary, nil)
//    }
//
//    static func load(key: String) -> Data? {
//        let query = [
//            kSecClass as String       : kSecClassGenericPassword,
//            kSecAttrAccount as String : key,
//            kSecReturnData as String  : kCFBooleanTrue!,
//            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
//
//        var dataTypeRef: AnyObject? = nil
//
//        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
//
//        if status == noErr {
//            return dataTypeRef as! Data?
//        } else {
//            return nil
//        }
//    }
    
    static func updatePassword(_ password: String, serviceKey: String) {
        guard let dataFromString = password.data(using: .utf8) else { return }

        let keychainQuery: [CFString : Any] = [kSecClass: kSecClassGenericPassword,
                                               kSecAttrService: serviceKey,
                                               kSecValueData: dataFromString]
        SecItemDelete(keychainQuery as CFDictionary)
        SecItemAdd(keychainQuery as CFDictionary, nil)
      }

      static func removePassword(serviceKey: String) {

        let keychainQuery: [CFString : Any] = [kSecClass: kSecClassGenericPassword,
                                               kSecAttrService: serviceKey]

        SecItemDelete(keychainQuery as CFDictionary)
      }

      static func loadPassword(serviceKey: String) -> String? {
        let keychainQuery: [CFString : Any] = [kSecClass : kSecClassGenericPassword,
                                               kSecAttrService : serviceKey,
                                               kSecReturnData: kCFBooleanTrue as Any,
                                               kSecMatchLimitOne: kSecMatchLimitOne]

        var dataTypeRef: AnyObject?
        SecItemCopyMatching(keychainQuery as CFDictionary, &dataTypeRef)
        guard let retrievedData = dataTypeRef as? Data else { return nil }

        return String(data: retrievedData, encoding: .utf8)
      }
}

//extension Data {
//
//    init<T>(from value: T) {
//        var value = value
//        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
//    }
//
//    func to<T>(type: T.Type) -> T {
//        return self.withUnsafeBytes { $0.pointee }
//    }
//}


//extension Data {
//
////    init<T>(value: T) {
////        self = withUnsafePointer(to: value) { (ptr: UnsafePointer<T>) -> Data in
////            return Data(buffer: UnsafeBufferPointer(start: ptr, count: 1))
////        }
////    }
////
////    mutating func append<T>(value: T) {
////        withUnsafePointer(to: value) { (ptr: UnsafePointer<T>) in
////            append(UnsafeBufferPointer(start: ptr, count: 1))
////        }
////    }
//
//    init<T>(from value: T) {
//        var value = value
//        var myData = Data()
//        withUnsafePointer(to:&value, { (ptr: UnsafePointer<T>) -> Void in
//            myData = Data( buffer: UnsafeBufferPointer(start: ptr, count: 1))
//        })
//        self.init(myData)
//    }
//
//    func to<T>(type: T.Type) -> T? where T: ExpressibleByIntegerLiteral {
//            var value: T = 0
//            guard count >= MemoryLayout.size(ofValue: value) else { return nil }
//            _ = Swift.withUnsafeMutableBytes(of: &value, { copyBytes(to: $0)} )
//            return value
//        }
//}
//
//extension Data {
//
//    init<T>(from value: T) {
//        var value = value
//        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
//    }
//
//    func to<T>(type: T.Type) -> T {
//        return self.withUnsafeBytes { $0.load(as: T.self) }
//    }
//}
