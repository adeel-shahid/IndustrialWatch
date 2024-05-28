//
//  ViolationDetailViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 19/05/2024.
//

import UIKit

class ViolationDetailViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var lblEmployeeName: UILabel!
    @IBOutlet weak var lblSectionName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblviolatedRuleName: UILabel!
    @IBOutlet weak var ScrollViewContainer: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    var employeeName = "Muhammad Anees"
    var imgArray = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        lblEmployeeName.text = employeeName
        lblviolatedRuleName.text = "Mobile Usage"
        lblTime.text = "10 : 00 AM"
        lblDate.text = "23 August 2023"
        lblSectionName.text = "Packing"
        imgArray.append(UIImage(named: "ViolationsSmoking")!)
        imgArray.append(UIImage(named: "MobileUsageViolation")!)
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
            
            for i in 0..<imgArray.count {
                let imageView = UIImageView(frame: CGRect(x: CGFloat(i) * scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollViewHeight))
                imageView.contentMode = .scaleAspectFit
                imageView.image = imgArray[i]
                scrollView.addSubview(imageView)
            }
            
            scrollView.contentSize = CGSize(width: CGFloat(imgArray.count) * scrollView.frame.width, height: scrollViewHeight)
            
            self.ScrollViewContainer.addSubview(scrollView)
            
        pageController.numberOfPages = imgArray.count
        pageController.currentPage = 0
        pageController.tintColor = UIColor.red // Change color as needed
        pageController.pageIndicatorTintColor = UIColor.lightGray // Change color as needed
        pageController.currentPageIndicatorTintColor = UIColor.black // Change color as needed
        pageController.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
            
            self.ScrollViewContainer.addSubview(pageController)
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
