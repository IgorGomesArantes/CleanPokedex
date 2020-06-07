//
//  DetailsModel.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 06/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

enum Details {
    enum TabType: String {
        case about = "About"
        case stats = "Stats"
        case evolution = "Evolution"
    }
    
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
    
    enum ShowTabInformations {
        struct Response {
            let pokemon: Pokemon
        }
        
        struct ViewModel {
            enum CellType {
                case overview(Overview)
                case baseStats((String, [BaseStats]))
                case evolution((String, [Evolution]))
                case keyValue((String, [(String, String)]))
            }
            
            struct Overview {
                let text: String
            }
            
            struct BaseStats {
                let tag: String
                let value: String
                let valuePercent: Float
            }
            
            struct Evolution {
                struct Pokemon {
                    let code: String
                    let name: String
                    let imageURL: String
                }
                
                let reason: String
                let initial: Pokemon
                let evolved: Pokemon
            }
            
            let displayedCells: [CellType]
        }
    }
    
    enum ShowTabs {
        struct Response {
            let tabs: [TabType]
        }
        
        struct ViewModel {
            let displayedTabs: [String]
        }
    }
    
    enum SelectTab {
        struct Response {
            let indexPath: IndexPath
        }
        
        struct ViewModel {
            let indexPath: IndexPath
        }
    }
}
