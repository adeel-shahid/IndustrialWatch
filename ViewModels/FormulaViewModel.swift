//
//  FormulaViewModel.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 04/04/2024.
//

import Foundation
struct FormulaViewModel{
    
    func getAllFormulas()->[Formula]{
        var formulas = [Formula]()
        var f = Formula(raw_material_id: 1, material: "Iron", quantity: 300,unit: "G")
        formulas.append(f)
        f = Formula(raw_material_id: 2, material: "Silver", quantity: 200,unit: "G")
        formulas.append(f)
        f = Formula(raw_material_id: 3, material: "Copper", quantity: 50,unit: "G")
        formulas.append(f)
        return formulas
    }
    
}
