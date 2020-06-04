//
//  HomeView.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 03/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class HomeView: UIView {
    // MARK: View properties
    let tableView: UITableView = UITableView()
    
    // MARK: Initialization methods
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configuration methods
private extension HomeView {
    
}
