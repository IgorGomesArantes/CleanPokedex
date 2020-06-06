//
//  DetailsInteractor.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 06/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

protocol DetailsBusinessLogic {
    func showAbout()
    func showStats()
    func showDetails()
    func showEvolution()
}

protocol DetailsDataStore {
    var pokemon: Pokemon! { get set }
}

final class DetailsInteractor: DetailsDataStore {
    // MARK: Data store properties
    var pokemon: Pokemon!
    
    // MARK: Properties
    var presenter: DetailsPresentationLogic?
}

// MARK: Business logic methods
extension DetailsInteractor: DetailsBusinessLogic {
    func showDetails() {
        presenter?.presentDetails(response: Details.ShowDetails.Response(pokemon: pokemon))
    }
    
    func showAbout() {
        
    }
    
    func showStats() {
        
    }
    
    func showEvolution() {
        
    }
}
