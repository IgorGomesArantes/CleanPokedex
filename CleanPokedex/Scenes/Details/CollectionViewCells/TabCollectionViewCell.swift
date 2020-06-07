//
//  TabCollectionViewCell.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 07/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit

final class TabCollectionViewCell: UICollectionViewCell {
    // MARK: View properties
    let titleLabel: UILabel = UILabel()
    let pokeballImageView: UIImageView = UIImageView()
    
    // MARK: Initialization methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Overrided methods
extension TabCollectionViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        setAsDeselected()
    }
}

// MARK: Public methods
extension TabCollectionViewCell {
    func setup(title: String) {
        titleLabel.text = title
    }
    
    func setAsSelected() {
        pokeballImageView.isHidden = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func setAsDeselected() {
        pokeballImageView.isHidden = true
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
    }
}

// MARK: Configuration methods
private extension TabCollectionViewCell {
    func initialConfiguration() {
        titleLabelConfiguration()
        pokeballImageViewConfiguration()
        setAsDeselected()
    }
    
    func pokeballImageViewConfiguration() {
        contentView.addSubview(pokeballImageView)
        pokeballImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokeballImageView.widthAnchor.constraint(equalToConstant: 100),
            pokeballImageView.heightAnchor.constraint(equalToConstant: 100),
            pokeballImageView.centerYAnchor.constraint(equalTo: contentView.bottomAnchor),
            pokeballImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        pokeballImageView.image = UIImage(named: "tabPokeball")
    }
    
    func titleLabelConfiguration() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
        
        titleLabel.textAlignment = .center
    }
}
