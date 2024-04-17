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
        let api = APIWrapper()
        let response : APIMessage = api.getMethodCall(controllerName: "Production", actionName: "GetAllBatches?product_number=\(productNumber)")
        if response.ResponseCode == 200{
            if let data = response.ResponseData{
                batches = try! JSONDecoder().decode([BatchStatus].self,from: data)
            }
        }
        return batches
    }
    
    func getBatcheDetailOf(batchNumber: String)->BatchStatus{
        var batches = BatchStatus(batch_number: "", status: 0)
        let api = APIWrapper()
        let response : APIMessage = api.getMethodCall(controllerName: "Production", actionName: "GetBatchDetails?batch_number=\(batchNumber)")
        if response.ResponseCode == 200{
            if let data = response.ResponseData{
                batches = try! JSONDecoder().decode(BatchStatus.self,from: data)
            }
        }
        return batches
    }
    
}
