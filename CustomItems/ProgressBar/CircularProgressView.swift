//
//  CircularProgressView.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 18/05/2024.
//

import UIKit

class CircularProgressView: UIView {

    private var progressLayer = CAShapeLayer()
    private var trackLayer = CAShapeLayer()
    private var progressLabel = UILabel()
    private var subheadingLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureProgressViewToBeCircular()
        self.configureProgressLabel()
        self.configureSubheadingLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureProgressViewToBeCircular()
        self.configureProgressLabel()
        self.configureSubheadingLabel()
    }

    var setProgressColor: UIColor = UIColor.red {
        didSet {
            progressLayer.strokeColor = setProgressColor.cgColor
        }
    }

    var setTrackColor: UIColor = UIColor.white {
        didSet {
            trackLayer.strokeColor = setTrackColor.cgColor
        }
    }

    var subheadingText: String? {
        didSet {
            subheadingLabel.text = subheadingText
        }
    }

    private var viewCGPath: CGPath? {
        return UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
                            radius: (frame.size.width - 1.5)/2,
                            startAngle: CGFloat(-0.5 * Double.pi),
                            endAngle: CGFloat(1.5 * Double.pi), clockwise: true).cgPath
    }

    private func configureProgressViewToBeCircular() {
        self.drawsView(using: trackLayer, startingPoint: 10.0, ending: 1.0)
        self.drawsView(using: progressLayer, startingPoint: 10.0, ending: 0.0)
    }

    private func drawsView(using shape: CAShapeLayer, startingPoint: CGFloat, ending: CGFloat) {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width/2.0

        shape.path = self.viewCGPath
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = setProgressColor.cgColor
        shape.lineWidth = startingPoint
        shape.strokeEnd = ending

        self.layer.addSublayer(shape)
    }

    private func configureProgressLabel() {
        progressLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height * 0.6)
        progressLabel.center = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0)
        progressLabel.textAlignment = .center
        progressLabel.textColor = UIColor.black
        progressLabel.font = UIFont.systemFont(ofSize: 40)
        self.addSubview(progressLabel)
    }

    private func configureSubheadingLabel() {
        subheadingLabel.frame = CGRect(x: 0, y: progressLabel.frame.maxY, width: self.frame.width, height: self.frame.height * 0.4)
        subheadingLabel.textAlignment = .center
        subheadingLabel.textColor = UIColor.gray
        subheadingLabel.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(subheadingLabel)
    }

    func setProgressWithAnimation(duration: TimeInterval, value: Float) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0 //start animation at point 0
        animation.toValue = value //end animation at point specified
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLayer.strokeEnd = CGFloat(value)
        progressLayer.add(animation, forKey: "animateCircle")

        // Update the labels with the progress values
        progressLabel.text = "\(Int(value * 100))%"
    }
}

