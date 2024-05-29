//
//  EditEmployeeViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/05/2024.
//

import UIKit
import Toast_Swift
class EditEmployeeViewController: UIViewController {

    @IBOutlet weak var txtPassword: UITexfield_Additions!
    @IBOutlet weak var txtUserName: UITexfield_Additions!
    @IBOutlet weak var txtName: UITexfield_Additions!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var profileContainer: UIView!
    var profile = EmployeeProfileDetail(name: "", job_type: "", job_role: "", section: "", username: "", password: "", image: "")
    var predicate : ((_ employee: EmployeeProfileDetail) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        profileContainer.layer.cornerRadius = profileContainer.frame.size.width / 2
        profileContainer.clipsToBounds = true
        profileContainer.layer.borderWidth = 1
        profileContainer.layer.borderColor = UIColor.black.cgColor
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.image = UIImage(named: "Person")
        txtName.layer.cornerRadius = 10
        txtUserName.layer.cornerRadius = 10
        txtPassword.layer.cornerRadius = 10
        txtName.text = profile.name
        txtUserName.text = profile.username
        txtPassword.text = profile.password
        let obj = UserDefaults.standard
        let employeeId = obj.integer(forKey: "employeeId")
        let url = APIWrapper().getImageURL(imagePath: profile.image, employeeId: employeeId)
        imageView.kf.setImage(with: url)
    }
    

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnUpdate(_ sender: Any) {
        guard let name = txtName.text, !txtName.text!.isEmpty,
              let username = txtUserName.text, !txtUserName.text!.isEmpty,
              let password = txtPassword.text, !txtPassword.text!.isEmpty
                else
        {
            view.makeToast("Fill the Text Field", duration: 2.0, position: .bottom)
            return
        }
        profile.name = name
        profile.username = username
        profile.password = password
        let response = EmployeeViewModel().updateEmployeeProfile(profile: profile)
        if response.ResponseCode == 200 {
            predicate?(profile)
            self.dismiss(animated: true)
        }
    }
}
