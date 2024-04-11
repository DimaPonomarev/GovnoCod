

import UIKit


enum ImageEditorTypeEnum {
    case iconImage, textureImage
}

protocol LetsOpenImagePickerDelegate: AnyObject {
    func lets_openImagePicker(type: ImageEditorTypeEnum)
    func lets_openSettings()
}

protocol LetsUpdateImageOnSettingsView: AnyObject {
    func lets_updateImage(imageData: Data)
}

protocol LetsUpdateImageOnTextureView: AnyObject {
    func lets_updateTextureImage(imageData: Data)
}

extension EditorBlueDetailViewController: PremiumMainControllerDelegate {
    func funcProductBuyed() {
//        adImage.isHidden = true
        contentScrollView.topAnchor.constraint(equalTo: topImage.bottomAnchor).isActive = true
    }
}

class EditorBlueDetailViewController: UIViewController {
    
    enum EditorBlueViewType {
        case settingsView, collidersView, textureView, propeertiesView
    }
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var contentScrollView: UIScrollView!
//    @IBOutlet weak var adImage: UIImageView!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var modeCollectionView: UICollectionView!
    @IBOutlet weak var optionsLabel: UILabel!
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var imageHeight2: NSLayoutConstraint!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var freeViewHeight: NSLayoutConstraint!
    private var selectedIndex = 0
    
    private var firstView: SettingsAppView!
    private var secondView: CollidersAppView!
    private var thirdView: TextureAppView!
    private var fourView: PropeertiesBlueView!
    private var editorViewType: EditorBlueViewType = .settingsView
    private var editorManager = EditorCustomManager.shared
    private var realm = CoreDataBase.shared
    private var isFirstLoad = true
    var modObject: ModRealmModelElement!
    var chosenObject: EditorItemRealmModelElement?
    var chosenObjectLocal: EditorItemLocalRealmModelElement?
    
