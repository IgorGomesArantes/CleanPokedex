//
//  HomeRouter.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 03/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

protocol HomeRoutingLogic {
    func routeToDetails(withIndex index: Int)
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

final class HomeRouter: HomeDataPassing, HomeRoutingLogic {
    
    // MARK: Data passing properties
    var dataStore: HomeDataStore?
    
    // MARK: Properties
    weak var viewController: HomeViewController?
    
    // MARK: Routing logic methods
    func routeToDetails(withIndex index: Int) {
        let detailsViewController = DetailsViewController()
        var destination = detailsViewController.router!.dataStore!
        passDataToDetails(source: dataStore!, destination: &destination, index: index)
        navigateToDetails(destination: detailsViewController)
    }
    
    // MARK: Private methods
    private func navigateToDetails(destination: DetailsViewController) {
        viewController?.show(destination, sender: nil)
    }

    private func passDataToDetails(source: HomeDataStore, destination: inout DetailsDataStore, index: Int) {
        let pokemon = source.pokemons[index]
        destination.pokemon = pokemon
        destination.evolutionMap = getEvolutionMap(forPokemon: pokemon)
    }
    
    private func getEvolutionMap(forPokemon pokemon: Pokemon) -> [String:Pokemon] {
        var evolutionsMap: [String:Pokemon] = [:]
        let evolutionPokemons = dataStore?.pokemons.filter { pokemon.evolutions.contains($0.code) } ?? []
        evolutionPokemons.forEach { evolutionsMap[$0.code] = $0 }
        return evolutionsMap
    }
}
