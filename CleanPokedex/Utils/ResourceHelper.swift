//
//  ResourceHelper.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 09/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

final class ResourceHelper {
    static func getPokemonColorName(withType type: PokemonType) -> String {
        let colorName: String = type.rawValue.lowercased()
        return colorName
    }
    
    static func getPokemonBackgroundColorName(withType type: PokemonType) -> String {
        let colorName: String = "background-\(type.rawValue.lowercased())"
        return colorName
    }
    
    static func getPokemonTypeTagName(withType type: PokemonType) -> String {
         let imageName: String = "\(type.rawValue.lowercased())-tag"
         return imageName
     }
}
