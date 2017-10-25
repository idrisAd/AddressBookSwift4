//
//  Person.swift
//  AddressBookSwift4
//
//  Created by Idris Adrien on 25/10/2017.
//  Copyright © 2017 Idris Adrien. All rights reserved.
//

import Foundation




class Person{
    var firstName : String
    var lastName : String
    
    init(firstName: String, lastName: String){
        self.firstName = firstName
        self.lastName = lastName
    }
    
}

extension Person : Equatable {

    public static func ==(lhs: Person, rhs: Person) -> Bool{
        return (lhs.firstName == rhs.firstName) && (lhs.lastName == rhs.lastName)
    }

}