    private var imageEditorType: ImageEditorTypeEnum = .iconImage
    private var goToBack: Bool = false
    weak var updateImageDelegate: LetsUpdateImageOnSettingsView?
    weak var updateTextureImageDelegate: LetsUpdateImageOnTextureView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        struct DefaultStruct {
            static let noname = "string"
        }
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
        if UIDevice.current.userInterfaceIdiom == .phone {
            freeViewHeight.setValue(0.34, forKey: "multiplier")
        }
        hideKeyboardWhenTappedAroundMainScreen()
        lets_setupBloodyObject()
        lets_setupBloodyUI()
        lets_setupBloodyCollectionView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.lets_setupBloodyViews()
            self.lets_showBloodyView(.settingsView)
        })
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPhotoAd))
//        adImage.isUserInteractionEnabled = true
//        adImage.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowPoeTTT), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHidePoeTTT), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        struct DefaultStruct {
            static let noname = "string"
        }
        if goToBack == false {
            goToBack = true
            lets_compareItems()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        struct DefaultStruct {
            static let noname = "string"
        }
        if isFirstLoad {
            lets_lets_setGradient()
            lets_updateBloodyFrames()
        }
        isFirstLoad = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        struct DefaultStruct {
            static let noname = "string"
        }
//        if IAPManagerPoeTTT.shared.productBuyes.contains(.unlockFuncProduct) && IAPManagerPoeTTT.shared.productBuyes.contains(.unlockContentProduct) {
//            adImage.isHidden = true
            contentScrollView.topAnchor.constraint(equalTo: topImage.bottomAnchor).isActive = true
//        }
        if NetMonitor.shared.isReachable == false {
            let alert = UIAlertController(title: NSLocalizedString("noInternetConnection", comment: ""), message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
        }
        print("🌀 \(String(describing: type(of: self)))")
    }
    
    private func lets_lets_setGradient() {
        struct DefaultStruct {
            static let noname = "string"
        }
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
    
    private func lets_compareItemsBeforeCloseScreen() {
        struct DefaultStruct {
            static let noname = "string"
        }
        if firstView.enterName.text == "" || firstView.enterName.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            lets_noNameAlert()
        } else {
            editorManager.lets_compareOldNewItems { [self] isNeedToChange in
                if isNeedToChange {
                    self.lets_saveChangeAlert()
                } else {
                    self.goToBack = true
                    navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    private func lets_saveChangeAlert() {
        struct DefaultStruct {
            static let noname = "string"
        }
        DispatchQueue.main.async {
            let alert = UIAlertController(title: NSLocalizedString("saveChange", comment: ""), message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.goToBack = true
                self.lets_saveBloodyChanges()
                //self.navigationController?.popViewController(animated: true)
            }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: { _ in
                self.goToBack = true
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true)
        }
    }
    
    private func lets_noNameAlert() {
        struct DefaultStruct {
            static let noname = "string"
        }
        DispatchQueue.main.async {
            let alert = UIAlertController(title: NSLocalizedString("noName", comment: ""), message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Go Back", style: .default, handler: { _ in
                self.goToBack = true
                self.navigationController?.popViewController(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Enter Name", style: .default, handler: { _ in
                self.goToBack = false
            }))
            self.present(alert, animated: true)
        }
    }
    
    private func lets_compareItems() {
        struct DefaultStruct {
            static let noname = "string"
        }
        if firstView.enterName.text == "" || firstView.enterName.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            print("Letters", firstView.enterName.text?.trimmingCharacters(in: .whitespacesAndNewlines).count)
            lets_noNameAlert()
        } else {
            editorManager.lets_compareOldNewItems { [self] isNeedToChange in
                if isNeedToChange {
                    self.lets_saveChangeAlert()
                } else {
                    self.goToBack = true
                }
            }
        }
    }
    
    
    private func lets_makeCoppy() {
        struct DefaultStruct {
            static let noname = "string"
        }
        if let chosenObject = chosenObject {
            editorManager.oldItem = ForEditorItem(id: chosenObject.id,
                                                    name: chosenObject.name,
                                                    imageData: chosenObject.imageData,
                                                    iconData: chosenObject.imageData,
                                                    type: chosenObject.type,
                                                    category: chosenObject.category,
                                                    xValue: chosenObject.xValue,
                                                    yValue: chosenObject.yValue,
                                                    heightValue: chosenObject.heightValue,
                                                    widthValue: chosenObject.widthValue,
                                                    pixelValue: chosenObject.pixelValue,
                                                    canBeTaken: chosenObject.canBeTaken,
                                                    canGlow: chosenObject.canGlow,
                                                    canBurn: chosenObject.canBurn,
                                                    canFloat: chosenObject.canFloat)
            editorManager.newItem = editorManager.oldItem
        }
        if let chosenObjectLocal = chosenObjectLocal {
            editorManager.oldItem = ForEditorItem(id: chosenObjectLocal.id,
                                                    name: chosenObjectLocal.name,
                                                    imageData: chosenObjectLocal.imageData,
                                                    iconData: chosenObjectLocal.iconData,
                                                    type: chosenObjectLocal.type,
                                                    category: chosenObjectLocal.category,
                                                    xValue: chosenObjectLocal.xValue,
                                                    yValue: chosenObjectLocal.yValue,
                                                    heightValue: chosenObjectLocal.heightValue,
                                                    widthValue: chosenObjectLocal.widthValue,
                                                    pixelValue: chosenObjectLocal.pixelValue,
                                                    canBeTaken: chosenObjectLocal.canBeTaken,
                                                    canGlow: chosenObjectLocal.canGlow,
                                                    canBurn: chosenObjectLocal.canBurn,
                                                    canFloat: chosenObjectLocal.canFloat)
            editorManager.newItem = editorManager.oldItem
        }
        if let modObject = modObject {
            editorManager.oldItem = ForEditorItem(id: modObject.id,
                                                    name: modObject.modTitle,
                                                    imageData: modObject.modImageData,
                                                    iconData: modObject.modImageData,
                                                    type: "Mod",
                                                    category: modObject.categoryName,
                                                    xValue: "0.0",
                                                    yValue: "0.0",
                                                    heightValue: "0.0",
                                                    widthValue: "0.0",
                                                    pixelValue: "0.0",
                                                    canBeTaken: false,
                                                    canGlow: false,
                                                    canBurn: false,
                                                    canFloat: false)
            editorManager.newItem = editorManager.oldItem
            
        }
    }
    
    private func lets_setupBloodyObject() {
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_makeCoppy()
        image.image = UIImage(data: editorManager.newItem.imageData)
    }
    
    
    private func lets_setupBloodyViews() {
        struct DefaultStruct {
            static let noname = "string"
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            firstView = SettingsAppView(frame: CGRect(x: optionsView.bounds.minX, y: optionsView.bounds.minY - 25, width: optionsView.bounds.width, height: optionsView.bounds.height + 200), vc: self)
        } else if UIScreen.main.bounds.height <= 900 {
            firstView = SettingsAppView(frame: CGRect(x: optionsView.bounds.minX, y: optionsView.bounds.minY - 25, width: optionsView.bounds.width, height: optionsView.bounds.height + 200), vc: self)
        } else {
            firstView = SettingsAppView(frame: optionsView.bounds, vc: self)
        }
        if UIDevice.current.userInterfaceIdiom == .phone {
            secondView = CollidersAppView(frame: CGRect(x: optionsView.bounds.minX, y: optionsView.bounds.minY - 25, width: optionsView.bounds.width, height: optionsView.bounds.height))
        }
        else {
            secondView = CollidersAppView(frame: optionsView.bounds)
        }
        thirdView = TextureAppView(frame: optionsView.bounds, vc: self)
        fourView = PropeertiesBlueView(frame: CGRect(x: optionsView.bounds.minX, y: optionsView.bounds.minY, width: optionsView.bounds.width, height: optionsView.bounds.height - 25))
        
        firstView.delegate = self
        thirdView.delegate = self
    }
    
    private func lets_updateBloodyFrames() {
        struct DefaultStruct {
            static let noname = "string"
        }
        [firstView, secondView, thirdView, fourView].forEach { view in
            view?.frame = optionsView.bounds
        }
    }
    
    private func lets_showBloodyView(_ type: EditorBlueViewType) {
        struct DefaultStruct {
            static let noname = "string"
        }
        editorViewType = type
        [firstView, secondView, thirdView, fourView].forEach { view in
            view?.removeFromSuperview()
        }
        switch type {
        case .settingsView:
            optionsView.addSubview(firstView)
            optionsView.bringSubviewToFront(firstView)
            if UIDevice.current.userInterfaceIdiom != .phone {
                contentView.frame.size.height = optionsView.bounds.height + 400 // Новая высота
                contentScrollView.contentSize.height = contentView.frame.size.height
            } else if UIScreen.main.bounds.height <= 700 {
                contentView.frame.size.height = optionsView.bounds.height + 250 // Новая высота
                contentScrollView.contentSize.height = contentView.frame.size.height
            }
        case .collidersView:
            optionsView.addSubview(secondView)
            optionsView.bringSubviewToFront(secondView)
            if UIDevice.current.userInterfaceIdiom != .phone {
                contentView.frame.size.height = optionsView.bounds.height + 200 // Новая высота
                contentScrollView.contentSize.height = contentView.frame.size.height
            } else if UIScreen.main.bounds.height <= 700 {
               contentView.frame.size.height = optionsView.bounds.height  // Новая высота
               contentScrollView.contentSize.height = contentView.frame.size.height
           }
        case .textureView:
            optionsView.addSubview(thirdView)
            optionsView.bringSubviewToFront(thirdView)
            if UIDevice.current.userInterfaceIdiom != .phone {
                contentView.frame.size.height = optionsView.bounds.height + 270// Новая высота
                contentScrollView.contentSize.height = contentView.frame.size.height
            } else if UIScreen.main.bounds.height <= 700 {
                contentView.frame.size.height = optionsView.bounds.height + 200// Новая высота
                contentScrollView.contentSize.height = contentView.frame.size.height
            }
        case .propeertiesView:
            optionsView.addSubview(fourView)
            optionsView.bringSubviewToFront(fourView)
            if UIDevice.current.userInterfaceIdiom != .phone {
                contentView.frame.size.height = optionsView.bounds.height + 270// Новая высота
                contentScrollView.contentSize.height = contentView.frame.size.height
            } else if UIScreen.main.bounds.height <= 700 {
                contentView.frame.size.height = optionsView.bounds.height + 200 // Новая высота
                contentScrollView.contentSize.height = contentView.frame.size.height
            }
        }
    }
    
    private func lets_setupBloodyUI() {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.lets_setLinearGradientBackground(startColor: UIColor(red: 0.26, green: 0.25, blue: 0.55, alpha: 1.0),
                                         endColor: UIColor(red: 0.17, green: 0.16, blue: 0.35, alpha: 1.0))
        self.view.backgroundColor = .darkGray
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            optionsLabel.font = UIFont(name: "VT323-Regular", size: 40)
        } else {
            optionsLabel.font = UIFont(name: "VT323-Regular", size: 24)
        }
        
        optionsLabel.textColor = UIColor.white
        optionsLabel.text = NSLocalizedString("SET ITEM SETTINGS", comment: "") + ":"
    }
    
    private func lets_setupBloodyCollectionView() {
        struct DefaultStruct {
            static let noname = "string"
        }
        modeCollectionView.delegate = self
        modeCollectionView.dataSource = self
        modeCollectionView.register(UINib(nibName: "EditModeCollectionViewBlueCell", bundle: nil), forCellWithReuseIdentifier: "EditModeCollectionViewBlueCell")
    }
    
    private func lets_saveBloodyChanges(shouldPop: Bool = false) {
        struct DefaultStruct {
            static let noname = "string"
        }
        if EditorCustomManager.shared.newItem.name == "" {
            let alert = UIAlertController(title: NSLocalizedString("Can’t save mod without name", comment: ""), message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
        } else {
            editorManager.lets_compareOldNewItems { [self] isNeedToChange in
                if isNeedToChange {
                    DispatchQueue.main.async { [self] in
                        
                        if realm.editorItemsLocal.contains(where: {$0.id == editorManager.oldItem.id}) {
                            for item in realm.editorItemsLocal {
                                if item.id == self.editorManager.newItem.id {
                                    DispatchQueue.main.async { [self] in
                                        realm.editorUpdateLocalMod(obj: item, localMod: self.editorManager.newItem)
                                        
                                        editorManager.oldItem = ForEditorItem(name: editorManager.newItem.name,
                                                                                imageData: editorManager.newItem.imageData,
                                                                                iconData: editorManager.newItem.imageData,
                                                                                type: editorManager.newItem.type,
                                                                                category: editorManager.newItem.category,
                                                                                xValue: editorManager.newItem.xValue,
                                                                                yValue: editorManager.newItem.yValue,
                                                                                heightValue: editorManager.newItem.heightValue,
                                                                                widthValue: editorManager.newItem.widthValue,
                                                                                pixelValue: editorManager.newItem.pixelValue,
                                                                                canBeTaken: editorManager.newItem.canBeTaken,
                                                                                canGlow: editorManager.newItem.canGlow,
                                                                                canBurn: editorManager.newItem.canBurn,
                                                                                canFloat: editorManager.newItem.canFloat)
                                        editorManager.newItem = editorManager.oldItem
                                        lets_showBloodyAlertSaver(isSaved: true)
                                        return
                                    }
                                }
                            }
                        } else {
                            
                            let newObjLocal = EditorItemLocalRealmModelElement()
                            newObjLocal.id = UUID().uuidString
                            newObjLocal.idInt = realm.editorItemsLocal.count
                            newObjLocal.name = editorManager.newItem.name
                            newObjLocal.imageData = editorManager.newItem.imageData
                            newObjLocal.iconData = editorManager.newItem.iconData
                            newObjLocal.type = editorManager.newItem.type
                            newObjLocal.category = editorManager.newItem.category
                            newObjLocal.xValue = editorManager.newItem.xValue
                            newObjLocal.yValue = editorManager.newItem.yValue
                            newObjLocal.heightValue = editorManager.newItem.heightValue
                            newObjLocal.widthValue = editorManager.newItem.widthValue
                            newObjLocal.pixelValue = editorManager.newItem.pixelValue
                            newObjLocal.canBeTaken = editorManager.newItem.canBeTaken
                            newObjLocal.canGlow = editorManager.newItem.canGlow
                            newObjLocal.canBurn = editorManager.newItem.canBurn
                            newObjLocal.canFloat = editorManager.newItem.canFloat
                            realm.saveBlueEditorItemLocal(mod: newObjLocal)
                            lets_showBloodyAlertSaver(isSaved: true)
                            
                            editorManager.oldItem = ForEditorItem(name: newObjLocal.name,
                                                                    imageData: newObjLocal.imageData,
                                                                    iconData: newObjLocal.imageData,
                                                                    type: newObjLocal.type,
                                                                    category: newObjLocal.category,
                                                                    xValue: newObjLocal.xValue,
                                                                    yValue: newObjLocal.yValue,
                                                                    heightValue: newObjLocal.heightValue,
                                                                    widthValue: newObjLocal.widthValue,
                                                                    pixelValue: newObjLocal.pixelValue,
                                                                    canBeTaken: newObjLocal.canBeTaken,
                                                                    canGlow: newObjLocal.canGlow,
                                                                    canBurn: newObjLocal.canBurn,
                                                                    canFloat: newObjLocal.canFloat)
                            editorManager.newItem = editorManager.oldItem
                            
                        }
                    }
                } else {
                    lets_showBloodyAlertSaver(isSaved: false)
                }
            }
        }
    }
    
    private func lets_showBloodyAlertSaver(isSaved: Bool) {
        struct DefaultStruct {
            static let noname = "string"
        }
        var message = ""
        if isSaved {
            message = NSLocalizedString("success", comment: "")
        } else {
            message = NSLocalizedString("nothingToSave", comment: "")
        }
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            if isSaved {
                self.navigationController?.popViewController(animated: true)
            }
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
//    @objc private func keyboardWillShowPoeTTT(notification: NSNotification) {
//        imageHeight2 = topView.heightAnchor.constraint(equalToConstant: 0)
//        imageHeight.isActive = false
//        imageHeight2.isActive = true
//        UIView.animate(withDuration: 0.5, animations: { [weak self] in
//            guard let self else { return }
//            self.view.layoutIfNeeded()
//        })
//    }
//
//    @objc private func keyboardWillHidePoeTTT(notification: NSNotification) {
//        imageHeight = topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.32)
//        imageHeight.isActive = true
//        imageHeight2.isActive = false
//        UIView.animate(withDuration: 0.5, animations: { [weak self] in
//            guard let self else { return }
//            self.view.layoutIfNeeded()
//        })
//    }
    
    @objc private func keyboardWillShowPoeTTT(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                guard let self else { return }
                self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height)
            })
        }
    }
    
    @objc private func keyboardWillHidePoeTTT(notification: NSNotification) {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self else { return }
            self.view.transform = .identity
        })
        view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    @IBAction func back(_ sender: UIButton) {
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_compareItemsBeforeCloseScreen()
    }
    
    @IBAction func savveAction(_ sender: Any) {
        struct DefaultStruct {
            static let noname = "string"
        }
        if firstView.enterName.text == "" || firstView.enterName.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            let alert = UIAlertController(title: NSLocalizedString("noName", comment: ""), message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
        } else {
            lets_saveBloodyChanges()
        }
    }
}

