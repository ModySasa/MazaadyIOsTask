//
//  ProductsInteractor.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/12/25.
//

import MSConnectionLib

actor ProductsInteractorNetworkManager: ProductsInteractorMethod , BaseUrlProviding {
    private let networkManager = NetworkManager()
    
    func getProducts() async -> Result<[Product], MultipleDecodingErrors> {
        await networkManager.get(
            from: getUrl(url),
            lang: getLang(),
            parameters: networkManager.optionalBody,
            responseType: [Product].self,
            token: nil
        )
    }
}
