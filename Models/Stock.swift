//
//  Stock.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 05/04/2024.
//

import Foundation
struct Stock:Codable{
    var stock_number : String
    var raw_material_id : Int
    var quantity : Int
    var unit : String
    var price_per_unit : Int
    var purchased_date : String
}

//"stock_number":"202401121254",
//    "raw_material_id":1,
//    "quantity":21,
//    "unit":"Kg",
//    "price_per_unit":6300,
//    "purchased_date":"2024-11-23"
