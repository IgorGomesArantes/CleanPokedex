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
            var pokemons: [Pokemon]
        }
        
        struct Request {
        }
        
        struct ViewModel {
            struct DisplayedPokemon {
                var name: String
            }
            
            var displayedPokemons: [DisplayedPokemon]
        }
    }
}
