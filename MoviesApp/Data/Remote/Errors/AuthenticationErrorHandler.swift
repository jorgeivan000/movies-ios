//
//  AuthenticationErrorHandler.swift
//  MoviesApp
//
//  Created by jorgehc on 12/14/18.
//  Copyright © 2018 jorgehc.com. All rights reserved.
//

import Foundation

class AuthenticationErrorHandler: HorrorHandler {
    func horrorHandler(code: Int) -> String? {
        if code == 401 {
            return String.unauthorizedCodeMessage
        }
        if code == 403 {
            return String.bannedCodeMessage
        }
        return nil
    }
}
