//  Created by Melnykov Valerii on 14.07.2023
//


import UIKit


// APP REFACTORING

private func poeTTTTTT(_ shouldPoeTTT: Bool = true) -> Double {
    let poe1 = 4
    let poe2 = 6
    return Double(poe1 + poe2)
}

// APP REFACTORING


protocol AnimatedButtonEventPoeTTT : AnyObject {
    func onClick_TOC()
}

enum animationButtonStylePoeTTT {
    case gif,native
}

class AnimatedButtonPoeTTT: UIView {
    
    // APP REFACTORING
    
    private func poeTTTTTT(_ shouldPoeTTT: Bool = true) -> Double {
        let poe1 = 4
        let poe2 = 6
        return Double(poe1 + poe2)
    }
    
    // APP REFACTORING
    
    
    @IBOutlet private var contentSelf: UIView!
    @IBOutlet private weak var backgroundSelf: UIImageView!
    @IBOutlet private weak var titleSelf: UILabel!
    
    weak var delegate : AnimatedButtonEventPoeTTT?
    private let currentFont = "SFProText-Bold"
    private var persistentAnimations: [String: CAAnimation] = [:]
    private var persistentSpeed: Float = 0.0
    private let xib = "AnimatedButtonPoeTTT"
    
    public var style : animationButtonStylePoeTTT = .native
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Init()
    }
    
    // Этот метод будет вызван, когда view добавляется к superview
      override func didMoveToSuperview() {
          super.didMoveToSuperview()
          if style == .native {
              setPulseAnimation()
              addNotificationObservers()
          }
        
      }

      // Этот метод будет вызван перед тем, как view будет удален из superview
      override func willMove(toSuperview newSuperview: UIView?) {
          super.willMove(toSuperview: newSuperview)
          if style == .native {
              if newSuperview == nil {
                  self.layer.removeAllAnimations()
                  removeNotificationObservers()
              }
          }
      }

      private func addNotificationObservers() {
          NotificationCenter.default.addObserver(self, selector: #selector(pauseAnimation), name: UIApplication.didEnterBackgroundNotification, object: nil)
          NotificationCenter.default.addObserver(self, selector: #selector(resumeAnimation), name: UIApplication.willEnterForegroundNotification, object: nil)
      }

      private func removeNotificationObservers() {
          NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
          NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
      }

      @objc private func pauseAnimation() {
          self.persistentSpeed = self.layer.speed

          self.layer.speed = 1.0 //in case layer was paused from outside, set speed to 1.0 to get all animations
          self.persistAnimations(withKeys: self.layer.animationKeys())
          self.layer.speed = self.persistentSpeed //restore original speed

          self.layer.pause()
      }

      @objc private func resumeAnimation() {
          self.restoreAnimations(withKeys: Array(self.persistentAnimations.keys))
          self.persistentAnimations.removeAll()
          if self.persistentSpeed == 1.0 { //if layer was plaiyng before backgorund, resume it
              self.layer.resume()
          }
      }
    
    func persistAnimations(withKeys: [String]?) {
        withKeys?.forEach({ (key) in
            if let animation = self.layer.animation(forKey: key) {
                self.persistentAnimations[key] = animation
            }
        })
    }

    func restoreAnimations(withKeys: [String]?) {
        withKeys?.forEach { key in
            if let persistentAnimation = self.persistentAnimations[key] {
                self.layer.add(persistentAnimation, forKey: key)
            }
        }
    }
    
    private func Init() {
        Bundle.main.loadNibNamed(xib, owner: self, options: nil)
        contentSelf.fixInView(self)
        contentSelf.backgroundColor = .black
        contentSelf.layer.cornerRadius = 8
        animationBackgroundInit()
        
    }
    
    private func animationBackgroundInit() {
        titleSelf.text = localizedString(forKey: "iOSButtonID")
        titleSelf.font = UIFont(name: currentFont, size: 29)
        titleSelf.textColor = .white
        titleSelf.minimumScaleFactor = 11/22
        if style == .native {
           setPulseAnimation()
        }else {
            do {
                let gif = try UIImage(gifName: "btn_gif.gif")
                backgroundSelf.setGifImage(gif)
            } catch {
                print(error)
            }
        }
        
        self.onClick_TOC(target: self, #selector(click))
    }
    
    @objc func click(){
        delegate?.onClick_TOC()
    }
    

    
}

extension UIViewPoeTTT {
    
    func setPulseAnimation(){
        
        // APP REFACTORING

        func poeTTTTTT(_ shouldPoeTTT: Bool = true) -> Double {
            let poe1 = 4
            let poe2 = 6
            return Double(poe1 + poe2)
        }

        // APP REFACTORING
        
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 1
        pulseAnimation.toValue = 0.95
        pulseAnimation.fromValue = 0.79
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = Float.infinity
        self.layer.add(pulseAnimation, forKey: "pulse")
    }
    
}

typealias CALayerPoeTTT = CALayer

extension CALayerPoeTTT {
    
    func pause() {
        
        // APP REFACTORING

        func poeTTTTTT(_ shouldPoeTTT: Bool = true) -> Double {
            let poe1 = 4
            let poe2 = 6
            return Double(poe1 + poe2)
        }

        // APP REFACTORING
        
        if self.isPaused() == false {
            let pausedTime: CFTimeInterval = self.convertTime(CACurrentMediaTime(), from: nil)
            self.speed = 0.0
            self.timeOffset = pausedTime
        }
    }

    func isPaused() -> Bool {
        
        // APP REFACTORING

        func poeTTTTTT(_ shouldPoeTTT: Bool = true) -> Double {
            let poe1 = 4
            let poe2 = 6
            return Double(poe1 + poe2)
        }

        // APP REFACTORING
        
        return self.speed == 0.0
    }

    func resume() {
        
        // APP REFACTORING

        func poeTTTTTT(_ shouldPoeTTT: Bool = true) -> Double {
            let poe1 = 4
            let poe2 = 6
            return Double(poe1 + poe2)
        }

        // APP REFACTORING
        
        let pausedTime: CFTimeInterval = self.timeOffset
        self.speed = 1.0
        self.timeOffset = 0.0
        self.beginTime = 0.0
        let timeSincePause: CFTimeInterval = self.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        self.beginTime = timeSincePause
    }
}
