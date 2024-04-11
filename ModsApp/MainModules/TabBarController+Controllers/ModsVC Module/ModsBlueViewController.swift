

import UIKit

let models = [CategoryRealmModelElemen(categoryName: "Building", images: [
    Images(image: UIImage(named: "RectangleForImageViewOnMainScreen")!),
    Images(image: UIImage(named: "RectangleForImageViewOnMainScreen")!)]),
              CategoryRealmModelElemen(categoryName: "People"),
              CategoryRealmModelElemen(categoryName: "somethin"),
              CategoryRealmModelElemen(categoryName: "another")]


class ModsBlueViewController: UIViewController {
    
    enum InfoSearchActiveEnum {
        case infoActive, searchActive, noOneActive
    }
    
    enum CategoryListBloodyTypeEnum {
        case horizontalScroll, showAllVerticalScroll
    }
    
    enum SearchBloodyModeEnum {
        case searchMode, defaultMode
    }
    
    enum CategiriesBloodyCollectionTypeEnum {
        case categories, settings
    }
    
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var adImage: UIImageView!
    @IBOutlet weak var settingsCollection: UICollectionView!
    @IBOutlet weak var searchCustomView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var blurCollection: UICollectionView!
    @IBOutlet weak var blurCustomView: UIView!
    
    @IBOutlet weak var navBarBgImageView: UIImageView!
    @IBOutlet weak var sbImage: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var subscriptionButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var categoriesButton: UIButton!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var contentCollectionView: UICollectionView!
    @IBOutlet weak var categoryCVHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var underSettingsView: UIView!
    
    private var newSearchButtonHeightConstraint: NSLayoutConstraint!
    private var infoSearchActive: InfoSearchActiveEnum = .noOneActive
    
    private var categoryScroll: CategoryListBloodyTypeEnum = .horizontalScroll
    private var searchMode: SearchBloodyModeEnum = .defaultMode
    private var categiriesCollectionType: CategiriesBloodyCollectionTypeEnum = .categories
    private var settingsItem: [ModelForSettingsItem] = [
        ModelForSettingsItem(title: NSLocalizedString("privacy_policy", comment: ""), imageName: "privacy", urlStr: SubscriptionKey.policyLink),
        ModelForSettingsItem(title: NSLocalizedString("terms_of_use", comment: ""), imageName: "terms", urlStr: SubscriptionKey.termsLink),
        //        ModelForSettingsItem(title: NSLocalizedString("subsInfo", comment: ""), imageName: "subsInfo", urlStr: SubscriptionKey.subInfo),
        //        ModelForSettingsItem(title: NSLocalizedString("restore", comment: ""), imageName: "restore", urlStr: "")
    ]
    private var filteredMods: [ModRealmModelElement] = []
    private var localDB = LocalDataOnThisApp.shared
    private var currentCategory = ""
    private var screenHeight = UIScreen.main.bounds.size.height
    private var isFirstLoad = true
    private var isFirstSubviews = true
    
    private var customAlert: SubscriptionAlertBlueView?
    lazy var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let effectView = CustomVisualBlueEffectView(effect: effect, intensity: 0.1)
        return effectView
    }()
    
    
