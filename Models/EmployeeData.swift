//
//  EmployeeData.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 25/06/2024.
//

import Foundation
struct EmployeeData: Codable {
    let employee_name: String
    let rules: [ViolatedRules]
}

struct ViolatedRules: Codable {
    let rule_name: String
    let total_time: Int
}
