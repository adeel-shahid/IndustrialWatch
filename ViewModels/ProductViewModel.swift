//
//  ProductViewModel.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 05/04/2024.
//

import Foundation
struct ProductViewModel{
    
    func insertProduct(product: Product)->APIMessage{
        let json = try! JSONEncoder().encode(product)
        let api = APIWrapper()
        let response = api.postMethodCall(controllerName: "Production", actionName: "AddProduct", httpBody: json)
        return response
    }
    
}
