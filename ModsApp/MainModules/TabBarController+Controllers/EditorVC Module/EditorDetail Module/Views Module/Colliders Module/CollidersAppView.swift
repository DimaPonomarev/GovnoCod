
import UIKit

class CollidersAppView: UIView {
    
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var labelX: UILabel!
    @IBOutlet weak var labelX2: UILabel!
    @IBOutlet weak var labelW: UILabel!
    @IBOutlet weak var labelW2: UILabel!
    
    @IBOutlet weak var xText: UITextField!
    @IBOutlet weak var yText: UITextField!
    @IBOutlet weak var widthText: UITextField!
    @IBOutlet weak var heightText: UITextField!
    
    @IBOutlet weak var eoxView: UIView!
    @IBOutlet weak var metalView: UIView!
    @IBOutlet weak var widthView: UIView!
    @IBOutlet weak var heightView: UIView!
    @IBOutlet weak var xView: UIView!
    @IBOutlet weak var yView: UIView!
    
    @IBOutlet weak var eoxButton: UIButton!
    @IBOutlet weak var metalButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        lets_nibBloodySetup()
        lets_setEoxMetalButtons()
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
    
    private func lets_setEoxMetalButtons() {
        struct DefaultStruct {
            static let noname = "string"
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            let customFont = UIFont(name: "VT323-Regular", size: 40)
            eoxButton.titleLabel?.font = customFont
            metalButton.titleLabel?.font = customFont
        } else {
            let customFont = UIFont(name: "VT323-Regular", size: 20)
            eoxButton.titleLabel?.font = customFont
            metalButton.titleLabel?.font = customFont
        }
    }
    
    @IBAction func eoxButtonTapped(_ sender: UIButton) {
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_setEoxMetalButtons()
    }
    
    @IBAction func metalButtonTapped(_ sender: UIButton) {
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_setEoxMetalButtons()
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
        view = lets_loadViewFromBloodyNibulon()
        view.backgroundColor = .clear
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
        lets_somethingBloodySetup()
    }
    
    private func lets_somethingBloodySetup() {
        struct DefaultStruct {
            static let noname = "string"
        }
        eoxButton.titleLabel?.adjustsFontSizeToFitWidth = true
        eoxButton.titleLabel?.lineBreakMode = .byClipping
        eoxButton.setTitle("EOX", for: .normal)
        
        metalButton.titleLabel?.adjustsFontSizeToFitWidth = true
        metalButton.titleLabel?.lineBreakMode = .byClipping
        metalButton.setTitle("METAL", for: .normal)
                
        let views: [UIView] = [eoxView, metalView,xView, yView, widthView, heightView]
        
        for view in views {
            view.layer.borderWidth = 2
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.cornerRadius = 10
        }
        
        
        [labelX, labelX2, labelW, labelW2].forEach { label in
            if UIDevice.current.userInterfaceIdiom == .pad {
                label.font = UIFont(name: "VT323-Regular", size: 40)
            } else {
                label.font = UIFont(name: "VT323-Regular", size: 20)
            }
            label.textColor = .white
        }
        
        
        [xText, yText, widthText, heightText].forEach { label in
            if UIDevice.current.userInterfaceIdiom == .pad {
                label.font = UIFont(name: "VT323-Regular", size: 40)
            } else {
                label.font = UIFont(name: "VT323-Regular", size: 20)
            }
            label.textColor = .white
        }
        
        xText.delegate = self
        yText.delegate = self
        widthText.delegate = self
        heightText.delegate = self
        
        xText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        yText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        widthText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        heightText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        xText.text = EditorCustomManager.shared.newItem.xValue
        yText.text = EditorCustomManager.shared.newItem.yValue
        widthText.text = EditorCustomManager.shared.newItem.widthValue
        heightText.text = EditorCustomManager.shared.newItem.heightValue
    }
    
}

extension CollidersAppView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        struct DefaultStruct {
            static let noname = "string"
        }
        switch textField {
        case xText:
            print("xText textFieldShouldBeginEditing", xText.text as Any)
        case yText:
            print("yText textFieldShouldBeginEditing", yText.text as Any)
        case widthText:
            print("widthText textFieldShouldBeginEditing", widthText.text as Any)
        case heightText:
            print("heightText textFieldShouldBeginEditing", heightText.text as Any)
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
        case xText:
            print("xText textFieldShouldBeginEditing", xText.text as Any)
            EditorCustomManager.shared.newItem.xValue = xText.text ?? ""
        case yText:
            print("yText textFieldShouldBeginEditing", yText.text as Any)
            EditorCustomManager.shared.newItem.yValue = yText.text ?? ""
        case widthText:
            print("widthText textFieldShouldBeginEditing", widthText.text as Any)
            EditorCustomManager.shared.newItem.widthValue = widthText.text ?? ""
        case heightText:
            print("heightText textFieldShouldBeginEditing", heightText.text as Any)
            EditorCustomManager.shared.newItem.heightValue = heightText.text ?? ""
        default: break
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        struct DefaultStruct {
            static let noname = "string"
        }
        switch textField {
        case xText:
            if xText.isFirstResponder {
                EditorCustomManager.shared.newItem.xValue = xText.text ?? ""
            }
        case yText:
            if yText.isFirstResponder {
                EditorCustomManager.shared.newItem.yValue = yText.text ?? ""
            }
        case widthText:
            if widthText.isFirstResponder {
                EditorCustomManager.shared.newItem.widthValue = widthText.text ?? ""
            }
        case heightText:
            if heightText.isFirstResponder {
                EditorCustomManager.shared.newItem.heightValue = heightText.text ?? ""
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
