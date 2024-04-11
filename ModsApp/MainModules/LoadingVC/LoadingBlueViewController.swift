//
//  LoadingViewController11111.swift
//  ModsApp
//
//  Created by David on 26.04.2023.
//

import UIKit

class LoadingBlueViewController: UIViewController {
    
//    @IBOutlet weak var loadingLabel: UILabel!
//    @IBOutlet weak var progressView: UIProgressView!
    private let loadingLabel = UILabel()
    private let progressView = UIProgressView()
    private var isDropBoxReady = false
    private var isCheckedSubs = false
    private var realmDataBase = CoreDataBase.shared
    private var localDataBase = LocalDataOnThisApp.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLoadingLabel()
        makeProgressView()
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_zetupka_UI()
        DropBoxBeautifulManager.shared.installDropBox()
        NotificationCenter.default.addObserver(self, selector: #selector(dropDidFinishDownloading), name: Notification.Name("dropBoxIsReady"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_animateBloodyLoader()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        struct DefaultStruct {
            static let noname = "string"
        }
        print("🌀 \(String(describing: type(of: self)))")
    }
    
    override func viewDidLayoutSubviews() {
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_setGradient()
        progressView.layer.borderWidth = 3
        progressView.layer.borderColor = UIColor.white.cgColor        
    }
    
    private func makeProgressView() {

        view.addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(28)
            $0.top.equalTo(loadingLabel.snp.bottom).offset(35)
        }
    }
    
    private func makeLoadingLabel() {
        loadingLabel.textColor = .white
        view.addSubview(loadingLabel)
        loadingLabel.textAlignment = .center
        
        loadingLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }

    
    @objc private func dropDidFinishDownloading() {
        isDropBoxReady = true
        if isCheckedSubs && presentedViewController == nil {
            showContent()
        }
    }
    
    private func lets_animateBloodyLoader() {
        struct DefaultStruct {
            static let noname = "string"
        }
        let gradientImage = UIImage.gradientImage(with: progressView.frame,
            colors: [  UIColor(red: 0.345, green: 0.345, blue: 0.708, alpha: 1).cgColor,
                       UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor,
                       UIColor(red: 0.345, green: 0.345, blue: 0.71, alpha: 1).cgColor,
                       UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor,
                       UIColor(red: 0.345, green: 0.345, blue: 0.71, alpha: 1).cgColor,
                       UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor,
                       UIColor(red: 0.345, green: 0.345, blue: 0.71, alpha: 1).cgColor,
                       UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor,
                       UIColor(red: 0.345, green: 0.345, blue: 0.71, alpha: 1).cgColor ],
            locations: nil)
        
        progressView.progressImage = gradientImage!
        progressView.layer.cornerRadius = 10
        UIView.animate(withDuration: 1) { [weak self] in
            self?.progressView.setProgress(1.0, animated: true)
        } completion: { _ in
            if self.progressView.progress == 1.0 {
                // Progress completed
                if ContentMagicUnLocker.shared.isLostConnection == true {
                    ContentMagicUnLocker.shared.isLostConnection = false
                }
                //                IAPManagerPoeTTT.shared.validateSubscriptions(productIdentifiers: [Configurations.unlockContentSubscriptionID,Configurations.unlockFuncSubscriptionID,Configurations.unlockContentSubscriptionID]) { results in
                
                self.isCheckedSubs = true
                if IAPManagerPoeTTT.shared.productBuyes.contains(.unlockFuncProduct) {
                    IAPManagerPoeTTT.shared.isEditorEnabled = true
                }
                if IAPManagerPoeTTT.shared.productBuyes.contains(.unlockFuncProduct) {
                    IAPManagerPoeTTT.shared.isRemoveAddBought = true
                }
                if self.isDropBoxReady && self.presentedViewController == nil {
                    self.showContent()
                }
            }
        }
    }
    
    private func lets_zetupka_UI() {
        struct DefaultStruct {
            static let noname = "string"
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            loadingLabel.font = UIFont(name: "VT323-Regular", size: 72)
        } else {
            loadingLabel.font = UIFont(name: "VT323-Regular", size: 24)
        }
        loadingLabel.textColor = UIColor.white
        loadingLabel.text = NSLocalizedString("LOADING...", comment: "")
    }
    
    private func lets_setGradient() {
        struct DefaultStruct {
            static let noname = "string"
        }
        let color = UIColor(red: 0.004, green: 0, blue: 0.213, alpha: 1)

        self.lets_setLinearGradientBackground(startColor: color,
                                              endColor: color)
    }
    
    private func lets_convertData() {
        struct DefaultStruct {
            static let noname = "string"
        }
        var categories: [CategoryRealmModelElement] = []
        var mods: [ModRealmModelElement] = []
        var editorItems: [EditorItemRealmModelElement] = []
        DispatchQueue.main.async { [self] in
            CoreDataBase.shared.categories.forEach { category in
                categories.append(category)
            }
            localDataBase.categories = categories.sorted(by: {$0.categoryName < $1.categoryName})
            
            CoreDataBase.shared.mods.forEach { mod in
                mods.append(mod)
            }
            localDataBase.mods = mods.sorted(by: {$0.id < $1.id})
            
            CoreDataBase.shared.editorItems.forEach { editItem in
                editorItems.append(editItem)
            }
            localDataBase.editorItems = editorItems.sorted(by: {$0.id < $1.id})
        }
    }
    
    @objc private func showContent() {
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_convertData()
        DispatchQueue.main.async { [self] in
            progressView.progress = 1.0
            UIView.animate(withDuration: 1) { [weak self] in
                self?.view.layoutIfNeeded()
            } completion: { [weak self] _ in
                if self?.progressView.progress == 1.0 {
                    let tabBar = AppTabBar()
                    self?.navigationController?.pushViewController(tabBar, animated: true)
                }
            }
        }
    }
}


fileprivate extension UIImage {
    static func gradientImage(with bounds: CGRect,
                              colors: [CGColor],
                              locations: [NSNumber]?) -> UIImage? {
        struct DefaultStruct {
            static let noname = "string"
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        // This makes it horizontal
        gradientLayer.locations = [0, 0.13, 0.25, 0.39, 0.49, 0.63, 0.76, 0.88, 1]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.cornerRadius = 10
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.9, b: 3.03, c: -20.2, d: 387.83, tx: 10.13, ty: -194.48))



        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
}
