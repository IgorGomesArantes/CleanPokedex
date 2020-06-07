//
//  DetailsPresenter.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 06/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

protocol DetailsPresentationLogic {
    func presentTabs(_ response: Details.ShowTabs.Response)
    func presentDetails(_ response: Details.ShowDetails.Response)
    func presentDeselecTab(_ response: Details.SelectTab.Response)
    func presentSelectedTab(_ response: Details.SelectTab.Response)
    func presentAboutTab(_ response: Details.ShowTabInformations.Response)
    func presentStatsTab(_ response: Details.ShowTabInformations.Response)
    func presentEvolutionTab(_ response: Details.ShowTabInformations.Response)
}

final class DetailsPresenter {
    // MARK: Properties
    weak var viewController: DetailsDisplayLogic?
}

// MARK: Presentation logic methods
extension DetailsPresenter: DetailsPresentationLogic {
    func presentTabs(_ response: Details.ShowTabs.Response) {
        viewController?.displayTabs(Details.ShowTabs.ViewModel(displayedTabs: response.tabs.map { $0.rawValue }))
    }
    
    func presentAboutTab(_ response: Details.ShowTabInformations.Response) {
        viewController?.displayTabInformations(Details.ShowTabInformations.ViewModel(displayedCells: getAboutTabInformation(pokemon: response.pokemon)))
    }
    
    func presentDetails(_ response: Details.ShowDetails.Response) {
        viewController?.displayDetails(Details.ShowDetails.ViewModel(displayedPokemon: getDisplayedPokemon(pokemon: response.pokemon)))
    }
    
    func presentDeselecTab(_ response: Details.SelectTab.Response) {
        viewController?.displayDeselectTab(Details.SelectTab.ViewModel(indexPath: response.indexPath))
    }
    
    func presentSelectedTab(_ response: Details.SelectTab.Response) {
        viewController?.displaySelectTab(Details.SelectTab.ViewModel(indexPath: response.indexPath))
    }
    
    func presentStatsTab(_ response: Details.ShowTabInformations.Response) {
        viewController?.displayTabInformations(Details.ShowTabInformations.ViewModel(displayedCells: getStatsInformation(pokemon: response.pokemon)))
    }
    
    func presentEvolutionTab(_ response: Details.ShowTabInformations.Response) {
        
    }
}

// MARK: Private methods
private extension DetailsPresenter {
    func getDisplayedPokemon(pokemon: Pokemon) -> Details.ShowDetails.ViewModel.DisplayedPokemon {
        return Details.ShowDetails.ViewModel.DisplayedPokemon(name: pokemon.name,
                                                              code: pokemon.code,
                                                              imageURL: pokemon.imageURL,
                                                              types: pokemon.types,
                                                              mainType: pokemon.types.first!)
    }
    
    func getAboutTabInformation(pokemon: Pokemon) -> [Details.ShowTabInformations.ViewModel.CellType] {
        let overview = Details.ShowTabInformations.ViewModel.Overview(text: pokemon.xDescription)
        
        let height = ("Height", pokemon.height)
        let weight = ("Weight", pokemon.weight)
        let eggCycles = ("Egg Cycles", pokemon.cycles)
        let eggGroups = ("Egg Groups", pokemon.eggGroups)
        let gender = ("Gender", "M: \(pokemon.malePercentage ?? "") - F: \(pokemon.femalePercentage ?? "")")
        let reducedAbilities = pokemon.abilities.reduce("", { (result, value) in "\(result)\(value), " })
        let abilities = ("Abilities", String(reducedAbilities.prefix(reducedAbilities.count - 2)))
        
        let pokedexDataSection = Details.ShowTabInformations.ViewModel.CellType.keyValue(("Pokédex Data", [height, weight, abilities]))
        let breedingSection = Details.ShowTabInformations.ViewModel.CellType.keyValue(("Breeding", [gender, eggGroups, eggCycles]))
        let overviewSection = Details.ShowTabInformations.ViewModel.CellType.overview(overview)
        
        return [overviewSection, pokedexDataSection, breedingSection]
    }
    
    func getStatsInformation(pokemon: Pokemon) -> [Details.ShowTabInformations.ViewModel.CellType] {
        let overview = Details.ShowTabInformations.ViewModel.Overview(text: pokemon.xDescription)
        
        let height = ("Height", pokemon.height)
        let weight = ("Weight", pokemon.weight)
        let abilities = ("Abilities", pokemon.abilities.reduce("", { (result, value) in "\(result)\(value), " }))
        
        let pokedexDataSection = Details.ShowTabInformations.ViewModel.CellType.keyValue(("Pokédex Data", [height, weight, abilities]))
        let overviewSection = Details.ShowTabInformations.ViewModel.CellType.overview(overview)
        
        return [overviewSection, pokedexDataSection]
    }
}
