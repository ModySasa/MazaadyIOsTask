//
//  TagsInteractor.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/12/25.
//

import MSConnectionLib

actor TagsInteractorNetworkManager: TagsInteractorMethod , BaseUrlProviding {
    private let networkManager = NetworkManager()
    
    func getTags() async -> Result<TagResponse, MultipleDecodingErrors> {
        await networkManager.get(
            from: getUrl(url),
            lang: getLang(),
            parameters: networkManager.optionalBody,
            responseType: TagResponse.self,
            token: nil
        )
    }
}
