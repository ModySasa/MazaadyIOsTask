//
//  UserInteractor.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/12/25.
//

import MSConnectionLib

actor UserInteractorNetworkManager: UserInteractorMethod , BaseUrlProviding {
    private let networkManager = NetworkManager()
    
    func getUser() async -> Result<UserProfile, MultipleDecodingErrors> {
        await networkManager.get(
            from: getUrl(url),
            lang: getLang(),
            parameters: networkManager.optionalBody,
            responseType: UserProfile.self,
            token: nil
        )
    }
}
