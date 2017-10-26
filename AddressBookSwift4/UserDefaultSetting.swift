//
//  UserDefaultSetting.swift
//  AddressBookSwift4
//
//  Created by Idris Adrien on 26/10/2017.
//  Copyright © 2017 Idris Adrien. All rights reserved.
//

import UIKit

enum UserDefaultsKeys : String {
    case isFirstLaunch = "isFirstLaunch"
}
extension UserDefaults{
    
    func isFirstLaunch () -> Bool{
        return (UserDefaults.standard.value(forKey: "isFirstLaunch") as? Bool) ?? true
    }
    
    func userSawWelcomeMessage() {
        UserDefaults.standard.set(false, forKey: "isFirstLaunch")
    }

}
