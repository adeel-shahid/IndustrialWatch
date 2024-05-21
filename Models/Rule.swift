//
//  Rule.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/02/2024.
//

import Foundation
struct Rule:Codable{
    var id : Int
    var name : String
    var allowed_time : String?
    var fine : Int?
    var status : String?
}
