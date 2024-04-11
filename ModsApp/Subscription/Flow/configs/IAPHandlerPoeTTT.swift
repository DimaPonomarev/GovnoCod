
import Foundation
import StoreKit
import Pushwoosh
import Adjust
import SwiftyStoreKit

protocol IAPManagerProtocolPoeTTT: AnyObject {
    func infoAlert(title: String, message: String)
    func goToTheApp()
    func failed()
}

class IAPManagerPoeTTT: NSObject, SKPaymentTransactionObserver, SKProductsRequestDelegate {
    
    static let shared = IAPManagerPoeTTT()
    weak var  transactionsDelegate: IAPManagerProtocolPoeTTT?
    
    public var  localizablePrice = "$4.99"
    
    
    private var  inMain: SKProduct?
    private var  inUnlockContent: SKProduct?
    private var  inUnlockFunc: SKProduct?
    private var  inUnlockOther: SKProduct?
    var isEditorEnabled = false
    var isRemoveAddBought = false
    
    private var mainProduct = Configurations.mainSubscriptionID
    private var unlockContentProduct = Configurations.unlockContentSubscriptionID
    private var unlockFuncProduct = Configurations.unlockFuncSubscriptionID
    private var unlockOther = Configurations.unlockerThreeSubscriptionID
    
    private var secretKey = Configurations.subscriptionSharedSecret
    
    private var isRestoreTransaction = true
    
    private let iapError      = NSLocalizedString("error_iap", comment: "")
    private let prodIDError   = NSLocalizedString("inval_prod_id", comment: "")
    private let restoreError  = NSLocalizedString("faledRestore", comment: "")
    private let purchaseError = NSLocalizedString("notPurchases", comment: "")
    
    public var productBuy : PremiumMainControllerStylePoeTTT = .unlockFuncProduct
    public var productBuyes: [PremiumMainControllerStylePoeTTT] = []
    
    public func loadProductsFunc() {
        SKPaymentQueue.default().add(self)
        let request = SKProductsRequest(productIdentifiers:[mainProduct,unlockContentProduct,unlockFuncProduct,unlockOther])
        request.delegate = self
        request.start()
    }
    
    
    public func doPurchase() {
        switch productBuy {
        case .mainProduct:
            if let inMain {
                processPurchase(for: inMain, with: Configurations.mainSubscriptionID)
            }
            else {
                transactionsDelegate?.infoAlert(title: "Error", message: "Product is empty!")
            }
        case .unlockContentProduct:
            if let inUnlockContent {
                processPurchase(for: inUnlockContent, with: Configurations.unlockContentSubscriptionID)
            }
            else {
                transactionsDelegate?.infoAlert(title: "Error", message: "Product is empty!")
            }
        case .unlockFuncProduct:
            if let inUnlockFunc {
                processPurchase(for: inUnlockFunc, with: Configurations.unlockFuncSubscriptionID)
            }
            else {
                transactionsDelegate?.infoAlert(title: "Error", message: "Product is empty!")
            }
        case .unlockOther:
            if let inUnlockOther {
                processPurchase(for: inUnlockOther, with: Configurations.unlockerThreeSubscriptionID)
            }
            else {
                transactionsDelegate?.infoAlert(title: "Error", message: "Product is empty!")
            }
        }
    }
    
    public func localizedPrice() -> String {
        guard NetworkStatusMonitorPoeTTT.shared.isNetworkAvailable else { return localizablePrice }
        switch productBuy {
        case .mainProduct:
            processProductPrice(for: inMain)
        case .unlockContentProduct:
            processProductPrice(for: inUnlockContent)
        case .unlockFuncProduct:
            processProductPrice(for: inUnlockFunc)
        case .unlockOther:
            processProductPrice(for: inUnlockOther)
        }
        return localizablePrice
    }
    
    private func getCurrentProduct() -> SKProduct? {
        switch productBuy {
        case .mainProduct:
            return self.inMain
        case .unlockContentProduct:
            return self.inUnlockContent
        case .unlockFuncProduct:
            return self.inUnlockFunc
        case .unlockOther:
            return self.inUnlockOther
        }
    }
    
    private func processPurchase(for product: SKProduct, with configurationId: String) {
        if product.productIdentifier.isEmpty {
            
            self.transactionsDelegate?.infoAlert(title: iapError, message: prodIDError)
        } else if product.productIdentifier == configurationId {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        }
    }
    
    
    public func doRestore() {
        guard isRestoreTransaction else { return }
        SKPaymentQueue.default().restoreCompletedTransactions()
        isRestoreTransaction = false
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        if queue.transactions.isEmpty {
            print("No purchases to restore")
            transactionsDelegate?.infoAlert(title: iapError, message: restoreError)
        } else {
            print("Restored \(queue.transactions.count) purchases")
        }
    }
    
