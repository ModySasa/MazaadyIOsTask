//
//  Product.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/12/25.
//


struct Product: Codable {
    let id: Int?
    let name: String?
    let image: String?
    let price: Double?
    let currency: String?
    let offer: Double?
    let endDate: Double?

    enum CodingKeys: String, CodingKey {
        case id, name, image, price, currency, offer
        case endDate = "end_date"
    }
}

extension Product {
    var countdownComponents: (days: Int, hours: Int, minutes: Int)? {
        guard let endDate = endDate else { return nil }
        let totalSeconds = Int(endDate)

        let days = totalSeconds / 86400
        let hours = (totalSeconds % 86400) / 3600
        let minutes = (totalSeconds % 3600) / 60

        return (days, hours, minutes)
    }
}

struct ProductSearchRequest : Codable {
    let name : String?
}
