//
//  Strings.swift
//  SamoolahAgent
//
//  Created by Mohamed Safwat on 02/02/2024.
//

import Foundation
import L10n_swift

func strings(key:ProjectStrings, preName:PreProjectStringName = .non) -> String {
    var multiLang = preName.rawValue
    if preName != .non {
        multiLang = "\(preName.rawValue).\(key.rawValue)"
    } else {
        multiLang = key.rawValue
    }
    
    return multiLang.l10n()
}

enum ProjectStrings: String {
    //MARK: texts
    case non = ""
    
    case following = "following"
    case followers = "followers"
    
    
    case home = "home"
    case search = "search"
    case cart = "cart"
    case user = "user"
}

enum PreProjectStringName : String {
    case non = ""
    case pageTitle = "pageTitle"
    case toast = "toast"
    case emptyState = "emptyState"
    case errorMessage = "errorMessage"
    case button = "button"
    case navBar = "navBar"
    case days = "days"
}
