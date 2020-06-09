//
//  DetailsInteractor.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 06/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

protocol DetailsBusinessLogic {
    func start()
    func showTabs()
    func showDetails()
    func selectTab(withIndexPath indexPath: IndexPath)
}

protocol DetailsDataStore {
    var pokemon: Pokemon! { get set }
    var evolutionMap: [String: Pokemon] { get set }
}

final class DetailsInteractor: DetailsDataStore {
    // MARK: Data store properties
    var pokemon: Pokemon!
    var evolutionMap: [String: Pokemon] = [:]
    
    // MARK: Properties
    var presenter: DetailsPresentationLogic?
    let tabs: [Details.TabType] = [.about, .stats, .evolution]
    
    var selectedTab: IndexPath = IndexPath(row: 1, section: 0) {
        didSet {
            showTabInformations()
        }
    }
}

// MARK: Business logic methods
extension DetailsInteractor: DetailsBusinessLogic {
    func start() {
        showTabs()
        showDetails()
    }
    
    func selectTab(withIndexPath indexPath: IndexPath) {
        guard indexPath.row != selectedTab.row else { return }
        
        presenter?.presentSelectedTab(Details.SelectTab.Response(indexPath: indexPath))
        presenter?.presentDeselecTab(Details.SelectTab.Response(indexPath: selectedTab))
        
        selectedTab = indexPath
    }
    
    func showTabs() {
        presenter?.presentTabs(Details.ShowTabs.Response(tabs: tabs))
    }
    
    func showDetails() {
        presenter?.presentDetails(Details.ShowDetails.Response(pokemon: pokemon))
    }
}

// MARK: Private methods
private extension DetailsInteractor {
    func showTabInformations() {
        switch tabs[selectedTab.row] {
        case .about:
            let tabType: Details.ShowTabInformations.Response.TabType = .About((pokemon, pokemon.types.first!))
            presenter?.presentTabInformation(Details.ShowTabInformations.Response(tabType: tabType))
        case .stats:
            let tabType: Details.ShowTabInformations.Response.TabType = .Stats((pokemon, pokemon.types.first!))
            presenter?.presentTabInformation(Details.ShowTabInformations.Response(tabType: tabType))
        case .evolution:
            let tabType: Details.ShowTabInformations.Response.TabType = .Evolution((getEvolutions(), pokemon.types.first!))
            presenter?.presentTabInformation(Details.ShowTabInformations.Response(tabType: tabType))
        }
    }
    
    func getEvolutions() -> [(Pokemon, Pokemon, String)] {
        var evolutions: [(Pokemon, Pokemon, String)] = []

        for index in 0..<pokemon.evolutions.count - 1 {
            let initial = evolutionMap[pokemon.evolutions[index]]!
            let evolved = evolutionMap[pokemon.evolutions[index + 1]]!
            evolutions.append((initial, evolved, initial.reason))
        }
        
        return evolutions
    }
}
