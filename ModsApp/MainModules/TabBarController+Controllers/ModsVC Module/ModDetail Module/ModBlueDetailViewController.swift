

import UIKit
import SnapKit
//

extension ModBlueDetailViewController: PremiumMainControllerDelegate {
    func funcProductBuyed() {
//        adImage.isHidden = true
        mainImage.topAnchor.constraint(equalTo: customNavBar.bottomAnchor, constant: 10).isActive = true
    }
}

class ModBlueDetailViewController: UIViewController {
    
    enum ButtonActivityEnum {
        case downloadActive, shareActive, editActive, noOneActive
    }
    
    enum ButtonCustomBloodyStateEnum {
        case defaultState, notActiveState
    }
    
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var navBarImage: UIImageView!
    
    let viewUpperMainImageView = UIImageView()
    let labelInViewUpperMainImageView = UILabel()
    let mainImage = UIImageView()
    let rectangleImageViewInsideMainImage = UIImageView()
    let downloadView = UIImageView()
    let downloadLabel = UILabel()
    let editModeView = UIImageView()
    let editModeLabel = UILabel()
    let shareView = UIImageView()
    let shareLabel = UILabel()
    let stackViewOfButtons = UIStackView()
    let modDescriptionView = UIImageView()
    let modDescriptionLabel = UILabel()
    private let customLineView = CustomLineView()
    let modDescriptionTextView = UITextView()

    
    
    private var buttonActivity: ButtonActivityEnum = .noOneActive
    var modObject: ModRealmModelElement!
    private var isDownload: Bool = false
    private let networkMonitoring = NetMonitor.shared
    private var buttonCustomState: ButtonCustomBloodyStateEnum = .defaultState
    private var loadAlert: UIAlertController? = nil
    
    private var customAlert: SubscriptionAlertBlueView?
    lazy var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let effectView = CustomVisualBlueEffectView(effect: effect, intensity: 0.1)
        return effectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        struct DefaultStruct {
            static let noname = "string"
        }
        addViews()
        makeViews()
        makeConstraints()
        lets_zetup_UI()
        lets_setupBloodyGesture()
        lets_setupInfo()
        //        networkMonitoring.startMonitoring()
        
        if networkMonitoring.isReachable == false {
            lets_showConnectionAlert()
        }
        

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        struct DefaultStruct {
            static let noname = "string"
        }
        
