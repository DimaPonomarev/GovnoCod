//
//  EditorViewC0ntroller.swift
//  ModsApp
//
//  Created by David on 25.04.2023.
//

import UIKit
//

extension EditorBlueViewController: PremiumMainControllerDelegate {
    func funcProductBuyed() {
        adImage.isHidden = true
        collectionView.topAnchor.constraint(equalTo: optionsStack.bottomAnchor).isActive = true
    }
}

class EditorBlueViewController: UIViewController {
    
    enum TemplateTypes: Int {
        case misc
        case living
    }
    
    @IBOutlet weak var optionsStack: UIStackView!
    @IBOutlet weak var adImage: UIImageView!
    @IBOutlet weak var leftImg: UIImageView!
    @IBOutlet weak var rightImg: UIImageView!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leeftItemView: UIView!
    @IBOutlet weak var leftItemLabel: UILabel!
    @IBOutlet weak var rightItemView: UIView!
    @IBOutlet weak var rightItemLabel: UILabel!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    private var fontSize = 20
    private var localDB: [EditorItemRealmModelElement] = []
    private var currCateg: TemplateTypes = .misc
    
    override func viewDidLoad() {
        super.viewDidLoad()
        struct DefaultStruct {
            static let noname = "string"
        }
        print("🌀 \(String(describing: type(of: self)))")
        lets_zetup_UI()
        lets_zetupCollection()
        lets_getEditorItems(template: .misc)
        
        leftImg.isHidden = true
        rightImg.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPhotoAd))
        adImage.isUserInteractionEnabled = true
        adImage.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_setupBloodySegment(currCateg.rawValue)
        lets_lets_setGradient()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        struct DefaultStruct {
            static let noname = "string"
        }
