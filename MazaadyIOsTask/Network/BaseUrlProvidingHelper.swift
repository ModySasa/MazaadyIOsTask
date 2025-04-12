//
//  BaseUrlProvidingHelper.swift
//  Samoolah
//
//  Created by Moha on 9/30/24.
//

import L10n_swift
import MSConnectionLib

extension BaseUrlProviding{
    func getLang() -> String {
        L10n.shared.language
    }
    func getToken() -> String {
        URLPrefHelper.shared.getToken() ?? ""
    }
}
