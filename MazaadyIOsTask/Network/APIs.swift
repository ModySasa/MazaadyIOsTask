//
//  APIs.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/11/25.
//

import MSConnectionLib

extension APIs {
    enum AppAPIs : String {
        case tags = "tags"
        case user = "user"
        case advertisements = "advertisements"
        case products = "products"
        
        func url() -> String {
            return "interview-tasks" + "/" + self.rawValue
        }
    }
}
