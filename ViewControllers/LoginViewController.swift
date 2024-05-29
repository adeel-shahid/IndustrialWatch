//
//  ViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 26/11/2023.
//

import UIKit
import Toast_Swift
class LoginViewController: UIViewController {
    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUsername.layer.cornerRadius = 15
        txtPassword.layer.cornerRadius = 15

    }

    @IBAction func btnEyeAction(_ sender: Any) {
        if btnEye.isSelected{
            btnEye.isSelected = false
            txtPassword.isSecureTextEntry = true
        }else{
            btnEye.isSelected = true
            txtPassword.isSecureTextEntry = false
        }
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        authenticateUser()
    }
    
    private func authenticateUser(){
        if let username = txtUsername.text, !txtUsername.text!.isEmpty,
           let password = txtPassword.text, !txtPassword.text!.isEmpty
        {
            let responseUser = EmployeeViewModel().login(username: username, password: password)
            if responseUser != nil{
                if responseUser?.user_role == "Admin"{
                    self.txtUsername.text = ""
                    self.txtPassword.text = ""
                    let controller = storyboard?.instantiateViewController(withIdentifier: "AdminDashboardViewController") as! AdminDashboardViewController
                    controller.modalPresentationStyle = .fullScreen
                    controller.adminName = responseUser!.name
                    self.present(controller, animated: true)
                }else if responseUser?.user_role == "Supervisor"{
                    self.txtUsername.text = ""
                    self.txtPassword.text = ""
                    let controller = storyboard?.instantiateViewController(withIdentifier: "SupervisorDashBoardViewController") as! SupervisorDashBoardViewController
                    controller.supervisorName = responseUser!.name
                    controller.supervisorId = responseUser!.id
                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller, animated: true)
                }else if responseUser?.user_role == "Employee"{
                    self.txtUsername.text = ""
                    self.txtPassword.text = ""
                    let controller = storyboard?.instantiateViewController(withIdentifier: "EmployeeDashboard")
                    let objUserDefault = UserDefaults.standard
                    objUserDefault.set(responseUser!.name, forKey: "username")
                    objUserDefault.set(responseUser!.id, forKey: "employeeId")
                    controller?.modalPresentationStyle = .fullScreen
                    self.present(controller!, animated: true)
                }else{
                    self.view.makeToast("Invalid Crediential Please Try Again", duration: 3.0, position: .bottom)
                }
            }else{
                self.view.makeToast("Invalid Crediential Please Try Again", duration: 3.0, position: .bottom)
            }
        }
    }
    
}
