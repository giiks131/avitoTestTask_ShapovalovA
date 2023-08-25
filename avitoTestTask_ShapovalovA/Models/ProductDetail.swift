//
//  ProductDetail.swift
//  avitoTestTask_ShapovalovA
//
//  Created by Aleksandr Shapovalov on 25/08/23.
//

import Foundation

struct ProductDetail: Codable {
    let id: String
    let name: String
    let detailedDescription: String
    let imageUrl: String
    let price: Double
}
