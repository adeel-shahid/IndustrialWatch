//
//  Supervisor.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 23/02/2024.
//

import Foundation
struct Supervisor:Codable{
    var id: Int
    var name : String
    var username : String
    var password : String
    var role : String
    var sections : [Section]
}
