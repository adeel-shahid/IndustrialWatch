//
//  Product.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 05/04/2024.
//

import Foundation
struct Product:Codable{
    var name : String
    var inspection_angles : String?
    var product_number : String
    var materials : [Formula]?
}
