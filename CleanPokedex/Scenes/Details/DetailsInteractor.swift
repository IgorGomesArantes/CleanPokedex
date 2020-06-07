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
}

final class DetailsInteractor: DetailsDataStore {
    // MARK: Data store properties
    var pokemon: Pokemon!
    
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
            presenter?.presentAboutTab(Details.ShowTabInformations.Response(pokemon: pokemon))
        case .stats:
            presenter?.presentStatsTab(Details.ShowTabInformations.Response(pokemon: pokemon))
        case .evolution:
            presenter?.presentEvolutionTab(Details.ShowTabInformations.Response(pokemon: pokemon))
        }
    }
}
