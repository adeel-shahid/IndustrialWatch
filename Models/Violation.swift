//
//  Violation.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 19/05/2024.
//

import Foundation
struct Violation:Codable{
    var employee_id : Int?
    var allowed_time : String
    var end_time : String
    var start_time : String
    var section_id : Int
    var section_name : String
    var fine : Float?
    var violation_id : Int
    var date : String
    var rule_name : String
    var images : [ImagePath]
}

struct ImagePath:Codable{
    var capture_time : String?
    var image_url : String?
}
