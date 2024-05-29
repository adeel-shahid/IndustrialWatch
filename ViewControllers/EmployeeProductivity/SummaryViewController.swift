//
//  SummaryViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/05/2024.
//

import UIKit

class SummaryViewController: UIViewController {
    
    @IBOutlet weak var lblEmployeeName: UILabel!
    @IBOutlet weak var lblViolations: UILabel!
    @IBOutlet weak var lblTotalFine: UILabel!
    @IBOutlet weak var lblTotalAttendance: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var violationContainer: UIView!
    @IBOutlet weak var fineContainer: UIView!
    @IBOutlet weak var attendanceContainer: UIView!
    @IBOutlet weak var circularView: CircularProgressView!
    var employeeName = ""
    var employeeId = 0
    var summary = EmployeeSummary(total_fine: 0.0, violation_count: 0, attendance_rate: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        lblEmployeeName.text = employeeName
        setData()
        fineContainer.layer.cornerRadius = 10
        fineContainer.layer.shadowColor = UIColor.black.cgColor
        fineContainer.layer.shadowOpacity = 0.5
        fineContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        fineContainer.layer.shadowRadius = 4
        violationContainer.layer.cornerRadius = 10
        violationContainer.layer.shadowColor = UIColor.black.cgColor
        violationContainer.layer.shadowOpacity = 0.5
        violationContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        violationContainer.layer.shadowRadius = 4
        attendanceContainer.layer.cornerRadius = 10
        attendanceContainer.layer.shadowColor = UIColor.black.cgColor
        attendanceContainer.layer.shadowOpacity = 0.5
        attendanceContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        attendanceContainer.layer.shadowRadius = 4
    }
    
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        setData()
        
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
    
    private func setData(){
        
        let date = formateTime(self.datePicker)
        summary = EmployeeViewModel().getEmployeeSummary(employeeId: self.employeeId, date: date)
        lblTotalAttendance.text = summary.attendance_rate
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
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
