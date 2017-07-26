//
//  FirstViewController.swift
//  wordguess practice
//
//  Created by Sahana Murthy on 7/16/17.
//  Copyright © 2017 Sahana Murthy. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class FirstViewController: UIViewController {
    var ref:DatabaseReference?
    var handle:DatabaseHandle?
    var currentUid = Auth.auth().currentUser?.uid

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var txtInput: UITextField!
    
    var whatToDo:Bool = false
    
    @IBAction func newGame(_ sender: Any) {
        self.newGame()

//        whatToDo = true
//        performSegue(withIdentifier: "segue", sender: self)
    }
    
    @IBAction func existingGame(_ sender: Any) {
//        whatToDo = false
        if txtInput.text != "" {
            performSegue(withIdentifier: "segue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameController = segue.destination as! GameViewController
        gameController.gameID = txtInput.text!
//        gameController.doThis = whatToDo
//        print(whatToDo)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var currentUser = Auth.auth().currentUser?.email
        userLabel.text = currentUser
//        txtInput.placeholder = "Game Id #"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newGame() {
        var newNum:Int = 0
        var game = GameState()
        ref = Database.database().reference()
        let handleGames = self.ref?.child("game").queryLimited(toLast: 1).observeSingleEvent(of: .value, with: {snapshot in
            if !snapshot.exists() {
                newNum = 1
                let newRef = self.ref?.child("game").child("\(newNum)").setValue("\(newNum)")
                game.createCards(newNum)
                game.createPlayers(newNum)
                self.createAlert(title: "New Game Created!", message: "You just created game \(newNum)")
            } else {
                let handleLatestGame = self.ref?.child("game").queryLimited(toLast: 1).observeSingleEvent(of: .value, with: {snapshot in
                    if let value = snapshot.value as? NSDictionary {
                        print(value.allValues[0])
                        let num = ((value.allValues[0]) as AnyObject).integerValue
                        newNum = num! + 1
                        let newRef = self.ref?.child("game").child("\(newNum)").setValue("\(newNum)")
                        game.createCards(newNum)
                        game.createPlayers(newNum)
                        self.createAlert(title: "New Game Created!", message: "You just created game \(newNum)")
                        
                    } else if let value = snapshot.value as? NSArray {
                        print("NSARRAY")
                        print(value[1])
                        let num = ((value[1]) as AnyObject).integerValue
                        newNum = num! + 1
                        let newRef = self.ref?.child("game").child("\(newNum)").setValue("\(newNum)")
                        game.createCards(newNum)
                        game.createPlayers(newNum)
                        self.createAlert(title: "New Game Created!", message: "You just created game \(newNum)")

                    }
                })
                
            }
            
            
        })
        
    }
    
    func createAlert (title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }


}
