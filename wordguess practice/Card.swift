//
//  Card.swift
//  wordguess practice
//
//  Created by Sahana Murthy on 7/14/17.
//  Copyright © 2017 Sahana Murthy. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Card {
    var team:Int = 0
    var word:String = ""
    var flipped: Bool = true
    
    init(team: Int, word: String) {
        self.team = team
        self.word = word
    }
}
