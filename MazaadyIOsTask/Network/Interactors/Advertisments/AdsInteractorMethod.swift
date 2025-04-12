//
//  AdsInteractor.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/12/25.
//

import MSConnectionLib

protocol AdsInteractorMethod {
    func getAds() async -> Result<AdvertisementResponse, MultipleDecodingErrors>
}

extension AdsInteractorMethod {
    var url: String { APIs.AppAPIs.advertisements.url() }
}
