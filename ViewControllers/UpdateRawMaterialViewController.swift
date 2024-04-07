//
//  UpdateRawMaterialViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 04/04/2024.
//

import UIKit
import Toast_Swift
class UpdateRawMaterialViewController: UIViewController {
    @IBOutlet weak var txtName: UITexfield_Additions!
    @IBOutlet weak var container: UIView!
    
    var predicate : (() -> Void)?
    
    var rawMaterial = RawMaterials(id: 0, name: "Not Found")
    override func viewDidLoad() {
        super.viewDidLoad()
        container.layer.cornerRadius = 20
        txtName.layer.cornerRadius = 15
        txtName.text = rawMaterial.name
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnUpdate(_ sender: Any) {
        
        guard let name = txtName.text, !txtName.text!.isEmpty else{
            view.makeToast("Fill The Name Text Field!", duration: 2.0, position: .bottom)
            return
        }
        self.rawMaterial.name = name
        let response = RawMaterialViewModel().updateRawMaterial(rawMaterial: rawMaterial)
        if response.ResponseCode == 200{
            predicate?()
            self.dismiss(animated: true)
        }else{
            view.makeToast("\(response.ResponseMessage)", duration: 2.0, position: .bottom)
        }
    }
}
