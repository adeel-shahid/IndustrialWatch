//
//  Violation.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 19/05/2024.
//

import Foundation
struct Violation:Codable{
    var violation_id : Int
    var date : String
    var time : String
    var rule_name : String
    var images : [String]
}
