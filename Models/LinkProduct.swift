//
//  LinkProduct.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 16/04/2024.
//

import Foundation
struct LinkProduct:Codable{
    var product_number : String
    var packs_per_batch : Int
    var piece_per_pack : Int
    var rejection_tolerance : Float
}

//{
//    "product_number":"Gla#16042024125726",
//    "packs_per_batch":24,
//    "piece_per_pack":12,
//    "rejection_tolerance":2
//}
