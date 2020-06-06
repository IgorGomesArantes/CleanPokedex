//
//  DetailsPresenter.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 06/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

protocol DetailsPresentationLogic {
    func presentDetails(response: Details.ShowDetails.Response)
}

final class DetailsPresenter {
    // MARK: Properties
    weak var viewController: DetailsDisplayLogic?
}

// MARK: Presentation logic methods
extension DetailsPresenter: DetailsPresentationLogic {
    func presentDetails(response: Details.ShowDetails.Response) {
        viewController?.displayDetails(viewModel: Details.ShowDetails.ViewModel(displayedPokemon: getDisplayedPokemon(pokemon: response.pokemon)))
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
}
