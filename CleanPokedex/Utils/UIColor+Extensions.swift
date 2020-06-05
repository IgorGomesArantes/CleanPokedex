//
//  UIColor+Extensions.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 05/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit

extension UIColor {
    static func getPokemonColor(withType type: PokemonType) -> UIColor {
        let colorName: String = type.rawValue.lowercased()
        return UIColor(named: colorName)!
    }
    
    static func getPokemonBackgroundColor(withType type: PokemonType) -> UIColor {
        let colorName: String = "background-\(type.rawValue.lowercased())"
        return UIColor(named: colorName)!
    }
}
