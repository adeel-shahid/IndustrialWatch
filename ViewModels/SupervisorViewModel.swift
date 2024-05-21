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
        let api = APIWrapper()
        let response = api.getMethodCall(controllerName: "Employee", actionName: "GetAllSupervisors")
        if response.ResponseCode == 200 {
            if let data = response.ResponseData{
                supervisors = try! JSONDecoder().decode([Supervisor].self, from: data)
            }
        }
        return supervisors
    }
    
    func deleteSupervisor(id: Int)->APIMessage{
        let api = APIWrapper()
        let response = api.deleteMethodCall(controllerName: "Supervisor", actionName: "delete_supervisor/\(id)")
        return response
    }
    
    func getSupervisorById(id : Int)->SupervisorDetail{
        let api = APIWrapper()
        let response = api.getMethodCall(controllerName: "Employee", actionName: "GetSupervisorDetail?supervisor_id=\(id)")
        var supervisor = SupervisorDetail(username: "", password: "", sections: [])
        if response.ResponseCode == 200{
            if let data = response.ResponseData{
                let list : [SupervisorDetail] = try! JSONDecoder().decode([SupervisorDetail].self, from: data)
                supervisor = list[0]
            }
        }
        return supervisor
    }
    
    func updateSupervisor(supervisor: SupervisorDetail)->APIMessage{
        let api = APIWrapper()
        let jsonData = try! JSONEncoder().encode(supervisor)
        let response = api.putMethodCall(controllerName: "Employee", actionName: "UpdateSupervisor", httpBody: jsonData)
        return response
    }
    
    func insertSupervisor(supervisor: Supervisor)->APIMessage{
        let api = APIWrapper()
        let json = try! JSONEncoder().encode(supervisor)
        let response = api.postMethodCall(controllerName: "Supervisor", actionName: "insert_supervisor", httpBody: json)
        return response
    }
    
}
