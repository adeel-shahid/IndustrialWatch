//
//  SectionViewModel.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 01/04/2024.
//

import Foundation
struct SectionViewModel{
    
    func getAllSections(withStatus: Int) -> [Section]{
        var sections = [Section]()
        let api = APIWrapper()
        let response : APIMessage = api.getMethodCall(controllerName: "Section", actionName: "GetAllSections?status=\(withStatus)")
        if response.ResponseCode == 200{
            if let data = response.ResponseData{
                sections = try! JSONDecoder().decode([Section].self, from: data)
            }
        }
        else{
            print(response.ResponseMessage)
        }
        return sections
    }
    
    func getSectionByID(id: Int)->Section{
        let api = APIWrapper()
        var section : Section = Section(id: 0, name: "", status: 0)
        let response = api.getMethodCall(controllerName: "Section", actionName: "GetSectionDetail?section_id=\(id)")
        if response.ResponseCode == 200{
            if let data = response.ResponseData{
                section = try! JSONDecoder().decode(Section.self, from: data)
            }
        }
        else{
            print(response.ResponseMessage)
        }
        return section
    }
    
    func insertSectionWithRules(section: Section)->APIMessage{
        let jsonData = try! JSONEncoder().encode(section)
        let api = APIWrapper()
        let response = api.postMethodCall(controllerName: "Section", actionName: "InsertSection", httpBody: jsonData)
        return response
    }
    
    func changeSectionStatus(withId: Int)->APIMessage{
        let api = APIWrapper()
        let response = api.getMethodCall(controllerName: "Section", actionName: "ChangeSectionAcitivityStatus?section_id=\(withId)")
        return response
    }
    
    func update(section: Section)->APIMessage{
        let json = try! JSONEncoder().encode(section)
        let api = APIWrapper()
        let response = api.putMethodCall(controllerName: "Section", actionName: "UpdateSection", httpBody: json)
        return response
    }
    
    func getAllSectionNames(withStatus: Int)->[String]{
        var sections = [Section]()
        var sectionNames = [String]()
        let api = APIWrapper()
        let response : APIMessage = api.getMethodCall(controllerName: "Section", actionName: "GetAllSections?status=\(withStatus)")
        if response.ResponseCode == 200{
            if let data = response.ResponseData{
                sections = try! JSONDecoder().decode([Section].self, from: data)
            }
        }
        else{
            print(response.ResponseMessage)
        }
        for section in sections {
            sectionNames.append(section.name)
        }
        return sectionNames
    }
    
}
