

import UIKit

class SettingsAppView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loadIconLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var enterNameView: UIView!
    @IBOutlet weak var enterName: UITextField!
    @IBOutlet weak var typeTitle: UITextField!
    @IBOutlet weak var categoryTitle: UITextField!
    @IBOutlet weak var loadButton: UIButton!
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var viewForImage: UIView!
    
    weak var delegate: LetsOpenImagePickerDelegate?
    
    var mainEditorVC: EditorBlueDetailViewController?
    
    init(frame: CGRect, vc: EditorBlueDetailViewController) {
        super.init(frame: frame)
        self.mainEditorVC = vc
        lets_nib_zetupka_()
        lets_setupUI()
        struct DefaultStruct {
            static let noname = "string"
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        lets_nib_zetupka_()
        lets_setupUI()
        struct DefaultStruct {
            static let noname = "string"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        lets_nib_zetupka_()
        lets_setupUI()
        struct DefaultStruct {
            static let noname = "string"
        }
    }
    
    func lets_setupUI() {
        struct DefaultStruct {
            static let noname = "string"
        }
        let views: [UIView] = [nameView, typeView, categoryView]
        for view in views {
//            view.setLinearGradientBackground(startColor: UIColor(red: 0.26, green: 0.25, blue: 0.55, alpha: 1.0),
//                                             endColor: UIColor(red: 0.17, green: 0.16, blue: 0.35, alpha: 1.0), radius: 10)
            view.layer.borderWidth = 2
            view.layer.masksToBounds = true
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.cornerRadius = 10
            view.clipsToBounds = true
        }
        
        viewForImage.layer.cornerRadius = 10
        viewForImage.layer.borderColor = UIColor.white.cgColor
        viewForImage.layer.borderWidth = 2
        image.layer.cornerRadius = 10
        
        enterNameView.layer.cornerRadius = 10
        enterNameView.clipsToBounds = true
        
        loadButton.layer.cornerRadius = 10
        
        let attributedString_privacyB = NSAttributedString(string: "LOAD", attributes: [NSAttributedString.Key.font: UIFont(name: "VT323-Regular", size: 20) as Any, NSAttributedString.Key.foregroundColor: UIColor.black])
        loadButton.setAttributedTitle(attributedString_privacyB, for: .normal)
        
        //scrollView.shouldIgnoreScrollingAdjustment = true
//        scrollView.isScrollEnabled = false
    }
    
    @IBAction func openGallery(_ sender: Any) {
        struct DefaultStruct {
            static let noname = "string"
        }
        PermissionForGalleryManager.shared.lets_permissionToGallery { access in
            print("openGalerry in Settings", access)
            if access {
                self.delegate?.lets_openImagePicker(type: .iconImage)
            } else {
                self.delegate?.lets_openSettings()
            }
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
    
    private func lets_nib_zetupka_() {
        struct DefaultStruct {
            static let noname = "string"
        }
        view = lets_loadViewFromBloodyNibulon()
        view.backgroundColor = .clear
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
        lets_setupSomething()
    }
    
    private func lets_setupSomething() {
        struct DefaultStruct {
            static let noname = "string"
        }
        mainEditorVC?.updateImageDelegate = self
        
        [nameLabel, loadIconLabel, typeLabel, categoryLabel].forEach { label in
            if UIDevice.current.userInterfaceIdiom == .pad {
                label.font = UIFont(name: "VT323-Regular", size: 40)
            } else {
                label.font = UIFont(name: "VT323-Regular", size: 20)
            }
            label.textColor = UIColor.white
        }
        
        [enterName, typeTitle, categoryTitle].forEach { text in
            if UIDevice.current.userInterfaceIdiom == .pad {
                text.font = UIFont(name: "VT323-Regular", size: 40)
            } else {
                text.font = UIFont(name: "VT323-Regular", size: 20)
            }
        }
        
        enterName.delegate = self
        typeTitle.delegate = self
        categoryTitle.delegate = self
        enterName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        typeTitle.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        categoryTitle.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        lets_setupBloodySettings(item: EditorCustomManager.shared.newItem)
    }
    
    private func lets_setupBloodySettings(item: ForEditorItem) {
        struct DefaultStruct {
            static let noname = "string"
        }
        categoryTitle.text = item.category
        typeTitle.text = item.type
        enterName.text = item.name
        
        if item.iconData.count == 0 {
            image.image = UIImage(data: item.imageData)
        } else {
            image.contentMode = .scaleAspectFit
            image.image = UIImage(data: item.iconData)
        }
    }
}


extension SettingsV: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        struct DefaultStruct {
            static let noname = "string"
        }
        switch textField {
        case enterName:
            print("enterName textFieldShouldBeginEditing", enterName.text as Any)
        case typeTitle:
            print("typeTitle textFieldShouldBeginEditing", typeTitle.text as Any)
        case categoryTitle:
            print("categoryTitle textFieldShouldBeginEditing", categoryTitle.text as Any)
        default: break
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        struct DefaultStruct {
            static let noname = "string"
        }
        guard let outputText = textField.text else { return }
        switch textField {
        case enterName:
            print("enterName textFieldDidEndEditing", enterName.text as Any)
            EditorCustomManager.shared.newItem.name = enterName.text ?? ""
        case typeTitle:
            print("typeTitle textFieldDidEndEditing", typeTitle.text as Any)
            EditorCustomManager.shared.newItem.type = typeTitle.text ?? ""
        case categoryTitle:
            print("categoryTitle textFieldDidEndEditing", categoryTitle.text as Any)
            EditorCustomManager.shared.newItem.category = categoryTitle.text ?? ""
        default: break
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        struct DefaultStruct {
            static let noname = "string"
        }
        switch textField {
        case enterName:
            if enterName.isFirstResponder {
                EditorCustomManager.shared.newItem.name = enterName.text ?? ""
            }
            if enterName.text == "" || enterName.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
                enterNameView.layer.borderWidth = 2
                enterNameView.layer.borderColor = UIColor.systemRed.cgColor
            } else {
                enterNameView.layer.borderWidth = 0
                enterNameView.layer.borderColor = UIColor.white.cgColor
            }
        case typeTitle:
            if typeTitle.isFirstResponder {
                EditorCustomManager.shared.newItem.type = typeTitle.text ?? ""
            }
        case categoryTitle:
            if categoryTitle.isFirstResponder {
                EditorCustomManager.shared.newItem.category = categoryTitle.text ?? ""
            }
        default: break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        struct DefaultStruct {
            static let noname = "string"
        }
        textField.resignFirstResponder()
        return true
    }
}

typealias SettingsV = SettingsAppView
extension SettingsV: LetsUpdateImageOnSettingsView {
    func lets_updateImage(imageData: Data) {
        struct DefaultStruct {
            static let noname = "string"
        }
        if image.image?.accessibilityIdentifier != "imagePlaceholder" {
            image.contentMode = .scaleAspectFit
            viewForImage.backgroundColor = .clear
        }
        
        image.image = UIImage(data: imageData)
    }
}
