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
    var id : Int = 0
    var supervisor = Supervisor(id: 0, name: "", username: "", password: "", role: "", sections: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        supervisor = SupervisorViewModel().getSupervisorById(id: id)
        container.layer.cornerRadius = 15
        lblName.text = supervisor.name
        txtUsername.text = supervisor.username
        txtPassword.text = supervisor.password
        txtUsername.layer.cornerRadius = 15
        txtPassword.layer.cornerRadius = 15
    }
    
    var predicate : (() -> Void)?
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true,completion: nil)
    }
    
    @IBAction func btnUpdate(_ sender: Any) {
        guard let username = txtUsername.text,let password = txtPassword.text, !txtUsername.text!.isEmpty,!txtPassword.text!.isEmpty else {
                print("Username is nil or empty.")
                return
            }
        supervisor.username = username
        supervisor.password = password
        let response = SupervisorViewModel().updateSupervisor(supervisor: supervisor)
        if response.ResponseCode == 200{
            
            //Swift tost Notification
            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
               let topViewController = window.rootViewController?.topMostViewController() {
                topViewController.view.makeToast("Supervisor SeccuessFully Updated", duration: 3.0, position: .bottom)
                
                predicate?()
                self.dismiss(animated: true)
                
            }
        }else{
            let alert = UIAlertController(title: "Error", message: response.ResponseMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive))
            self.present(alert, animated: true)
        }
    }
    
}
