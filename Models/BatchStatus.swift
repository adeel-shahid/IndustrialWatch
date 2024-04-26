//
//  BatchStatus.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 16/04/2024.
//

import Foundation
struct BatchStatus:Codable{
    var batch_number : String
    var batch_yield : Float?
    var date : String?
    var defected_piece : Int?
    var rejection_tolerance : Float?
    var total_piece: Int?
    var status : Int
}


//{
//    "batch_number": "B002",
//    "batch_yield": 0.92,
//    "date": "04/02/24",
//    "defected_piece": 2,
//    "rejection_tolerance": 0.07,
//    "status": 1,
//    "total_piece": Int
//}
