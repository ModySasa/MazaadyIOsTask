//
//  ProductsInteractor.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/12/25.
//

import MSConnectionLib

protocol ProductsInteractorMethod {
    func getProducts(_ body : ProductSearchRequest) async -> Result<[Product], MultipleDecodingErrors>
}

extension ProductsInteractorMethod {
    var url: String { APIs.AppAPIs.products.url() }
}
