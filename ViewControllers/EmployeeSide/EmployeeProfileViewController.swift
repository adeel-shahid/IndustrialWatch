//
//  EmployeeProfileViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/05/2024.
//

import UIKit

class EmployeeProfileViewController: UIViewController {

    
    @IBOutlet weak var lblJobType: UILabel!
    @IBOutlet weak var lblSection: UILabel!
    @IBOutlet weak var lblJobRole: UILabel!
    @IBOutlet weak var lblEmployeeUsername: UILabel!
    @IBOutlet weak var lblEmployeeName: UILabel!
    @IBOutlet weak var UICustomLogOut: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var profileContainer: UIView!
    var profile = EmployeeProfileDetail(name: "", job_type: "", job_role: "", section: "", username: "", password: "", image: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        profileContainer.layer.cornerRadius = profileContainer.frame.size.width / 2
        profileContainer.clipsToBounds = true
        profileContainer.layer.borderWidth = 1
        profileContainer.layer.borderColor = UIColor.black.cgColor
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.image = UIImage(named: "Person")
        UICustomLogOut.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnLogout(_ :))))
        let obj = UserDefaults.standard
        let employeeId = obj.integer(forKey: "employeeId")
        profile = EmployeeViewModel().getEmployeeProfileDetail(employeeId: employeeId)
        setData(employee: profile)
    }
    @objc func btnLogout(_ sender: Any){
        self.dismiss(animated: true)
    }
    
    @IBAction func btnEdit(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "EditEmployeeViewController") as! EditEmployeeViewController
        controller.profile = self.profile
        controller.predicate = { [unowned self]
            employee in
            self.profile = employee
            setData(employee: profile)
        }
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    private func setData(employee: EmployeeProfileDetail){
        lblEmployeeName.text = employee.name
        lblEmployeeUsername.text = employee.username
        lblSection.text = employee.section
        lblJobRole.text = employee.job_role
        lblJobType.text = employee.job_type
        let obj = UserDefaults.standard
        let employeeId = obj.integer(forKey: "employeeId")
        self.profile.id = employeeId
        let url = APIWrapper().getImageURL(imagePath: employee.image, employeeId: employeeId)
        self.imageView.kf.setImage(with: url)
    }
}
