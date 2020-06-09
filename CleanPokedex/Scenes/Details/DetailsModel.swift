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
        struct Request { }
        
        struct Response {
            let tabs: [String]
            let pokemon: Pokemon
        }
        
        struct ViewModel {
            struct DisplayedPokemon {
                let name: String
                let code: String
                let imageURL: String
                let typeImageNames: [String]
                let backgroundColorName: String
            }
            
            let title: String
            let displayedTabs: [String]
            let displayedPokemon: DisplayedPokemon
        }
    }
    
    enum SelectTab {
        struct Request {
            let selectedTab: Int
        }
        
        struct Response {
            struct About {
                let pokemon: Pokemon
                let mainType: PokemonType
            }
            
            struct Stats {
                let pokemon: Pokemon
                let mainType: PokemonType
            }
            
            struct Evolution {
                struct Data {
                    let reason: String
                    let initial: Pokemon
                    let evolved: Pokemon
                }
                
                let data: [Data]
                let mainType: PokemonType
            }
            
            enum TabType {
                case about(About)
                case stats(Stats)
                case evolution(Evolution)
            }
            
            let tabType: TabType
            let selectedTab: Int
            let deselectedTab: Int
        }
        
        struct ViewModel {
            struct Overview {
                let text: String
            }
            
            struct Stats {
                struct Data {
                    let key: String
                    let value: String
                    let colorName: String
                    let valuePercent: Float
                }
                
                let data: [Data]
                let headerTitle: String
                let headerTitleColorName: String
            }
            
            struct Evolution {
                struct Pokemon {
                    let code: String
                    let name: String
                    let imageURL: String
                }
                
                struct Data {
                    let reason: String
                    let initial: Pokemon
                    let evolved: Pokemon
                }
                
                let data: [Data]
                let headerTitle: String
                let headerTitleColorName: String
            }
            
            struct About {
                struct Data {
                    let title: String
                    let text: String
                }
                
                let data: [Data]
                let headerTitle: String
                let headerTitleColorName: String
            }
            
            enum SectionType {
                case about(About)
                case stats(Stats)
                case overview(Overview)
                case evolution(Evolution)
            }
            
            let selectedTab: Int
            let deselectedTab: Int
            let displayedSections: [SectionType]
        }
    }
}
