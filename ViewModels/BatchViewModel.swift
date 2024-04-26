//
//  BatchViewModel.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 25/03/2024.
//

import Foundation
struct BatchViewModel{
    
    func getAllBatchesOf(productNumber : String)->[BatchStatus]{
        var batches = [BatchStatus]()
        var product_number = productNumber
        let api = APIWrapper()
        // Encoding the string according to api format
        if productNumber.contains("#"){
            let originalString = productNumber
            if let encodedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                product_number = encodedString
            }
            let response : APIMessage = api.getMethodCall(controllerName: "Production", actionName: "GetAllBatches?product_number=\(product_number)")
            if response.ResponseCode == 200{
                if let data = response.ResponseData{
                    batches = try! JSONDecoder().decode([BatchStatus].self,from: data)
                }
            }
        }
        return batches
    }
        
    func getBatcheDetailOf(batchNumber: String)->BatchStatus{
        var batches = BatchStatus(batch_number: "", status: 0)
        let api = APIWrapper()
        var batch_number = batchNumber
        // Encoding the string according to api format
        if batchNumber.contains("#"){
            let originalString = batchNumber
            if let encodedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                batch_number = encodedString
            }
            let response : APIMessage = api.getMethodCall(controllerName: "Production", actionName: "GetBatchDetails?batch_number=\(batch_number)")
            if response.ResponseCode == 200{
                if let data = response.ResponseData{
                    batches = try! JSONDecoder().decode(BatchStatus.self,from: data)
                }
            }
            
        }
        return batches
    }
        func createBatches(navigationStock: NavigationStock)->APIMessage{
            let api = APIWrapper()
            let json = try! JSONEncoder().encode(navigationStock)
            let response = api.postMethodCall(controllerName: "Production", actionName: "AddBatch", httpBody: json)
            return response
        }
        
    
}
