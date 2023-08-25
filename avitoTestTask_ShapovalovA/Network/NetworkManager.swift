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

    // Fetching the list of products
    func fetchProducts(completion: @escaping ([Product]?, Error?) -> Void) {
        let url = URL(string: "https://www.avito.st/s/interns-ios/main-page.json")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "Data Error", code: -1, userInfo: nil))
                return
            }

            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(products, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }

    // Fetching the details for a specific product
    func fetchProductDetail(for id: String, completion: @escaping (ProductDetail?, Error?) -> Void) {
        let url = URL(string: "https://www.avito.st/s/interns-ios/details/\(id).json")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "Data Error", code: -1, userInfo: nil))
                return
            }

            do {
                let productDetail = try JSONDecoder().decode(ProductDetail.self, from: data)
                completion(productDetail, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