//        if IAPManagerPoeTTT.shared.isRemoveAddBought {
        if IAPManagerPoeTTT.shared.productBuyes.contains(.unlockFuncProduct) {
            if IAPManagerPoeTTT.shared.productBuyes.contains(.unlockContentProduct) {
                adImage.isHidden = true
                collectionView.topAnchor.constraint(equalTo: optionsStack.bottomAnchor).isActive = true
            } else {
                adImage.image = UIImage(named: "ad2")
            }
        }
        if NetMonitor.shared.isReachable == false {
            let alert = UIAlertController(title: NSLocalizedString("noInternetConnection", comment: ""), message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
        }
    }
    
    private func lets_lets_setGradient() {
        struct DefaultStruct {
            static let noname = "string"
        }
        topImage.lets_setLinearGradientBackground(startColor: UIColor(red: 0.26, green: 0.25, blue: 0.55, alpha: 1.0),
                                             endColor: UIColor(red: 0.17, green: 0.16, blue: 0.35, alpha: 1.0))
        self.lets_setLinearGradientBackground(startColor: UIColor(red: 0.26, green: 0.25, blue: 0.55, alpha: 1.0),
                                         endColor: UIColor(red: 0.17, green: 0.16, blue: 0.35, alpha: 1.0))
    }
    
    @objc func didTapPhotoAd(_ sender: UITapGestureRecognizer) {
        let vc = PremiumMainControllerPoeTTT()
        if !IAPManagerPoeTTT.shared.productBuyes.contains(.unlockFuncProduct) {
            vc.productBuy = .unlockFuncProduct
        } else {
            vc.productBuy = .unlockContentProduct
        }
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func lets_zetup_UI() {
        
        struct DefaultStruct {
            static let noname = "string"
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            fontSize = 64
        }
        
        view.backgroundColor = .violet
        topImage.layer.cornerRadius = 10
        
        mainTitle.textColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        mainTitle.text = NSLocalizedString("Editor_", comment: "").uppercased()
        if UIDevice.current.userInterfaceIdiom == .pad {
            mainTitle.font = UIFont(name: "VT323-Regular", size: 72)
        } else {
            mainTitle.font = UIFont(name: "VT323-Regular", size: 48)
        }
        
        leftItemLabel.text = NSLocalizedString("MISC TEMPLATES", comment: "").uppercased()
        rightItemLabel.text = NSLocalizedString("LIVING TEMPLATES", comment: "").uppercased()
        [leftItemLabel, rightItemLabel].forEach { lbl in
            if UIDevice.current.userInterfaceIdiom == .pad {
                lbl?.font = UIFont(name: "VT323-Regular", size: 40)
            } else {
                lbl?.font = UIFont(name: "VT323-Regular", size: 20)
            }
            
        }
        
        lets_setupBloodyGesture()
    }
    
    
    
    private func lets_zetupCollection() {
        struct DefaultStruct {
            static let noname = "string"
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "EditBlueItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EditBlueItemCollectionViewCell")
    }
    
    private func lets_setupBloodyGesture() {
        struct DefaultStruct {
            static let noname = "string"
        }
        let leftGesture = UITapGestureRecognizer(target: self, action: #selector(lets_leftBloodyAction))
        leeftItemView.addGestureRecognizer(leftGesture)
        let rightGesture = UITapGestureRecognizer(target: self, action: #selector(lets_rightBloodyAction))
        rightItemView.addGestureRecognizer(rightGesture)
    }
    
    private func lets_setupBloodySegment(_ index: Int) {
        struct DefaultStruct {
            static let noname = "string"
        }
        leeftItemView.layer.cornerRadius = 8
        leeftItemView.layer.masksToBounds = true
        leeftItemView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        rightItemView.layer.cornerRadius = 8
        rightItemView.layer.masksToBounds = true
        rightItemView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        switch index {
        case 0:
            leftImg.isHidden = false
            rightImg.isHidden = true
            
            //            rightItemView.removeLinearGradientBackground()
            rightItemView.backgroundColor = .white
            
            leeftItemView.backgroundColor = .clear
            leeftItemView.lets_removeLinearGradientBackground()
            //            leeftItemView.setLinearGradientBackground3(startColor: UIColor(named: "Corn")!,
            //                                                       endColor: UIColor(named: "MangoTango")!,
            //                                                       radius: 8,
            //                                                       maskCorner: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
            
            rightItemLabel.textColor = UIColor(red: 44/255, green: 42/255, blue: 89/255, alpha: 1)
            leftItemLabel.textColor = UIColor.white
        case 1:
            leftImg.isHidden = true
            rightImg.isHidden = false
            
            //            leeftItemView.removeLinearGradientBackground()
            leeftItemView.backgroundColor = .white
            
            rightItemView.backgroundColor = .clear
            rightItemView.lets_removeLinearGradientBackground()
            //            rightItemView.setLinearGradientBackground3(startColor: UIColor(named: "Corn")!,
            //                                                       endColor: UIColor(named: "MangoTango")!,
            //                                                       radius: 10,
            //                                                       maskCorner: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
            
            leftItemLabel.textColor = UIColor(red: 44/255, green: 42/255, blue: 89/255, alpha: 1)
            rightItemLabel.textColor = UIColor.white
        default: print("")
        }
    }
    
    @objc private func lets_leftBloodyAction() {
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_setupBloodySegment(0)
        lets_getEditorItems(template: .misc)
    }
    
    @objc private func lets_rightBloodyAction() {
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_setupBloodySegment(1)
        lets_getEditorItems(template: .living)
    }
    
    private func lets_getEditorItems(template: TemplateTypes) {
        struct DefaultStruct {
            static let noname = "string"
        }
        currCateg = template
        switch template {
            
        case .living:
            lets_setupBloodySegment(1)
            localDB = LocalDataOnThisApp.shared.lets_getLivingTemplates()
            print("Get Living Templates")
        case .misc:
            lets_setupBloodySegment(0)
            localDB = LocalDataOnThisApp.shared.lets_getMiscTemplates()
            print("Get Misc Templates")
        }
        
        collectionView.reloadData()
    }
}

extension EditorBlueViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        struct DefaultStruct {
            static let noname = "string"
        }
        return localDB.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        struct DefaultStruct {
            static let noname = "string"
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditBlueItemCollectionViewCell", for: indexPath) as! EditBlueItemCollectionViewCell
        cell.backgroundColor = UIColor(red: 136/255, green: 133/255, blue: 210/255, alpha: 1)
        cell.lets_zetupkaTsell(localDB[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        struct DefaultStruct {
            static let noname = "string"
        }
        let detail = EditorBlueDetailViewController()
        detail.chosenObject = localDB[indexPath.row]
        detail.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detail, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        struct DefaultStruct {
            static let noname = "string"
        }
        let width = collectionView.frame.width / 3 - 10
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        struct DefaultStruct {
            static let noname = "string"
        }
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        struct DefaultStruct {
            static let noname = "string"
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        struct DefaultStruct {
            static let noname = "string"
        }
        return .init(top: 18, left: 0, bottom: 32, right: 0)
    }
    
    func lets_centerCollectionViewCell(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
        struct DefaultStruct {
            static let noname = "string"
        }
        let totalWidth = cellWidth * numberOfItems
        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
}
