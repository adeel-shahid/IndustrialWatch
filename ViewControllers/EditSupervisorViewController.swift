//
//  EditSupervisorViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 23/02/2024.
//

import UIKit

class EditSupervisorViewController: UIViewController {

    @IBOutlet weak var txtPassword: UITexfield_Additions!
    @IBOutlet weak var txtUsername: UITexfield_Additions!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var lblName: UILabel!
    var name : String = "Not Found"
    override func viewDidLoad() {
        super.viewDidLoad()
        container.layer.cornerRadius = 15
        lblName.text = name
        txtUsername.layer.cornerRadius = 15
        txtPassword.layer.cornerRadius = 15
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true,completion: nil)
    }
    
    @IBAction func btnUpdate(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
