//
//  RawMaterialDetails.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 05/04/2024.
//

import Foundation
struct RawMaterialDetails:Codable{
    var stock_number : String
    var price_per_kg : Int
    var purchased_date : String
    var quantity : Int
}
