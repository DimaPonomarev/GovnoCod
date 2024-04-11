

import UIKit

protocol CustomModsAlertBloodyProtocolDelegate: AnyObject {
    func lets_makeAction(type: AlertCustomBlueType)
    func lets_closeThisAlert()
}

enum AlertCustomBlueType {
    case subscription, watchVideo
}

class SubscriptionAlertBlueView: UIView {
    
    @IBOutlet weak var heavyMetalView: UIView!
    @IBOutlet var view: UIView!
    @IBOutlet weak var alertTitle: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var centralImage: UIImageView!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var actionViewContainer: UIView!
    @IBOutlet weak var actionImage: UIImageView!
    @IBOutlet weak var actionTitle: UILabel!
    @IBOutlet weak var topTitleView: UIView!
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var rightLabelConstraint: NSLayoutConstraint!
    
    private var viewType: AlertCustomBlueType = .subscription
    weak var alertDelegate: CustomModsAlertBloodyProtocolDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        lets_nib_zetup_()
        struct DefaultStruct {
            static let noname = "string"
        }
    }

    init(viewType: AlertCustomBlueType, frame: CGRect) {
        super.init(frame: frame)
        self.viewType = viewType
        lets_nib_zetup_()
        struct DefaultStruct {
            static let noname = "string"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        lets_nib_zetup_()
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
    
    private func lets_nib_zetup_() {
        struct DefaultStruct {
            static let noname = "string"
        }
        view = lets_loadViewFromBloodyNibulon()
        view.backgroundColor = .clear
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
        lets_zetup_()
    }
    
    private func lets_zetup_() {
        struct DefaultStruct {
            static let noname = "string"
        }

        let tapAction = UITapGestureRecognizer(target: self, action: #selector(lets_mainCustomBloodyAction))
        actionViewContainer.addGestureRecognizer(tapAction)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            rightLabelConstraint.constant = 56
        } else {
            rightLabelConstraint.constant = 16
        }
        
        mainContentView.layer.cornerRadius = 24
        heavyMetalView.layer.cornerRadius = 24
        topTitleView.layer.cornerRadius = 24
        topTitleView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        topTitleView.layer.borderColor = UIColor(named: "Rhino")?.cgColor
        topTitleView.layer.borderWidth = 2
        mainContentView.layer.borderColor = UIColor(named: "Rhino")?.cgColor
        mainContentView.layer.borderWidth = 2
        actionViewContainer.backgroundColor = .clear
        alertTitle.textColor = .white
        alertTitle.font = UIFont(name: "Troika", size: 32)
        firstLabel.textColor = .white
        firstLabel.font = UIFont(name: "Poppins-Bold", size: 16)
        descriptionTitle.textColor = .white
        descriptionTitle.font = UIFont.boldSystemFont(ofSize: 16)
        thirdLabel.textColor = .white
        thirdLabel.font = UIFont.boldSystemFont(ofSize: 16)
        actionTitle.textColor = .white
        actionTitle.font = UIFont(name: "Poppins-Bold", size: 32)
        
        switch viewType {
        case .subscription:
            centralImage.image = UIImage(named: "discount")
            actionImage.image = UIImage(named: "sale")
            alertTitle.text = NSLocalizedString("Subscription", comment: "")
            firstLabel.text = NSLocalizedString("firstLabel_s", comment: "")
            descriptionTitle.text = NSLocalizedString("descriptionTitle_s", comment: "")
            thirdLabel.text = NSLocalizedString("thirdLabel_s", comment: "")
            actionTitle.text = NSLocalizedString("actionTitle_s", comment: "").uppercased()
        case .watchVideo:
            centralImage.image = UIImage(named: "gift")
            actionImage.image = UIImage(named: "watchVideo")
            alertTitle.text = NSLocalizedString("watchVideo", comment: "")
            firstLabel.text = NSLocalizedString("firstLabel_w", comment: "")
            descriptionTitle.text = NSLocalizedString("descriptionTitle_w", comment: "")
            thirdLabel.text = NSLocalizedString("thirdLabel_w", comment: "")
            actionTitle.text = NSLocalizedString("actionTitle_w", comment: "").uppercased()
        }
    }
    
    @objc private func lets_mainCustomBloodyAction() {
        struct DefaultStruct {
            static let noname = "string"
        }
        alertDelegate?.lets_makeAction(type: viewType)
    }
    
    @IBAction func closeAlertAction(_ sender: UIButton) {
        struct DefaultStruct {
            static let noname = "string"
        }
        alertDelegate?.lets_closeThisAlert()
    }
    
}
