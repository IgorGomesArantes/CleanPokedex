//
//  HomeView.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 03/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit

final class HomeView: UIView {
    // MARK: View properties
    let pokemonsTableView: UITableView = UITableView()
    
    // MARK: Initialization methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configuration methods
private extension HomeView {
    func initialConfiguration() {
        pokemonsTableViewConfiguration()
    }
    
    func pokemonsTableViewConfiguration() {
        addSubview(pokemonsTableView)
        pokemonsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokemonsTableView.topAnchor.constraint(equalTo: topAnchor),
            pokemonsTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            pokemonsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pokemonsTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
