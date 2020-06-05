//
//  UIImage+Extensions.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 05/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit

extension UIImage {
    static func getPokemonTag(withType type: PokemonType) -> UIImage {
        let imageName: String = "\(type.rawValue.lowercased())-tag"
        return UIImage(named: imageName)!
    }
}
