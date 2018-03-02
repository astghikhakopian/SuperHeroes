//
//  SuperHero.swift
//  SuperHeroes
//
//  Created by astghik on 1/28/18.
//  Copyright © 2018 ACA. All rights reserved.
//

import UIKit

class SuperHero {
    var name: String;
    var image: UIImage;
    var description: String;

    init(name: String, image: UIImage, description: String) {
        self.name = name;
        self.image = image;
        self.description = description;
    }
}
