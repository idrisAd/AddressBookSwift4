//
//  Person.swift
//  AddressBookSwift4
//
//  Created by Idris Adrien on 25/10/2017.
//  Copyright © 2017 Idris Adrien. All rights reserved.
//

import Foundation

extension Person {
    
    var firstLetter: String {
        
        if let first = lastName?.characters.first {
            return String(first)
        } else {
            return "?"
        }
    }
    
    
    
}
