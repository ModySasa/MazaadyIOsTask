//
//  TagResponse.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/12/25.
//


struct TagResponse: Codable {
    let tags: [Tag]?
}

struct Tag: Codable {
    let id: Int?
    let name: String?
}
