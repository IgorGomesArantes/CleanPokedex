//
//  DetailsRouter.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 06/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

protocol DetailsRoutingLogic {
    
}

protocol DetailsDataPassing {
    var dataStore: DetailsDataStore? { get }
}

final class DetailsRouter: DetailsDataPassing {
    // MARK: Data passing properties
    var dataStore: DetailsDataStore?
    
    // MARK: Properties
    weak var viewController: DetailsViewController?
}

// MARK: Routing logic methods
extension DetailsRouter: DetailsRoutingLogic {
    
}
