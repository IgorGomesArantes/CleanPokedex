//
//  HomeViewController.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 03/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: Properties
    let homeView: UIView = HomeView(frame: .zero)
}

// MARK: View lifecycle methods
extension HomeViewController {
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
