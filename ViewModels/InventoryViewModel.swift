//
//  InventoryViewModel.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 05/04/2024.
//

import Foundation
struct InventoryViewModel{
    
    func getAllInventory()->[Inventory]{
        var inventory = [Inventory]()
        let api = APIWrapper()
        let response = api.getMethodCall(controllerName: "Production", actionName: "GetAllInventory")
        if response.ResponseCode == 200{
            if let data = response.ResponseData{
                inventory = try! JSONDecoder().decode([Inventory].self, from: data)
            }
        }
        return inventory
    }
    
    func getRawMaterialDetails(id: Int)->[RawMaterialDetails]{
        var material = [RawMaterialDetails]()
        let api = APIWrapper()
        let response = api.getMethodCall(controllerName: "Production", actionName: "GetStockDetailOfRawMaterial?id=\(id)")
        if response.ResponseCode == 200{
            if let data = response.ResponseData{
                material = try! JSONDecoder().decode([RawMaterialDetails].self, from: data)
            }
        }
        return material
    }
    
    func insertNewStock(stock: Stock)->APIMessage{
        let json = try! JSONEncoder().encode(stock)
        let api = APIWrapper()
        let response = api.postMethodCall(controllerName: "Production", actionName: "AddStock", httpBody: json)
        return response
    }
    
}
