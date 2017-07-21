//
//  User.swift
//  wordguess practice
//
//  Created by Sahana Murthy on 7/20/17.
//  Copyright © 2017 Sahana Murthy. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class User {
    var uid:String = ""
    var role:String = ""
    var team:Int = 0
    var ref:DatabaseReference?
    var handle:DatabaseHandle?

    
    init(uid: String) {
        self.uid = uid
        let handlePlayers = ref?.child("players").queryLimited(toFirst:4).observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let childValue = child as! DataSnapshot
                let newValue = childValue.value as? NSDictionary
                //                print("VALUE")
                //                print(newValue!)
                let uid: String? = newValue?.object(forKey: "user") as! String
                print(uid!)
                if uid! == self.uid {
                    
                    self.role = newValue?.object(forKey: "role") as! String
                    print(self.role)
                    let team: Int? = newValue?.object(forKey: "team") as! Int
                    print(team!)
  
                    break
                }
                
            }
        })
    }
}
