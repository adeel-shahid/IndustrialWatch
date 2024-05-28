//
//  AllowedTimeViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 26/05/2024.
//

import UIKit
import Toast_Swift
class AllowedTimeViewController: UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var txtMinutes: UITexfield_Additions!
    @IBOutlet weak var txtHours: UITexfield_Additions!
    override func viewDidLoad() {
        super.viewDidLoad()
        container.layer.cornerRadius = 15
    }
    var predicate : ((_ time: String)->Void)?
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnOk(_ sender: Any) {
        if txtHours.text == nil && txtMinutes == nil{
            view.makeToast("Please Fill at least One Text Field", duration: 2.0 , position: .bottom)
            return
        }
        var hours = "00"
        var minutes = "00"
        if txtHours.text == nil || txtHours.text!.isEmpty{
            minutes = txtMinutes.text!
        }else if txtMinutes.text == nil || txtMinutes.text!.isEmpty{
            hours = txtHours.text!
        }else{
            hours = txtHours.text!
            minutes = txtMinutes.text!
        }
        let timestring = "\(hours):\(minutes):00"
        predicate?(timestring)
        self.dismiss(animated: true)
    }
}
