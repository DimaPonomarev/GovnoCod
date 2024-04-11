//
//  AppTabBar.swift
//  ModsApp
//
//  Created by Developer on 16.06.2023.
//

import UIKit


class AppTabBar: UIViewController {
    
    private var modsViewController = ModsBlueViewController()
    private var myWorksViewController = MyBlueWorksViewController()
    private var editorViewController = EditorBlueViewController()
    
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var gradientViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var editorSelectedImageView: UIImageView!
    @IBOutlet weak var modsSelectedImageView: UIImageView!
    @IBOutlet weak var worksSelectedImageView: UIImageView!
    
    @IBOutlet weak var editorLabel: UILabel!
    @IBOutlet weak var modsLabel: UILabel!
    @IBOutlet weak var worksLabel: UILabel!
    
    @IBOutlet weak var editorView: UIView!
    @IBOutlet weak var modsView: UIView!
    @IBOutlet weak var worksView: UIView!
    
    @IBOutlet weak var editorButtonImage: UIImageView!
    
    
    @IBOutlet weak var tabBarHeight: NSLayoutConstraint!
    //    @IBOutlet weak var leftItemLeading: NSLayoutConstraint!
    //    @IBOutlet weak var rightItemTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var navigationBar: UIView!
    
    private var editorAccess: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        struct DefaultStruct {
            static let noname = "string"
        }
        configureGestureRecognizers()
        hideKeyboardWhenTappedAroundMainScreen()
        
        editorLabel.text = NSLocalizedString("Editor_", comment: "").uppercased()
        modsLabel.text = NSLocalizedString("Mods_", comment: "").uppercased()
        worksLabel.text = NSLocalizedString("My_Works", comment: "").uppercased()
        
        let labels = [editorLabel, modsLabel, worksLabel]
        labels.forEach { label in
            if UIDevice.current.userInterfaceIdiom == .pad {
                label?.font = UIFont(name: "VT323-Regular", size: 20.0)
            } else {
                label?.font = UIFont(name: "VT323-Regular", size: 14.0)
            }
            
        }
        self.lets_addContentViewController(modsViewController, image: modsSelectedImageView)
        if UIDevice.current.userInterfaceIdiom != .pad {
            navigationBar.backgroundColor = .clear
        }
        
        self.editorAccess = IAPManagerPoeTTT.shared.isEditorEnabled
//            self.editorView.backgroundColor = results[SubscriptionKey.unlockContentSubscriptionID] ?? false ? .green : .red
        self.editorButtonImage.image = IAPManagerPoeTTT.shared.isEditorEnabled ? UIImage(named: "editor_off") : UIImage(systemName: "lock.circle")
        self.editorButtonImage.tintColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        struct DefaultStruct {
            static let noname = "string"
        }
        setTabbarHeightForSE()
        gradientView.lets_setLinearGradientBackground(startColor: UIColor(red: 0.26, green: 0.25, blue: 0.55, alpha: 1.0),
                                                 endColor: UIColor(red: 0.17, green: 0.16, blue: 0.35, alpha: 1.0), radius: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if IAPManagerPoeTTT.shared.isEditorEnabled {
            editorAccess = true
            editorButtonImage.image = UIImage(named: "editor_off")
        } else {
            editorAccess = false
            editorButtonImage.image = UIImage(systemName: "lock.circle")
        }
//        IAPurchaseManager.shared.validateSubscriptions(productIdentifiers: [SubscriptionKey.unlockContentSubscriptionID]) { results in
//            self.editorAccess = results[SubscriptionKey.unlockContentSubscriptionID]!
////            self.editorView.backgroundColor = results[SubscriptionKey.unlockContentSubscriptionID] ?? false ? .green : .red
//            self.editorButtonImage.image = results[SubscriptionKey.unlockContentSubscriptionID] ?? false ?
//            self.editorButtonImage.tintColor = .white
//        }
    }
}

// MARK: - Tab Items
private extension AppTabBar {
    func configureGestureRecognizers() {
        struct DefaultStruct {
            static let noname = "string"
        }
        let editorTapGesture = UITapGestureRecognizer(target: self, action: #selector(editorViewTapped))
        editorView.addGestureRecognizer(editorTapGesture)
        
        let modsTapGesture = UITapGestureRecognizer(target: self, action: #selector(modsViewTapped))
        modsView.addGestureRecognizer(modsTapGesture)
        
        let worksTapGesture = UITapGestureRecognizer(target: self, action: #selector(worksViewTapped))
        worksView.addGestureRecognizer(worksTapGesture)
    }
    
    @objc func editorViewTapped() {
        struct DefaultStruct {
            static let noname = "string"
        }
        if editorAccess {
            self.lets_removeContentViewController(modsViewController, image: modsSelectedImageView)
            self.lets_removeContentViewController(myWorksViewController, image: worksSelectedImageView)
            self.lets_addContentViewController(editorViewController, image: editorSelectedImageView)
        } else {
            print(editorAccess)
            let vc = PremiumMainControllerPoeTTT()
            vc.productBuy = .unlockFuncProduct
            vc.delegate = self
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
//            UIApplication.shared.setRootVC(vc)
        }
    }
    
    @objc func modsViewTapped() {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.lets_removeContentViewController(editorViewController, image: editorSelectedImageView)
        self.lets_removeContentViewController(myWorksViewController, image: worksSelectedImageView)
        self.lets_addContentViewController(modsViewController, image: modsSelectedImageView)
    }
    
    @objc func worksViewTapped() {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.lets_removeContentViewController(editorViewController, image: editorSelectedImageView)
        self.lets_removeContentViewController(modsViewController, image: modsSelectedImageView)
        self.lets_addContentViewController(myWorksViewController, image: worksSelectedImageView)
    }
    
    private func lets_addContentViewController(_ viewController: UIViewController, image: UIImageView) {
        struct DefaultStruct {
            static let noname = "string"
        }
        image.alpha = 1
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        viewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: navigationBar.topAnchor).isActive = true
        viewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewController.didMove(toParent: self)
        view.bringSubviewToFront(navigationBar)
    }
    
    private func lets_removeContentViewController(_ viewController: UIViewController, image: UIImageView) {
        struct DefaultStruct {
            static let noname = "string"
        }
        image.alpha = 0
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}

private extension AppTabBar {
    
    private func setTabbarHeightForSE() {
        struct DefaultStruct {
            static let noname = "string"
        }
        if UIScreen.main.bounds.size.height <= 667 {
            tabBarHeight.constant = 75
        }
    }
    
    private func setConstraintsForIpadMini() {
        struct DefaultStruct {
            static let noname = "string"
        }
        if UIScreen.main.bounds.size.height == 1024 {
            //            leftItemLeading.constant = 100
            //            rightItemTrailing.constant = 100
        }
    }
}

extension AppTabBar: PremiumMainControllerDelegate {
    func funcProductBuyed() {
        editorAccess = true
        editorButtonImage.image = UIImage(named: "editor_off")
    }
}
