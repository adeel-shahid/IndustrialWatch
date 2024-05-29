//
//  RulesAddorEditTableViewCell.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/02/2024.
//

import UIKit
import Toast_Swift
class RulesAddorEditTableViewCell: UITableViewCell {

    @IBOutlet weak var containerTime: UIView!
    @IBOutlet weak var txtTime: UILabel!
    @IBOutlet weak var lblRuleName: UILabel!
    @IBOutlet weak var btnCheckBoxOutlet: UIButton!
    @IBOutlet weak var txtFine: UITexfield_Additions!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var rules = [Rule]()
    var checked = [Int]()
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        txtFine.layer.cornerRadius = 10
        containerTime.layer.cornerRadius = 10
        rules = RuleViewModel().getRules()
        
    }
    
    @IBAction func btnCheckBox(_ sender: UIButton) {
        
    }
    
    
}


extension UIViewController {
    func topMostViewController() -> UIViewController {
        if let presentedViewController = presentedViewController {
            return presentedViewController.topMostViewController()
        }
        if let navigationController = self as? UINavigationController {
            return navigationController.visibleViewController?.topMostViewController() ?? navigationController
        }
        if let tabBarController = self as? UITabBarController {
            return tabBarController.selectedViewController?.topMostViewController() ?? tabBarController
        }
        return self
    }
}


//let timeString = txtTime.text!
//
//// Create a date formatter instance
//let dateFormatter = DateFormatter()
//dateFormatter.dateFormat = "mm:ss" // Specify the format of the time string
//
//// Set the time zone to avoid issues with time parsing
//dateFormatter.timeZone = TimeZone(identifier: "UTC")
//
//// Convert the time string to a Date object
//if let timeDate = dateFormatter.date(from: timeString) {
//    // Since we are only interested in the time component, we don't need to print the complete Date object
//    let calendar = Calendar.current
//    let components = calendar.dateComponents([.hour, .minute, .second], from: timeDate)
//    if let hour = components.hour, let minute = components.minute, let second = components.second {
//        print("\(hour):\(minute):\(second)") // Output: 10:30:00
//    }
//} else {
//    print("Error: Invalid time string")
//}
