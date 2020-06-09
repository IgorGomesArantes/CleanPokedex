//
//  DetailsModel.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 06/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit

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
                let types: [PokemonType]
                let mainType: PokemonType
            }
            
            let title: String
            let displayedTabs: [String]
            let displayedPokemon: DisplayedPokemon
        }
    }
    
    enum SelectTab {
        struct Request {
            let selectedTab: IndexPath
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
            let selectedTab: IndexPath
            let deselectedTab: IndexPath
        }
        
        struct ViewModel {
            struct Overview {
                let text: String
            }
            
            struct Stats {
                struct Data {
                    let key: String
                    let value: String
                    let barColor: UIColor
                    let valuePercent: Float
                }
                
                let data: [Data]
                let headerTitle: String
                let headerTitleColor: UIColor
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
                let headerTitleColor: UIColor
            }
            
            struct About {
                struct Data {
                    let title: String
                    let text: String
                }
                
                let data: [Data]
                let headerTitle: String
                let headerTitleColor: UIColor
            }
            
            enum SectionType {
                case about(About)
                case stats(Stats)
                case overview(Overview)
                case evolution(Evolution)
            }
            
            let selectedTab: IndexPath
            let deselectedTab: IndexPath
            let displayedSections: [SectionType]
        }
    }
}
