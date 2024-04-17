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
    
    func getLinkedProducts()->[Product]{
        var products = [Product]()
        let api = APIWrapper()
        let response = api.getMethodCall(controllerName: "Production", actionName: "GetLinkedProducts")
        if let data = response.ResponseData{
            products = try! JSONDecoder().decode([Product].self, from: data)
        }
        return products
    }
    
    func getUnLinkedProducts()->[Product]{
        var products = [Product]()
        let api = APIWrapper()
        let response = api.getMethodCall(controllerName: "Production", actionName: "GetUnlinkedProducts")
        if let data = response.ResponseData{
            products = try! JSONDecoder().decode([Product].self, from: data)
        }
        return products
    }
    
    func linkProduct(linkProduct: LinkProduct)->APIMessage{
        let api = APIWrapper()
        let json = try! JSONEncoder().encode(linkProduct)
        let response = api.postMethodCall(controllerName: "Production", actionName: "LinkProduct", httpBody: json)
        return response
    }
 
    
    func getProductFormulaOf(productNumber: String)->[ProductFormula]{
        var productFormula = [ProductFormula]()
        let api = APIWrapper()
        let response = api.getMethodCall(controllerName: "Production", actionName: "GetFormulaOfProduct?product_number=\(productNumber)")
        if response.ResponseCode == 200{
            if let data = response.ResponseData {
                productFormula = try! JSONDecoder().decode([ProductFormula].self, from: data)
            }
        }
        return productFormula
    }
    
}
