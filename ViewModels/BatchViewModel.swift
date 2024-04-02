//
//  BatchViewModel.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 25/03/2024.
//

import Foundation
struct BatchViewModel{
    
    func getAllBatches()->[Batch]{
        var batches = [Batch]()
        let api = APIWrapper()
        let response : APIMessage = api.getMethodCall(controllerName: "Product", actionName: "get_all_batches")
        if response.ResponseCode == 200{
            if let data = response.ResponseData{
                batches = try! JSONDecoder().decode([Batch].self,from: data)
            }
        }
        return batches
    }
    
}
