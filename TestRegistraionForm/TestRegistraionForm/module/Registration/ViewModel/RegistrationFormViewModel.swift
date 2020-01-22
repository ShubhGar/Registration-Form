//
//  RegistrationFormViewModel.swift
//  TestRegistraionForm
//
//  Created by Shubham Garg on 22/01/20.
//  Copyright © 2020 Shubham Garg. All rights reserved.
//

import Foundation


class RegistrationFormViewModel{
    
    
    func checkValid(name: String)-> Bool{
        let numbers = CharacterSet.decimalDigits
        if name.isEmpty {
            return false
        }
        guard name.rangeOfCharacter(from: numbers) != nil else {
            return true
        }
        return false
    }
    
    func checkValid(country: String)->Bool{
        guard country.isEmpty else{
            return true
        }
        return false
    }
    
    func checkValid(date:String)->Bool{
        guard date.isEmpty else{
            return true
        }
        return false
    }
    
    func checkValid(email:String)->Bool{
        let regex = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: email)
    }
    
    func submitDetail(name: String,country: String, date:String, email:String){
        print("submitted")
    }
}
