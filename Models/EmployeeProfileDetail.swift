//
//  EmployeeProfileDetail.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 28/05/2024.
//

import Foundation
struct EmployeeProfileDetail:Codable{
    var id : Int?
    var name : String
    var job_type : String
    var job_role : String
    var section : String
    var username : String
    var password : String
    var image : String
}


//{
//                    'name': employee_details[0],
//                    'job_type': employee_details[1],
//                    'job_role': employee_details[2],
//                    'section': employee_details[3],
//                    'username': employee_details[4],
//                    'password': employee_details[5],
//                    'image': employee_details[6],
//                }
