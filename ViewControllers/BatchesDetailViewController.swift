//
//  BatchesDetailViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 15/04/2024.
//

import UIKit

class BatchesDetailViewController: UIViewController {

    @IBOutlet weak var UICustomButtonDownload: UIView!
    @IBOutlet weak var lblBatchNumber: UILabel!
    @IBOutlet weak var lblTotalYield: UILabel!
    @IBOutlet weak var lblRejectionTolerance: UILabel!
    @IBOutlet weak var lblDefectedPieces: UILabel!
    @IBOutlet weak var lblTotalPieces: UILabel!
    @IBOutlet weak var lblDated: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var statusContainer: UIView!
    var batchNumber : String = "Not Found"
    var productNumber : String = "Not Found"
    var batchStatus : BatchStatus = BatchStatus(batch_number: "Not Found", status: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        statusContainer.layer.cornerRadius = 20
        UICustomButtonDownload.layer.cornerRadius = 15
        lblBatchNumber.text = "\(batchNumber)"
        UICustomButtonDownload.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnDownloadImages(_ :))))
        batchStatus = BatchViewModel().getBatcheDetailOf(batchNumber: batchNumber)
        if batchStatus.status == 1 && batchStatus.batch_number != ""{
            lblStatus.text = "Rejected"
            lblStatus.textColor = UIColor.white
            statusContainer.backgroundColor = UIColor.red
            lblDated.text = batchStatus.date
            lblTotalPieces.text = "\(batchStatus.total_piece!)"
            lblDefectedPieces.text = "\(batchStatus.defected_piece!)"
            lblRejectionTolerance.text = "\(batchStatus.rejection_tolerance!) %"
            lblTotalYield.text = "\(batchStatus.batch_yield!) %"
        }else if batchStatus.status == 0 && batchStatus.batch_number != ""{
            lblStatus.text = "Accepted"
            lblStatus.textColor = UIColor.black
            statusContainer.backgroundColor = UIColor.green
            lblDated.text = batchStatus.date
            lblTotalPieces.text = "\(batchStatus.total_piece!)"
            lblDefectedPieces.text = "\(batchStatus.defected_piece!)"
            lblRejectionTolerance.text = "\(batchStatus.rejection_tolerance!) %"
            lblTotalYield.text = "\(batchStatus.batch_yield!) %"
        }else if batchStatus.status == 2 && batchStatus.batch_number != ""{
            lblStatus.text = "Pending"
            lblStatus.textColor = UIColor.white
            statusContainer.backgroundColor = UIColor.black
            lblDated.text = batchStatus.date
            lblTotalPieces.text = "None"
            lblDefectedPieces.text = "None"
            lblRejectionTolerance.text = "None"
            lblTotalYield.text = "None"
        }else{
            lblStatus.text = "Not Found"
        }
    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func btnDownloadImages(_ sender: Any){
        let api = APIWrapper()
        let encodedProductNumber = encodeString(productNumber)
        let encodedBatchNumber = encodeString(batchNumber)
        let reponse = api.getMethodCall(controllerName: "Production", actionName: "GetDefectedImagesOfBatch?product_number=\(encodedProductNumber)&batch_number=\(encodedBatchNumber)")
        if reponse.ResponseCode == 200{
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "DownloadManagerViewController") as! DownloadManagerViewController
            controller.assignDownloadData(batch_number: batchNumber, product_number: productNumber, isAllBatches: false)
            controller.modalPresentationStyle = .overFullScreen
            self.present(controller, animated: false)
        }else{
            let alert = UIAlertController(title: "Not Found", message: "Rejected Batch Not Found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(alert, animated: true)
        }
    }
    
    func encodeString(_ stringNumber: String) -> String {
        if stringNumber.contains("#") {
            return stringNumber.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? stringNumber
        } else {
            return stringNumber
        }
    }
    
}
