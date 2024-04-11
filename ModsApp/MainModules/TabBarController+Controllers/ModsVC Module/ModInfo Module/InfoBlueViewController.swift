

import UIKit
import SafariServices
import WebKit

class InfoBlueViewController: UIViewController {
    
    @IBOutlet weak var navBarBgImage: UIImageView!
    @IBOutlet weak var ma1nT1tle: UILabel!
    @IBOutlet weak var webV1ew: WKWebView!
    
    var sett1ngItem: ModelForSettingsItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        struct DefaultStruct {
            static let noname = "string"
        }
        if NetMonitor.shared.isReachable == false {
            let alert = UIAlertController(title: NSLocalizedString("noInternetConnection", comment: ""), message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
        }
        
        //
        view.backgroundColor = UIColor(red: 36/256, green: 16/256, blue: 10/256, alpha: 1)
        //view.backgroundColor = UIColor(red: 0.341, green: 0.51, blue: 0.545, alpha: 1)
        if UIDevice.current.userInterfaceIdiom == .pad {
            ma1nT1tle.font = UIFont(name: "VT323-Regular", size: 62)
        } else {
            ma1nT1tle.font = UIFont(name: "VT323-Regular", size: 38)
        }
        ma1nT1tle.textColor = UIColor.white
        ma1nT1tle.text = sett1ngItem.title.uppercased()
        webV1ew.backgroundColor = .clear
        let url = URL(string: sett1ngItem.urlStr)!
        webV1ew.load(URLRequest(url: url))
        webV1ew.allowsBackForwardNavigationGestures = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        struct DefaultStruct {
            static let noname = "string"
        }
        navBarBgImage.lets_setLinearGradientBackground(startColor: UIColor(red: 0.26, green: 0.25, blue: 0.55, alpha: 1.0),
                                                  endColor: UIColor(red: 0.17, green: 0.16, blue: 0.35, alpha: 1.0))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        struct DefaultStruct {
            static let noname = "string"
        }
        print("🌀 \(String(describing: type(of: self)))")
    }
    

    @IBAction func goBloodyeBack(_ sender: UIButton) {
        struct DefaultStruct {
            static let noname = "string"
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    
}

