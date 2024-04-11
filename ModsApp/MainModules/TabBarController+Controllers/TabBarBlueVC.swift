import UIKit
//

class TabBarBlueController: UITabBarController {
    
    private var modsViewController = ModsBlueViewController()
    private var myWorksViewController = MyBlueWorksViewController()
    private var editorViewController = EditorBlueViewController()
    
    private let widthScreen = Int(UIScreen.main.bounds.width)
    private let heightTabBar = 150
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        struct DefaultStruct {
            static let noname = "string"
        }
        self.delegate = self
        hideKeyboardWhenTappedAroundMainScreen()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_setupTabBarItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        struct DefaultStruct {
            static let noname = "string"
        }
    }
}

// MARK: - Setup UI
extension TabBarBlueController {
    
    private func lets_setupTabBarItems()  {
        struct DefaultStruct {
            static let noname = "string"
        }
        tabBar.frame = CGRect(x: Int(self.view.frame.minX), y: Int(self.view.frame.maxY) - (heightTabBar), width: widthScreen, height: heightTabBar)
        guard let items = tabBar.items else { return }
        let imagesSelected = ["editor_on", "mods_on", "myWorks_on"]
        let imagesDeselected = ["editor_off", "mods_off", "myWorks_off"]
        for num in 0..<items.count {
            items[num].image = UIImage(named: imagesDeselected[num])?.withRenderingMode(.alwaysOriginal)
            items[num].selectedImage = UIImage(named: imagesSelected[num])?.withRenderingMode(.alwaysOriginal)
            if UIDevice.current.userInterfaceIdiom == .pad {
                items[num].titlePositionAdjustment = .init(horizontal: 20, vertical: -(items[num].image?.size.height)! / 1.5)
                items[num].imageInsets = UIEdgeInsets(top: -5, left: 0, bottom: -5, right: 0)
            } else {
                items[num].titlePositionAdjustment = .zero
            }
        }
        tabBar.itemPositioning = .centered
        lets_setupSomething()
    }
    
    private func lets_setupSomething() {
        struct DefaultStruct {
            static let noname = "string"
        }
        let editorNavigation = UINavigationController()
        let modsNavigation = UINavigationController()
        let myWorksNavigation = UINavigationController()
        
        for nav in [editorNavigation, modsNavigation, myWorksNavigation] {
            nav.navigationBar.isHidden = true
        }
        
        editorNavigation.title = NSLocalizedString("Editor_", comment: "").uppercased()
        modsNavigation.title = NSLocalizedString("Mods_", comment: "").uppercased()
        myWorksNavigation.title = NSLocalizedString("My_Works", comment: "").uppercased()
        
        
        editorNavigation.viewControllers = [editorViewController]
        modsNavigation.viewControllers = [modsViewController]
        myWorksNavigation.viewControllers = [myWorksViewController]
        
        tabBar.tintColor = .white
        tabBar.barTintColor = .white
        tabBar.backgroundColor = UIColor(named: "Victoria")

        setViewControllers([editorNavigation, modsNavigation, myWorksNavigation], animated: true)
        selectedViewController = modsNavigation
        
    }
}


// MARK: - UITabBarControllerDelegate
extension TabBarBlueController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        struct DefaultStruct {
            static let noname = "string"
        }
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        struct DefaultStruct {
            static let noname = "string"
        }
        tabBar.barTintColor = .red
    }
}
