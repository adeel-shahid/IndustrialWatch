//
//  Section.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 01/04/2024.
//

import Foundation
struct Section:Codable{
    var id : Int
    var name : String
    var rules : [Rule]
}
