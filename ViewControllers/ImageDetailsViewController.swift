//
//  ImageDetailsViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/03/2024.
//

import UIKit

class ImageDetailsViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var lblProductNumber: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    var productNumber : String = "Not Found"
    
    var slides : [Slide] = []
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
                pageControl.currentPage = Int(pageIndex)
                
                let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
                let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
                
                // vertical
                let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
                let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
                
                let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
                let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
                
                
                /*
                 * below code changes the background color of view on paging the scrollview
                 */
        //        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
                
            
                /*
                 * below code scales the imageview on paging the scrollview
                 */
                let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
                
                if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
                    
                    slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
                    slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
                    
                } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
                    slides[1].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
                    slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
                    
                } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
                    slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
                    slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
                    
                } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
                    slides[3].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
                    slides[4].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
                }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        lblProductNumber.text = productNumber
        slides = Slide().createSlides()
        setupSlideScrollView(slides: slides)
        pageControl.numberOfPages = slides.count
                pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }

    
    
    func setupSlideScrollView(slides : [Slide]) {
            scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
            scrollView.isPagingEnabled = true
            
            for i in 0 ..< slides.count {
                slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
                scrollView.addSubview(slides[i])
            }
        }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
}
