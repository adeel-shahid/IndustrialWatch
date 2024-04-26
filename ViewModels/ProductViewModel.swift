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
        var product = Product(name: "", product_number: productNumber)
        
        // Encoding the string according to api format
        if productNumber.contains("#"){
            let originalString = productNumber
            if let encodedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                print("Encoded String:", encodedString)
                product.product_number = encodedString
            }
        }
        
        var productFormula = [ProductFormula]()
        let api = APIWrapper()
        let response = api.getMethodCall(controllerName: "Production", actionName: "GetFormulaOfProduct?product_number=\(product.product_number)")
        if response.ResponseCode == 200{
            if let data = response.ResponseData {
                print(data)
                productFormula = try! JSONDecoder().decode([ProductFormula].self, from: data)
            }
        }
        
        return productFormula
    }
    
}
