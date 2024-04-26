//
//  StaticList.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 17/04/2024.
//

import Foundation
struct NavigationStock:Encodable{
    var batch_per_day : Int
    var product_number : String
    var stock_list : [Stocks]
}

struct Stocks:Encodable{
    var stocks : [String]
}

class StaticItems{
    static var staticStockList = [NavigationStock]()
    static var product = Product(name: "Not Found", product_number: "")
}

