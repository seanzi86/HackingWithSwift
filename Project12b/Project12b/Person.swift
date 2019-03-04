//
//  Person.swift
//  Project10
//
//  Created by Sean Carrington on 28/02/2019.
//  Copyright © 2019 seanzi86. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {

    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
}
