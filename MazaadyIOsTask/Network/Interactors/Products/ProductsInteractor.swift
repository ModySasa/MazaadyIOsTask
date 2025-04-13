//
//  ProductsInteractor.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/12/25.
//

import MSConnectionLib

actor ProductsInteractorNetworkManager: ProductsInteractorMethod , BaseUrlProviding {
    private let networkManager = NetworkManager()
    
    func getProducts(_ body : ProductSearchRequest) async -> Result<[Product], MultipleDecodingErrors> {
        await networkManager.get(
            from: getUrl(url),
            lang: getLang(),
            parameters: body,
            responseType: [Product].self,
            token: nil
        )
    }
}
