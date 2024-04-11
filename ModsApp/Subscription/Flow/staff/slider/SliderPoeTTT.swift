//  Created by Melnykov Valerii on 14.07.2023
//

import Foundation
import UIKit
import SwiftUI

class SliderPoeTTT: UIView {
    
    public var label: UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 50,height: 20))
    private var pageControl: CustomPageControlPoeTTT = CustomPageControlPoeTTT(frame: CGRect(x: 0, y: 0, width: 50, height: 1)) //UIPageControl(frame: CGRect(x: 0, y: 0, width: 50, height: 1))
    private var textsArray: [String] = ["Add your texts seperated by '|n'"]
    
    private(set) var isPaused: Bool = false
    private(set) var currentIndex = 0
    private var timer : Timer?
    
    fileprivate let tapticFeedback: UINotificationFeedbackGenerator = UINotificationFeedbackGenerator()
    
    @IBInspectable var labelTextsForSlider: String = "" {
        didSet {
            textsArray = labelTextsForSlider.components(separatedBy: "|n")
            label.text = textsArray[0]
            label.adjustsFontSizeToFitWidth = true
            pageControl.numberOfPages = textsArray.count
            
            var i = 0
            // remove leading newline/whitespace characters
            for text in textsArray {
                let trimmed = text.replacingOccurrences(of: "^\\s*", with: "", options: .regularExpression)
                textsArray[i] = trimmed
                i+=1
            }
        }
    }
    
    @IBInspectable var labelTextColor: UIColor = UIColor.black {
        didSet {
            label.textColor = labelTextColor
        }
    }
    
    @IBInspectable var labelSize: CGFloat = CGFloat(17.0) {
        didSet{
            label.font = UIFont(name: labelFont, size: labelSize)
        }
    }
    @IBInspectable var labelFont: String = "SFProText-Bold" {
        didSet {
            label.font = UIFont(name: labelFont, size: labelSize)
        }
    }
    
    @IBInspectable var pagerTintColor: UIColor = UIColor.black {
        didSet {
            pageControl.pageIndicatorTintColor = self.pagerTintColor
        }
    }
    
    @IBInspectable var pagerCurrentColor: UIColor = UIColor.white {
        didSet {
            pageControl.currentPageIndicatorTintColor = self.pagerCurrentColor
        }
    }
    
    @IBInspectable var timeToSlide: Double = 4.0 {
        didSet {
            timer?.invalidate()
            startTimerOrResume()
        }
    }
    
    @IBInspectable var enableGestures: Bool = false {
        didSet {
            if enableGestures{
                configureGestures()
            }
            else{
                self.gestureRecognizers?.forEach(self.removeGestureRecognizer)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        startPageControl()
        startLabel()
        startTimerOrResume()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        startPageControl()
        startLabel()
        startTimerOrResume()
    }
    
    private func configureGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.addGestureRecognizer(swipeLeft)
    }
    
    private func startLabel() {
        label.text = textsArray[0]
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        self.addSubview(label)
        
        let bottomConstraint = NSLayoutConstraint(item: label,
                                                  attribute: NSLayoutConstraint.Attribute.bottom,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: pageControl,//toItem: self,
                                                  attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 5)
        
        let topConstraint = NSLayoutConstraint(item: label,
                                               attribute: NSLayoutConstraint.Attribute.top,
                                               relatedBy: NSLayoutConstraint.Relation.equal,
                                               toItem: self,
                                               attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        
        let trailingConstraint = NSLayoutConstraint(item: self,
                                                    attribute: NSLayoutConstraint.Attribute.trailing,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: label,
                                                    attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        
        let leadingConstraint = NSLayoutConstraint(item: label,
                                                   attribute: NSLayoutConstraint.Attribute.leading,
                                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                                   toItem: self,
                                                   attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([bottomConstraint, topConstraint, trailingConstraint, leadingConstraint])
    }
    
    @objc private func pageControlHandle(sender: UIPageControl){
        print(sender.currentPage)
        pageControlChanged(currentIndex: sender.currentPage)
        
    }
    
    private func pageControlChanged(currentIndex: Int) {
        if currentIndex == self.textsArray.count {
            self.currentIndex = 0
        }
        
        self.label.pushTransition(duration: 0.5, animationSubType: convertFromCATransitionSubtype(CATransitionSubtype.fromRight))
        self.label.text = self.textsArray[currentIndex]
        
        self.pageControl.currentPage = currentIndex
        
    }
    
    private func startPageControl() {
        pageControl.numberOfPages = 1
        pageControl.currentPage = 0
        
        pageControl.isUserInteractionEnabled = false
        
        pageControl.pageIndicatorTintColor = .clear //pagerTintColor
        pageControl.currentPageIndicatorTintColor = .clear //pagerCurrentColor
        pageControl.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.addTarget(self, action: #selector(pageControlHandle), for: .valueChanged)
        addSubview(pageControl)
        
        let horizontalConstraint = NSLayoutConstraint(item: pageControl, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: pageControl, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 10)
        
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
        
    }
    
    public func pause() {
        timer?.invalidate()
        isPaused = true
    }
    
    public func start() {
        // startOrResumeTimer()
    }
    
    public var slidingTexts: [String] {
        get{
            return textsArray
        }
        set{
            textsArray = newValue
            label.text = textsArray[0]
            pageControl.numberOfPages = textsArray.count
            
            var i = 0
            // remove leading newline/whitespace characters
            for text in textsArray {
                let trimmed = text.replacingOccurrences(of: "^\\s*", with: "", options: .regularExpression)
                textsArray[i] = trimmed
                i+=1
            }
        }
    }
    
    func restartpageControl() {
        self.currentIndex = 0
        self.pageControl.currentPage = self.currentIndex
        self.label.text = self.textsArray[self.currentIndex]
        startTimerOrResume()
    }
    
    
    private func startTimerOrResume() {
        timer?.invalidate()
        timer =  Timer.scheduledTimer(timeInterval: timeToSlide, target: self, selector: #selector(self.timersJob), userInfo: nil, repeats: true)
        isPaused = false
        
    }
    
    @objc private func timersJob() {
        self.currentIndex += 1
        if self.currentIndex == self.textsArray.count {
            self.currentIndex = 0
        }
        
        self.label.pushTransition(duration: 0.5, animationSubType: convertFromCATransitionSubtype(CATransitionSubtype.fromRight))
        self.label.text = self.textsArray[self.currentIndex]
        
        self.pageControl.currentPage = self.currentIndex
    }
    
    @objc private func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        self.tapticFeedback.notificationOccurred(.success)
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                // timer?.invalidate()
                currentIndex -= 1
                if currentIndex < 0{
                    currentIndex = textsArray.count - 1
                }
                
                label.pushTransition(duration: 0.5, animationSubType: convertFromCATransitionSubtype(CATransitionSubtype.fromLeft))
                label.text = self.textsArray[currentIndex]
                
                pageControl.currentPage = currentIndex
                startTimerOrResume()
                
            case UISwipeGestureRecognizer.Direction.down:
                break
            case UISwipeGestureRecognizer.Direction.left:
                timer?.invalidate()
                currentIndex += 1
                if currentIndex == textsArray.count{
                    currentIndex = 0
                }
                
                label.pushTransition(duration: 0.5, animationSubType: convertFromCATransitionSubtype(CATransitionSubtype.fromRight))
                label.text = self.textsArray[currentIndex]
                
                pageControl.currentPage = self.currentIndex
                startTimerOrResume()
                
            case UISwipeGestureRecognizer.Direction.up:
                break
            default:
                break
            }
        }
    }
}

