//
//  EmployeeViewModel.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 14/05/2024.
//

import Foundation
struct EmployeeViewModel{
    
    func getAllEmployees()->[Employee]{
        let api = APIWrapper()
        var employees = [Employee]()
        let response = api.getMethodCall(controllerName: "Employee", actionName: "GetAllEmployees?section_id=-1&ranking_required=0")
        if response.ResponseCode == 200 {
            if let data = response.ResponseData{
                employees = try! JSONDecoder().decode([Employee].self, from: data)
            }
        }
        return employees
    }
    
    func getEmployees(withSection: String)->[Employee]{
        let employees = getAllEmployees()
        var filterResult = [Employee]()
        for employee in employees {
            if employee.section_name == withSection{
                filterResult.append(employee)
            }
        }
        return filterResult
    }
    
    func getEmployees(withSection: String, andEmployeeName: String)->[Employee]{
        let employees = getAllEmployees()
        var filterResult = [Employee]()
        for employee in employees {
            if employee.section_name == withSection && employee.name.range(of: andEmployeeName, options: .caseInsensitive) != nil{
                filterResult.append(employee)
            }
        }
        return filterResult
    }
    
    func getJobRoleNames()->[String]{
        var jobs = [JobRole]()
        let api = APIWrapper()
        let response = api.getMethodCall(controllerName: "Employee", actionName: "GetAllJobRoles")
        if response.ResponseCode == 200{
            if let data = response.ResponseData{
                jobs = try! JSONDecoder().decode([JobRole].self, from: data)
            }
        }
        var jobName = [String]()
        for job in jobs {
            jobName.append(job.name)
        }
        return jobName
    }
    
    func getJobRole()->[JobRole]{
        var jobs = [JobRole]()
        let api = APIWrapper()
        let response = api.getMethodCall(controllerName: "Employee", actionName: "GetAllJobRoles")
        if response.ResponseCode == 200{
            if let data = response.ResponseData{
                jobs = try! JSONDecoder().decode([JobRole].self, from: data)
            }
        }
        return jobs
    }
    
    func getEmployeeDetail(employeeID: Int) -> EmployeeDetail{
        var emp = EmployeeDetail(total_fine: 0.0, productivity: 0.0, total_attendance: "0.0")
        let api = APIWrapper()
        let response = api.getMethodCall(controllerName: "Employee", actionName: "GetEmployeeDetail?employee_id=\(employeeID)")
        if response.ResponseCode == 200{
            if let data = response.ResponseData {
                emp = try! JSONDecoder().decode(EmployeeDetail.self, from: data)
            }
        }
        return emp
    }
    
    func getEmployeeAttendance(employeeID: Int) -> [Attendance]{
        var attendance = [Attendance]()
        let api = APIWrapper()
        let response = api.getMethodCall(controllerName: "Employee", actionName: "GetEmployeeAttendance?employee_id=\(employeeID)")
        if response.ResponseCode == 200{
            if let data = response.ResponseData{
                attendance = try! JSONDecoder().decode([Attendance].self, from: data)
            }
        }
        return attendance
    }
    
    func getEmployeeViolations(employeeId: Int) -> [Violation]{
        var violations = [Violation]()
        let api = APIWrapper()
        let response = api.getMethodCall(controllerName: "Employee", actionName: "GetAllViolations?employee_id=\(employeeId)")
        if response.ResponseCode == 200{
            if let data = response.ResponseData{
                violations = try! JSONDecoder().decode([Violation].self, from: data)
            }
        }
        return violations
    }
    
    func login(username: String, password: String) -> User?{
        do{
            var user = User(id: 0, name: "", user_role: "")
            let api = APIWrapper()
            let response = api.getMethodCall(controllerName: "Employee", actionName: "Login?username=\(username)&password=\(password)")
            if response.ResponseCode == 200{
                if let data = response.ResponseData{
                    user = try JSONDecoder().decode(User.self, from: data)
                }
            }
            return user
        }catch{
            return nil
        }
    }
    
    func getEmployeeProfileDetail(employeeId : Int) -> EmployeeProfileDetail{
        var profile = EmployeeProfileDetail(name: "", job_type: "", job_role: "", section: "", username: "", password: "", image: "")
        let api = APIWrapper()
        let response = api.getMethodCall(controllerName: "Employee", actionName: "GetEmployeeProfile?employee_id=\(employeeId)")
        if response.ResponseCode == 200{
            if let data = response.ResponseData {
                profile = try! JSONDecoder().decode(EmployeeProfileDetail.self, from: data)
            }
        }
        return profile
    }
    
    func updateEmployeeProfile(profile: EmployeeProfileDetail) -> APIMessage{
        let json = try! JSONEncoder().encode(profile)
        let api = APIWrapper()
        let response = api.putMethodCall(controllerName: "Employee", actionName: "UpdateEmployeeProfile", httpBody: json)
        return response
    }
    
    
    func getEmployeeSummary(employeeId: Int, date: String) -> EmployeeSummary{
        let api = APIWrapper()
        var summary = EmployeeSummary(total_fine: 0.0, violation_count: 0, attendance_rate: "0/0")
        let response = api.getMethodCall(controllerName: "Employee", actionName: "GetEmployeeSummary?employee_id=\(employeeId)&date=\(date)")
        if response.ResponseCode == 200 {
            if let data = response.ResponseData{
                summary = try! JSONDecoder().decode(EmployeeSummary.self, from: data)
            }
        }
        return summary
    }
    
}
