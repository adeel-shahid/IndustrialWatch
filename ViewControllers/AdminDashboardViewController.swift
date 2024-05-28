//
//  AdminDashboardViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/02/2024.
//

import UIKit

class AdminDashboardViewController: UIViewController {

    @IBOutlet weak var lblAdminName: UILabel!
    @IBOutlet weak var btnSection: UIView!
    @IBOutlet weak var btnProduction: UIView!
    @IBOutlet weak var btnEmployeeProductivity: UIView!
    @IBOutlet weak var btnSupervisors: UIView!
    var adminName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.isHidden = true
        lblAdminName.text = adminName
        optimizeUI()
    }
    @IBAction func btnLogout(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
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
        gesture = UITapGestureRecognizer(target: self, action: #selector(navigateToProductionMenuView))
        btnProduction.addGestureRecognizer(gesture)
    }
    
    @objc private func navigateToSectionView(){
        Task{
            await asyncNavigationToSectionView()
        }
    }
    
    func asyncNavigationToSectionView() async {
        showActivityIndicator()
        let controller = storyboard?.instantiateViewController(withIdentifier: "SectionViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
        hideActivityIndicator()
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
    
    @objc private func navigateToProductionMenuView(){
        let controller = storyboard?.instantiateViewController(withIdentifier: "ProductionMenuViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
    }
    
    private func showActivityIndicator(){
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator(){
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
}
