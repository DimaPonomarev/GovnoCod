

import UIKit

class TextureAppView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var loadLabel: UILabel!
    @IBOutlet weak var pixelLabel: UILabel!
    @IBOutlet weak var pixelCount: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var slider: GradientSlider!
    @IBOutlet weak var loadButton: UIButton!
    
    
    weak var delegate: LetsOpenImagePickerDelegate?
    var mainEditorVC: EditorBlueDetailViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        lets_nibBloodySetup()
        struct DefaultStruct {
            static let noname = "string"
        }
    }
    
    init(frame: CGRect, vc: EditorBlueDetailViewController) {
        super.init(frame: frame)
        self.mainEditorVC = vc
        lets_nibBloodySetup()
        struct DefaultStruct {
            static let noname = "string"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        lets_nibBloodySetup()
        struct DefaultStruct {
            static let noname = "string"
        }
    }
    
    private func lets_loadViewFromBloodyNibulon() -> UIView {
        struct DefaultStruct {
            static let noname = "string"
        }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    
    private func lets_nibBloodySetup() {
        struct DefaultStruct {
            static let noname = "string"
        }
        contentView = lets_loadViewFromBloodyNibulon()
        contentView.backgroundColor = .clear
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = true
        addSubview(contentView)
        
        imageContainerView.layer.borderWidth = 2
        imageContainerView.layer.borderColor = UIColor.white.cgColor
        imageContainerView.layer.cornerRadius = 10
        loadButton.layer.cornerRadius = 10
        
        lets_setupBloodySomethibng()
    }
    
    private func lets_setupBloodySomethibng() {
        struct DefaultStruct {
            static let noname = "string"
        }
        slider.setThumbImage(UIImage(), for: .normal)
        slider.setThumbImage(UIImage(), for: .highlighted)
//        slider.setThumbImage(UIImage(named: "sliderImg"), for: .normal)
//        slider.setThumbImage(UIImage(named: "sliderImg"), for: .highlighted)
 
        mainEditorVC?.updateTextureImageDelegate = self
 
        containerView.backgroundColor = .clear
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.cornerRadius = 10
        
        [loadLabel, pixelLabel, pixelCount].forEach { label in
            if UIDevice.current.userInterfaceIdiom == .pad {
                label.font = UIFont(name: "VT323-Regular", size: 40)
            } else {
                label.font = UIFont(name: "VT323-Regular", size: 20)
            }
            label.textColor = .white
        }
        
        loadLabel.text = NSLocalizedString("load_texture", comment: "")
        
        let attributedString_privacyB = NSAttributedString(string: "LOAD", attributes: [NSAttributedString.Key.font: UIFont(name: "VT323-Regular", size: 20) as Any, NSAttributedString.Key.foregroundColor: UIColor.black])
        loadButton.setAttributedTitle(attributedString_privacyB, for: .normal)
        
        pixelLabel.textColor = UIColor.white
        pixelCount.text = EditorCustomManager.shared.newItem.pixelValue + "PX"
        DispatchQueue.main.async { [self] in
            slider.value = Float(EditorCustomManager.shared.newItem.pixelValue) ?? 0
            slider.setValue(Float(EditorCustomManager.shared.newItem.pixelValue) ?? 0, animated: true)
        }
        
        slider.minimumValue = 0
        slider.maximumValue = 1000
        slider.isContinuous = true
        
        slider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
        
        lets_setupBloodySettings(item: EditorCustomManager.shared.newItem)
    }
    
    @objc func sliderValueDidChange(_ sender:UISlider!) {
        struct DefaultStruct {
            static let noname = "string"
        }
        pixelCount.text = "\(sender.value)" + "PX"
        EditorCustomManager.shared.newItem.pixelValue = "\(slider.value)"
    }
    
    @IBAction func loadButtonTapped(_ sender: Any) {
        struct DefaultStruct {
            static let noname = "string"
        }
        PermissionForGalleryManager.shared.lets_permissionToGallery { access in
            print("openGalerry in Texture", access)
            if access {
                self.delegate?.lets_openImagePicker(type: .textureImage)
            } else {
                self.delegate?.lets_openSettings()
            }
        }
    }
    
    private func lets_setupBloodySettings(item: ForEditorItem) {
        struct DefaultStruct {
            static let noname = "string"
        }
        if item.iconData.count == 0 {
            image.image = UIImage(data: item.imageData)
        } else {
            image.contentMode = .scaleAspectFit
            image.image = UIImage(data: item.imageData)
        }
        
    }
}

extension TextureAppView: LetsUpdateImageOnTextureView {
    
    func lets_updateTextureImage(imageData: Data) {
        struct DefaultStruct {
            static let noname = "string"
        }
        print("image picker texture delegate")
//        if image.image?.accessibilityIdentifier != "imagePlaceholder" {
//            image.contentMode = .scaleAspectFit
//            imageContainerView.backgroundColor = .clear
//        }
        
        image.image = UIImage(data: imageData)
    }
}


















@IBDesignable
class GradientSlider: UISlider {
    
    private let expandedTouchArea: CGFloat = 30 // Adjust this value as needed to expand the touch area
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let largerBounds = bounds.insetBy(dx: -expandedTouchArea, dy: -expandedTouchArea)
        return largerBounds.contains(point) ? self : super.hitTest(point, with: event)
    }
    
    @IBInspectable var thickness: CGFloat = 15 {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var sliderThumbImage: UIImage? {
        didSet {
            setup()
        }
    }
    
    func setup() {
        let minTrackStartColor = UIColor(named: "Rhino")
        let minTrackEndColor = UIColor(named: "CornflowerBlue")
        let maxTrackColor = UIColor.white
        do {
            if let startCGColor = minTrackStartColor?.cgColor,
               let endCGColor = minTrackEndColor?.cgColor {
                self.setMinimumTrackImage(try self.gradientImage(
                    size: self.trackRect(forBounds: UIScreen.main.bounds).size,
                    colorSet: [startCGColor, endCGColor]),
                                          for: .normal)
            }
            self.setMaximumTrackImage(try self.gradientImage(
                size: self.trackRect(forBounds: self.bounds).size,
                colorSet: [maxTrackColor.cgColor, maxTrackColor.cgColor]),
                                      for: .normal)
            //self.setThumbImage(sliderThumbImage, for: .normal)
        } catch {
            self.minimumTrackTintColor = UIColor(named: "Rhino")
            self.maximumTrackTintColor = UIColor.white
        }

        self.thumbTintColor = .clear
    }
    
    func gradientImage(size: CGSize, colorSet: [CGColor]) throws -> UIImage? {
        let tgl = CAGradientLayer()
        tgl.frame = CGRect.init(x:0, y:0, width:size.width, height: size.height)
        tgl.cornerRadius = tgl.frame.height / 2
        tgl.masksToBounds = false
        tgl.colors = colorSet
        tgl.startPoint = CGPoint.init(x:0.0, y:0.5)
        tgl.endPoint = CGPoint.init(x:1.0, y:0.5)
        
        UIGraphicsBeginImageContextWithOptions(size, tgl.isOpaque, 0.0);
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        tgl.render(in: context)
        let image =
        
        UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets:
                                                                        UIEdgeInsets.init(top: 0, left: size.height, bottom: 0, right: size.height))
        UIGraphicsEndImageContext()
        return image!
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(
            x: bounds.origin.x,
            y: bounds.origin.y,
            width: bounds.width,
            height: thickness * 0.5
        )
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
