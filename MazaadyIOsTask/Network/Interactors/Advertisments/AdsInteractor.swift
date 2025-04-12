//
//  ProductsInteractor.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/12/25.
//

import MSConnectionLib

actor AdsInteractorNetworkManager: AdsInteractorMethod , BaseUrlProviding {
    private let networkManager = NetworkManager()
    
    func getAds() async -> Result<AdvertisementResponse, MultipleDecodingErrors> {
        await networkManager.get(
            from: getUrl(url),
            lang: getLang(),
            parameters: networkManager.optionalBody,
            responseType: AdvertisementResponse.self,
            token: nil
        )
    }
}
