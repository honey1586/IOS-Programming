//
//  AreaModels.swift
//  IOSProject
//
//  Created by KPUGAME on 2021/05/22.
//

import Foundation

struct Result: Codable {
    let data: [ResultItem]
}

struct ResultItem: Codable {
    let title : String
    let items : [String]
}
