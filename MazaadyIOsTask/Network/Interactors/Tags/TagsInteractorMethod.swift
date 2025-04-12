//
//  TagsInteractor.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/12/25.
//

import MSConnectionLib

protocol TagsInteractorMethod {
    func getTags() async -> Result<TagResponse, MultipleDecodingErrors>
}

extension TagsInteractorMethod {
    var url: String { APIs.AppAPIs.tags.url() }
}
