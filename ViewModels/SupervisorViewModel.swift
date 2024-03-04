//
//  SupervisorViewModel.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 23/02/2024.
//

import Foundation
struct SupervisorViewModel{
    
    func getSupervisors()->[Supervisor]{
        var supervisors = [Supervisor]()
        var s = Supervisor(name: "Muhammad Anees", username: "anees123")
        supervisors.append(s)
        s = Supervisor(name: "Usama Fayyaz", username: "usama")
        supervisors.append(s)
        return supervisors
    }
    
}
