//
//  AdminDashboardViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/02/2024.
//

import UIKit

class AdminDashboardViewController: UIViewController {

    @IBOutlet weak var btnSection: UIView!
    @IBOutlet weak var btnProduction: UIView!
    @IBOutlet weak var btnEmployeeProductivity: UIView!
    @IBOutlet weak var btnSupervisors: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        optimizeUI()
    }
    @IBAction func btnLogout(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
    }
    
    
    private func optimizeUI(){
        btnSection.layer.cornerRadius = 20
        btnProduction.layer.cornerRadius = 20
        btnSupervisors.layer.cornerRadius = 20
        btnEmployeeProductivity.layer.cornerRadius = 20
        var gesture = UITapGestureRecognizer(target: self, action: #selector(navigateToSectionView))
        btnSection.addGestureRecognizer(gesture)
        gesture = UITapGestureRecognizer(target: self, action: #selector(navigateToSupervisorView))
        btnSupervisors.addGestureRecognizer(gesture)
        gesture = UITapGestureRecognizer(target: self, action: #selector(navigateToEmployeeProductivityView))
        btnEmployeeProductivity.addGestureRecognizer(gesture)
        gesture = UITapGestureRecognizer(target: self, action: #selector(navigateToProductionView))
        btnProduction.addGestureRecognizer(gesture)
    }
    
    @objc private func navigateToSectionView(){
        let controller = storyboard?.instantiateViewController(withIdentifier: "SectionViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
    }
    
    @objc private func navigateToSupervisorView(){
        let controller = storyboard?.instantiateViewController(withIdentifier: "SupervisorViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
    }
    
    @objc private func navigateToEmployeeProductivityView(){
        let controller = storyboard?.instantiateViewController(withIdentifier: "EmployeeProductivityViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
    }
    
    @objc private func navigateToProductionView(){
        let controller = storyboard?.instantiateViewController(withIdentifier: "ProductionViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
    }
    
}
