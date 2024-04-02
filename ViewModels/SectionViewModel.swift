//
//  SectionViewModel.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 01/04/2024.
//

import Foundation
struct SectionViewModel{
    
    func getAllSections()->[Section]{
        var sections = [Section]()
        let api = APIWrapper()
        let response : APIMessage = api.getMethodCall(controllerName: "Section", actionName: "get_all_sections")
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
        var section : Section = Section(id: 0, name: "", rules: [])
        let response = api.getMethodCall(controllerName: "Section", actionName: "get_section_rules/\(id)")
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
    
}
