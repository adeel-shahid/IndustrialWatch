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
        var r = Rule(id: 0, name: "Smoking", allowedTime: "05:00", fine: 500)
        rules.append(r)
        r = Rule(id: 1, name: "Mobile Usage", allowedTime: "10:00", fine: 300)
        rules.append(r)
        r = Rule(id: 2, name: "Gossiping", allowedTime: "08:00", fine: 600)
        rules.append(r)
        return rules
    }
}
