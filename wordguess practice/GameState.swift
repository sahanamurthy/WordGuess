//
//  GameState.swift
//  wordguess practice
//
//  Created by Sahana Murthy on 7/14/17.
//  Copyright © 2017 Sahana Murthy. All rights reserved.
//

import Foundation
import UIKit
import GameplayKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class GameState {
    
    var currentUser = Auth.auth().currentUser?.email
    var currentUid = Auth.auth().currentUser?.uid
    
    var teams = [1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2,
                 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3,
                 3, 3, 4]
    
    var words = [
        "Night",
        "Poison",
        "Tower",
        "Pyramid",
        "Opera",
        "Scuba Diver",
        "Africa",
        "Mail",
        "Undertaker",
        "Aztec",
        "Maple",
        "Orange",
        "Temple",
        "Smuggler",
        "England",
        "Pupil",
        "Plot",
        "Witch",
        "Ketchup",
        "Atlantis",
        "Vacuum",
        "Soldier",
        "Berry",
        "Pants",
        "Wall",
        "Pipe",
        "Novel",
        "Ivory",
        "America",
        "Snow",
        "Trunk",
        "Bark",
        "Thief",
        "Eagle",
        "Genius",
        "Beijing",
        "Racket",
        "Torch",
        "State",
        "Link",
        "Dance",
        "Flute",
        "Bunny",
        "Carrot",
        "Princess",
        "Time",
        "Unicorn",
        "Spy",
        "Circle",
        "Bed",
        "Port",
        "Disease",
        "Swing",
        "Hand",
        "Fort",
        "Germany",
        "Loch Ness",
        "Log",
        "Code",
        "Kiwi",
        "Spike",
        "Scientist",
        "Row",
        "Pistol",
        "Robot",
        "Embassy",
        "Paste",
        "Missile",
        "Bug",
        "Mint",
        "Gold",
        "Tick",
        "Crash",
        "Tail",
        "Angel",
        "Spider"
    ]
    
    var shuffledCards:[String] = []
    var shuffledTeams:[Int] = []
    
    var cards:[Card] = []
    
    init() {
        shuffledCards = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: words) as! [String]
        shuffledTeams = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: teams) as! [Int]
    }
    
    var ref:DatabaseReference?
    
    func createCards() {
        ref = Database.database().reference()
        
        for i in 0...24 {
            let index = i
            
            let card = Card(team: shuffledTeams[i], word: shuffledCards[i])
            cards.insert(card, at: i)
            
            let post = [
                "word": shuffledCards[i],
                "team": shuffledTeams[i],
                "flipped": true
            ] as [String: Any]
            
            let cardsRef = ref?.child("card");
            cardsRef?.child("\(index)").setValue(post)
        }
        
        // If unable to create multiple games, delete clues
        //        let deleteRef = ref?.child("clue").removeValue()
    }
    
    func createPlayers() {
        ref = Database.database().reference()
        
        let players = ["giver1", "guesser1", "giver2", "guesser2"]
        let teams = [1, 1, 2, 2]
        let roles = ["giver", "guesser", "giver", "guesser"]
        var index = 0
        
        for player in players {
            let post = [
                "team": teams[index],
                "role": roles[index],
                "user": "add"
            ] as [String: Any]
            
            let playersRef = ref?.child("players");
            playersRef?.child("\(player)").setValue(post)
            
            index = index + 1
        }
        
        // If unable to create several games, delete UIDs
//        let deleteRef = ref?.child("players").child("uids").removeValue()
    }

}







