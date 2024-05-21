//
//  HorizontalImageSlider.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 20/05/2024.
//

import Foundation
import UIKit

/// The horizontal scroll view subclasses the UIScrollView and adds your views using
/// programmatic NSLayoutConstraints.
/// - Important: Setting a height constraint on this view is highly recommended.
/// It would also be recommended to set a width constraint on your added arrangedViews.
class HorizontalScrollView: UIScrollView {
    /// The views that have been added to this scroll view.
    var arrangedViews: [UIView] = []
    /// The constraints added as a result of the arrangedViews added.
    private var arrangedViewContraints: [NSLayoutConstraint] = []
    /// The spacing between views, defaults to 8.0.
    var interItemSpacing: CGFloat = 8.0 { didSet { setNeedsUpdateConstraints() } }
    /// The content inset around the arranged views within the scroll view.
    var contentInsetValue: UIEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0) {
        didSet { contentInset = contentInsetValue }
    }

    // MARK: - INITIALIZERS:

    override init(frame: CGRect) {
        super.init(frame: frame)
        delaysContentTouches = false
        contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }

    @available(*, unavailable) required init?(coder: NSCoder) { nil }

    // MARK: - OVERRIDES OF INHERITANCE:

    override open func updateConstraints() {
        super.updateConstraints()
        removeConstraintsForArrangedViews()
        addConstraintsForArrangedViews()
    }

    // MARK: - EXPOSED FUNCTIONS:

    /// Add the views you want to the scrolling horizontal view.
    /// The views are automatically added on the main queue.
    /// - Parameter views: ([UIView]) The arrays of views you want to add.
    func addArrangedViews(_ views: [UIView]) {
        DispatchQueue.main.async {
            views.forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                self.arrangedViews.append($0)
                self.addSubview($0)
            }
            self.setNeedsUpdateConstraints()
        }
    }

    /// Removes the view at a specified index with a boolean returned in the completion handler.
    /// The view is automatically removed on the main thread.
    /// - Parameter index: (Int) The index of the view you would like to remove.
    /// - Parameter completion: (optional)  Returns true if the view was removed, false if not found.
    func removeView(index: Int, completion: ((Bool) -> Void)? = nil) {
        guard let view = self.arrangedViews[safe: index] else {
            completion?(false)
            return
        }
        view.alpha = 1.0
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseOut, animations: {
            view.alpha = 0
        }, completion: { [weak self] _ in
            DispatchQueue.main.async {
                self?.arrangedViews.remove(at: index)
                view.removeFromSuperview()
                self?.updateConstraints()
                completion?(true)
            }
        })
    }

    /// Removes all arranged views, with the option of leaving the first view.
    /// Leaving the first view could be handy when your first view features a button
    /// like "Add a photo" while the views following it are photos.
    /// Arranged views are removed on the main thread.
    /// - Parameter exceptFirstView: (Bool) Pass true to preserve the first view.
    func removeAllArrangedViews(exceptFirstView: Bool = true) {
        DispatchQueue.main.async {
            guard let first = self.arrangedViews.first else { return }
            self.arrangedViews = exceptFirstView ? [first] : []
            for subview in self.subviews {
                if exceptFirstView, subview == first { continue }
                subview.removeFromSuperview()
            }

            self.updateConstraints()
        }
    }

    /// Removes all the constraints for the arranged views.
    private func removeConstraintsForArrangedViews() {
        arrangedViewContraints.forEach { $0.isActive = false }
        arrangedViewContraints.removeAll()
    }

    /// Adds all the constraints for the arranged views and updates the array of NSLayoutConstraints.
    private func addConstraintsForArrangedViews() {
        for (index, view) in arrangedViews.enumerated() {
            switch index {
            case 0:
                arrangedViewContraints.append(leadingConstraint(forView: view))
                arrangedViewContraints.append(topConstraint(forView: view))
            case arrangedViews.count - 1:
                arrangedViewContraints.append(trailingConstraint(forView: view))
                arrangedViewContraints.append(topConstraint(forView: view))
                fallthrough
            default:
                let previousView = arrangedViews[index - 1]
                let constraint = leadingToTrailingConstraint(forView: view, toView: previousView)
                arrangedViewContraints.append(constraint)
            }
        }
    }

    // MARK: - CONSTRAINT HELPERS:
    // It would be wise to leave these helpers as you utilize this class
    // across mutliple projects, instead of adding them as extensions.

    /// Creates a leading constraint horizontally from one views leading edge to another views trailing edge.
    /// - Parameter arrangedView: (UIView) The view that should have the leading constraint.
    /// - Parameter toView: (UIView)  The view that should have the trailing constraint.
    /// - Important: This function activates the constraint.
    /// - Returns: (NSLayoutConstraint) The horizontal NSLayoutConstraint.
    private func leadingToTrailingConstraint(forView arrangedView: UIView,
                                             toView: UIView) -> NSLayoutConstraint {
        let constraint = arrangedView.leadingAnchor
            .constraint(equalTo: toView.trailingAnchor, constant: interItemSpacing)
        constraint.isActive = true
        return constraint
    }

    /// Creates a top constraint from the passed view's top edge to this class's top edge.
    /// - Parameter arrangedView: (UIView) The view that should have the top constraint.
    /// - Important: This function activates the constraint.
    /// - Returns: (NSLayoutConstraint) The top NSLayoutConstraint.
    private func topConstraint(forView arrangedView: UIView) -> NSLayoutConstraint {
        let constraint = arrangedView.topAnchor.constraint(equalTo: self.topAnchor)
        constraint.isActive = true
        return constraint
    }

    /// Creates a leading constraint from the passed view's leading edge to this class's leading edge.
    /// - Parameter arrangedView: (UIView) The view that should have the leading constraint.
    /// - Important: This function activates the constraint.
    /// - Returns: (NSLayoutConstraint) The leading NSLayoutConstraint.
    private func leadingConstraint(forView arrangedView: UIView) -> NSLayoutConstraint {
        let constraint = arrangedView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        constraint.isActive = true
        return constraint
    }

    /// Creates a trailing constraint from the passed view's trailing edge to this class's trailing edge.
    /// - Parameter arrangedView: (UIView) The view that should have the trailing constraint.
    /// - Important: This function activates the constraint.
    /// - Returns: (NSLayoutConstraint) The trailing NSLayoutConstraint.
    private func trailingConstraint(forView arrangedView: UIView) -> NSLayoutConstraint {
        let constraint = arrangedView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        constraint.isActive = true
        return constraint
    }
}

private extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

class ButtonHorizontalScrollingView: UIView {
    let allButtonStyles = ButtonType.allCases
    let scrollingView = HorizontalScrollView(frame: .zero)

    init() {
        super.init(frame: .zero)
        self.buildUserInterface()
    }

    @available(*, unavailable) required init?(coder: NSCoder) { nil }

    private func buildUserInterface() {
        let buttons = allButtonStyles.compactMap { createButton(style: $0) }
        scrollingView.translatesAutoresizingMaskIntoConstraints = false
        scrollingView.addArrangedViews(buttons)
        scrollingView.isUserInteractionEnabled = true
        scrollingView.interItemSpacing = 10
//        scrollingView.height(36)
        scrollingView.showsHorizontalScrollIndicator = false
        self.addSubview(scrollingView)
        scrollingView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollingView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        scrollingView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        scrollingView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }

    private func createButton(style: ButtonType) -> UIButton {
        var configuration = UIButton.Configuration.plain()
        configuration.background.cornerRadius = 8
        configuration.background.backgroundColor = .darkGray // background color
        let font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        let container = AttributeContainer([NSAttributedString.Key.font: font])
        configuration.attributedTitle = AttributedString(style.text, attributes: container)
        configuration.baseForegroundColor = .white // text color
        let button = UIButton(configuration: configuration)
        return button
    }
}

enum ButtonType: Int, CaseIterable {
    case fashionStyle,
         sportyChic,
         muaythaiTraining,
         backStretches,
         boxingLifestyle,
         shadowBoxing,
         officeOutfit,
         workwearStyle

    var text: String {
        switch self {
        case .fashionStyle: return "Fashion Style"
        case .sportyChic: return "Sporty Chic"
        case .muaythaiTraining: return "Muaythai Training"
        case .backStretches: return "Back Stretches"
        case .boxingLifestyle: return "Boxing Lifestyles"
        case .shadowBoxing: return "Shadow Boxing"
        case .officeOutfit: return "Office Outfit"
        case .workwearStyle: return "Workwear Style"
        }
    }
}
