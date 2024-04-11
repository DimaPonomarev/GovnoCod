//
//  CellForCategoriesTableView.swift
//  ModsApp
//
//  Created by Дмитрий Пономарев on 08.11.2023.
//

import UIKit
import SnapKit

final class CellForCategoriesTableView: UITableViewCell {
    
    //MARK: - identifier
    
    static var identifier: String {
        return String(describing: self)
    }
    
    //  MARK: - UI properties
    
    let categoryImageView = UIImageView()
    let lockView = UIImageView()
    let categoryLabel = UILabel()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupMethods()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - configureView
    
    func configureView(_ model: CategoryRealmModelElement) {
        categoryLabel.text = model.categoryName
    }
}

//  MARK: - Private methods

private extension CellForCategoriesTableView {
    
    //  MARK: - setupMethods
    
    func setupMethods() {
        addViews()
        makeConstraints()
        setupViews()
        makeFirstCell()
    }
    
    //  MARK: - addViews
    
    func addViews() {
        contentView.addSubview(categoryImageView)
        categoryImageView.addSubview(categoryLabel)
        contentView.addSubview(lockView)
    }
    
    //  MARK: - makeConstraints
    
    func makeConstraints() {
        categoryImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(5)
        }
        categoryLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        lockView.snp.makeConstraints {
            $0.edges.equalTo(categoryImageView)
        }
    }
    
    //  MARK: - setupViews
    
    func setupViews() {
        contentView.backgroundColor = UIColor(red: 0.004, green: 0, blue: 0.213, alpha: 1)
        lockView.isHidden = true
        categoryImageView.image = UIImage(named: "buttonBlue")
        lockView.image = UIImage(named: "lockedButtonOnMainScreen")
        categoryLabel.textAlignment = .center
        categoryLabel.textColor = .white
        if UIDevice.current.userInterfaceIdiom == .pad {
            categoryLabel.font = UIFont(name: "VT323-Regular", size: 28)
        } else {
            categoryLabel.font = UIFont(name: "VT323-Regular", size: 24)
        }
    }
    
    func makeFirstCell() {
        print(lockView.isHidden)
    }
    
}

