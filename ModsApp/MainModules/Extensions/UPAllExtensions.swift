import UIKit
import AVFoundation
import SnapKit

typealias MyPlayer = AVPlayer
extension MyPlayer {
    var isPlaying: Bool {
        let isPlayMyVideo = (rate != 0 && error == nil)
        return isPlayMyVideo
    }
}


typealias Baton = UIButton
extension Baton {
    func lets_setLinearGradientBackgroundButton(startColor: UIColor, endColor: UIColor, radius: CGFloat) {
        struct DefaultStruct {
            static let noname = "string"
        }
        // Create the gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        // Set the gradient colors
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        
        // Set the gradient direction (top to bottom)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        // Insert the gradient layer as the background
        gradientLayer.cornerRadius = radius
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func lets_removeLinearGradientBackgroundButton() {
        struct DefaultStruct {
            static let noname = "string"
        }
        // Find the gradient layer in the button's layer hierarchy
        if let gradientLayer = layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            // Remove the gradient layer from the layer hierarchy
            gradientLayer.removeFromSuperlayer()
        }
    }
}

typealias Controller = UIViewController
extension Controller {
    
    func hideKeyboardWhenTappedAroundMainScreen() {
        struct DefaultStruct {
            static let noname = "string"
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.make_dismissBloodyKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func make_dismissBloodyKeyboard() {
        struct DefaultStruct {
            static let noname = "string"
        }
        view.endEditing(true)
    }
    
    func lets_setLinearGradientBackground(startColor: UIColor, endColor: UIColor) {
        struct DefaultStruct {
            static let noname = "string"
        }
        // Create the gradient layer
        let gradientLayer = CAGradientLayer()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            gradientLayer.frame = UIScreen.main.bounds
        } else {
            gradientLayer.frame = view.bounds
        }
        let color = UIColor(red: 0.004, green: 0, blue: 0.213, alpha: 1)

        // Set the gradient colors
        gradientLayer.colors = [color.cgColor, color.cgColor]
        
        // Set the gradient direction (top to bottom)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        // Insert the gradient layer as the background
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

typealias viewha = UIView
extension viewha {
    func lets_setLinearGradientBackground(startColor: UIColor, endColor: UIColor, radius: CGFloat) {
        struct DefaultStruct {
            static let noname = "string"
        }
        // Create the gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        let color = UIColor(red: 0.004, green: 0, blue: 0.213, alpha: 1)

        // Set the gradient colors
        gradientLayer.colors = [color.cgColor, color.cgColor]
        
        // Set the gradient direction (top to bottom)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        // Insert the gradient layer as the background
        gradientLayer.cornerRadius = radius
        self.layer.sublayers?.forEach({
            if $0 is CAGradientLayer {
                $0.removeFromSuperlayer()
            }
        })
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func lets_setLinearGradientBackground2(startColor: UIColor, endColor: UIColor, radius: CGFloat) {
        struct DefaultStruct {
            static let noname = "string"
        }
        // Create the gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        // Set the gradient colors
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        
        // Set the gradient direction (top to bottom)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        // Insert the gradient layer as the background
        gradientLayer.cornerRadius = radius
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func lets_setLinearGradientBackground3(startColor: UIColor, endColor: UIColor, radius: CGFloat, maskCorner: CACornerMask) {
        struct DefaultStruct {
            static let noname = "string"
        }
        // Create the gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        // Set the gradient colors
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        
        // Set the gradient direction (top to bottom)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        // Insert the gradient layer as the background
        gradientLayer.cornerRadius = radius
        gradientLayer.maskedCorners = maskCorner
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func lets_removeLinearGradientBackground() {
        struct DefaultStruct {
            static let noname = "string"
        }
        // Find the gradient layer in the button's layer hierarchy
        if let gradientLayer = layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            // Remove the gradient layer from the layer hierarchy
            gradientLayer.removeFromSuperlayer()
        }
    }

    
    func setLinearGradientBackground(startColor: UIColor, endColor: UIColor, startPoint: CGPoint, endPoint: CGPoint) {
        struct DefaultStruct {
            static let noname = "string"
        }
        // Create the gradient layer
        let gradientLayer = CAGradientLayer()
        
        
        
        // Set the gradient colors
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        
        // Set the gradient direction
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        // Insert the gradient layer as the background
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func applyGradientBackground(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        struct DefaultStruct {
            static let noname = "string"
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func lets_pushTransitionBlue(duration:CFTimeInterval, animationSubType: String) {
        struct DefaultStruct {
            static let noname = "string"
        }
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = convertToOptionalCATransitionSubtypedcdcd(animationSubType)
        animation.duration = duration
        self.layer.add(animation, forKey: convertFromCATransitionTypedddd(CATransitionType.push))
    }
}



typealias ImageV = UIImageView
extension ImageV {
    
    func lets_setLinearGradientBackground(startColor: UIColor, endColor: UIColor) {
        struct DefaultStruct {
            static let noname = "string"
        }
        // Create the gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        // Set the gradient colors
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        
        // Set the gradient direction (top to bottom)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        // Remove any existing sublayers
        layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        
        // Insert the gradient layer as the background
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func lets_setupBloodyImages(from url: String, mod: ModRealmModelElement?, category: CategoryRealmModelElement?, editorItem: EditorItemRealmModelElement?, type: ModelForDropBoxItemsType) {
        
        struct DefaultStruct {
            static let noname = "string"
        }
        let imageCacheItems = NSCache<AnyObject, AnyObject>()
        var task: URLSessionTask!
        let loader = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        loader.color = .white
        guard let url = URL(string: url) else { return }
        self.image = nil
        addSubview(loader)
        bringSubviewToFront(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loader.startAnimating()
        if let task = task {
            task.cancel()
        }
        if let imageFromCache = imageCacheItems.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.image = imageFromCache
            loader.removeFromSuperview()
            return
        }
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let newImage = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.sync {
                switch type {
                case .mods:
                    if let mod = mod {
                        CoreDataBase.shared.modChangeBlueImageData(mod: mod, modImageData: data)
                    }
                case .category:
                    if let category = category {
                        CoreDataBase.shared.categoryBlueChangeImageData(cat: category, categoryImageData: data)
                    }
                case .editorItems:
                    if let editor = editorItem {
                        CoreDataBase.shared.editorUpdateBlueImageData(obj: editor, data: data)
                    }
                }
                
            }
            imageCacheItems.setObject(newImage, forKey: url.absoluteString as AnyObject)
            DispatchQueue.main.async {
                self.isHidden = false
                self.image = newImage
                loader.stopAnimating()
            }
        }
        task.resume()
    }
}

extension UISearchBar {
    
    func setPlaceholderTextColorTo_BloodyApp(color: UIColor) {
        struct DefaultStruct {
            static let noname = "string"
        }
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = color
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = color
    }
    
    func setupSearchBloodyBar() {
        struct DefaultStruct {
            static let noname = "string"
        }
        searchTextField.clearButtonMode = .never
        self.setImage(UIImage(named: "Search Icon"), for: .search, state: .normal)
        //        self.setImage(UIImage(systemName: "xmark.circle.fill"), for: .clear, state: .normal)
        self.tintColor = .black
        
        self.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        self.setPlaceholderTextColorTo_BloodyApp(color: UIColor.black)
        
        if let searchTextfield = self.value(forKey: "searchField") as? UITextField  {
            searchTextfield.backgroundColor = .clear
        }
        
        if #available(iOS 13.0, *) {
            let placeholder = NSAttributedString(string: NSLocalizedString("search", comment: ""), attributes: [ .foregroundColor: UIColor.black.withAlphaComponent(1) ])
            let searchTextField = self.searchTextField
            
            // Key workaround to be able to set attributedPlaceholder
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    searchTextField.attributedPlaceholder = placeholder
                }
            }
        }
    }
    
    @objc private func clearButtonBloodyActionApp() {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.resignFirstResponder()
        NotificationCenter.default.post(name: Notification.Name("clearButtonActionApp"), object: nil)
    }
}


class AnimationMySlider: UIView {
    
    var label: UILabel = UILabel(frame: CGRect(x: 0, y: 0,width: 50, height: 20))
    private weak var pageImageViewControl: UIImageView!
    //    private var pageControl: UIPageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 50, height: 1))
    private var texts : [String] = ["Add your texts seperated by '|n'"]
    private(set) var currentIndex = 0
    private var timer : Timer?
    fileprivate let tapticFeedback = UINotificationFeedbackGenerator()
    
    @IBInspectable var labelTexts: String = "" {
        didSet {
            texts = labelTexts.components(separatedBy: "|n")
            label.text = texts[0]
            label.adjustsFontSizeToFitWidth = true
            //            pageControl.numberOfPages = texts.count
            var i = 0
            // remove leading newline/whitespace characters
            for text in texts {
                let trimmed = text.replacingOccurrences(of: "^\\s*", with: "", options: .regularExpression)
                texts[i] = trimmed
                i+=1
            }
        }
    }
    
    @IBInspectable var pagerTintColor: UIColor = UIColor.black {
        didSet {
            //          self.pageIndicatorTintColor = self.pagerTintColor
        }
    }
    
    @IBInspectable var pagerCurrentColor: UIColor = UIColor.white {
        didSet {
            //          self.currentPageIndicatorTintColor = self.pagerCurrentColor
        }
    }
    
    @IBInspectable var timeToSlide: Double = 15.0 {
        didSet {
            timer?.invalidate()
            startOrResumeBlueTimerssssss()
        }
    }
    
    public var slidingTexts: [String] {
        get {
            return texts
        }
        set {
            texts = newValue
            label.text = texts[0]
            //            pageControl.numberOfPages = texts.count
            var i = 0
            for text in texts {
                let trimmed = text.replacingOccurrences(of: "^\\s*", with: "", options: .regularExpression)
                texts[i] = trimmed
                i+=1
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        makePageImageViewControl()
        makeLabel()
        startOrResumeBlueTimerssssss()
        configureBlueGesturessssss()
        struct DefaultStruct {
            static let noname = "string"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        makePageImageViewControl()
        makeLabel()
        startOrResumeBlueTimerssssss()
        configureBlueGesturessssss()
        struct DefaultStruct {
            static let noname = "string"
        }
    }
    
    private func makePageImageViewControl() {
        struct DefaultStruct {
            static let noname = "string"
        }
        let pageImageViewControl = UIImageView()
        pageImageViewControl.contentMode = .scaleAspectFit
        addSubview(pageImageViewControl)
        
        pageImageViewControl.snp.makeConstraints {
            $0.width.equalTo(72)
            $0.height.equalTo(12)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(3)
        }
        
        pageImageViewControl.image = UIImage(named: "page-0-image")
        self.pageImageViewControl = pageImageViewControl
    }
    
    private func makeLabel() {
        struct DefaultStruct {
            static let noname = "string"
        }
        let label = UILabel()
        addSubview(label)
        
        label.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(pageImageViewControl.snp.top)
            $0.height.equalTo(50)
        }
        
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor.white
        self.label = label
    }
    
    private func configureBlueGesturessssss() {
        struct DefaultStruct {
            static let noname = "string"
        }
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToBlueSwipeGesturesssss))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToBlueSwipeGesturesssss))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.addGestureRecognizer(swipeLeft)
    }
    
    
    private func startOrResumeBlueTimerssssss() {
        struct DefaultStruct {
            static let noname = "string"
        }
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: timeToSlide, target: self, selector: #selector(self.timerBlueStart), userInfo: nil, repeats: true)
    }
    
    @objc private func timerBlueStart() {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.currentIndex += 1
        if self.currentIndex == self.texts.count{
            self.currentIndex = 0
        }
        self.label.lets_pushTransitionBlue(duration: 0.5, animationSubType: convertFromCATransitionSubtypecdcdcds(CATransitionSubtype.fromRight))
        self.label.text = self.texts[self.currentIndex]
        //        self.pageControl.currentPage = self.currentIndex
        pageImageViewControl.image = nil
        pageImageViewControl.image = UIImage(named: "page-\(currentIndex)-image")
        prigressBarCounter += 1
        if prigressBarCounter == 4 {
            print("show progress")
            NotificationCenter.default.post(name: Notification.Name("show_progress"), object: nil)
        }
    }
    
    private var prigressBarCounter = 0
    
    @objc private func respondToBlueSwipeGesturesssss(gesture: UIGestureRecognizer) {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.tapticFeedback.notificationOccurred(.success)
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                timer?.invalidate()
                currentIndex -= 1
                if currentIndex < 0{
                    currentIndex = texts.count - 1
                }
                label.lets_pushTransitionBlue(duration: 0.5, animationSubType: convertFromCATransitionSubtypecdcdcds(CATransitionSubtype.fromLeft))
                label.text = self.texts[currentIndex]
                //                pageControl.currentPage = currentIndex
                pageImageViewControl.image = nil
                pageImageViewControl.image = UIImage(named: "page-\(currentIndex)-image")
                startOrResumeBlueTimerssssss()
            case UISwipeGestureRecognizer.Direction.left:
                timer?.invalidate()
                currentIndex += 1
                if currentIndex == texts.count{
                    currentIndex = 0
                }
                label.lets_pushTransitionBlue(duration: 0.5, animationSubType: convertFromCATransitionSubtypecdcdcds(CATransitionSubtype.fromRight))
                label.text = self.texts[currentIndex]
                //                pageControl.currentPage = self.currentIndex
                pageImageViewControl.image = nil
                pageImageViewControl.image = UIImage(named: "page-\(currentIndex)-image")
                startOrResumeBlueTimerssssss()
            case UISwipeGestureRecognizer.Direction.down, UISwipeGestureRecognizer.Direction.up:
                break
            default:
                break
            }
            prigressBarCounter += 1
            if prigressBarCounter == 4 {
                print("show progress")
                NotificationCenter.default.post(name: Notification.Name("show_progress"), object: nil)
            }
        }
    }
}

fileprivate func convertFromCATransitionSubtypecdcdcds(_ input: CATransitionSubtype) -> String {
    struct DefaultStruct {
        static let noname = "string"
    }
    return input.rawValue
}

fileprivate func convertToOptionalCATransitionSubtypedcdcd(_ input: String?) -> CATransitionSubtype? {
    struct DefaultStruct {
        static let noname = "string"
    }
    guard let input = input else { return nil }
    return CATransitionSubtype(rawValue: input)
}

fileprivate func convertFromCATransitionTypedddd(_ input: CATransitionType) -> String {
    struct DefaultStruct {
        static let noname = "string"
    }
    return input.rawValue
}



extension UIImage {
    
    func updateImageOrientionUpSide() -> UIImage? {
        struct DefaultStruct {
            static let noname = "string"
        }
        if self.imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        }
        UIGraphicsEndImageContext()
        return nil
    }
}


// MARK: UICOLOR
extension UIColor {
    static var backgroundDark = UIColor(red: 36/256, green: 16/256, blue: 10/256, alpha: 1.0)
    
    static var darkOrange = UIColor(red: 161/256, green: 61/256, blue: 28/256, alpha: 1.0)
    
    static var nativeOrange = UIColor(red: 235/256, green: 120/256, blue: 37/256, alpha: 1.0)
    
    static var brown = UIColor(red: 70/256, green: 31/256, blue: 18/256, alpha: 1.0)
    
    static var softBrown = UIColor(red: 189/256, green: 110/256, blue: 84/256, alpha: 1.0)
    
    static var violet = UIColor(red: 63/256, green: 63/256, blue: 140/256, alpha: 1.0)
}
