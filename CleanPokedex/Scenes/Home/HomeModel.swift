//
//  HomeModel.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 04/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

enum Home {
    enum FetchPokemons {
        struct Response {
            let pokemons: [Pokemon]
        }
        
        struct Request {
        }
        
        struct ViewModel {
            struct DisplayedPokemon {
                let name: String
                let code: String
                let imageURL: String
                let types: [PokemonType]
                let mainType: PokemonType
            }
            
            var displayedPokemons: [DisplayedPokemon]
        }
    }
}
