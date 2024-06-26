//
//  DownloadManagerViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 19/04/2024.
//
//http://10.211.55.3:5000/api/Production/GetAllDefectedImages?product_number=Cei%2306042024124659
import UIKit
import Toast_Swift
class DownloadManagerViewController: UIViewController, DownloadDelegate {
    
    @IBOutlet weak var downloadProgressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var container: UIView!
    
    var downloadURLString = "http://10.211.55.3:5000/api/Production/GetAllDefectedImages?product_number=Dis%2321052024003405"
    
    var download: Download?
    
    func assignDownloadData(batch_number: String, product_number: String, isAllBatches: Bool) {
           // Encode the product number
           let encodedProductNumber: String
           if product_number.contains("#") {
               encodedProductNumber = product_number.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? product_number
           } else {
               encodedProductNumber = product_number
           }
           
        // Encode the batch number
        let encodedBatchNumber: String
        if batch_number.contains("#") {
            encodedBatchNumber = batch_number.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? batch_number
        } else {
            encodedBatchNumber = batch_number
        }
        
           // Construct the download URL string
        if isAllBatches{
            self.downloadURLString = "http://10.211.55.3:5000/api/Production/GetAllDefectedImages?product_number=\(encodedProductNumber)"
        }else{
            self.downloadURLString = "http://10.211.55.3:5000/api/Production/GetDefectedImagesOfBatch?product_number=\(encodedProductNumber)&batch_number=\(encodedBatchNumber)"
        }
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        container.layer.cornerRadius = 15
        container.layer.borderWidth = 0.5
        container.layer.borderColor = UIColor.black.cgColor
        
        // Specify the file URL where the downloaded file will be saved
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectoryURL.appendingPathComponent("IndustrialWatch.zip")
        
        // Initialize download with URL and file URL
        download = Download(url: downloadURLString, fileURL: fileURL)
        download?.delegate = self
        view.makeToast("Close the Download manager to go back. Be sure to let the download complete.", duration: 3.0, position: .bottom)
        // Start the download
        download?.startDownload()
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        download?.cancelDownload()
        self.dismiss(animated: true)
    }
    
    // MARK: - DownloadDelegate
    
    func downloadProgressUpdate(for progress: Float) {
        DispatchQueue.main.async {
            self.progressView.progress = progress
            self.downloadProgressLabel.text = String(format: "%.1f%%", progress * 100)
        }
    }
    
    func downloadCompletedSuccessfully() {
        // Handle download completion
        print("Download completed successfully.")
    }
    
    func downloadFailed(with error: Error) {
        // Handle download failure
        print("Download failed with error: \(error)")
    }
}

//Downloading Zip File Code

final class Download: NSObject, URLSessionDownloadDelegate {
    
    weak var delegate: DownloadDelegate?
    var downloadTask: URLSessionDownloadTask?
    var resumeData: Data?
    var progress: Float = 0.0
    var fileURL: URL // Location where the downloaded file will be saved
    
    init(url: String, fileURL: URL) {
        // Construct file URL by appending filename with ".zip" extension to the app's documents directory
        self.fileURL = Download.documentsDirectory.appendingPathComponent("IndustrialWatch\(Date().timeIntervalSinceReferenceDate).zip")
        super.init()
        guard let url = URL(string: url) else { return }
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        downloadTask = session.downloadTask(with: url)
    }
    
    func startDownload() {
        downloadTask?.resume()
    }
    
    func cancelDownload() {
        downloadTask?.cancel()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        // Move the downloaded file to the specified fileURL with ".zip" extension
        do {
            try FileManager.default.moveItem(at: location, to: fileURL)
            // Notify delegate that download is complete
            print(fileURL)
            delegate?.downloadCompletedSuccessfully()
        } catch {
            print("Error moving downloaded file: \(error)")
            // Notify delegate of download failure
            delegate?.downloadFailed(with: error)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        // Calculate progress
        progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        delegate?.downloadProgressUpdate(for: progress)
    }
    
    static var documentsDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}


protocol DownloadDelegate: class {
    func downloadProgressUpdate(for progress: Float)
    func downloadCompletedSuccessfully()
    func downloadFailed(with error: Error)
}
