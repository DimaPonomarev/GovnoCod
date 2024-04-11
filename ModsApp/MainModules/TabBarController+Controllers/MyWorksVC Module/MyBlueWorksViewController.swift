

import UIKit

extension MyBlueWorksViewController: PremiumMainControllerDelegate {
    func funcProductBuyed() {
        adImage.isHidden = true
        emptyView.topAnchor.constraint(equalTo: topImage.bottomAnchor).isActive = true
    }
}

class MyBlueWorksViewController: UIViewController {
    
    @IBOutlet weak var adImage: UIImageView!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var empView: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    private var localDB = LocalDataOnThisApp.shared
    private var realmDataBase = CoreDataBase.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_lets_zetupka_UI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPhotoAd))
        adImage.isUserInteractionEnabled = true
        adImage.addGestureRecognizer(tapGesture)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_lets_setGradient()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        struct DefaultStruct {
            static let noname = "string"
        }
        if IAPManagerPoeTTT.shared.productBuyes.contains(.unlockFuncProduct) {
            if IAPManagerPoeTTT.shared.productBuyes.contains(.unlockContentProduct) {
                adImage.isHidden = true
                emptyView.topAnchor.constraint(equalTo: topImage.bottomAnchor).isActive = true
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
        
        lets_updateBlueSavedData()
        
        print("🌀 \(String(describing: type(of: self)))")
    }
    
    
    
    private func lets_updateBlueSavedData() {
        struct DefaultStruct {
            static let noname = "string"
        }
        var editorItemsLocal: [EditorItemLocalRealmModelElement] = []
        DispatchQueue.main.async { [self] in
            CoreDataBase.shared.editorItemsLocal.forEach { editItem in
                editorItemsLocal.append(editItem)
            }
            localDB.editorItemsSaved = editorItemsLocal.sorted(by: {$0.idInt > $1.idInt})
            if localDB.editorItemsSaved.count != 0 {
                empView.isHidden = true
                emptyLabel.isHidden = true
            }
            
            collectionView.reloadData()
        }
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
    
    private func lets_setupBlueCollection() {
        struct DefaultStruct {
            static let noname = "string"
        }
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MyWorksCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyWorksCollectionViewCell")
    }
    
    private func lets_lets_zetupka_UI() {
        struct DefaultStruct {
            static let noname = "string"
        }
        view.backgroundColor = .violet
        topImage.layer.cornerRadius = 10
        
        emptyLabel.text = NSLocalizedString("emptyLabel", comment: "")
        if UIDevice.current.userInterfaceIdiom == .pad {
            mainTitle.font = UIFont(name: "VT323-Regular", size: 72)
            emptyLabel.font = UIFont(name: "VT323-Regular", size: 44)
        } else {
            mainTitle.font = UIFont(name: "VT323-Regular", size: 48)
            emptyLabel.font = UIFont(name: "VT323-Regular", size: 38)
        }
        emptyLabel.textColor = UIColor.white
        mainTitle.textColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        mainTitle.text = NSLocalizedString("My_Works", comment: "").uppercased()
        lets_setupBlueCollection()
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
    
}

extension MyBlueWorksViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        struct DefaultStruct {
            static let noname = "string"
        }
        return localDB.editorItemsSaved.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        struct DefaultStruct {
            static let noname = "string"
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyWorksCollectionViewCell", for: indexPath) as! MyWorksCollectionViewCell
        cell.lets_setupCell(localDB.editorItemsSaved[indexPath.row])
        cell.titleLabel.text = localDB.editorItemsSaved[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        struct DefaultStruct {
            static let noname = "string"
        }
        let detail = EditorBlueDetailViewController()
        detail.chosenObjectLocal = localDB.editorItemsSaved[indexPath.row]
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
    
    func centerCollectionViewCell(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
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
