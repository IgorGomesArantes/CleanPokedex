//
//  DetailsInteractor.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 06/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

protocol DetailsBusinessLogic {
    func showDetails(_ request: Details.ShowDetails.Request)
    func selectTab(_ request: Details.SelectTab.Request)
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
    var selectedTab: IndexPath = IndexPath(row: 0, section: 1)
    var presenter: DetailsPresentationLogic?
    let tabs: [String] = ["About", "Stats", "Evolution"]
    
//    var selectedTab: IndexPath = IndexPath(row: 1, section: 0) {
//        didSet {
//            showTabInformations()
//        }
//    }
    

}

// MARK: Business logic methods
extension DetailsInteractor: DetailsBusinessLogic {
    func showDetails(_ request: Details.ShowDetails.Request) {
        presenter?.presentDetails(Details.ShowDetails.Response(tabs: tabs, pokemon: pokemon))
    }
    
    func selectTab(_ request: Details.SelectTab.Request) {
        guard !(request.selectedTab.row == selectedTab.row && request.selectedTab.section == selectedTab.section) else { return }
        
        let deselectedTab = selectedTab
        self.selectedTab = request.selectedTab
        presenter?.presentSelectTab(Details.SelectTab.Response(tabType: getTabType(request.selectedTab.row),
                                                               selectedTab: request.selectedTab,
                                                               deselectedTab: deselectedTab))
    }
}

// MARK: Private methods
private extension DetailsInteractor {
    func getTabType(_ selectedTab: Int) -> Details.SelectTab.Response.TabType {
        switch selectedTab {
        case 0:
            return .about(Details.SelectTab.Response.About(pokemon: pokemon, mainType: pokemon.types.first!))
        case 1:
            return .stats(Details.SelectTab.Response.Stats(pokemon: pokemon, mainType: pokemon.types.first!))
        default:
            return .evolution(Details.SelectTab.Response.Evolution(data: getEvolutions(), mainType: pokemon.types.first!))
        }
    }
    
    func getEvolutions() -> [Details.SelectTab.Response.Evolution.Data] {
        var evolutions: [Details.SelectTab.Response.Evolution.Data] = []

        for index in 0 ..< pokemon.evolutions.count - 1 {
            let initial = evolutionMap[pokemon.evolutions[index]]!
            let evolved = evolutionMap[pokemon.evolutions[index + 1]]!
            evolutions.append(Details.SelectTab.Response.Evolution.Data(reason: evolved.reason, initial: initial, evolved: evolved))
        }
        
        return evolutions
    }
}
