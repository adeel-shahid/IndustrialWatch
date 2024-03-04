//
//  TextFieldWithPadding.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 20/02/2024.
//
import UIKit
import Foundation
class UITexfield_Additions: UITextField {
    
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
