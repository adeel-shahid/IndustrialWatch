//
//  RuleViewModel.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/02/2024.
//

import Foundation
struct RuleViewModel{
    
    
    
    public func getRules() -> [Rule]{
        var rules : [Rule] = []
        let api = APIWrapper()
        var response = api.getMethodCall(controllerName: "Section", actionName: "GetAllRule")
        if response.ResponseCode == 200 {
            if let data = response.ResponseData{
                rules = try! JSONDecoder().decode([Rule].self, from: data)
            }
        }
        return rules
    }
}
