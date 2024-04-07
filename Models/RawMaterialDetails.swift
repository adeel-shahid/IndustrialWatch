//
//  RawMaterialDetails.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 05/04/2024.
//

import Foundation
struct RawMaterialDetails:Decodable{
    var price_per_unit : String
    var purchased_date : String
    var quantity : Int
}
