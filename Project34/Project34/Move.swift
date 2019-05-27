//
//  Move.swift
//  Project34
//
//  Created by Sean Carrington on 27/05/2019.
//  Copyright © 2019 seanzi86. All rights reserved.
//

import GameplayKit
import UIKit

class Move: NSObject, GKGameModelUpdate {
    var value: Int = 0
    var column: Int
    
    init(column: Int) {
        self.column = column
    }
}
