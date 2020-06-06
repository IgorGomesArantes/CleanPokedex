//
//  DetailsModel.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 06/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

enum Details {
    enum ShowDetails {
        struct Response {
            let pokemon: Pokemon
        }
        
        struct ViewModel {
            struct DisplayedPokemon {
                let name: String
                let code: String
                let imageURL: String
                let types: [PokemonType]
                let mainType: PokemonType
            }
            
            let displayedPokemon: DisplayedPokemon
        }
    }
}
