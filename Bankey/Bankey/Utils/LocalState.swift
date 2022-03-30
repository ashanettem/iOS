//
//  LocalState.swift
//  Bankey
//
//  Created by PandaH on 3/28/22.
//

import Foundation

//A class used to remember whether or not we have onboarded
public class LocalState{
    
    //enum called keys of type string
    private enum Keys:String{
        case hasOnboarded
    }
    
    //define a variable on localstate called hasOnboarded which takes a boolean
    public static var hasOnboarded:Bool{
        get{
            //access user defaults standards, looking for boolean, rawValue is the string representation of an enum
            return UserDefaults.standard.bool(forKey: Keys.hasOnboarded.rawValue)
        }
        set(newValue){
            //pass in a new boolean value, and it will write to disk
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnboarded.rawValue)
            //synchronize to avoid race condition, multiple parts of the app may try to write to user defaults at the same time 
            UserDefaults.standard.synchronize()
        }
    }
    
    
}
