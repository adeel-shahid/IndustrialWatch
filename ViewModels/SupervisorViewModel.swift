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
        let response = api.getMethodCall(controllerName: "Supervisor", actionName: "get_all_supervisor")
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
    
    func getSupervisorById(id : Int)->Supervisor{
        let api = APIWrapper()
        let response = api.getMethodCall(controllerName: "Supervisor", actionName: "get_supervisor_by_id/\(id)")
        var supervisor = Supervisor(id: 0, name: "", username: "", password: "", role: "", sections: [])
        if response.ResponseCode == 200{
            if let data = response.ResponseData{
                supervisor = try! JSONDecoder().decode(Supervisor.self, from: data)
            }
        }
        return supervisor
    }
    
    func updateSupervisor(supervisor: Supervisor)->APIMessage{
        let api = APIWrapper()
        let jsonData = try! JSONEncoder().encode(supervisor)
        let response = api.putMethodCall(controllerName: "Supervisor", actionName: "update_supervisor", httpBody: jsonData)
        return response
    }
    
    func insertSupervisor(supervisor: Supervisor)->APIMessage{
        let api = APIWrapper()
        let json = try! JSONEncoder().encode(supervisor)
        let response = api.postMethodCall(controllerName: "Supervisor", actionName: "insert_supervisor", httpBody: json)
        return response
    }
    
}
