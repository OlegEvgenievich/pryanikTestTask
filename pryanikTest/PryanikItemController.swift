//
//  PryanikItemController.swift
//  pryanikTest
//
//  Created by Олег Бабыр on 06.06.2021.
//

import Foundation
import UIKit

class PryanikItemController {
    static let shared = PryanikItemController()
    
    func findPryanikItem(withName name: String, inPryanikData pryanikData: [PryanikData]) -> PryanikItem? {
        
        var pryanikItem: PryanikItem? {
            for item in pryanikData {
                if item.name == name {
                    return item.data
                }
            }
            return nil
        }
        
        return pryanikItem
    }
    
    func fetchPryanik(completion: @escaping (Result<Pryanik, Error>) -> Void) {

        let url = URL(string: "https://pryaniky.com/static/json/sample.json")!
        
        let jsonDecoder = JSONDecoder()

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
        
            if let data = data, let decodedData = try? jsonDecoder.decode(Pryanik.self, from: data) {
                completion(.success(decodedData))
        }
    }
        task.resume()
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
}