        lets_lets_setGradient()
        lets_setButtonsGradient()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        struct DefaultStruct {
            static let noname = "string"
        }
        if IAPManagerPoeTTT.shared.productBuyes.contains(.unlockFuncProduct) {
//            lockView.isHidden = true
            if IAPManagerPoeTTT.shared.productBuyes.contains(.unlockContentProduct) {
//                adImage.isHidden = true
                mainImage.topAnchor.constraint(equalTo: customNavBar.bottomAnchor, constant: 10).isActive = true
            } else {
//                adImage.image = UIImage(named: "ad2")
            }
        }
        print("🌀 \(String(describing: type(of: self)))")
    }
    
    deinit {
        //        networkMonitoring.stopToMonitoring()
    }
    
    func addViews() {
        view.addSubview(rectangleImageViewInsideMainImage)
        view.addSubview(viewUpperMainImageView)
        viewUpperMainImageView.addSubview(labelInViewUpperMainImageView)
        rectangleImageViewInsideMainImage.addSubview(mainImage)
        view.addSubview(stackViewOfButtons)
        stackViewOfButtons.addArrangedSubview(downloadView)
        stackViewOfButtons.addArrangedSubview(editModeView)
        stackViewOfButtons.addArrangedSubview(shareView)
        view.addSubview(modDescriptionView)
        modDescriptionView.addSubview(modDescriptionLabel)
        view.addSubview(customLineView)
        view.addSubview(modDescriptionTextView)

    }
    
    func makeConstraints() {

        viewUpperMainImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(117)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        labelInViewUpperMainImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalTo(labelInViewUpperMainImageView.intrinsicContentSize).inset(20)
        }
        rectangleImageViewInsideMainImage.snp.makeConstraints {
            $0.top.equalTo(viewUpperMainImageView.snp.bottom).inset(1)
            $0.left.right.equalTo(viewUpperMainImageView)
            $0.height.equalTo(200)
        }
        
        mainImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.bottom.right.equalToSuperview().inset(1)
        }
        stackViewOfButtons.snp.makeConstraints {
            $0.top.equalToSuperview().inset(400)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().inset(20)
        }
        modDescriptionView.snp.makeConstraints {
            $0.top.equalTo(stackViewOfButtons.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(190)
            $0.height.equalTo(29)
        }
        modDescriptionLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        customLineView.snp.makeConstraints {
            $0.top.equalTo(modDescriptionView.snp.bottom).inset(1)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(290)
            $0.height.equalTo(1)
        }
        modDescriptionTextView.snp.makeConstraints {
            $0.top.equalTo(customLineView).offset(20)
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }

    func makeViews() {
        customLineView.backgroundColor = .white
        modDescriptionView.image = UIImage(named: "modDescription")
        modDescriptionLabel.textAlignment = .center
        modDescriptionLabel.minimumScaleFactor = 0.5
        modDescriptionLabel.adjustsFontSizeToFitWidth = true
        labelInViewUpperMainImageView.minimumScaleFactor = 0.5
        labelInViewUpperMainImageView.numberOfLines = 2
        labelInViewUpperMainImageView.adjustsFontSizeToFitWidth = true
        labelInViewUpperMainImageView.textAlignment = .center
        viewUpperMainImageView.image = UIImage(named: "UpperViewOnMainViewOnDescriptionMod")
        rectangleImageViewInsideMainImage.image = UIImage(named: "rectangleForDescription")
        mainImage.roundCorners([.bottomLeft, .bottomRight], radius: 0)
        stackViewOfButtons.axis = .vertical
        stackViewOfButtons.spacing = 20

    }
    
    private func lets_lets_setGradient() {
        struct DefaultStruct {
            static let noname = "string"
        }
        let color = UIColor(red: 0.004, green: 0, blue: 0.213, alpha: 1)

        self.lets_setLinearGradientBackground(startColor: color, endColor: color)
        
        navBarImage.lets_setLinearGradientBackground(startColor: color, endColor: color)
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
    
    private func lets_showCustomBloodyAlertWithBlur(alertType: AlertCustomBlueType) {
        struct DefaultStruct {
            static let noname = "string"
        }
        var size = CGSize()
        switch alertType {
        case .subscription:
            if UIDevice.current.userInterfaceIdiom == .phone {
                size = CGSize(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.6)
            } else {
                size = CGSize(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.4)
            }
        case .watchVideo:
            if UIDevice.current.userInterfaceIdiom == .phone {
                size = CGSize(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.55)
            } else {
                size = CGSize(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.35)
            }
        }
        DispatchQueue.main.async { [self] in
            blurView.frame = UIScreen.main.bounds
            view.addSubview(blurView)
            view.bringSubviewToFront(blurView)
            blurView.alpha = 0
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.blurView.alpha = 1
            } completion: { [weak self] _ in
                let frame = CGRect(origin: CGPoint(), size: size)
                self?.customAlert = SubscriptionAlertBlueView(viewType: alertType, frame: frame)
                self?.customAlert?.alpha = 0
                self?.customAlert?.alertDelegate = self
                self?.customAlert?.center = self!.view.center
                self?.view.addSubview(self!.customAlert!)
                self?.view.bringSubviewToFront(self!.customAlert!)
                UIView.animate(withDuration: 0.15) { [weak self] in
                    self?.customAlert?.alpha = 1
                }
            }
        }
    }
    
    private func lets_hideCustomBloodyAlertWithBlur() {
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_updateDownloadButtonBloodyUI(state: .defaultState)
        lets_updateShareButtonBloodyUI(state: .defaultState)
        
        if customAlert != nil {
            UIView.animate(withDuration: 0.15) { [weak self] in
                self?.customAlert?.alpha = 0
            } completion: { [weak self] _ in
                self?.customAlert?.removeFromSuperview()
                self?.customAlert = nil
                UIView.animate(withDuration: 0.15) { [weak self] in
                    self?.blurView.alpha = 0
                } completion: { [weak self] _ in
                    self?.blurView.removeFromSuperview()
                }
            }
        }
    }
        
    private func lets_setupInfo() {
        struct DefaultStruct {
            static let noname = "string"
        }
        labelInViewUpperMainImageView.text = modObject.modTitle.uppercased()
        modDescriptionTextView.text = modObject.modDescription
        if modObject.modImageData.count == 0 {
            DropBoxBeautifulManager.shared.getBloodyImageURLFromDropBox(img: modObject.modImagePath) { urlString in
                if let urlString = urlString {
                    self.mainImage.lets_setupBloodyImages(from: urlString, mod: self.modObject, category: nil, editorItem: nil, type: .mods)
                }
            }
        } else {
            mainImage.image = UIImage(data: modObject.modImageData)
        }
    }
    
    private func lets_zetup_UI() {
        
        struct DefaultStruct {
            static let noname = "string"
        }
        
        view.backgroundColor = .violet
        mainImage.layer.cornerRadius = 10
        
        let _ = [downloadLabel, editModeLabel, shareLabel].compactMap {
            if UIDevice.current.userInterfaceIdiom == .pad {
                $0.font = UIFont(name: "VT323-Regular", size: 72)
            } else {
                $0.font = UIFont(name: "VT323-Regular", size: 30)
            }
            $0.textColor = .white

        }
        labelInViewUpperMainImageView.textColor = .black
        if UIDevice.current.userInterfaceIdiom == .pad {
            topTitle.font = UIFont(name: "VT323-Regular", size: 72)
            labelInViewUpperMainImageView.font = UIFont(name: "VT323-Regular", size: 64)
        } else {
            topTitle.font = UIFont(name: "VT323-Regular", size: 48)
            labelInViewUpperMainImageView.font = UIFont(name: "VT323-Regular", size: 32)
        }
        topTitle.textColor = UIColor.white
        topTitle.text = NSLocalizedString("melonMods", comment: "").uppercased()
        
        downloadLabel.text = NSLocalizedString("downloadLabel", comment: "").uppercased()
        shareLabel.text = NSLocalizedString("shareLabel", comment: "").uppercased()
        editModeLabel.text = NSLocalizedString("startEditModeLabel", comment: "").uppercased()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            modDescriptionLabel.font = UIFont(name: "VT323-Regular", size: 26)
            modDescriptionTextView.font = UIFont(name: "VT323-Regular", size: 30)

        } else {
            modDescriptionLabel.font = UIFont(name: "VT323-Regular", size: 20)
            modDescriptionTextView.font = UIFont(name: "VT323-Regular", size: 24)
        }
        
        modDescriptionLabel.textColor = UIColor.white
        modDescriptionLabel.text = " \(NSLocalizedString("modDescription", comment: "").uppercased())"
        modDescriptionTextView.backgroundColor = .clear
        modDescriptionTextView.textColor = UIColor.white
    }
    
    private func lets_setButtonsGradient() {
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_updateDownloadButtonBloodyUI(state: .defaultState)
        lets_updateShareButtonBloodyUI(state: .defaultState)
        lets_updateStartEditButtonBloodyUI(state: .defaultState)
    }
    
    private func lets_updateDownloadButtonBloodyUI(state: ButtonCustomBloodyStateEnum) {
        struct DefaultStruct {
            static let noname = "string"
        }
        switch state {
        case .defaultState:
            downloadView.addSmallImageWithName("downloadIcon")
            downloadView.addLabelOnView(label: downloadLabel)
            downloadView.layer.cornerRadius = 8
            downloadView.clipsToBounds = true
            downloadView.backgroundColor = .clear
            downloadView.image = UIImage(named: "Rectangle 6360")
            downloadLabel.textColor = .white
        case .notActiveState:
            downloadView.addSmallImageWithName("downloadIcon")
            downloadView.addLabelOnView(label: downloadLabel)
            downloadView.layer.cornerRadius = 8
            downloadView.backgroundColor = .clear
            downloadView.image = UIImage(named: "Rectangle 6360")
            downloadLabel.textColor = .white
        }
    }
    
    private func lets_updateShareButtonBloodyUI(state: ButtonCustomBloodyStateEnum) {
        struct DefaultStruct {
            static let noname = "string"
        }
        switch state {
        case .defaultState:
            shareView.layer.cornerRadius = 8
            shareView.clipsToBounds = true
            shareView.backgroundColor = .clear
            shareView.image = UIImage(named: "Rectangle 6360")
            shareView.addSmallImageWithName("shareIcon")
            shareView.addLabelOnView(label: shareLabel)
            shareLabel.textColor = .white
        case .notActiveState:
            shareView.layer.cornerRadius = 8
            shareView.backgroundColor = .clear
            shareView.image = UIImage(named: "Rectangle 6360")
            shareView.addSmallImageWithName("shareIcon")
            shareView.addLabelOnView(label: shareLabel)
            shareLabel.textColor = .white
        }
        
    }
    
    private func lets_updateStartEditButtonBloodyUI(state: ButtonCustomBloodyStateEnum) {
        struct DefaultStruct {
            static let noname = "string"
        }
        switch state {
        case .defaultState:
            editModeView.layer.cornerRadius = 8
            editModeView.clipsToBounds = true
            editModeView.backgroundColor = .clear
            editModeView.image = UIImage(named: "Rectangle 6360")
            editModeView.addSmallImageWithName("editIcon")
            editModeView.addLabelOnView(label: editModeLabel)
            editModeLabel.textColor = .white
            
        case .notActiveState:
            editModeView.layer.cornerRadius = 8
            editModeView.backgroundColor = .clear
            editModeView.addSmallImageWithName("editIcon")
            editModeView.image = UIImage(named: "Rectangle 6360")
            editModeLabel.textColor = .white
        }
    }

    private func lets_setupBloodyGesture() {
        struct DefaultStruct {
            static let noname = "string"
        }
        downloadView.isUserInteractionEnabled = true
        shareView.isUserInteractionEnabled = true
        editModeView.isUserInteractionEnabled = true

        let downloadGesture = UITapGestureRecognizer(target: self, action: #selector(lets_downloadBloodyActions))
        downloadView.addGestureRecognizer(downloadGesture)
        let shareGesture = UITapGestureRecognizer(target: self, action: #selector(lets_shareBloodyAction))
        shareView.addGestureRecognizer(shareGesture)
        let editModeGesture = UITapGestureRecognizer(target: self, action: #selector(lets_editBloodyModeAction))
        editModeView.addGestureRecognizer(editModeGesture)
    }
    
    private func lets_loadingStart() {
        struct DefaultStruct {
            static let noname = "string"
        }
        loadAlert = UIAlertController(title: NSLocalizedString("wait", comment: ""), message: nil, preferredStyle: .alert)
        present(loadAlert!, animated: true)
    }
    
    private func lets_loadingStop() {
        struct DefaultStruct {
            static let noname = "string"
        }
        if loadAlert != nil {
            dismiss(animated: true) {
                self.loadAlert = nil
            }
        }
    }
    
    private func lets_downloadContentable(fileLink: URL, fileName: String, isDownload: Bool) {
        struct DefaultStruct {
            static let noname = "string"
        }
        DropBoxBeautifulManager.shared.downloadBloodyFileBy(urlPath: modObject.modFilePath) { isFile in
            if isFile != nil {
                let downloadfilename: String = self.modObject.modFilePath
                let fileArray = downloadfilename.components(separatedBy: "/")
                let finalFileName = fileArray.last
                let filemanager = FileManager.default
                guard let newFile = finalFileName else { return }
                let docsurl = try! filemanager.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                var myUrlString = docsurl.appendingPathComponent(newFile).absoluteString
                myUrlString = myUrlString.replacingOccurrences(of: "file://", with: "")
                filemanager.createFile(atPath: myUrlString, contents: isFile, attributes: nil)
                if filemanager.fileExists(atPath: myUrlString) {
                    print("File Exists at \(myUrlString)")
                } else {
                    print("File not found")
                }
                DispatchQueue.main.async {
                    self.lets_loadingStop()
                    self.buttonActivity = .noOneActive
                    if isDownload {
                        self.lets_successBlueDownload()
                    } else {
                        self.lets_shareBloodyFile(pathFile: myUrlString)
                    }
                }
            } else {
                print("error get file url")
            }
        }
    }
    
    private func lets_successBlueDownload() {
        struct DefaultStruct {
            static let noname = "string"
        }
        let alert = UIAlertController(title: NSLocalizedString("successDownloadFile", comment: ""), message: NSLocalizedString("successDownloadFile2", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true) { [self] in
            self.lets_updateDownloadButtonBloodyUI(state: .defaultState)
            self.lets_updateShareButtonBloodyUI(state: .defaultState)
        }
    }
    
    private func lets_shareBloodyFile(pathFile: String) {
        struct DefaultStruct {
            static let noname = "string"
        }
        let shareFile = NSURL(fileURLWithPath: pathFile)
        var shredArrdy = [Any]()
        shredArrdy.append(shareFile)
        let fr = CGRect(x: 280, y: 500, width: 50, height: 50)
        let ActVC = UIActivityViewController(activityItems: shredArrdy, applicationActivities: nil)
        if UIDevice.current.userInterfaceIdiom == .pad {
            ActVC.popoverPresentationController?.sourceView = self.view
            ActVC.popoverPresentationController?.sourceRect = fr
        }
        ActVC.completionWithItemsHandler = { [weak self] (activityType, completed: Bool, returnedItems:[Any]?, error: Error?) in
            if completed == false {
                print("Activity View Controller dismiss")
            } else {
                print("Activity View Controller china")
                self?.lets_successSavedBloodyAlertino()
            }
        }
        present(ActVC, animated: true, completion: { [self] in
            lets_updateDownloadButtonBloodyUI(state: .defaultState)
            lets_updateShareButtonBloodyUI(state: .defaultState)
        })
    }
    
    private func lets_successSavedBloodyAlertino() {
        struct DefaultStruct {
            static let noname = "string"
        }
        let alert = UIAlertController(title: NSLocalizedString("success", comment: "").uppercased(), message: NSLocalizedString("success_completed", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    private func lets_downloadBloodyContent(isDownload: Bool) {
        struct DefaultStruct {
            static let noname = "string"
        }
        self.isDownload = isDownload
        if ContentMagicUnLocker.shared.isLocked {
            
        } else {
            DropBoxBeautifulManager.shared.getBloodyFileUrlFromDropbox(path: modObject.modFilePath) { [self] urlString in
                if let urlString = urlString, let url = URL(string: urlString) {
                    DispatchQueue.main.async {
                        self.lets_downloadContentable(fileLink: url, fileName: self.modObject.modTitle + self.modObject.id, isDownload: isDownload)
                    }
                }
            }
        }
    }
    
    
    @objc private func lets_downloadBloodyActions() {
        struct DefaultStruct {
            static let noname = "string"
        }
        if buttonActivity != .noOneActive {
            if buttonActivity != .downloadActive {
                return
            }
        }
        buttonActivity = .downloadActive
        
        if networkMonitoring.isReachable == false {
            lets_showConnectionAlert()
        } else {
            lets_updateDownloadButtonBloodyUI(state: .notActiveState)
            lets_downloadBloodyContent(isDownload: true)
        }
    }
    
    @objc private func lets_shareBloodyAction() {
        struct DefaultStruct {
            static let noname = "string"
        }
        if buttonActivity != .noOneActive {
            if buttonActivity != .shareActive {
                return
            }
        }
        buttonActivity = .shareActive
        
        if networkMonitoring.isReachable == false {
            lets_showConnectionAlert()
        } else {
            lets_updateShareButtonBloodyUI(state: .notActiveState)
            lets_downloadBloodyContent(isDownload: false)
        }
    }
    
    private func lets_showConnectionAlert() {
        struct DefaultStruct {
            static let noname = "string"
        }
        let alert = UIAlertController(title: NSLocalizedString("noInternetConnection", comment: ""), message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    @objc private func lets_editBloodyModeAction() {
        struct DefaultStruct {
            static let noname = "string"
        }
        if !IAPManagerPoeTTT.shared.productBuyes.contains(.unlockFuncProduct) {
            let vc = PremiumMainControllerPoeTTT()
            vc.productBuy = .unlockFuncProduct
            vc.delegate = self
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        } else {
            if buttonActivity != .noOneActive {
                if buttonActivity != .editActive {
                    return
                }
            }
            buttonActivity = .editActive
            
            lets_updateStartEditButtonBloodyUI(state: .notActiveState)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
                lets_updateStartEditButtonBloodyUI(state: .defaultState)
                self.buttonActivity = .noOneActive
                let editor = EditorBlueDetailViewController()
                editor.modObject = modObject
                editor.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(editor, animated: true)
                
            }
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        struct DefaultStruct {
            static let noname = "string"
        }
        navigationController?.popViewController(animated: true)
    }
}

extension ModBlueDetailViewController: CustomModsAlertBloodyProtocolDelegate {
    func lets_makeAction(type: AlertCustomBlueType) {
        struct DefaultStruct {
            static let noname = "string"
        }
        print(type)
        switch type {
        case .watchVideo:
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [weak self] in
               
            })
        case .subscription:
            break
        }
    }
    
    func lets_closeThisAlert() {
        lets_hideCustomBloodyAlertWithBlur()
    }
    
}
