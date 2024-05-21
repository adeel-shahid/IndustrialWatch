//
//  Employee.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 14/05/2024.
//

import Foundation
struct Employee:Codable{
    var employee_id : Int
    var name : String
    var section_name : String
    var productivity : Float
    var image : String
}


//'employee_id': employee[0],
//'name': employee[1],
//'section_name': employee[2],
//'productivity': employee[3],
//'image': image_urls[0]


struct EmployeeDetail:Codable{
    var total_fine : Float
    var productivity : Float
    var total_attendance : String
}
