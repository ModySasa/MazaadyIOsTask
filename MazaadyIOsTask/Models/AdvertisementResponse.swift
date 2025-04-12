//
//  AdvertisementResponse.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/12/25.
//


struct AdvertisementResponse: Codable {
    let advertisements: [Advertisement]?
}

struct Advertisement: Codable {
    let id: Int?
    let image: String?
}
