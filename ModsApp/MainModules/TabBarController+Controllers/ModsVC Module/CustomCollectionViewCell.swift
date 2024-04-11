//
//  CustomCollectionViewCell.swift
//  ModsApp
//
//  Created by Дмитрий Пономарев on 08.11.2023.
//


import UIKit
import SnapKit

final class CustomCollectionViewCell: UICollectionViewCell {
    
    //MARK: - identifier
    
    static var identifier: String {
        return String(describing: self)
    }
    
    //  MARK: - UI properties
    
    let recatngleImageView = UIImageView()
    let inputtedImageViewInReactngle = UIImageView()
    let descriptionView = UIImageView()
    let mainTitleLabel = UILabel()
    let subTitleLabel = UILabel()

    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMethods()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - configureView
    
    public func configureView(_ model: ModRealmModelElement) {
        recatngleImageView.image = UIImage()
        mainTitleLabel.text = model.modTitle.uppercased()
        subTitleLabel.text = model.modDescription
        if model.modImageData.count == 0 {
            DropBoxBeautifulManager.shared.getBloodyImageURLFromDropBox(img: model.modImagePath) { urlString in
                if let urlString = urlString {
                    self.recatngleImageView.lets_setupBloodyImages(from: urlString, mod: model, category: nil, editorItem: nil, type: .mods)
                }
            }
        } else {
            recatngleImageView.image = UIImage(data: model.modImageData)
        }
    }
}

//  MARK: - Private methods

private extension CustomCollectionViewCell {
    
    //MARK: - setup
    
    func setupMethods() {
        addViews()
        setupViews()
        setupConstraints()
    }
    
    func addViews() {
        contentView.addSubview(recatngleImageView)
        recatngleImageView.addSubview(descriptionView)
        descriptionView.addSubview(mainTitleLabel)
        descriptionView.addSubview(subTitleLabel)

    }
    
    //MARK: - setupConstraints
    
    func setupConstraints() {
        recatngleImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        descriptionView.snp.makeConstraints {
            $0.bottom.left.equalToSuperview()
        }
        mainTitleLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(2)
        }
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(2)
            $0.left.equalTo(mainTitleLabel)
            $0.bottom.equalToSuperview()
        }

    }
    
    func setupViews() {
        contentView.backgroundColor = .clear
        descriptionView.image = UIImage(named: "descriptionViewOnMainView")
        mainTitleLabel.text = "hello"
        subTitleLabel.text = "hell hello"
        recatngleImageView.image = UIImage(named: "rectangleForImageViewOnMainScreen")
    }
}
