//
//  ViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 26/11/2023.
//

import UIKit

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
        if txtUsername.text == "adeel"
            && txtPassword.text == "123"{
            let controller = storyboard?.instantiateViewController(withIdentifier: "AdminDashboardViewController")
            controller?.modalPresentationStyle = .fullScreen
            self.present(controller!, animated: true)
        }else{
            let alert = UIAlertController(title: "Alert", message: "Invalid Username or password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    
    //Custom eye visibility on and off
    
    
//    var iconsClick = false
//    let imageicon = UIImageView()
    //        imageicon.image = UIImage(named: "eyeclose")
    //        let contentView = UIView()
    //        contentView.addSubview(imageicon)
    //        contentView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
    //        imageicon.frame = CGRect(x: -10, y: 0, width: 20, height: 20)
    //        txtPassword.rightView = contentView
    //        txtPassword.rightViewMode = .always
    //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(Gesture:)))
    //        imageicon.isUserInteractionEnabled = true
    //        imageicon.addGestureRecognizer(tapGesture)
    
    
    //    @objc func imageTapped(Gesture:UITapGestureRecognizer){
    //        let tappedImage = Gesture.view as! UIImageView
    //        if iconsClick{
    //            iconsClick = false
    //            tappedImage.image = UIImage(named: "eyeopen")
    //            txtPassword.isSecureTextEntry = false
    //        }else{
    //            iconsClick = true
    //            tappedImage.image = UIImage(named: "eyeclose")
    //            txtPassword.isSecureTextEntry = true
    //        }
    //    }
}
