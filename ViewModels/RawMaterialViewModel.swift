//
//  RawMaterialViewModel.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 03/04/2024.
//

import Foundation
struct RawMaterialViewModel{
    
    func getRawMaterials()->[RawMaterials]{
        var rawMaterials = [RawMaterials]()
        let api = APIWrapper()
        let response = api.getMethodCall(controllerName: "Production", actionName: "GetAllRawMaterials")
        if response.ResponseCode == 200 {
            if let data = response.ResponseData{
                rawMaterials = try! JSONDecoder().decode([RawMaterials].self, from: data)
            }
        }else{
            print("\n\(response.ResponseMessage)")
        }
        return rawMaterials
    }
    
    func updateRawMaterial(rawMaterial: RawMaterials)->APIMessage{
        let api = APIWrapper()
        let json = try! JSONEncoder().encode(rawMaterial)
        let response = api.putMethodCall(controllerName: "Production", actionName: "UpdateRawMaterial", httpBody: json)
        return response
    }
    
    func insertRawMaterial(rawMaterial : RawMaterials)-> APIMessage{
        let api = APIWrapper()
        let json = try! JSONEncoder().encode(rawMaterial)
        let response = api.postMethodCall(controllerName: "Production", actionName: "AddRawMaterial?name=\(rawMaterial.name)", httpBody: json)
        return response
    }
    
    func getStockDetailOfRawMaterial(rawMaterialId: Int)->[RawMaterialDetails]{
        var rawMaterials = [RawMaterialDetails]()
        let api = APIWrapper()
        let response = api.getMethodCall(controllerName: "Production", actionName: "GetStockDetailOfRawMaterial?id=\(rawMaterialId)")
        if response.ResponseCode == 200{
            if let data = response.ResponseData{
                rawMaterials = try! JSONDecoder().decode([RawMaterialDetails].self, from: data)
            }
        }
        return rawMaterials
    }
    
}