//    MARK: - NewCode_____________________________________
    let searchTextFieldd = UIImageView()
    let labelInSearchTextField = UILabel()
    let labelCategories = UILabel()
    let tableViewForCategories = UITableView()
    let countOfVisibleContentsLabel = UILabel()
    let openClosedVisibleContentsButton = UIButton()
    let collectionViewForCategories = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    //    MARK: - NewCode_____________________________________

    override func viewDidLoad() {
        super.viewDidLoad()
        struct DefaultStruct {
            static let noname = "string"
        }
        //    MARK: - NewCode_____________________________________
        addViews()
        setupViews()
        makeConstraints()
        setupCollectionView()
        //    MARK: - NewCode_____________________________________
        
        lets_lets_zetupka_UI()
        lets_setupCategory()
        lets_setupCollection()
        
        searchBar.tintColor = UIColor(red: 60/255, green: 58/255, blue: 126/255, alpha: 1)
        blurCustomView.isHidden = true
        blurCustomView.backgroundColor = .clear
        
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.textColor = UIColor(red: 60/255, green: 58/255, blue: 126/255, alpha: 1)
            searchBar.searchTextField.font = UIFont(name: "VT323-Regular", size: 30)
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            mainTitle.font = UIFont(name: "VT323-Regular", size: 72)
        } else {
            mainTitle.font = UIFont(name: "VT323-Regular", size: 48)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPhotoAd))
        adImage.isUserInteractionEnabled = true
        adImage.addGestureRecognizer(tapGesture)
        categoriesButton.semanticContentAttribute = .forceRightToLeft
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        struct DefaultStruct {
            static let noname = "string"
        }
        if IAPManagerPoeTTT.shared.productBuyes.contains(.unlockFuncProduct) {
            if IAPManagerPoeTTT.shared.productBuyes.contains(.unlockContentProduct) {
                adImage.isHidden = true
                stackView.topAnchor.constraint(equalTo: customNavBar.bottomAnchor).isActive = true
            } else {
                adImage.image = UIImage(named: "ad2")
            }
        }
        if isFirstLoad {
            lets_setCategoryHeightHorizontal()
            if categiriesCollectionType == .settings {
                infoAction(UIButton())
            }
        }
        if NetMonitor.shared.isReachable == false {
            let alert = UIAlertController(title: NSLocalizedString("noInternetConnection", comment: ""), message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
        }
        categoriesButton.semanticContentAttribute = .forceRightToLeft
        print("🌀 \(String(describing: type(of: self)))")
        isFirstLoad = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        struct DefaultStruct {
            static let noname = "string"
        }
        if isFirstSubviews {
            lets_lets_setGradient()
        }
        isFirstSubviews = false
//        categoriesButton.setNeedsLayout()
//        categoriesButton.layoutIfNeeded()
    }
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        searchBar.resignFirstResponder()
        struct DefaultStruct {
            static let noname = "string"
        }
    }
    
    private func lets_addBlur() {
        struct DefaultStruct {
            static let noname = "string"
        }
        DispatchQueue.main.async { [self] in
//            let blurGesture = UITapGestureRecognizer(target: self, action: #selector(searchActionPressed))
//            blurCustomView.isUserInteractionEnabled = true
//            blurCustomView.addGestureRecognizer(blurGesture)

            blurView.alpha = 0
            blurCustomView.alpha = 0
            blurCustomView.isHidden = false
            blurView.frame = blurCustomView.bounds
            blurCustomView.addSubview(blurView)
            blurCustomView.bringSubviewToFront(blurView)
            blurCustomView.bringSubviewToFront(blurCollection)
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.blurView.alpha = 1
                self?.blurCustomView.alpha = 1
            } completion: { _ in
            }
        }
    }
    //    MARK: - NewCode_____________________________________
    func addViews() {
        view.addSubview(searchTextFieldd)
        searchTextFieldd.addSubview(labelInSearchTextField)
        view.addSubview(labelCategories)
        view.addSubview(tableViewForCategories)
        view.addSubview(countOfVisibleContentsLabel)
        view.addSubview(openClosedVisibleContentsButton)
        view.addSubview(collectionViewForCategories)
    }
    
    func makeConstraints() {
        searchTextFieldd.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
        labelInSearchTextField.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        labelCategories.snp.makeConstraints {
            $0.top.equalTo(searchTextFieldd.snp.bottom).offset(20)
            $0.left.right.equalTo(searchTextFieldd)
        }
        tableViewForCategories.snp.makeConstraints {
            $0.top.equalTo(labelCategories.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(180)
        }
        countOfVisibleContentsLabel.snp.makeConstraints {
            $0.top.equalTo(tableViewForCategories.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        openClosedVisibleContentsButton.snp.makeConstraints {
            $0.leading.equalTo(countOfVisibleContentsLabel.snp.trailing).offset(20)
            $0.top.equalTo(tableViewForCategories.snp.bottom).offset(20)
        }
        collectionViewForCategories.snp.makeConstraints {
            $0.top.equalTo(countOfVisibleContentsLabel.snp.bottom)
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(100)

        }
    }

    func setupViews() {
        searchTextFieldd.layer.cornerRadius = 10
        searchTextFieldd.image = UIImage(named: "findImage")
        
        labelInSearchTextField.text = "hello"
        labelInSearchTextField.textAlignment = .center
        labelInSearchTextField.textColor = .white
        
        
        labelCategories.text = "Categories:"
        labelCategories.textColor = .white
        tableViewForCategories.backgroundColor = UIColor(red: 0.004, green: 0, blue: 0.213, alpha: 1)
        tableViewForCategories.dataSource = self
        tableViewForCategories.delegate = self

        tableViewForCategories.register(CellForCategoriesTableView.self, forCellReuseIdentifier: CellForCategoriesTableView.identifier)
        countOfVisibleContentsLabel.text = "View all"
        countOfVisibleContentsLabel.textColor = .white
        openClosedVisibleContentsButton.setImage(UIImage(named: "open"), for: .normal)
    }
    
    func setupCollectionView() {
        collectionViewForCategories.backgroundColor = .clear
        collectionViewForCategories.dataSource = self
        collectionViewForCategories.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSizeMake(256, 364)
        collectionViewForCategories.setCollectionViewLayout(layout, animated: false)
        
    }
    //    MARK: - NewCode_____________________________________

    
    
    private func lets_lets_setGradient() {
        struct DefaultStruct {
            static let noname = "string"
        }
        navBarBgImageView.lets_setLinearGradientBackground(startColor: UIColor(red: 0.26, green: 0.25, blue: 0.55, alpha: 1.0),
                                                      endColor: UIColor(red: 0.17, green: 0.16, blue: 0.35, alpha: 1.0))
        self.lets_setLinearGradientBackground(startColor: UIColor(red: 0.26, green: 0.25, blue: 0.55, alpha: 1.0),
                                         endColor: UIColor(red: 0.17, green: 0.16, blue: 0.35, alpha: 1.0))
    }
    
    private func lets_showCustomAlertWithBlur(alertType: AlertCustomBlueType) {
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
    
    private func lets_hideCustomAlertWithBlur() {
        struct DefaultStruct {
            static let noname = "string"
        }
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
    
    
    private func lets_setupCategory() {
        struct DefaultStruct {
            static let noname = "string"
        }
        guard localDB.categories.count >= 2 else { return }
        currentCategory = localDB.categories[1].categoryName
        lets_updateCategoryButton()
    }
    
    private func lets_lets_zetupka_UI() {
        struct DefaultStruct {
            static let noname = "string"
        }
        navBarBgImageView.layer.cornerRadius = 10
        
        //        self.setLinearGradientBackground(startColor: UIColor(red: 0.26, green: 0.25, blue: 0.55, alpha: 1.0),
        //                                         endColor: UIColor(red: 0.17, green: 0.16, blue: 0.35, alpha: 1.0))
        
        underSettingsView.backgroundColor = .clear
        sbImage.layer.cornerRadius = 10
        searchBar.isHidden = true
        sbImage.isHidden = true
        searchBar.delegate = self
        searchBar.setupSearchBloodyBar()
        NotificationCenter.default.addObserver(self, selector: #selector(lets_clearButtonActionApp), name: Notification.Name("clearButtonActionApp"), object: nil)
        
        
        mainTitle.textColor = UIColor.white
        mainTitle.text = NSLocalizedString("melonMods", comment: "").uppercased()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            categoriesLabel.font = UIFont(name: "VT323-Regular", size: 40)
        } else {
            categoriesLabel.font = UIFont(name: "VT323-Regular", size: 20)
        }
        
        categoriesLabel.textColor = UIColor.white
        categoriesLabel.text = NSLocalizedString("categoriesLabel", comment: "").uppercased() + ":"
        
        lets_updateCategoryButton()
        
        searchCustomView.backgroundColor = .clear
        searchCustomView.isHidden = true
        searchTextField.isHidden = true
        searchTextField.delegate = self
        searchTextField.textColor = UIColor(red: 0.235, green: 0.227, blue: 0.494, alpha: 1)
        searchTextField.font = UIFont(name: "VT323-Regular", size: 30)
        searchTextField.textAlignment = .left
        searchTextField.tintColor = UIColor(red: 0.235, green: 0.227, blue: 0.494, alpha: 1)
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let placeholder = NSAttributedString(string: NSLocalizedString("search", comment: ""), attributes: [ .foregroundColor: UIColor(red: 0.235, green: 0.227, blue: 0.494, alpha: 1)])
        let searchTextField = self.searchTextField
        
        // Key workaround to be able to set attributedPlaceholder
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                searchTextField?.attributedPlaceholder = placeholder
            }
        }
    }
    
    private func lets_updateCategoryButton() {
        struct DefaultStruct {
            static let noname = "string"
        }
        var myFont = UIFont()
        if UIDevice.current.userInterfaceIdiom == .pad {
            myFont = UIFont(name: "VT323-Regular", size: 40)!
        } else {
            myFont = UIFont(name: "VT323-Regular", size: 20)!
        }
        let attributedText = NSAttributedString(string: NSLocalizedString("show_all", comment: ""), attributes: [NSAttributedString.Key.font: myFont, NSAttributedString.Key.foregroundColor: UIColor.white])
        categoriesButton.setAttributedTitle(attributedText, for: .normal)
        categoriesButton.titleLabel?.adjustsFontSizeToFitWidth = true
        categoriesButton.setNeedsDisplay()
        categoriesButton.layoutIfNeeded()
    }
    
    private func lets_setupCollection() {
        struct DefaultStruct {
            static let noname = "string"
        }
//        categoriesCollectionView.backgroundColor = .clear
        contentCollectionView.backgroundColor = UIColor.clear
//        categoriesCollectionView.delegate = self
//        categoriesCollectionView.dataSource = self
//        categoriesCollectionView.register(UINib(nibName: "CategoriesBlueCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesBlueCollectionViewCell")
        contentCollectionView.delegate = self
        contentCollectionView.dataSource = self
        contentCollectionView.register(UINib(nibName: "ContentBlueCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ContentBlueCollectionViewCell")
        contentCollectionView.register(UINib(nibName: "NativeAdsCollectionViewCell1121111", bundle: nil), forCellWithReuseIdentifier: "NativeAdsCollectionViewCell1121111")
        
        blurCollection.backgroundColor = .clear
        blurCollection.delegate = self
        blurCollection.dataSource = self
        blurCollection.register(UINib(nibName: "BlurCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BlurCellCollectionViewCell")
        
        settingsCollection.isHidden = true
        settingsCollection.register(UINib(nibName: "SettingsBlueCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SettingsBlueCollectionViewCell")
        settingsCollection.delegate = self
        settingsCollection.dataSource = self
    }
    
    private func lets_setCategoryHeightHorizontal() {
        struct DefaultStruct {
            static let noname = "string"
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            categoryCVHeight.constant = (UIScreen.main.bounds.size.width - 100) * 3 / 6.4
        } else {
            categoryCVHeight.constant = UIScreen.main.bounds.size.width * 3 / 6.4
        }
    }
    
    private func lets_setCategoryHeightHorizontalForSettings() {
        struct DefaultStruct {
            static let noname = "string"
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            categoryCVHeight.constant = 120
        } else {
            categoryCVHeight.constant = 120
        }
    }
    
    private func lets_setCategoryCVHeightVertical() {
        struct DefaultStruct {
            static let noname = "string"
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            categoryCVHeight.constant = (UIScreen.main.bounds.size.width - 100) * 6 / 6.4
        } else {
            categoryCVHeight.constant = UIScreen.main.bounds.size.width * 6 / 6.4
        }
    }
    
    private func lets_setCategoryViewConstraint() {
        struct DefaultStruct {
            static let noname = "string"
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            categoryViewConstraint.constant = 100
        } else {
            categoryViewConstraint.constant = 50
        }
    }
    
    @objc private func lets_clearButtonActionApp() {
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_updateSearchUI()
    }
    
    private func lets_updateScrollDirections(scrollDirection: UICollectionView.ScrollDirection) {
        struct DefaultStruct {
            static let noname = "string"
        }
        switch scrollDirection {
        case .vertical:
            categoryScroll = .showAllVerticalScroll
            lets_setCategoryCVHeightVertical()
        case .horizontal:
            categoryScroll = .horizontalScroll
            lets_setCategoryHeightHorizontal()
        @unknown default:
            break
        }
        if let layout = categoriesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = scrollDirection
        }
        
//        UIView.animate(withDuration: 0.1) {
//            self.view.layoutIfNeeded()
//        }
        self.view.layoutIfNeeded()
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
    
    func openSubScreen() {
        let vc = PremiumMainControllerPoeTTT()
        vc.productBuy = .unlockContentProduct
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    private func lets_updateSearchUI() {
        struct DefaultStruct {
            static let noname = "string"
        }
        searchTextField.text = ""
        if searchMode == .defaultMode {
            if let newSearchButtonHeightConstraint {
                NSLayoutConstraint.deactivate([newSearchButtonHeightConstraint])
            }
            else {
                NSLayoutConstraint.deactivate([searchButtonHeightConstraint])
            }
            newSearchButtonHeightConstraint = searchButton.heightAnchor.constraint(equalTo: infoButton.heightAnchor, multiplier: 0.7)
            newSearchButtonHeightConstraint.isActive = true
            searchButton.setBackgroundImage(UIImage(named: "Close Icon"), for: .normal)
            searchMode = .searchMode
            
            searchBar.isHidden = true
            sbImage.isHidden = false
            
            searchCustomView.isHidden = false
            searchTextField.isHidden = false
            
            infoButton.isHidden = true
            subscriptionButton.isHidden = true
            mainTitle.isHidden = true
            lets_addBlur()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.view.bringSubviewToFront(self.sbImage)
                self.view.bringSubviewToFront(self.searchBar)
            })
            
        } else {
            if let newSearchButtonHeightConstraint {
                NSLayoutConstraint.deactivate([newSearchButtonHeightConstraint])
            }
            else {
                NSLayoutConstraint.deactivate([searchButtonHeightConstraint])
            }
            newSearchButtonHeightConstraint = searchButton.heightAnchor.constraint(equalTo: infoButton.heightAnchor)
            newSearchButtonHeightConstraint.isActive = true
            infoSearchActive = .noOneActive
            searchButton.setBackgroundImage(UIImage(named: "search"), for: .normal)
            searchMode = .defaultMode
            
            searchBar.isHidden = true
            sbImage.isHidden = true
            
            searchCustomView.isHidden = true
            searchTextField.isHidden = true
            
            infoButton.isHidden = false
            subscriptionButton.isHidden = true
            mainTitle.isHidden = false
            UIView.animate(withDuration: 0.1) {
                self.blurCustomView.alpha = 0
            } completion: { _ in
                self.blurCustomView.isHidden = true
            }
            
        }
        contentCollectionView.reloadData()
        blurCollection.reloadData()
        // ad blur
    }
    
    @IBAction func choseCategoryAction(_ sender: UIButton) {
        struct DefaultStruct {
            static let noname = "string"
        }
        if categoryScroll == .horizontalScroll {
            lets_updateScrollDirections(scrollDirection: .vertical)
        } else {
            lets_updateScrollDirections(scrollDirection: .horizontal)
        }
    }
    
    @IBAction func infoAction(_ sender: UIButton) {
//        adImage?.isHidden.toggle()
        struct DefaultStruct {
            static let noname = "string"
        }
        if infoSearchActive != .noOneActive {
            if infoSearchActive != .infoActive {
                print("dfvcdefvcsdfv")
                return
            }
        }
        infoSearchActive = .infoActive
        
        
        //        updateScrollDirections(scrollDirection: .horizontal)
        if categiriesCollectionType == .categories {
            categiriesCollectionType = .settings
            //            setCategoryHeightHorizontalForSettings()
            //            categoryViewConstraint.constant = 16
            //            categoriesCollectionView.backgroundColor = #colorLiteral(red: 0.2056317627, green: 0.1957484186, blue: 0.4261773229, alpha: 1)
            //            underSettingsView.backgroundColor = #colorLiteral(red: 0.2056317627, green: 0.1957484186, blue: 0.4261773229, alpha: 1)
            //            categoryView.isHidden = true
            settingsCollection.backgroundColor = #colorLiteral(red: 0.2056317627, green: 0.1957484186, blue: 0.4261773229, alpha: 1)
            settingsCollection.isHidden = false
            subscriptionButton.isHidden = true
            searchButton.isHidden = true
            //categoriesLabel.isHidden = true
            //categoriesButton.isHidden = true
            mainTitle.text = NSLocalizedString("settings", comment: "").uppercased()
            infoButton.setBackgroundImage(UIImage(named: "close"), for: .normal)
        } else {
            infoSearchActive = .noOneActive
            categiriesCollectionType = .categories
            //            setCategoryViewConstraint()
            //            setCategoryHeightHorizontal()
            settingsCollection.isHidden = true
            categoriesCollectionView.backgroundColor = .clear
            underSettingsView.backgroundColor = .clear
            categoryView.isHidden = false
            
            subscriptionButton.isHidden = true
            searchButton.isHidden = false
            categoriesLabel.isHidden = false
            categoriesButton.isHidden = false
            mainTitle.text = NSLocalizedString("melonMods", comment: "").uppercased()
            infoButton.setBackgroundImage(UIImage(named: "info"), for: .normal)
        }
        categoriesCollectionView.reloadData()
    }
    
    @IBAction func subscriptionAction(_ sender: UIButton) {
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_showCustomAlertWithBlur(alertType: .subscription)
    }
    
    @IBAction func searchActionxxxx(_ sender: Any) {
        struct DefaultStruct {
            static let noname = "string"
        }
        if infoSearchActive != .noOneActive {
            if infoSearchActive != .searchActive {
                print("dfvcdefvcsdfv")
                return
            }
        }

        infoSearchActive = .searchActive
        lets_updateScrollDirections(scrollDirection: .horizontal)
        //
        lets_updateSearchUI()
    }
    
    @objc func searchActionPressed() {
//        self.view.endEditing(true)
//        if infoSearchActive != .noOneActive {
//            if infoSearchActive != .searchActive {
//                print("dfvcdefvcsdfv")
//                return
//            }
//        }
//
//        infoSearchActive = .searchActive
//        lets_updateScrollDirections(scrollDirection: .horizontal)
//        //
//        lets_updateSearchUI()
    }
}


extension ModsBlueViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        struct DefaultStruct {
            static let noname = "string"
        }
        switch collectionView {
            //    MARK: - NewCode_____________________________________
        case collectionViewForCategories:
            return (models[0].images?.count)!
            //    MARK: - NewCode_____________________________________
        case settingsCollection:
            return settingsItem.count
            
        case categoriesCollectionView:
            return localDB.categories.count
            
        case contentCollectionView:
            let mod = lets_filterModsArray(current: localDB.lets_getEvilCategory(by: currentCategory)).count
            return mod
            
        case blurCollection:
            if searchTextField.text != "" {
                let mod = lets_filterModsArray(current: localDB.lets_getEvilCategory(by: currentCategory)).count
                return mod
            }
        default: print("")
        }
        return Int()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        struct DefaultStruct {
            static let noname = "string"
        }
        switch collectionView {
        case settingsCollection:
            let cell = settingsCollection.dequeueReusableCell(withReuseIdentifier: "SettingsBlueCollectionViewCell", for: indexPath) as! SettingsBlueCollectionViewCell
            cell.lets_zetupkaTsell(settingsItem[indexPath.row])
            return cell
            
//        case categoriesCollectionView:
//            let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesBlueCollectionViewCell", for: indexPath) as! CategoriesBlueCollectionViewCell
//            if indexPath.row == 0 {
//                cell.lockView.isHidden = IAPManagerPoeTTT.shared.productBuyes.contains(.unlockContentProduct)
//            }
//            cell.lets_zetupkaTsell(localDB.categories[indexPath.row])
//            if currentCategory.contains(localDB.categories[indexPath.row].categoryName) {
//                cell.making_cellBloodySelected()
//            } else {
//                cell.making_cellBloodyDefault()
//            }
//            return cell
            
            //    MARK: - NewCode_____________________________________
        case collectionViewForCategories:
            guard let celll = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell()}
            let modelForColletionView = lets_filterModsArray(current: localDB.lets_getEvilCategory(by: currentCategory))[indexPath.row]
                    celll.configureView(modelForColletionView)
            return celll
            //    MARK: - NewCode_____________________________________
            
        case contentCollectionView:
            if ContentMagicUnLocker.shared.isLocked {
            }
            let cell = contentCollectionView.dequeueReusableCell(withReuseIdentifier: "ContentBlueCollectionViewCell", for: indexPath) as! ContentBlueCollectionViewCell
            let content = lets_filterModsArray(current: localDB.lets_getEvilCategory(by: currentCategory))[indexPath.row]
            cell.cellImage.image = nil
            cell.lets_setupCellBloodyBlue(content)
            return cell
            
        case blurCollection:
            if searchTextField.text != "" {
                let cell = blurCollection.dequeueReusableCell(withReuseIdentifier: "BlurCellCollectionViewCell", for: indexPath) as! BlurCellCollectionViewCell
                let content = lets_filterModsArray(current: localDB.lets_getEvilCategory(by: currentCategory))[indexPath.row]
                cell.cellTitle.text = content.modTitle.trimmingCharacters(in: .whitespacesAndNewlines)
                let count = lets_filterModsArray(current: localDB.lets_getEvilCategory(by: currentCategory)).count
                if indexPath.row == count - 1 {
                    cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
                    cell.layer.cornerRadius = 8
                } else {
                    cell.layer.cornerRadius = 0
                }
                return cell
            }
        default: print("")
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        struct DefaultStruct {
            static let noname = "string"
        }
        switch collectionView {
        case settingsCollection:
            print("settings", settingsItem[indexPath.row].title)
            if indexPath.row == 3 {
                print("restore")
                
            } else {
                let info = InfoBlueViewController()
                info.sett1ngItem = settingsItem[indexPath.row]
                info.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(info, animated: true)
            }
            
            
//        case categoriesCollectionView:
//            //settingsCollection.isHidden = true
//            if !IAPManagerPoeTTT.shared.productBuyes.contains(.unlockContentProduct) {
//                if indexPath.row == 0 {
//                    openSubScreen()
//                    return
//                }
//            }
//            searchTextField.text = ""
//            searchMode = .searchMode
//            lets_updateSearchUI()
//            print("category", indexPath.row)
//            lets_updateScrollDirections(scrollDirection: .horizontal)
//            currentCategory = localDB.categories[indexPath.row].categoryName
//            categoriesCollectionView.reloadData()
//            contentCollectionView.reloadData()
//            blurCollection.reloadData()
//            contentCollectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
//            contentCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//            categoriesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//            //                updateCategoryButton()
//
//
        case contentCollectionView, blurCollection:
            settingsCollection.isHidden = true
            
            if categiriesCollectionType == .settings {
                infoAction(UIButton())
            }
            
            if ContentMagicUnLocker.shared.isLocked {
                
            } else {
                let detail = ModBlueDetailViewController()
                detail.hidesBottomBarWhenPushed = true
                detail.modObject = lets_filterModsArray(current: localDB.lets_getEvilCategory(by: currentCategory))[indexPath.row]
                navigationController?.pushViewController(detail, animated: true)
            }
            
        default: print("")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        struct DefaultStruct {
            static let noname = "string"
        }
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            switch collectionView {
                
            case settingsCollection:
                return CGSize(width: 70, height: settingsCollection.frame.height)
                
//            case categoriesCollectionView:
//                let categoryCellWith = collectionView.frame.width / 3 - 15
//                switch categoryScroll {
//                case .horizontalScroll:
//                    return CGSize(width: categoryCellWith, height: categoryCellWith * 1.5)
//                case .showAllVerticalScroll:
//                    return CGSize(width: categoryCellWith, height: categoryCellWith * 1.5)
//                }
                
            case contentCollectionView:
                return CGSize(width: collectionView.frame.width * 0.9, height: UIScreen.main.bounds.height * 0.7 / 3)
            case blurCollection:
                return CGSize(width: collectionView.frame.width, height: 50)
            default: print("")
            }
        } else {
            switch collectionView {
            case settingsCollection:
                return CGSize(width: settingsCollection.frame.height * 0.7, height: settingsCollection.frame.height)
                
            case categoriesCollectionView:
                let categoryCellWith = collectionView.frame.width / 3 - 36
                switch categoryScroll {
                case .horizontalScroll:
                    return CGSize(width: categoryCellWith, height: categoryCellWith * 1.3)
                case .showAllVerticalScroll:
                    return CGSize(width: categoryCellWith, height: categoryCellWith * 1.3)
                }
                
                
            case contentCollectionView:
                return CGSize(width: collectionView.frame.width * 0.955, height: collectionView.frame.width * 0.49)
            case blurCollection:
                return CGSize(width: collectionView.frame.width, height: 50)
            default: print("")
            }
        }
        
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        struct DefaultStruct {
            static let noname = "string"
        }
        switch collectionView {
        case settingsCollection:
            return 0
            
//        case categoriesCollectionView:
//            if UIDevice.current.userInterfaceIdiom == .phone {
//                return 10
//            } else {
//                return 16
//            }
            
        case contentCollectionView:
            return 18
        default: print("")
        }
        return CGFloat()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        struct DefaultStruct {
            static let noname = "string"
        }
        switch collectionView {
        case settingsCollection:
            return 0
            
        case categoriesCollectionView:
            return 5
            
        case contentCollectionView:
            return 0
        default: print("")
        }
        return CGFloat()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        struct DefaultStruct {
            static let noname = "string"
        }
        switch collectionView {
        case settingsCollection:
            return centerCollectionViewCell(cellWidth: UIDevice.current.userInterfaceIdiom == .phone ? 70 : collectionView.frame.height * 0.7, numberOfItems: Double(settingsItem.count), spaceBetweenCell: 0, collectionView: collectionView)
            
//        case categoriesCollectionView:
//            if UIDevice.current.userInterfaceIdiom == .phone {
//                switch categoryScroll {
//                case .horizontalScroll:
//                    return .init(top: 0, left: 16, bottom: 0, right: 16)
//                case .showAllVerticalScroll:
//                    return .init(top: 8, left: 16, bottom: 16, right: 16)
//                }
//            } else {
//                switch categoryScroll {
//                case .horizontalScroll:
//                    return .init(top: 0, left: 20, bottom: 0, right: 20)
//                case .showAllVerticalScroll:
//                    return .init(top: 12, left: 18, bottom: 16, right: 18)
//                }
//            }
            
        case contentCollectionView:
            if UIDevice.current.userInterfaceIdiom == .phone {
                return .init(top: 18, left: 0, bottom: 50, right: 0)
            } else {
                return .init(top: 18, left: 0, bottom: 90, right: 0)
            }
            
        default: print("")
        }
        return UIEdgeInsets()
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


extension ModsBlueViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        struct DefaultStruct {
            static let noname = "string"
        }
        filteredMods = localDB.lets_getEvilCategory(by: currentCategory).filter({$0.modTitle.lowercased().contains(searchText.lowercased().prefix(10))})
        contentCollectionView.reloadData()
        blurCollection.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        struct DefaultStruct {
            static let noname = "string"
        }
        searchBar.resignFirstResponder()
        contentCollectionView.reloadData()
        blurCollection.reloadData()
    }
    
    func lets_filterModsArray(current array: [ModRealmModelElement]) -> [ModRealmModelElement] {
        struct DefaultStruct {
            static let noname = "string"
        }
        var content: [ModRealmModelElement] = []
        if searchTextField.text == "" {
            content = array
        } else {
            content = filteredMods
        }
        return content
    }
}

extension ModsBlueViewController: CustomModsAlertBloodyProtocolDelegate {
    func lets_makeAction(type: AlertCustomBlueType) {
        struct DefaultStruct {
            static let noname = "string"
        }
        //        print(type)
        //        switch type {
        //        case .watchVideo:
        //            break
        //        case .subscription:
        //            hideCustomAlertWithBlur()
        //            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
        //                SceneDelegate.shared?.lets_loadBloodySubscription()
        //            })
        //        }
    }
    
    func lets_closeThisAlert() {
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_hideCustomAlertWithBlur()
    }
    
}


extension ModsBlueViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        struct DefaultStruct {
            static let noname = "string"
        }
        guard let outputText = textField.text else { return }
        print(outputText)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        struct DefaultStruct {
            static let noname = "string"
        }
        switch textField {
        case searchTextField:
            if searchTextField.isFirstResponder {
                print(searchTextField.text as Any)
                filteredMods = localDB.lets_getEvilCategory(by: currentCategory).filter({$0.modTitle.lowercased().contains(searchTextField.text!.lowercased().prefix(10))})
                contentCollectionView.reloadData()
                blurCollection.reloadData()
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

extension ModsBlueViewController: PremiumMainControllerDelegate {
    func funcProductBuyed() {
        categoriesCollectionView.reloadData()
    }
}


extension ModsBlueViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        localDB.categories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellForCategoriesTableView.identifier, for: indexPath) as? CellForCategoriesTableView else { return UITableViewCell() }
        if indexPath.row == 0 {
            cell.lockView.isHidden = IAPManagerPoeTTT.shared.productBuyes.contains(.unlockContentProduct)
        }
        cell.configureView(localDB.categories[indexPath.row])
        
//        КОД НИЖЕ НЕ НУЖЕН. ОН СКОПИРОВАН, ЧТОБЫ БЫЛО ПОНЯТНО
//        if currentCategory.contains(localDB.categories[indexPath.row].categoryName) {
//            cell.making_cellBloodySelected()
//        } else {
//            cell.making_cellBloodyDefault()
//        }
//        ДО СЮДА
        return cell
            
            
            //        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellForCategoriesTableView.identifier, for: indexPath) as? CellForCategoriesTableView else { return UITableViewCell() }
            //        let modelForTableView = models[indexPath.row]
            //        cell.backgroundColor = .clear
            //        cell.configureView(modelForTableView)
            //        return cell
        }
//        return UITableViewCell()
//    }
}

extension ModsBlueViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //settingsCollection.isHidden = true
        if !IAPManagerPoeTTT.shared.productBuyes.contains(.unlockContentProduct) {
//            if indexPath.row == 0 {
//                openSubScreen()
//                return
//            }
        }
//        searchTextField.text = ""
//        searchMode = .searchMode
////        lets_updateSearchUI()
//        print("category", indexPath.row)
////        lets_updateScrollDirections(scrollDirection: .horizontal)
//        currentCategory = localDB.categories[indexPath.row].categoryName
////        categoriesCollectionView.reloadData()
//        contentCollectionView.reloadData()
//        tableViewForCategories.reloadData()
//        collectionViewForCategories.reloadData()
//        blurCollection.reloadData()
//        collectionViewForCategories.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
//        collectionViewForCategories.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//        categoriesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        //                updateCategoryButton()
        
    }
}
