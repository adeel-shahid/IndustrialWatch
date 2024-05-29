//
//  ViolationDetailViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 19/05/2024.
//

import UIKit
import Kingfisher
class ViolationDetailViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var lblEmployeeName: UILabel!
    @IBOutlet weak var lblSectionName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblviolatedRuleName: UILabel!
    @IBOutlet weak var ScrollViewContainer: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    var employeeName = "Not Found"
    var violationId = 0
    var imgArray = [UIImage]()
    var urls = [String]()
    var violations = Violation(allowed_time: "", end_time: "", start_time: "", section_id: 0, section_name: "", violation_id: 0, date: "", rule_name: "", images: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        lblEmployeeName.text = employeeName
        violations = EmployeeViewModel().getEmployeeViolationDetails(violationId: violationId)
        lblviolatedRuleName.text = violations.rule_name
        lblTime.text = violations.start_time
        lblDate.text = violations.date
        lblSectionName.text = violations.section_name
        
        for img in violations.images{
            if let url = img.image_url{
                urls.append(url)
            }
        }
        setUpImageScrollView()
    }
    
    
    func setUpImageScrollView() {
        // Calculate the height of the scroll view to fit within the parent view
        let scrollViewHeight = self.ScrollViewContainer.frame.height - 40
        
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.bounces = false // Optional: to prevent bouncing effect vertically
        
        DispatchQueue.main.async { [self] in
            for i in 0..<self.urls.count {
                let imageView = UIImageView(frame: CGRect(x: CGFloat(i) * scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollViewHeight))
                imageView.contentMode = .scaleAspectFit
                let url = APIWrapper().getViolationImageURL(imagePath: urls[i])
                imageView.kf.setImage(with: url) { [self] _ in
                    // Once the image is loaded, update the content size of the scroll view
                    let contentWidth = CGFloat(self.urls.count) * self.scrollView.frame.width
                    scrollView.contentSize = CGSize(width: contentWidth, height: scrollViewHeight)
                }
                scrollView.addSubview(imageView)
            }
        }
        
        pageController.numberOfPages = urls.count
        pageController.currentPage = 0
        pageController.tintColor = UIColor.red // Change color as needed
        pageController.pageIndicatorTintColor = UIColor.lightGray // Change color as needed
        pageController.currentPageIndicatorTintColor = UIColor.black // Change color as needed
        pageController.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
        
        self.ScrollViewContainer.addSubview(scrollView)
    }

        
        @objc func changePage(sender: UIPageControl) {
            let x = CGFloat(sender.currentPage) * scrollView.frame.size.width
            scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
            pageController.currentPage = Int(pageIndex)
        }


    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
