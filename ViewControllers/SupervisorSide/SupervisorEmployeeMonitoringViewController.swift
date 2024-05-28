//
//  SupervisorEmployeeMonitoringViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/05/2024.
//

import UIKit
import AVFoundation
import UniformTypeIdentifiers
import AVKit
import Photos

class SupervisorEmployeeMonitoringViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var videoview: UIView!
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // 2. Get the selected video URL
        
        
        if let assetURL = info[.referenceURL] as? URL{
            let fetchResult = PHAsset.fetchAssets(withALAssetURLs: [assetURL], options: nil)
            if let asset = fetchResult.firstObject{
                PHImageManager.default().requestAVAsset(forVideo: asset, options: nil){(avAsset,_,_) in
                    guard let avAsset = avAsset as? AVURLAsset else{
                        print("Failed to get Asset")
                        return
                    }
                    print(avAsset.url)
                    DispatchQueue.main.async {
                        self.videoURL = avAsset.url
                        self.lblFileName.text = "\(avAsset.url)"
                    }
                    
                    
                }
            }
        }
        
        
        guard let videoURL = info[UIImagePickerController.InfoKey.referenceURL] as? URL else {
                return
            }
            
            // 3. Upload the video to the API
        //self.videoURL = videoURL
        lblFileName.text = "\(self.videoURL)"
        lblFileName.isHidden = false
            
            // 4. Dismiss the UIImagePickerController
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            // 5. Dismiss the UIImagePickerController if the user cancels
            picker.dismiss(animated: true, completion: nil)
        }
    
    var videoURL = URL(string: "")
    @IBOutlet weak var lblFileName: UILabel!
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        imagePicker.delegate = self
        imagePicker.mediaTypes = [UTType.movie.identifier]
    }

    @IBAction func btnChooseVideo(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            //imagePicker.mediaTypes = ["public.movie"]
            imagePicker.allowsEditing = false // Optional: Allow trimming videos (if needed)
            present(imagePicker, animated: true, completion: nil)
          }
    }
    
    @IBAction func btnUploadVideo(_ sender: Any) {
        if let url = self.videoURL {
            uploadVideoToAPI(videoURL: url)
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func createBody(boundary: String, filePathKey: String, videoURL: URL) -> Data {
        var body = Data()
        let filename = videoURL.lastPathComponent
        let mimetype = "video/mp4"
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
        body.append(try! Data(contentsOf: videoURL))
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
    
    func uploadVideoToAPI(videoURL: URL) {
        
//        let player = AVPlayer(url: videoURL)
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = player
//        self.present(playerViewController, animated: true){
//            player.play()
//        }
//
//        return
        // 1. Create a URL request with the API endpoint
        var request = URLRequest(url: URL(string: "http://192.168.100.22:5000/api/Automation/PredictEmployeeViolation")!)
        request.httpMethod = "POST"
        
        // 2. Create a boundary string for the multipart/form-data upload
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // 3. Create the multipart/form-data request body
        var requestBodyData = Data()
        
        do {
            // Add the video data to the request body
            let videoData = try Data(contentsOf: videoURL)
            requestBodyData.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            requestBodyData.append("Content-Disposition: form-data; name=\"files\"; filename=\"\(videoURL.lastPathComponent)\"\r\n".data(using: .utf8)!)
            requestBodyData.append("Content-Type: video/mp4\r\n\r\n".data(using: .utf8)!)
            requestBodyData.append(videoData)
            requestBodyData.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        } catch {
            print("Error loading video data: \(error.localizedDescription)")
            return
        }
        
        request.httpBody = requestBodyData
        
        // 4. Create a URLSessionUploadTask and start the upload
        let task = URLSession.shared.uploadTask(with: request, from: requestBodyData) { data, response, error in
            if let error = error {
                print("Error uploading video: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Upload response status code: \(httpResponse.statusCode)")
            }
            
            if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                print("API response: \(responseString ?? "No response data")")
            }
        }
        
        task.resume()
    }
    
}
