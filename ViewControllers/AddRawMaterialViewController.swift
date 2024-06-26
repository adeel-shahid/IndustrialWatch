//
//  AddRawMaterialViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 04/04/2024.
//

import UIKit
import Toast_Swift
class AddRawMaterialViewController: UIViewController {

    @IBOutlet weak var txtName: UITexfield_Additions!
    @IBOutlet weak var container: UIView!
    var rawMterial = RawMaterials(id: 0, name: "")
    
    var predicate : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.layer.cornerRadius = 15
        container.layer.cornerRadius = 20
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func btnAdd(_ sender: Any) {
        
        guard let name = txtName.text, !txtName.text!.isEmpty else {
            view.makeToast("Fill The Name Text Field!", duration: 2.0, position: .bottom)
            return
        }
        
        self.rawMterial.name = name
        
        let response = RawMaterialViewModel().insertRawMaterial(rawMaterial: rawMterial)
        if response.ResponseCode == 200{
            predicate?()
            self.dismiss(animated: true)
        }else{
            view.makeToast("\(response.ResponseMessage)", duration: 2.0, position: .bottom)
        }
        
    }
    
}