    private func completeRestoredStatusFunc(restoreProductID : String) {
//        guard isRestoreTransaction else {
//            return
//        }
//
//        isRestoreTransaction = false
        
        validateSubscriptionWithCompletionHandler(productIdentifier: restoreProductID) { [weak self] result in
            guard let self = self else {
                return
            }
            
            if result {
                self.isRestoreTransaction = false
                self.transactionsDelegate?.goToTheApp()
            } else {
                self.isRestoreTransaction = true
                self.transactionsDelegate?.infoAlert(title: self.restoreError, message: self.purchaseError)
            }
        }
    }
    
    
    public func completeAllTransactionsFunc() {
        let transactions = SKPaymentQueue.default().transactions
        for transaction in transactions {
            let transactionState = transaction.transactionState
            if transactionState == .purchased || transactionState == .restored {
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
    
    // Ваша собственная функция для проверки подписки.
    public func validateSubscriptionWithCompletionHandler(productIdentifier: String,_ resultExamination: @escaping (Bool) -> Void) {
        SKReceiptRefreshRequest().start()
        
        guard let receiptUrl = Bundle.main.appStoreReceiptURL,
              let receiptData = try? Data(contentsOf: receiptUrl) else {
            pushwooshSetSubTag(value: false)
            resultExamination(false)
            return
        }
        
        let receiptDataString = receiptData.base64EncodedString(options: [])
        
        let jsonRequestBody: [String: Any] = [
            "receipt-data": receiptDataString,
            "password": self.secretKey,
            "exclude-old-transactions": true
        ]
        
        let requestData: Data
        do {
            requestData = try JSONSerialization.data(withJSONObject: jsonRequestBody)
        } catch {
            print("Failed to serialize JSON: \(error)")
            pushwooshSetSubTag(value: false)
            resultExamination(false)
            return
        }
#warning("replace to release")
        //#if DEBUG
        let url = URL(string: "https://sandbox.itunes.apple.com/verifyReceipt")!
        //#else
        //        let url = URL(string: "https://buy.itunes.apple.com/verifyReceipt")!
        //#endif
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = requestData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Failed to validate receipt: \(error) IAPManager")
                self.pushwooshSetSubTag(value: false)
                resultExamination(false)
                return
            }
            
            guard let data = data else {
                print("No data received from receipt validation IAPManager")
                self.pushwooshSetSubTag(value: false)
                resultExamination(false)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let latestReceiptInfo = json["latest_receipt_info"] as? [[String: Any]] {
                    for receipt in latestReceiptInfo {
                        if let receiptProductIdentifier = receipt["product_id"] as? String,
                           receiptProductIdentifier == productIdentifier,
                           let expiresDateMsString = receipt["expires_date_ms"] as? String,
                           let expiresDateMs = Double(expiresDateMsString) {
                            let expiresDate = Date(timeIntervalSince1970: expiresDateMs / 1000)
                            if expiresDate > Date() {
                                DispatchQueue.main.async {
                                    self.pushwooshSetSubTag(value: true)
                                    resultExamination(true)
                                }
                                return
                            }
                        }
                    }
                }
            } catch {
                print("Failed to parse receipt data 🔴: \(error) IAPManager")
            }
            
            DispatchQueue.main.async {
                self.pushwooshSetSubTag(value: false)
                resultExamination(false)
            }
        }
        task.resume()
    }
    
    
    func validateSubscriptions(productIdentifiers: [String], completion: @escaping ([String: Bool]) -> Void) {
        var results = [String: Bool]()
        let dispatchGroup = DispatchGroup()
        
        for productIdentifier in productIdentifiers {
            dispatchGroup.enter()
            validateSubscriptionWithCompletionHandler(productIdentifier: productIdentifier) { isValid in
                if isValid {
                    if productIdentifier == SubscriptionKey.mainSubscriptionID {
                        self.productBuyes.append(.mainProduct)
                    } else if productIdentifier == SubscriptionKey.unlockFuncSubscriptionID {
                        self.productBuyes.append(.unlockFuncProduct)
                    } else if productIdentifier == SubscriptionKey.unlockContentSubscriptionID {
                        self.productBuyes.append(.unlockContentProduct)
                    }
                }
                results[productIdentifier] = isValid
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(results)
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        Pushwoosh.sharedInstance().sendSKPaymentTransactions(transactions)
        for transaction in transactions {
            if let error = transaction.error as NSError?, error.domain == SKErrorDomain {
                switch error.code {
                case SKError.paymentCancelled.rawValue:
                    print("User cancelled the request IAPManager")
                case SKError.paymentNotAllowed.rawValue, SKError.paymentInvalid.rawValue, SKError.clientInvalid.rawValue, SKError.unknown.rawValue:
                    print("This device is not allowed to make the payment IAPManager")
                default:
                    break
                }
            }
            
            switch transaction.transactionState {
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                if let product = getCurrentProduct() {
                    if transaction.payment.productIdentifier == product.productIdentifier {
                        trackSubscription(transaction: transaction, product:  product)
                        transactionsDelegate?.goToTheApp()
                    }
                    
                    if product.productIdentifier == SubscriptionKey.mainSubscriptionID {
                        productBuyes.append(.mainProduct)
                    } else if product.productIdentifier == SubscriptionKey.unlockFuncSubscriptionID {
                        productBuyes.append(.unlockFuncProduct)
                        isRemoveAddBought = true
                        isEditorEnabled = true
                    } else if product.productIdentifier == SubscriptionKey.unlockContentSubscriptionID {
                        productBuyes.append(.unlockContentProduct)
                    }
                }
                
                //  print("Purchased IAPManager")
                
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                transactionsDelegate?.failed()
                print("Failed IAPManager")
                
            case .restored:
                if let product = getCurrentProduct() {
                    trackSubscription(transaction: transaction, product:  product)
                    completeRestoredStatusFunc(restoreProductID: product.productIdentifier)
                }
                SKPaymentQueue.default().finishTransaction(transaction)
                print("Restored IAPManager")
                
            case .purchasing, .deferred:
                print("Purchasing IAPManager")
                
            default:
                print("Default IAPManager")
            }
        }
        completeAllTransactionsFunc()
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("requesting to product IAPManager")
        
        if let invalidIdentifier = response.invalidProductIdentifiers.first {
            print("Invalid product identifier:", invalidIdentifier , "IAPManager")
        }
        
        guard !response.products.isEmpty else {
            print("No products available IAPManager")
            return
        }
        
        response.products.forEach({ productFromRequest in
            switch productFromRequest.productIdentifier {
            case Configurations.mainSubscriptionID:
                inMain = productFromRequest
            case Configurations.unlockContentSubscriptionID:
                inUnlockContent = productFromRequest
            case Configurations.unlockFuncSubscriptionID:
                inUnlockFunc = productFromRequest
            case Configurations.unlockerThreeSubscriptionID:
                inUnlockOther = productFromRequest
            default:
                print("error IAPManager")
                return
            }
            print("Found product: \(productFromRequest.productIdentifier) IAPManager")
        })
    }
    
    private func processProductPrice(for product: SKProduct?) {
        guard let product = product else { return }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = product.priceLocale
        
        if let formattedPrice = numberFormatter.string(from: product.price) {
            self.localizablePrice = formattedPrice
        } else {
            self.localizablePrice = "4.99 $"
        }
    }
    
    private func pushwooshSetSubTag(value : Bool) {
        
        var tag = Configurations.mainSubscriptionPushTag
        
        switch productBuy {
        case .mainProduct:
            print("continue IAPManager")
        case .unlockContentProduct:
            tag = Configurations.unlockContentSubscriptionPushTag
        case .unlockFuncProduct:
            tag = Configurations.unlockFuncSubscriptionPushTag
        case .unlockOther:
            tag = Configurations.unlockerThreeSubscriptionPushTag
        }
        
        Pushwoosh.sharedInstance().setTags([tag: value]) { error in
            if let err = error {
                print(err.localizedDescription)
                print("send tag error IAPManager")
            }
        }
    }
    
    private func trackSubscription(transaction: SKPaymentTransaction, product: SKProduct) {
        if let receiptURL = Bundle.main.appStoreReceiptURL,
           let receiptData = try? Data(contentsOf: receiptURL) {
            
            let price = NSDecimalNumber(decimal: product.price.decimalValue)
            let currency = product.priceLocale.currencyCode ?? "USD"
            let transactionId = transaction.transactionIdentifier ?? ""
            let transactionDate = transaction.transactionDate ?? Date()
            let salesRegion = product.priceLocale.regionCode ?? "US"
            
            if let subscription = ADJSubscription(price: price, currency: currency, transactionId: transactionId, andReceipt: receiptData) {
                subscription.setTransactionDate(transactionDate)
                subscription.setSalesRegion(salesRegion)
                Adjust.trackSubscription(subscription)
            }
        }
    }
}