extension EditorBlueDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        struct DefaultStruct {
            static let noname = "string"
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        struct DefaultStruct {
            static let noname = "string"
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditModeCollectionViewBlueCell", for: indexPath) as! EditModeCollectionViewBlueCell
        // Reset cell style to default
        cell.lets_removeGradient()
        cell.backgroundColor = .white
        cell.cellTitle.textColor = .backgroundDark
        
        if selectedIndex == indexPath.row {
            cell.lets_setupGradient()
            cell.cellTitle.textColor = .white
        }
        
        var title = ""
        switch indexPath.row {
        case 0:
            title = NSLocalizedString("SET ITEM SETTINGS", comment: "")
        case 1:
            title = NSLocalizedString("SET COLLIDERS", comment: "")
        case 2:
            title = NSLocalizedString("SELECT TEXTURE", comment: "")
        case 3:
            title = NSLocalizedString("SET PROPERTIES", comment: "")
        default:
            break
        }
        
        cell.cellTitle.text = title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        struct DefaultStruct {
            static let noname = "string"
        }
        selectedIndex = indexPath.row
        var tex = ""
        switch indexPath.row {
        case 0:
            tex = NSLocalizedString("SET ITEM SETTINGS", comment: "")
            lets_showBloodyView(.settingsView)
            
        case 1:
            tex = NSLocalizedString("SET COLLIDERS", comment: "")
            lets_showBloodyView(.collidersView)
        case 2:
            tex = NSLocalizedString("SELECT TEXTURE", comment: "")
            lets_showBloodyView(.textureView)
        case 3:
            tex = NSLocalizedString("SET PROPRTIES", comment: "")
            lets_showBloodyView(.propeertiesView)
        default: print("")
        }
        
        optionsLabel.text = tex + ":"
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        struct DefaultStruct {
            static let noname = "string"
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: collectionView.frame.width / 2 - 10, height: collectionView.frame.height / 2 - 20)
        } else {
            return CGSize(width: collectionView.frame.width / 2 - 5, height: collectionView.frame.height / 2 - 10)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        struct DefaultStruct {
            static let noname = "string"
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 20
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        struct DefaultStruct {
            static let noname = "string"
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 20
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        struct DefaultStruct {
            static let noname = "string"
        }
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

extension EditorBlueDetailViewController: LetsOpenImagePickerDelegate {
    
    func lets_openImagePicker(type: ImageEditorTypeEnum) {
        struct DefaultStruct {
            static let noname = "string"
        }
        imageEditorType = type
        lets_showImagePicker()
    }
    
    func lets_openSettings() {
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_showAlertSettings()
    }
    
    
    private func lets_showAlertSettings() {
        struct DefaultStruct {
            static let noname = "string"
        }
        DispatchQueue.main.async {
            let alert = UIAlertController(title: NSLocalizedString("Allow access to your photos", comment: ""), message: NSLocalizedString("Go to your settings and tap \"Photos\".", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: { _ in
            }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("Open Settings", comment: ""), style: .default, handler: { _ in
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                if UIApplication.shared.canOpenURL(url) == true {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    assertionFailure("Not able to open App privacy settings")
                    return
                }
                self.dismiss(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func lets_showImagePicker() {
        struct DefaultStruct {
            static let noname = "string"
        }
        DispatchQueue.main.async { [self] in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                let alert  = UIAlertController(title: NSLocalizedString("123", comment: ""), message: NSLocalizedString("125", comment: ""), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}


extension EditorBlueDetailViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        struct DefaultStruct {
            static let noname = "string"
        }
        picker.dismiss(animated: true, completion: nil)
        print("Image picker delegate")
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let upImage = image.updateImageOrientionUpSide() {
                lets_setupImage(image: upImage)
            } else {
                lets_setupImage(image: image)
            }
        }
    }
    
    private func lets_setupImage(image: UIImage) {
        struct DefaultStruct {
            static let noname = "string"
        }
        if let imgData = image.pngData() {
            if imgData.count > 15000000 {
                if let imgJpegData = image.jpegData(compressionQuality: 0.5) {
                    print("imgJpegData", imgJpegData)
                    switch imageEditorType {
                    case .iconImage:
                        editorManager.newItem.iconData = imgJpegData
                        updateImageDelegate?.lets_updateImage(imageData: editorManager.newItem.iconData)
                    case .textureImage:
                        print("textureImage1")
                        editorManager.newItem.imageData = imgJpegData
                        print("updateTextureImageDelegate", updateTextureImageDelegate)
                        updateTextureImageDelegate?.lets_updateTextureImage(imageData: editorManager.newItem.imageData)
                        self.image.image = UIImage(data: editorManager.newItem.imageData)
                    }
                    
                }
            } else {
                print("imgData", imgData)
                switch imageEditorType {
                case .iconImage:
                    editorManager.newItem.iconData = imgData
                    updateImageDelegate?.lets_updateImage(imageData: editorManager.newItem.iconData)
                case .textureImage:
                    print("textureImage2")
                    editorManager.newItem.imageData = imgData
                    print("updateTextureImageDelegate", updateTextureImageDelegate)
                    updateTextureImageDelegate?.lets_updateTextureImage(imageData: editorManager.newItem.imageData)
                    self.image.image = UIImage(data: editorManager.newItem.imageData)
                }
            }
        }
    }
}
