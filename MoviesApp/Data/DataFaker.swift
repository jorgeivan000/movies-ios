//
//  DataFaker.swift
//  MoviesApp
//
//  Created by jorgehc on 7/23/18.
//  Copyright © 2018 jorgehc.com. All rights reserved.
//
import Foundation

public protocol DataProvider { }

/// 1st validation
class SessionFaker: DataProvider {
    
    /** Intended to validate if a session has already started
    and is active. No login is required.
    */ 
    func hasSessionLocally() -> Bool {
        return true
    }
    
}

/// 2nd validation
class ValidSessionFaker: DataProvider {
    
    /** Intended to validate if user has already completed
     all onboarding steps, otherwise we are contemplating
     user must start again the onboarding process.
     */
    func hasCompletedOnboarding() -> Bool {
        return true
    }

}

/// 3rd validation
class UserFaker: DataProvider {
    /** Intended to validate if user has valid balance
     and valid payment method registered
     */
    func userHasSomeValidBalance() -> Bool {
        return true
    }
    
    /** Intended to validate if user must add contacts in order
     to access home view.
     */
    func userHasAccessContacts() -> Bool {
        return true
    }
}
