//
//  HomeModel.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 04/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit

enum Home {
    enum FetchPokemons {
        struct Request { }
        
        struct Response {
            enum Result {
                case success([Pokemon])
                case failure(Error)
            }
            
            let result: Result
        }

        struct ViewModel {
            struct DisplayedPokemon {
                let name: String
                let code: String
                let imageURL: String
                let types: [PokemonType]
                let backgroundColor: UIColor
            }
            
            struct DisplayedError {
                let title: String
                let message: String
                let buttonTitle: String
            }
            
            enum Result {
                case success([DisplayedPokemon])
                case failure(DisplayedError)
            }
            
            let result: Result
        }
    }
}
