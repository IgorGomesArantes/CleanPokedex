//
//  HomeRouter.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 03/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

protocol HomeRoutingLogic {
    func routeToDetails(selectedIndex index: Int)
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

final class HomeRouter: HomeDataPassing {
    // MARK: Data passing properties
    var dataStore: HomeDataStore?
    
    // MARK: Properties
    weak var viewController: HomeViewController?
}

// MARK: Routing logic methods
extension HomeRouter: HomeRoutingLogic {
    func routeToDetails(selectedIndex index: Int) {
        let detailsViewController = DetailsViewController()
        var destination = detailsViewController.router!.dataStore!
        
        passDataToDetails(source: dataStore!, destination: &destination, index: index)
        navigateToDetails(destination: detailsViewController)
    }
}

// MARK: Navigation methods
private extension HomeRouter {
    func navigateToDetails(destination: DetailsViewController) {
        viewController?.show(destination, sender: nil)
    }
}

// MARK: Passing data methods
private extension HomeRouter {
    func passDataToDetails(source: HomeDataStore, destination: inout DetailsDataStore, index: Int) {
        let pokemon = source.pokemons[index]
        destination.pokemon = pokemon
        destination.evolutionMap = getEvolutionMap(forPokemon: pokemon)
    }
}

// MARK: Private methods
private extension HomeRouter {
    func getEvolutionMap(forPokemon pokemon: Pokemon) -> [String:Pokemon] {
        var evolutionMap: [String:Pokemon] = [:]
        let evolutionPokemons = dataStore!.pokemons.filter { pokemon.evolutions.contains($0.code) }
        evolutionPokemons.forEach { evolutionMap[$0.code] = $0 }
        return evolutionMap
    }
}
