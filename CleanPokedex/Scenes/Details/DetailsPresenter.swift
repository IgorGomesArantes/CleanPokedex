//
//  DetailsPresenter.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 06/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

protocol DetailsPresentationLogic {
    func presentDetails(_ response: Details.ShowDetails.Response)
    func presentSelectTab(_ response: Details.SelectTab.Response)
    
    //    func presentTabs(_ response: Details.ShowTabs.Response)
    //    func presentDetails(_ response: Details.ShowDetails.Response)
    //    func presentDeselecTab(_ response: Details.SelectTab.Response)
    //    func presentSelectedTab(_ response: Details.SelectTab.Response)
    //    func presentTabInformation(_ response: Details.ShowTabInformations.Response)
}

final class DetailsPresenter {
    // MARK: Properties
    weak var viewController: DetailsDisplayLogic?
}

// MARK: Presentation logic methods
extension DetailsPresenter: DetailsPresentationLogic {
    func presentDetails(_ response: Details.ShowDetails.Response) {
        viewController?.displayDetails(Details.ShowDetails.ViewModel(title: response.pokemon.name,
                                                                     displayedTabs: response.tabs,
                                                                     displayedPokemon: getDisplayedPokemon(pokemon: response.pokemon)))
    }
    
    func presentSelectTab(_ response: Details.SelectTab.Response) {
        switch response.tabType {
        case .about(let about):
            viewController?.displaySelectTab(Details.SelectTab.ViewModel(selectedTab: response.selectedTab,
                                                                         deselectedTab: response.deselectedTab,
                                                                         displayedSections: getAboutTabSections(about)))
        case .stats(let stats):
            viewController?.displaySelectTab(Details.SelectTab.ViewModel(selectedTab: response.selectedTab,
                                                                         deselectedTab: response.deselectedTab,
                                                                         displayedSections: getStatsTabSections(stats)))
        case .evolution(let evolution):
            viewController?.displaySelectTab(Details.SelectTab.ViewModel(selectedTab: response.selectedTab,
                                                                         deselectedTab: response.deselectedTab,
                                                                         displayedSections: getEvolutionTabSections(evolution)))
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
    
    func getAboutTabSections(_ about: Details.SelectTab.Response.About) -> [Details.SelectTab.ViewModel.SectionType] {
        let overview = Details.SelectTab.ViewModel.Overview(text: about.pokemon.xDescription)
        let overviewSection = Details.SelectTab.ViewModel.SectionType.overview(overview)
        
        let height = Details.SelectTab.ViewModel.About.Data(title: "Height", text: about.pokemon.height)
        let weight = Details.SelectTab.ViewModel.About.Data(title: "Weight", text: about.pokemon.weight)
        let reducedAbilities = about.pokemon.abilities.reduce("", { (result, value) in "\(result)\(value), " })
        let abilities = Details.SelectTab.ViewModel.About.Data(title: "Abilities", text: String(reducedAbilities.prefix(reducedAbilities.count - 2)))
        
        let pokedexDataSection = Details.SelectTab.ViewModel.SectionType.about(Details.SelectTab.ViewModel.About(data: [height, weight, abilities],
                                                                                                                 headerTitle: "Pokédex Data",
                                                                                                                 headerTitleColor: about.mainType.color))
        
        let eggCycles = Details.SelectTab.ViewModel.About.Data(title: "Egg Cycles", text: about.pokemon.cycles)
        let eggGroups = Details.SelectTab.ViewModel.About.Data(title: "Egg Groups", text: about.pokemon.eggGroups)
        let gender = Details.SelectTab.ViewModel.About.Data(title: "Gender", text: "M: \(about.pokemon.malePercentage ?? "") - F: \(about.pokemon.femalePercentage ?? "")")
        
        let breedingSection = Details.SelectTab.ViewModel.SectionType.about(Details.SelectTab.ViewModel.About(data: [gender, eggGroups, eggCycles],
                                                                                                              headerTitle: "Breeding",
                                                                                                              headerTitleColor: about.mainType.color))
        
        return [overviewSection, pokedexDataSection, breedingSection]
    }
    
    func getStatsTabSections(_ stats: Details.SelectTab.Response.Stats) -> [Details.SelectTab.ViewModel.SectionType] {
        let healthPoints = Details.SelectTab.ViewModel.Stats.Data(key: "HP",
                                                                  value: String(stats.pokemon.healthPoints),
                                                                  barColor: stats.mainType.color,
                                                                  valuePercent: Float(stats.pokemon.healthPoints) / 100.0)
        
        let attack = Details.SelectTab.ViewModel.Stats.Data(key: "Attack",
                                                            value: String(stats.pokemon.attack),
                                                            barColor: stats.mainType.color,
                                                            valuePercent: Float(stats.pokemon.attack) / 100.0)
        
        let defense = Details.SelectTab.ViewModel.Stats.Data(key: "Defense",
                                                             value: String(stats.pokemon.defense),
                                                             barColor: stats.mainType.color,
                                                             valuePercent: Float(stats.pokemon.defense) / 100.0)
        
        let specialAttack = Details.SelectTab.ViewModel.Stats.Data(key: "Sp. Atk",
                                                                   value: String(stats.pokemon.specialAttack),
                                                                   barColor: stats.mainType.color,
                                                                   valuePercent: Float(stats.pokemon.specialAttack) / 100.0)
        
        let specialDefense = Details.SelectTab.ViewModel.Stats.Data(key: "Sp. Def",
                                                                    value: String(stats.pokemon.specialDefense),
                                                                    barColor: stats.mainType.color,
                                                                    valuePercent: Float(stats.pokemon.specialDefense) / 100.0)
        
        let speed = Details.SelectTab.ViewModel.Stats.Data(key: "Speed",
                                                           value: String(stats.pokemon.speed),
                                                           barColor: stats.mainType.color,
                                                           valuePercent: Float(stats.pokemon.speed) / 100.0)
        
        let totalSum = stats.pokemon.healthPoints + stats.pokemon.attack + stats.pokemon.defense + stats.pokemon.specialAttack + stats.pokemon.specialDefense + stats.pokemon.speed
        let total = Details.SelectTab.ViewModel.Stats.Data(key: "Total",
                                                           value: String(totalSum),
                                                           barColor: stats.mainType.color,
                                                           valuePercent: Float(totalSum) / 600.0)
        
        let statsSection = Details.SelectTab.ViewModel.SectionType.stats(Details.SelectTab.ViewModel.Stats(
            data: [healthPoints, attack, defense, specialAttack, specialDefense, speed, total],
            headerTitle: "Base Stats",
            headerTitleColor: stats.mainType.color))
        
        return [statsSection]
    }
    
    func getEvolutionTabSections(_ evolution: Details.SelectTab.Response.Evolution) -> [Details.SelectTab.ViewModel.SectionType] {
        
        let evolutionCells = evolution.data.map {
            Details.SelectTab.ViewModel.Evolution.Data(reason: $0.reason, initial: getEvolutionPokemon($0.initial), evolved: getEvolutionPokemon($0.evolved))
        }
        
        let section: Details.SelectTab.ViewModel.SectionType = .evolution(Details.SelectTab.ViewModel.Evolution(data: evolutionCells,
                                                                                                                headerTitle: "Evolution Chart",
                                                                                                                headerTitleColor: evolution.mainType.color))
        
        return [section]
    }
    
    func getEvolutionPokemon(_ pokemon: Pokemon) -> Details.SelectTab.ViewModel.Evolution.Pokemon {
        return Details.SelectTab.ViewModel.Evolution.Pokemon(code: pokemon.code, name: pokemon.name, imageURL: pokemon.imageURL)
    }
}
