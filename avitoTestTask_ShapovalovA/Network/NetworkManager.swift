//
//  NetworkManager.swift
//  avitoTestTask_ShapovalovA
//
//  Created by Aleksandr Shapovalov on 25/08/23.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func fetchProducts(completion: @escaping ([Product]?, Error?) -> Void) {
        let url = URL(string: "https://www.avito.st/s/interns-ios/main-page.json")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle response here
        }.resume()
    }

    func fetchProductDetail(for id: String, completion: @escaping (ProductDetail?, Error?) -> Void) {
        let url = URL(string: "https://www.avito.st/s/interns-ios/details/\(id).json")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle response here
        }.resume()
    }
}
