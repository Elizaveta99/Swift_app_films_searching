//
//  Film.swift
//  searching_app
//
//  Created by Lizaveta Rudzko on 3/25/1398 AP.
//  Copyright © 1398 Lizaveta Rudzko. All rights reserved.
//

import Foundation

class Film
{
    let title: String
    let year: String
    let descript: String
    let image: String
    var amount: Int
    var score: Double
    
    init(title: String, year: String, image: String, descript: String, score: Double, amount: Int)
    {
        self.title = title
        self.year = year
        self.descript = descript
        self.image = image
        self.amount = amount
        self.score = score
    }
}
