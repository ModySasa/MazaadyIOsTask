//
//  UserInteractor.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/12/25.
//

import MSConnectionLib

protocol UserInteractorMethod{
    func getUser() async -> Result<UserProfile, MultipleDecodingErrors>
}

extension UserInteractorMethod {
    var url: String { APIs.AppAPIs.user.url() }
}
