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
        struct Request {
        }
        
        enum Response {
            case success([Pokemon])
            case failure(Error)
        }

        enum ViewModel {
            struct DisplayedPokemon {
                let name: String
                let code: String
                let imageURL: String
                let types: [PokemonType]
                let mainType: PokemonType
            }
            
            struct DisplayedError {
                let title: String
                let message: String
                let buttonTitle: String
            }
            
            case success([DisplayedPokemon])
            case failure(DisplayedError)
        }
    }
}
