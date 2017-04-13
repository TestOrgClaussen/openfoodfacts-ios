//
//  ProductDataSource.swift
//  OpenFoodFacts
//
//  Created by Andrés Pizá Bückmann on 12/04/2017.
//  Copyright © 2017 Andrés Pizá Bückmann. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ProductDataSource {
    
    let endpoint = "https://ssl-api.openfoodfacts.org"
    
    func getProducts(byName name: String, page: Int, completion: @escaping (ProductsResponse) -> Void) {
        
        print("Getting products for: \(name)")
        let url = endpoint + "/cgi/search.pl?search_terms=\(encodeStringAsParameter(name))&search_simple=1&action=process&json=1&page=\(page)"
        
        print("URL: \(url)")
        
        Alamofire.request(url).responseObject { (response: DataResponse<ProductsResponse>) in
            
            switch response.result {
            case .success(let productResponse):
                print("Got \(productResponse.count ?? 0) products ")
                completion(productResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    fileprivate func encodeStringAsParameter(_ string: String) -> String {
        return string.replacingOccurrences(of: " ", with: "+").lowercased()
    }
}
