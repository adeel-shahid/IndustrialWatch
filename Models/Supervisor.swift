//
//  Supervisor.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 23/02/2024.
//

import Foundation
struct Supervisor:Codable{
    var employee_id : Int
    var employee_name : String
    var sections : [String]
}

struct SupervisorDetail : Codable{
    var employee_id : Int?
    var name : String?
    var username : String
    var password : String
    var sections : [Section]
    var sections_id : [Int]?
}
