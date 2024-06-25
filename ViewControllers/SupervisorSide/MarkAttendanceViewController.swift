//
//  MarkAttendanceViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 23/06/2024.
//

import UIKit
import Photos

class MarkAttendanceViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage{
            self.ImageView.image = img
    
        }
        self.imagepicker.dismiss(animated: true,completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.imagepicker.dismiss(animated: true)
    }
    
    @IBOutlet weak var ImageView: UIImageView!
    var imagepicker = UIImagePickerController()
    @IBOutlet weak var container: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagepicker.delegate = self
        PHPhotoLibrary.requestAuthorization{ status in
            switch status{
            case .authorized:
                print("access authorized")
            case .denied, .restricted, .notDetermined:
                print("access denied")
            default:
                break;
            }
        }
        container.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnBrowse(_ :))))
    }
    
    @objc func btnBrowse(_ sender: Any){
        self.imagepicker.modalPresentationStyle = .fullScreen
        self.present(imagepicker, animated: true)
    }
    
    
    @IBAction func btnUpload(_ sender: Any) {
        guard let image = self.ImageView.image else{
            return
        }
        markAttendance(image: image)
    }
    
    func markAttendance(image: UIImage) {
        // Create a URL request with the API endpoint
        guard let url = URL(string: "http://10.211.55.3:5000/api/Employee/MarkAttendance") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Create the boundary string for the multipart/form-data upload
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Create the multipart/form-data request body
        var requestBodyData = Data()
        
        // Convert UIImage to Data
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            print("Failed to convert image to Data")
            return
        }
        
        let filename = "image.jpeg"
        
        requestBodyData.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        requestBodyData.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        requestBodyData.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        requestBodyData.append(imageData)
        requestBodyData.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Configure the request with the request body
        request.httpBody = requestBodyData
        
        // Create a URLSession with custom configuration to extend timeout interval
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 3600.0
        sessionConfig.timeoutIntervalForResource = 3600.0
        let session = URLSession(configuration: sessionConfig)
        
        // Create a URLSessionUploadTask and start the upload
        let task = session.uploadTask(with: request, from: requestBodyData) { data, response, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "Failed to mark attendance. Please try again.")
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Upload response status code: \(httpResponse.statusCode)")
                
                // Handle the response if needed
                if let data = data {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            print("API response: \(jsonResponse)")
                            
                            // Example of parsing the JSON response
                            if let message = jsonResponse["message"] as? String {
                                print("Server message: \(message)")
                                DispatchQueue.main.async {
                                    self.dismiss(animated: true)
                                }
                            }
                            
                            DispatchQueue.main.async {
                                self.showAlert(title: "Success", message: jsonResponse["message"] as! String)
                            }
                        }
                    } catch {
                        print("Error decoding API response: \(error.localizedDescription)")
                        DispatchQueue.main.async {
                            self.showAlert(title: "Error", message: "Failed to parse server response. Please try again.")
                        }
                    }
                }
            }
        }
        
        task.resume()
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        // Assuming this function is within a UIViewController
        if let topController = UIApplication.shared.keyWindow?.rootViewController {
            topController.present(alert, animated: true)
        }
    }



    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
