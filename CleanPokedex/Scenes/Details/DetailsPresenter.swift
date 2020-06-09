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
    func presentTabInformation(_ response: Details.ShowTabInformations.Response)
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
    
    func presentDetails(_ response: Details.ShowDetails.Response) {
        viewController?.displayDetails(Details.ShowDetails.ViewModel(displayedPokemon: getDisplayedPokemon(pokemon: response.pokemon)))
    }
    
    func presentDeselecTab(_ response: Details.SelectTab.Response) {
        viewController?.displayDeselectTab(Details.SelectTab.ViewModel(indexPath: response.indexPath))
    }
    
    func presentSelectedTab(_ response: Details.SelectTab.Response) {
        viewController?.displaySelectTab(Details.SelectTab.ViewModel(indexPath: response.indexPath))
    }
    
    func presentTabInformation(_ response: Details.ShowTabInformations.Response) {
        switch response.tabType {
        case .About(let data):
            viewController?.displayTabInformations(
                Details.ShowTabInformations.ViewModel(displayedCells: getAboutTabInformation(pokemon: data.0, mainType: data.1)))
        case .Stats(let data):
            viewController?.displayTabInformations(
                Details.ShowTabInformations.ViewModel(displayedCells: getStatsInformation(pokemon: data.0, mainType: data.1)))
        case .Evolution(let data):
            viewController?.displayTabInformations(
                Details.ShowTabInformations.ViewModel(displayedCells: getEvolutionTabInformation(evolutions: data.0, pokemonType: data.1)))
        }
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
    
    func getAboutTabInformation(pokemon: Pokemon, mainType: PokemonType) -> [Details.ShowTabInformations.ViewModel.CellType] {
        let overview = Details.ShowTabInformations.ViewModel.Overview(text: pokemon.xDescription)
        
        let height = ("Height", pokemon.height)
        let weight = ("Weight", pokemon.weight)
        let eggCycles = ("Egg Cycles", pokemon.cycles)
        let eggGroups = ("Egg Groups", pokemon.eggGroups)
        let gender = ("Gender", "M: \(pokemon.malePercentage ?? "") - F: \(pokemon.femalePercentage ?? "")")
        let reducedAbilities = pokemon.abilities.reduce("", { (result, value) in "\(result)\(value), " })
        let abilities = ("Abilities", String(reducedAbilities.prefix(reducedAbilities.count - 2)))
        
        let pokedexHeaderData = Details.ShowTabInformations.ViewModel.CellType.HeaderData(title: "Pokédex Data", mainType: mainType)
        let breedingHeaderData = Details.ShowTabInformations.ViewModel.CellType.HeaderData(title: "Breeding", mainType: mainType)
        
        let pokedexDataSection = Details.ShowTabInformations.ViewModel.CellType.keyValue((pokedexHeaderData, [height, weight, abilities]))
        let breedingSection = Details.ShowTabInformations.ViewModel.CellType.keyValue((breedingHeaderData, [gender, eggGroups, eggCycles]))
        let overviewSection = Details.ShowTabInformations.ViewModel.CellType.overview(overview)
        
        return [overviewSection, pokedexDataSection, breedingSection]
    }
    
    func getStatsInformation(pokemon: Pokemon, mainType: PokemonType) -> [Details.ShowTabInformations.ViewModel.CellType] {
        let healthPoints = Details.ShowTabInformations.ViewModel.Stats(key: "HP",
                                                                       value: String(pokemon.healthPoints),
                                                                       valuePercent: Float(pokemon.healthPoints) / 100.0,
                                                                       mainType: mainType)
        
        let attack = Details.ShowTabInformations.ViewModel.Stats(key: "Attack",
                                                                 value: String(pokemon.attack),
                                                                 valuePercent: Float(pokemon.attack) / 100.0,
                                                                 mainType: mainType)
        
        let defense = Details.ShowTabInformations.ViewModel.Stats(key: "Defense",
                                                                  value: String(pokemon.defense),
                                                                  valuePercent: Float(pokemon.defense) / 100.0,
                                                                  mainType: mainType)
        
        let specialAttack = Details.ShowTabInformations.ViewModel.Stats(key: "Sp. Atk",
                                                                        value: String(pokemon.specialAttack),
                                                                        valuePercent: Float(pokemon.specialAttack) / 100.0,
                                                                        mainType: mainType)
        
        let specialDefense = Details.ShowTabInformations.ViewModel.Stats(key: "Sp. Def",
                                                                         value: String(pokemon.specialDefense),
                                                                         valuePercent: Float(pokemon.specialDefense) / 100.0,
                                                                         mainType: mainType)
        
        let speed = Details.ShowTabInformations.ViewModel.Stats(key: "Speed",
                                                                value: String(pokemon.speed),
                                                                valuePercent: Float(pokemon.speed) / 100.0,
                                                                mainType: mainType)
        
        let totalSum = pokemon.healthPoints + pokemon.attack + pokemon.defense + pokemon.specialAttack + pokemon.specialDefense + pokemon.speed
        let total = Details.ShowTabInformations.ViewModel.Stats(key: "Total",
                                                                value: String(totalSum),
                                                                valuePercent: Float(totalSum) / 600.0,
                                                                mainType: mainType)

        let statsHeaderData = Details.ShowTabInformations.ViewModel.CellType.HeaderData(title: "Base Stats", mainType: mainType)
        let statsSection = Details.ShowTabInformations.ViewModel.CellType.stats((statsHeaderData, [healthPoints, attack, defense, specialAttack, specialDefense, speed, total]))
        
        return [statsSection]
    }
    
    func getEvolutionTabInformation(evolutions: [(Pokemon, Pokemon, String)], pokemonType: PokemonType) -> [Details.ShowTabInformations.ViewModel.CellType] {
        
        let evolutionsViewModel = evolutions.map {
            Details.ShowTabInformations.ViewModel.Evolution(
                reason: $0.2,
                initial: Details.ShowTabInformations.ViewModel.Evolution.Pokemon(code: $0.0.code, name: $0.0.name, imageURL: $0.0.imageURL),
                evolved: Details.ShowTabInformations.ViewModel.Evolution.Pokemon(code: $0.1.code, name: $0.1.name, imageURL: $0.1.imageURL))
        }
        
        let evolutionHeaderData = Details.ShowTabInformations.ViewModel.CellType.HeaderData(title: "Evolution Chart", mainType: pokemonType)
        let evolutionSection = Details.ShowTabInformations.ViewModel.CellType.evolution((evolutionHeaderData, evolutionsViewModel))
        
        return [evolutionSection]
    }
}
