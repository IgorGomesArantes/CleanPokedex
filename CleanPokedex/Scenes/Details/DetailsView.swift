//
//  DetailsView.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 06/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class DetailsView: UIView {
    // MARK: View properties
    let codeLabel: UILabel = UILabel()
    let nameLabel: UILabel = UILabel()
    let containerView: UIView = UIView()
    let tagsStackView: UIStackView = UIStackView()
    let pokemonImageView: UIImageView = UIImageView()
    let informationTableView: UITableView = UITableView()
    let backgroudCircleImageView: UIImageView = UIImageView()
    let backgroundDetailImageView: UIImageView = UIImageView()
    let tabsCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: buildTabsCollectionFlowLayout())
    
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
extension DetailsView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        informationTableView.layer.cornerRadius = 25
        informationTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

// MARK: Configuration methods
private extension DetailsView {
    func initialConfiguration() {
        containerViewConfiguration()
        backgroudCircleImageViewConfiguration()
        pokemonImageViewConfiguration()
        codeLabelConfiguration()
        nameLabelConfiguration()
        backgroundDetailImageViewConfiguration()
        tagsStackViewConfiguration()
        tabsCollectionViewConfiguration()
        informationTableViewConfiguration()
    }
    
    func containerViewConfiguration() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 200),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func backgroudCircleImageViewConfiguration() {
        containerView.addSubview(backgroudCircleImageView)
        backgroudCircleImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroudCircleImageView.widthAnchor.constraint(equalToConstant: 130),
            backgroudCircleImageView.heightAnchor.constraint(equalToConstant: 130),
            backgroudCircleImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            backgroudCircleImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        ])
        
        backgroudCircleImageView.image = UIImage(named: "circle")
    }
    
    func pokemonImageViewConfiguration() {
        backgroudCircleImageView.addSubview(pokemonImageView)
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokemonImageView.widthAnchor.constraint(equalTo: backgroudCircleImageView.widthAnchor),
            pokemonImageView.heightAnchor.constraint(equalTo: backgroudCircleImageView.heightAnchor),
            pokemonImageView.centerYAnchor.constraint(equalTo: backgroudCircleImageView.centerYAnchor),
            pokemonImageView.centerXAnchor.constraint(equalTo: backgroudCircleImageView.centerXAnchor)
        ])
    }
    
    func codeLabelConfiguration() {
        containerView.addSubview(codeLabel)
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            codeLabel.topAnchor.constraint(equalTo: pokemonImageView.topAnchor, constant: 20),
            codeLabel.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: 25),
            codeLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -20)
        ])
        
        codeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        codeLabel.textColor = UIColor(red: 0.09, green: 0.09, blue: 0.106, alpha: 0.6)
    }
    
    func nameLabelConfiguration() {
        containerView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: codeLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: 25),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -20)
        ])
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 26)
        nameLabel.textColor = .white
    }
    
    func backgroundDetailImageViewConfiguration() {
        containerView.addSubview(backgroundDetailImageView)
        backgroundDetailImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundDetailImageView.widthAnchor.constraint(equalToConstant: 65),
            backgroundDetailImageView.heightAnchor.constraint(equalToConstant: 65),
            backgroundDetailImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            backgroundDetailImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        backgroundDetailImageView.image = UIImage(named: "backgroundDetail2")
    }
    
    func tagsStackViewConfiguration() {
        containerView.addSubview(tagsStackView)
        tagsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tagsStackView.heightAnchor.constraint(equalToConstant: 25),
            tagsStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            tagsStackView.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: 25),
            tagsStackView.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -20)
        ])
        
        tagsStackView.spacing = 5
        tagsStackView.axis = .horizontal
    }
    
    func tabsCollectionViewConfiguration() {
        addSubview(tabsCollectionView)
        tabsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tabsCollectionView.heightAnchor.constraint(equalToConstant: 50),
            tabsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tabsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tabsCollectionView.topAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        tabsCollectionView.isScrollEnabled = false
        tabsCollectionView.backgroundColor = .clear
    }
    
    func informationTableViewConfiguration() {
        addSubview(informationTableView)
        informationTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            informationTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            informationTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            informationTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            informationTableView.topAnchor.constraint(equalTo: tabsCollectionView.bottomAnchor)
        ])
        
        informationTableView.separatorStyle = .none
        informationTableView.estimatedRowHeight = 150
        informationTableView.rowHeight = UITableView.automaticDimension
        informationTableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
    }
}

// MARK: Private methods
private func buildTabsCollectionFlowLayout() -> UICollectionViewFlowLayout {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.minimumLineSpacing = 0
    
    return flowLayout
}
