//
//  EmployeeSummaryViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/05/2024.
//

import UIKit

class EmployeeSummaryViewController: UIViewController {

    @IBOutlet weak var lblViolations: UILabel!
    @IBOutlet weak var lblTotalFine: UILabel!
    @IBOutlet weak var lblAttendanceRate: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var attendanceContainer: UIView!
    @IBOutlet weak var ViolationContainer: UIView!
    @IBOutlet weak var totalFineContainer: UIView!
    @IBOutlet weak var circularView: CircularProgressView!
    var summary = EmployeeSummary(total_fine: 0.0, violation_count: 0, attendance_rate: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        totalFineContainer.layer.cornerRadius = 10
        totalFineContainer.layer.shadowColor = UIColor.black.cgColor
        totalFineContainer.layer.shadowOpacity = 0.5
        totalFineContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        totalFineContainer.layer.shadowRadius = 4
        ViolationContainer.layer.cornerRadius = 10
        ViolationContainer.layer.shadowColor = UIColor.black.cgColor
        ViolationContainer.layer.shadowOpacity = 0.5
        ViolationContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        ViolationContainer.layer.shadowRadius = 4
        attendanceContainer.layer.cornerRadius = 10
        attendanceContainer.layer.shadowColor = UIColor.black.cgColor
        attendanceContainer.layer.shadowOpacity = 0.5
        attendanceContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        attendanceContainer.layer.shadowRadius = 4
    }
    private func formateTime(_ sender: UIDatePicker) -> String{
        let selectedDate = sender.date
                
                // Extract the year and month components from the selected date
                let calendar = Calendar.current
                let components = calendar.dateComponents([.year, .month], from: selectedDate)
                
                // Ensure the components are non-nil
                guard let year = components.year, let month = components.month else {
                    // Return a default value in case of nil components (shouldn't happen)
                    return ""
                }
                let date = "\(month),\(year)"
                print("Selected date - \(date)")
                return date
    }
    
    @IBAction func datePickerValueChange(_ sender: Any) {
        setData()
    }
    private func setData(){
        
        let date = formateTime(self.datePicker)
        let obj = UserDefaults.standard
        let employeeId = obj.integer(forKey: "employeeId")
        summary = EmployeeViewModel().getEmployeeSummary(employeeId: employeeId, date: date)
        lblAttendanceRate.text = summary.attendance_rate
        lblTotalFine.text = "\(summary.total_fine)"
        lblViolations.text = "\(summary.violation_count)"
        if self.summary.attendance_rate == ""{
            return
        }
        circularView.setProgressColor = UIColor.green
        circularView.setTrackColor = UIColor.gray
        let atdarr = summary.attendance_rate.split(separator: "/")
        print(atdarr)
        if let presents = Float(atdarr[0]),
        let total = Float(atdarr[1])
        {
            circularView.setProgressWithAnimation(duration: 2.0, value: (presents / total))
        }else{
            circularView.setProgressWithAnimation(duration: 2.0, value: 0)
        }
    }
}
