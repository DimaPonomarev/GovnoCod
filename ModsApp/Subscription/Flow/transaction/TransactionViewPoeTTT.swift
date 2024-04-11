//  Created by Melnykov Valerii on 14.07.2023
//


import UIKit

protocol TransactionViewEventsPoeTTT : AnyObject {
    func userSubscribed()
    func transactionTreatment_TOC(title: String, message: String)
    func transactionFailed()
    func privacyOpen()
    func termsOpen()
}

class TransactionViewPoeTTT: UIView,AnimatedButtonEventPoeTTT,IAPManagerProtocolPoeTTT {
    func showBadMess() {
        transactionTreatment_TOC(title: NSLocalizedString( "Text30ID", comment: ""), message: NSLocalizedString("Text31ID", comment: ""))
    }
    
    private let xib = "TransactionViewPoeTTT"
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private(set) weak var title: SliderPoeTTT!
    @IBOutlet private(set) weak var trialLb: UILabel!
    @IBOutlet private(set) weak var descriptLb: UILabel!
    @IBOutlet private weak var purchaseBtn: AnimatedButtonPoeTTT!
    @IBOutlet private weak var privacyBtn: UIButton!
    @IBOutlet private weak var policyBtn: UIButton!
    @IBOutlet private weak var trialWight: NSLayoutConstraint!
    @IBOutlet private weak var sliderWight: NSLayoutConstraint!
    @IBOutlet private weak var sliderTop: NSLayoutConstraint!
    @IBOutlet private weak var conteinerWidth: NSLayoutConstraint!
    
    
    private let currentFont = "SFProText-Bold"
    public let inapp = IAPManagerPoeTTT.shared
    private let locale = NSLocale.current.languageCode
    public weak var delegate : TransactionViewEventsPoeTTT?
    private let networkingMonitor = NetworkStatusMonitorPoeTTT.shared
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Init()
    }
    
    public func localizeDescriptionLabel() {

    }
    
    private func Init() {
        Bundle.main.loadNibNamed(xib, owner: self, options: nil)
        if UIDevice.current.userInterfaceIdiom == .phone {
            // Устройство является iPhone
            if UIScreen.main.nativeBounds.height >= 2436 {
            } else {
                sliderTop.constant = 60
            }
        } else {
            conteinerWidth.constant = 400
            sliderTop.constant = 45
        }
        contentView.fixInView(self)
        contentView.backgroundColor = .clear
        buildConfigs_TOC()
    }
    
    private func buildConfigs_TOC(){
        configScreen_TOC()
        setSlider_TOC()
        setConfigLabels_TOC()
        setConfigButtons_TOC()
        setLocalization_TOC()
        configsInApp_TOC()
    }
    
    private func setSlider_TOC(){
        title.enableGestures = true
        title.backgroundColor = .clear
        // title.adjustsFontSizeToFitWidth = true
    }
    
    //MARK: config labels
    
    private func setConfigLabels_TOC(){
        //slider
        title.label.textColor = .white
        title.label.font = UIFont(name: currentFont, size: 21)
        title.label.adjustsFontSizeToFitWidth = true
        title.label.numberOfLines = 4
        title.label.setShadow()
        title.label.lineBreakMode = .byClipping
        if UIDevice.current.userInterfaceIdiom == .pad {
            title.label.font = UIFont(name: currentFont, size: 21)
        }
        trialLb.setShadow()
        trialLb.font = UIFont(name: currentFont, size: 13)
        trialLb.textColor = .white
        trialLb.textAlignment = .center
        trialLb.numberOfLines = 2
        trialLb.adjustsFontSizeToFitWidth = true
        
        descriptLb.setShadow()
        descriptLb.textColor = .white
        descriptLb.textAlignment = .center
        descriptLb.numberOfLines = 0
        descriptLb.font = UIFont.systemFont(ofSize: 15)
        
        privacyBtn.titleLabel?.setShadow()
        privacyBtn.titleLabel?.numberOfLines = 2
        privacyBtn.titleLabel?.textAlignment = .center
        
        privacyBtn.setTitleColor(.white, for: .normal)
        privacyBtn.tintColor = .white
        
        policyBtn.titleLabel?.setShadow()
        policyBtn.titleLabel?.numberOfLines = 2
        policyBtn.titleLabel?.textAlignment = .center
        policyBtn.setTitleColor(.white, for: .normal)
        policyBtn.tintColor = .white
    }
    
    //MARK: config button
    
    private func setConfigButtons_TOC(){
        self.purchaseBtn.delegate = self
        self.purchaseBtn.style = .native
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.purchaseBtn.setPulseAnimation()
        }
    }
    
    //MARK: config localization
    
    public func setLocalization_TOC() {
        title.labelTextsForSlider = "\(localizedString(forKey: "SliderID1").uppercased())|n\(localizedString(forKey: "SliderID2").uppercased())|n\(localizedString(forKey: "SliderID3").uppercased()) |n\(localizedString(forKey: "SliderID4").uppercased()) |n\(localizedString(forKey: "SliderID5").uppercased())"
        
        let description = localizedString(forKey: "iOSAfterID")
        let localizedPrice = IAPManagerPoeTTT.shared.localizedPrice()
        if locale == "en" {
            let string = "Start 3-days for FREE\n Then \(localizedPrice)/week".uppercased()
            trialLb.text = string
        }else {
            trialLb.text = ""
        }
        descriptLb.text = String(format: description, localizedPrice)
        
        privacyBtn.titleLabel?.lineBreakMode = .byWordWrapping
        privacyBtn.setAttributedTitle(localizedString(forKey: "TermsID").underLined, for: .normal)
        policyBtn.titleLabel?.lineBreakMode = .byWordWrapping
        policyBtn.setAttributedTitle(localizedString(forKey: "PrivacyID").underLined, for: .normal)
    }
    
    //MARK: screen configs
    
    private func configScreen_TOC(){
        if UIDevice.current.userInterfaceIdiom == .pad {
            trialWight.setValue(0.28, forKey: "multiplier")
            sliderWight.setValue(0.5, forKey: "multiplier")
        } else {
            trialWight.setValue(0.46, forKey: "multiplier")
            sliderWight.setValue(0.8, forKey: "multiplier")
        }
    }
    
    //MARK: configs
    private func configsInApp_TOC(){
        self.inapp.transactionsDelegate = self
    }
    
    
    public func restoreAction(){
        inapp.doRestore()
    }
    
    //MARK: actions
    
    @IBAction func privacyAction(_ sender: UIButton) {
        
        self.delegate?.termsOpen()
    }
    
    @IBAction func termsAction(_ sender: UIButton) {
        self.delegate?.privacyOpen()
    }
    
    func onClick_TOC() {
        guard NetworkStatusMonitorPoeTTT.shared.isNetworkAvailable else {
            showBadMess()
            return
        }
        UIApplication.shared.impactFeedbackGenerator(type: .heavy)
        inapp.doPurchase()
        purchaseBtn.isUserInteractionEnabled = false
    }
    
    //inapp
    
    func transactionTreatment_TOC(title: String, message: String) {
        self.delegate?.transactionTreatment_TOC(title: title, message: message)
    }
    
    func infoAlert(title: String, message: String) {
        purchaseBtn.isUserInteractionEnabled = true
        self.delegate?.transactionTreatment_TOC(title: title, message: message)
    }
    
    func goToTheApp() {
        self.delegate?.userSubscribed()
    }
    
    func failed() {
        purchaseBtn.isUserInteractionEnabled = true
        self.delegate?.transactionFailed()
    }
}
