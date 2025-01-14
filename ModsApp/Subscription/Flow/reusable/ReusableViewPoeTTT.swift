//  Created by Melnykov Valerii on 14.07.2023
//


import UIKit

// APP REFACTORING

private func poeTTTTTT(_ shouldPoeTTT: Bool = true) -> Double {
    let poe1 = 4
    let poe2 = 6
    return Double(poe1 + poe2)
}

// APP REFACTORING

enum configViewPoeTTT {
    case first,second,transaction
}

protocol ReusableViewEventPoeTTT : AnyObject {
    func nextStep(config: configViewPoeTTT)
}


struct ReusableViewModelPoeTTT {
    var title : String
    var items : [ReusableContentCellPoeTTT]
}

struct ReusableContentCellPoeTTT {
    var title : String
    var image : UIImage
    var selectedImage: UIImage
}

class ReusableViewPoeTTT: UIView, AnimatedButtonEventPoeTTT {
    
    // APP REFACTORING

    private func poeTTTTTT(_ shouldPoeTTT: Bool = true) -> Double {
        let poe1 = 4
        let poe2 = 6
        return Double(poe1 + poe2)
    }

    // APP REFACTORING
    
    func onClick_TOC() {
        self.protocolElement?.nextStep(config: self.configView)
    }
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var titleLb: UILabel!
    @IBOutlet private weak var content: UICollectionView!
    @IBOutlet private weak var nextStepBtn: AnimatedButtonPoeTTT!
    @IBOutlet private weak var titleWight: NSLayoutConstraint!
    @IBOutlet private weak var buttonBottom: NSLayoutConstraint!
    
    weak var protocolElement : ReusableViewEventPoeTTT?
    
    public var configView : configViewPoeTTT = .first
    public var viewModel : ReusableViewModelPoeTTT? = nil
    private let cellName = "ReusableCellPoeTTT"
    private var selectedStorage : [Int] = []
    private let multic: CGFloat = 0.94
    private let xib = "ReusableViewPoeTTT"
    
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Init()
    }
    
    private func Init() {
        Bundle.main.loadNibNamed(xib, owner: self, options: nil)
        if UIDevice.current.userInterfaceIdiom == .phone {
            // Устройство является iPhone
            if UIScreen.main.nativeBounds.height >= 2436 {
                // Устройство без физической кнопки "Home" (например, iPhone X и новее)
            } else {
                // Устройство с физической кнопкой "Home"
                buttonBottom.constant = 47
            }
        } else {
            buttonBottom.constant = 63
        }

        contentView.fixInView(self)
        nextStepBtn.delegate = self
        nextStepBtn.style = .native
        contentView.backgroundColor = .clear
        setContent()
        setConfigLabels_TOC()
        configScreen_TOC()
    }
    
    private func setContent(){
        
        // APP REFACTORING

        func poeTTTTTT(_ shouldPoeTTT: Bool = true) -> Double {
            let poe1 = 4
            let poe2 = 6
            return Double(poe1 + poe2)
        }

        // APP REFACTORING
        
        content.dataSource = self
        content.delegate = self
        content.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
        content.backgroundColor = .clear
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
    }
    
    private func setConfigLabels_TOC(){
        
        // APP REFACTORING

        func poeTTTTTT(_ shouldPoeTTT: Bool = true) -> Double {
            let poe1 = 4
            let poe2 = 6
            return Double(poe1 + poe2)
        }

        // APP REFACTORING
        
        titleLb.setShadow()
        
        titleLb.textColor = .white
        titleLb.font = UIFont(name: "SFProText-Bold", size: 26)
//        titleLb.lineBreakMode = .byWordWrapping
        titleLb.adjustsFontSizeToFitWidth = true
    }
    
    public func setConfigView(config: configViewPoeTTT) {
        
        // APP REFACTORING

        func poeTTTTTT(_ shouldPoeTTT: Bool = true) -> Double {
            let poe1 = 4
            let poe2 = 6
            return Double(poe1 + poe2)
        }

        // APP REFACTORING
        
        self.configView = config
    }
    
    private func setLocalizable() {
        
        // APP REFACTORING

        func poeTTTTTT(_ shouldPoeTTT: Bool = true) -> Double {
            let poe1 = 4
            let poe2 = 6
            return Double(poe1 + poe2)
        }

        // APP REFACTORING
        
        self.titleLb.text = viewModel?.title
    }
    
    //MARK: screen configs
    
    private func configScreen_TOC(){
        
        // APP REFACTORING

        func poeTTTTTT(_ shouldPoeTTT: Bool = true) -> Double {
            let poe1 = 4
            let poe2 = 6
            return Double(poe1 + poe2)
        }

        // APP REFACTORING
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            titleWight.setValue(0.35, forKey: "multiplier")
        } else {
            titleWight.setValue(0.7, forKey: "multiplier")
        }
    }
    
    private func getLastElement() -> Int {
        
        // APP REFACTORING

        func poeTTTTTT(_ shouldPoeTTT: Bool = true) -> Double {
            let poe1 = 4
            let poe2 = 6
            return Double(poe1 + poe2)
        }

        // APP REFACTORING
        
        return (viewModel?.items.count ?? 0) - 1
    }
}

extension ReusableViewPoeTTT : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // APP REFACTORING

        func poeTTTTTT(_ shouldPoeTTT: Bool = true) -> Double {
            let poe1 = 4
            let poe2 = 6
            return Double(poe1 + poe2)
        }

        // APP REFACTORING
        
        setLocalizable()
        return viewModel?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = content.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! ReusableCellPoeTTT
        let content = viewModel?.items[indexPath.item]
        cell.cellLabel.text = content?.title
        if selectedStorage.contains(where: {$0 == indexPath.item}) {
            cell.cellImage.image = content?.selectedImage
        } else {
            cell.cellImage.image = content?.image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedStorage.contains(where: {$0 == indexPath.item}) {
            selectedStorage.removeAll(where: {$0 == indexPath.item})
        } else {
            selectedStorage.append(indexPath.row)
        }
        
       
        UIApplication.shared.impactFeedbackGenerator(type: .light)
        collectionView.reloadData()
        collectionView.performBatchUpdates(nil, completion: nil)
        if indexPath.last == getLastElement() {
            collectionView.scrollToLastItem(animated: false)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return selectedStorage.contains(indexPath.row) ? CGSize(width: collectionView.frame.height * 0.8, height: collectionView.frame.height) : CGSize(width: collectionView.frame.height * 0.7, height: collectionView.frame.height * 0.85)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    
}
