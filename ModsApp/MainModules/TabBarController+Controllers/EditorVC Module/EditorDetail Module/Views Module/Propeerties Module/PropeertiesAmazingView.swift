

import UIKit

class PropeertiesBlueView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet var views: [UIView]!
    @IBOutlet var lables2: [UILabel]!
    @IBOutlet var viewsButt: [UIView]!
    
    @IBOutlet weak var can1: UIButton!
    @IBOutlet weak var can2: UIButton!
    @IBOutlet weak var can3: UIButton!
    @IBOutlet weak var can4: UIButton!
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        lets_nib_zetupka_()
        struct DefaultStruct {
            static let noname = "string"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        lets_nib_zetupka_()
        struct DefaultStruct {
            static let noname = "string"
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lets_updateBloodyUI()
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
        lets_zetupka_()
    }
    
    private func lets_zetupka_() {
        struct DefaultStruct {
            static let noname = "string"
        }
        views.forEach { view in
            view.backgroundColor = .clear
            view.layer.borderWidth = 1
            view.layer.masksToBounds = true
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.masksToBounds = true
            view.layer.cornerRadius = 8
        }
        
        lables2.forEach { label in
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                label.font = UIFont(name: "VT323-Regular", size: 40)
            } else {
                label.font = UIFont(name: "VT323-Regular", size: 20)
            }
            
            label.textColor = UIColor.white
        }
 
        lets_updateBloodyUI()
 
        let btns: [UIButton] = [can1, can2, can3, can4]
        
        for button in btns {
            button.layer.cornerRadius = 10
            button.titleLabel?.textColor = .black
        }
        lets_updateBloodyUI()
    }
    
    private func lets_updateBloodyUI() {
        struct DefaultStruct {
            static let noname = "string"
        }
        if !EditorCustomManager.shared.newItem.canBeTaken {
            lets_makeDisabledBlueView(btn: can1)
        } else {
            lets_makeEnabledBlueView(btn: can1)
        }
        if !EditorCustomManager.shared.newItem.canGlow {
            lets_makeDisabledBlueView(btn: can2)
        } else {
            lets_makeEnabledBlueView(btn: can2)
        }
        if !EditorCustomManager.shared.newItem.canBurn {
            lets_makeDisabledBlueView(btn: can3)
        } else {
            lets_makeEnabledBlueView(btn: can3)
        }
        if !EditorCustomManager.shared.newItem.canFloat {
            lets_makeDisabledBlueView(btn: can4)
        } else {
            lets_makeEnabledBlueView(btn: can4)
        }
    }
    
    private func lets_makeDisabledBlueView(btn: UIButton) {
        struct DefaultStruct {
            static let noname = "string"
        }
        btn.setBackgroundImage(UIImage(), for: .normal)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = UIColor.white
        btn.titleLabel?.textColor = .black
        var font = UIFont()
        if UIDevice.current.userInterfaceIdiom == .pad {
            font = UIFont(name: "VT323-Regular", size: 40)!
        } else {
            font = UIFont(name: "VT323-Regular", size: 20)!
        }
        
        btn.setAttributedTitle(NSAttributedString(string: NSLocalizedString("Disabled", comment: "").uppercased(), attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.black]), for: .normal)
    }
    
    private func lets_makeEnabledBlueView(btn: UIButton) {
        struct DefaultStruct {
            static let noname = "string"
        }
        btn.setBackgroundImage(UIImage(named: "btnOn"), for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        
        btn.titleLabel?.textColor = .white
        var font = UIFont()
        if UIDevice.current.userInterfaceIdiom == .pad {
            font = UIFont(name: "VT323-Regular", size: 40)!
        } else {
            font = UIFont(name: "VT323-Regular", size: 20)!
        }
        
        btn.setAttributedTitle(NSAttributedString(string: NSLocalizedString("Enabled", comment: "").uppercased(), attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
    }
    
    
    @IBAction func BloodyAct1(_ sender: Any) {
        struct DefaultStruct {
            static let noname = "string"
        }
        if EditorCustomManager.shared.newItem.canBeTaken {
            EditorCustomManager.shared.newItem.canBeTaken = false
            lets_makeDisabledBlueView(btn: can1)
        } else {
            EditorCustomManager.shared.newItem.canBeTaken = true
            lets_makeEnabledBlueView(btn: can1)
        }
    }
    
    @IBAction func BloodyAct2(_ sender: Any) {
        struct DefaultStruct {
            static let noname = "string"
        }
        if EditorCustomManager.shared.newItem.canGlow {
            EditorCustomManager.shared.newItem.canGlow = false
            lets_makeDisabledBlueView(btn: can2)
        } else {
            EditorCustomManager.shared.newItem.canGlow = true
            lets_makeEnabledBlueView(btn: can2)
        }
    }
    
    @IBAction func BloodyeAct3(_ sender: Any) {
        struct DefaultStruct {
            static let noname = "string"
        }
        if EditorCustomManager.shared.newItem.canBurn {
            EditorCustomManager.shared.newItem.canBurn = false
            lets_makeDisabledBlueView(btn: can3)
        } else {
            EditorCustomManager.shared.newItem.canBurn = true
            lets_makeEnabledBlueView(btn: can3)
        }
    }
    
    @IBAction func Bloodye_act4(_ sender: Any) {
        struct DefaultStruct {
            static let noname = "string"
        }
        if EditorCustomManager.shared.newItem.canFloat {
            EditorCustomManager.shared.newItem.canFloat = false
            lets_makeDisabledBlueView(btn: can4)
        } else {
            EditorCustomManager.shared.newItem.canFloat = true
            lets_makeEnabledBlueView(btn: can4)
        }
    }
    
}


