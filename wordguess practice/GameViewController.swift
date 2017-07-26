//
//  GameViewController.swift
//  wordguess practice
//
//  Created by Sahana Murthy on 7/4/17.
//  Copyright © 2017 Sahana Murthy. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import FirebaseDatabase
import FirebaseAuth

class GameViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    var doThis:Bool = false
    var ref:DatabaseReference?
    var handle:DatabaseHandle?
    
    let numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    @IBOutlet weak var txtOutput: UITextView!
    @IBOutlet weak var txtInput: UITextField!
//    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var clueNumView: UITextView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var turnLabel: UILabel!
    
    var selectedNum:String = ""
    
    var buttons: [UIButton] = [UIButton]()
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn10: UIButton!
    @IBOutlet weak var btn11: UIButton!
    @IBOutlet weak var btn12: UIButton!
    @IBOutlet weak var btn13: UIButton!
    @IBOutlet weak var btn14: UIButton!
    @IBOutlet weak var btn15: UIButton!
    @IBOutlet weak var btn16: UIButton!
    @IBOutlet weak var btn17: UIButton!
    @IBOutlet weak var btn18: UIButton!
    @IBOutlet weak var btn19: UIButton!
    @IBOutlet weak var btn20: UIButton!
    @IBOutlet weak var btn21: UIButton!
    @IBOutlet weak var btn22: UIButton!
    @IBOutlet weak var btn23: UIButton!
    @IBOutlet weak var btn24: UIButton!
    @IBOutlet weak var btn25: UIButton!
    
    var currentUser = Auth.auth().currentUser?.email
    var currentUid = Auth.auth().currentUser?.uid
    var userInGame:Bool = false
    var playerRole:String = ""
    var playerTeam:Int = 0
    var user:User? = nil
    var playerCount = 0
    var gameID:String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtInput.isHidden = true
        pickerView.isHidden = true
        sendBtn.isHidden = true
        doneBtn.isHidden = true 
//        txtInput.placeholder = "Clue"
        userLabel.text = currentUser
        ref = Database.database().reference()
        
        buttons.append(btn)
        buttons.append(btn2)
        buttons.append(btn3)
        buttons.append(btn4)
        buttons.append(btn5)
        buttons.append(btn6)
        buttons.append(btn7)
        buttons.append(btn8)
        buttons.append(btn9)
        buttons.append(btn10)
        buttons.append(btn11)
        buttons.append(btn12)
        buttons.append(btn13)
        buttons.append(btn14)
        buttons.append(btn15)
        buttons.append(btn16)
        buttons.append(btn17)
        buttons.append(btn18)
        buttons.append(btn19)
        buttons.append(btn20)
        buttons.append(btn21)
        buttons.append(btn22)
        buttons.append(btn23)
        buttons.append(btn24)
        buttons.append(btn25)
        
        for button in buttons {
            button.layer.cornerRadius = 10.0;
        }
        
//        var numberOfGame:Int = 0
        
         // Needs to be updated
//        if doThis == true {
//            var game = GameState()
//            game.newGame()
//            let num = game.gameNum
//            print("GAME NUM")
//                        print(num)
//            print(numberOfGame)
//            print("GAME NUM")
            //            game.createCards()
            //            game.createPlayers()
            //            self.addPlayer()
            //            let turnRef = ref?.child("turn").setValue("Purple clue giver");
//        }
        
         // Needs to be updated
        let handleUids = self.ref?.child("game").child("\(gameID)").child("players").child("uids").observe(.value, with: { snapshot in
            //            print(snapshot)
            
            self.playerCount = Int(snapshot.childrenCount)
//            print("Inside \(self.playerCount)")
            
            for child in snapshot.children {
                let childValue = child as! DataSnapshot
//                print(childValue.key)
                
                if childValue.key == self.currentUid {
                    self.userInGame = true
                }
            }
            
            if self.playerCount < 4 && self.userInGame == true {
                self.createAlert(title: "Almost there", message: "Waiting for 4 players")
                
            } else if (self.playerCount < 4 && self.userInGame == false) {
                self.addPlayer()
            } else if self.playerCount == 4 && self.userInGame == true {
//                print("Game is ready")
                
                let handlePlayers = self.ref?.child("game").child("\(self.gameID)").child("players").queryLimited(toFirst:4).observeSingleEvent(of: .value, with: { snapshot in
                    for child in snapshot.children {
                        let childValue = child as! DataSnapshot
                        let newValue = childValue.value as? NSDictionary
                        //                print("VALUE")
                        //                print(newValue!)
                        let uid: String? = newValue?.object(forKey: "user") as! String
                        //                        print(uid!)
                        if uid! == self.currentUid {
                            
                            self.playerRole = newValue?.object(forKey: "role") as! String
                            //                            print(self.playerRole)
                            self.playerTeam = newValue?.object(forKey: "team") as! Int
                            //                            print(self.playerTeam)
                            
                            if self.playerRole == "giver" {
                                self.addButtonBorder()
                                self.txtInput.isHidden = false
                                self.pickerView.isHidden = false
                                self.sendBtn.isHidden = false
                            } else if self.playerRole == "guesser" {
                                self.doneBtn.isHidden = false
                            }
                            
                            if self.playerTeam == 1 {
                                self.addBackgroundBorder(1)
                            } else if self.playerTeam == 2 {
                                self.addBackgroundBorder(2)
                            }
                            
                            self.createAlert(title: "Info", message: "You are the \(self.playerRole) for team \(self.playerTeam). Team 1: Purple. Team 2: Orange.")
                            break
                        }
                        
                    }
                    
                })

            }
            
        })

        var index = 0
        
         // Needs to be updated
        for button in buttons {
            handle = ref?.child("game").child("\(gameID)").child("card").child("\(index)").observe(.value, with: { snapshot in
                let value = snapshot.value as? NSDictionary
                let word: String? = value!.object(forKey: "word") as? String
                let team: Int? = value!.object(forKey: "team") as? Int
                let flipped: Bool? = value!.object(forKey: "flipped") as? Bool
                button.setTitle(word, for: .normal)
                button.tag = team!
                button.isEnabled = flipped!
            })
            
            index = index + 1
        }
        
         // Needs to be updated
        let turnHandle = ref?.child("game").child("\(gameID)").child("turn").observe(.value, with: { snapshot in
//            print("TURN")
//            print(snapshot.value!)
//            print("TURN")
            self.turnLabel.text = snapshot.value! as! String
        })
        
         // Needs to be updated
        handle = ref?.child("game").child("\(gameID)").child("card").observe(.value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            var purpleFlipped = true
            var orangeFlipped = true
            
            for button in self.buttons {
                if button.isEnabled == false {
                    if button.tag == 1 {
                        button.setBackgroundImage(#imageLiteral(resourceName: "Purplecom"), for: .disabled)
                    } else if (button.tag == 2) {
                        button.setBackgroundImage(#imageLiteral(resourceName: "Orange"), for: .disabled)
                    } else if (button.tag == 3) {
                        button.setBackgroundImage(#imageLiteral(resourceName: "cream"), for: .disabled)
                    } else if (button.tag == 4) {
                        button.setBackgroundImage(#imageLiteral(resourceName: "grey"), for: .disabled)
                        self.endGame()
                    }
                    
                }
                
                if button.tag == 1 && button.isEnabled == true {
                    purpleFlipped = false
                }
                
                if button.tag == 2 && button.isEnabled == true {
                    orangeFlipped = false
                }
                
            }
//            print("FLIPPED")
//            print(purpleFlipped)
//            print(orangeFlipped)
//            print("FLIPPED")
            if purpleFlipped == true || orangeFlipped == true {
                self.endGame()
            }

        })
        
         // Needs to be updated
        handle = ref?.child("game").child("\(gameID)").child("clue").queryLimited(toLast: 1).observe(.childAdded, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            let word: String? = value!.object(forKey: "word") as? String
            let number: String? = value!.object(forKey: "number") as? String
            self.txtOutput.text = word!
            self.clueNumView.text = number!
        })

    }
    
    func addPlayer() {
        ref = Database.database().reference()
        var person = ""
        
         // Needs to be updated
        let handlePlayers = ref?.child("game").child("\(gameID)").child("players").observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? [String : AnyObject]
            let something = value!["giver1"]?.object(forKey: "user") as? String
            //            print(something!)
            let something2 = value!["guesser1"]?.object(forKey: "user") as? String
            //             print(something2!)
            let something3 = value!["giver2"]?.object(forKey: "user") as? String
            //             print(something3!)
            let something4 = value!["guesser2"]?.object(forKey: "user") as? String
            //             print(something4!)
            
            let word = "add"
            switch word {
            case something!:
                person = "giver1"
                break
            case something2!:
                person = "guesser1"
                break
            case something3!:
                person = "giver2"
                break
            case something4!:
                person = "guesser2"
                break
            default:
                return
            }
//            print("PERSON \(person)")
            
             // Needs to be updated
            let playerRef = self.ref?.child("game").child("\(self.gameID)").child("players");
            playerRef?.child("\(person)").updateChildValues(["user": "\(self.currentUid!)"])
            
             // Needs to be updated
            let countRef = self.ref?.child("game").child("\(self.gameID)").child("players");
            countRef?.child("uids").child(self.currentUid!).setValue(person)
            return
        })
    }
    
    @IBAction func doneBtn(_ sender: UIButton) {
        doneWithTurn()
    }

    func doneWithTurn() {
         // Needs to be updated
        let handleTurn = ref?.child("game").child("\(gameID)").child("players").child("uids").queryOrdered(byChild: "\(self.currentUid)").observe(.value, with: {snapshot in
            let valueSnap = snapshot.value as? NSDictionary
            let something:String = valueSnap?.value(forKey: self.currentUid!) as? AnyObject as! String
            
            let turnRef = self.ref?.child("turn");
            
            if something == "giver1" {
                turnRef?.setValue("Purple guesser")
            } else if something == "guesser1" {
                turnRef?.setValue("Orange clue giver")
            } else if something == "giver2" {
                turnRef?.setValue("Orange guesser")
            } else if something == "guesser2" {
                turnRef?.setValue("Purple clue giver")
            }
            
        })

    }
    
    @IBAction func didTouchButton(_ sender: UIButton) {
        sender.isEnabled = false
        var ref:DatabaseReference?
        ref = Database.database().reference()
        
        var index:Int? = nil
        if (sender == btn) {
            index = 0
        } else if (sender == btn4) {
            index = 3
        } else if (sender == btn5) {
            index = 4
        } else if (sender == btn6) {
            index = 5
        } else if (sender == btn7) {
            index = 6
        } else if (sender == btn9) {
            index = 8
        } else if (sender == btn11) {
            index = 10
        } else if (sender == btn13) {
            index = 12
        } else if (sender == btn14) {
            index = 13
        } else if (sender == btn16) {
            index = 15
        } else if (sender == btn18) {
            index = 17
        } else if (sender == btn20) {
            index = 19
        } else if (sender == btn21) {
            index = 20
        } else if (sender == btn23) {
            index = 22
        } else if (sender == btn25) {
            index = 24
        } else if (sender == btn19) {
            index = 18
        } else if (sender == btn10) {
            index = 9
        } else if (sender == btn24) {
            index = 23
        } else if (sender == btn2) {
            index = 1
        } else if (sender == btn3) {
            index = 2
        } else if (sender == btn15) {
            index = 14
        } else if (sender == btn12) {
            index = 11
        } else if (sender == btn8) {
            index = 7
        } else if (sender == btn17) {
            index = 16
        } else if (sender == btn22) {
            index = 21
        }
//        print(index!)
        
         // Needs to be updated
        let cardsRef = ref?.child("game").child("\(gameID)").child("card");
        cardsRef?.child("\(index!)").updateChildValues(["flipped": false])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numbers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return numbers[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedNum = numbers[row]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtInput.resignFirstResponder()
        return false
    }
    
    func addButtonBorder() {
        for button in self.buttons {
            if button.tag == 1 {
                button.layer.borderWidth = 1.5;
                button.layer.borderColor = UIColor(red:0.56, green:0.27, blue:0.68, alpha:0.80).cgColor;
            } else if (button.tag == 2) {
                button.layer.borderWidth = 1.5;
                button.layer.borderColor = UIColor(red:0.95, green:0.47, blue:0.21, alpha:1.0).cgColor;
            } else if (button.tag == 3) {
                button.layer.borderWidth = 1.5;
                button.layer.borderColor = UIColor(red:0.99, green:0.89, blue:0.65, alpha:1.0).cgColor;
            } else if (button.tag == 4) {
                button.layer.borderWidth = 1.5;
                button.layer.borderColor = UIColor(red:0.08, green:0.06, blue:0.05, alpha:1.0).cgColor;
            }
            
        }
        
    }
    
    func addBackgroundBorder(_ team:Int) {
        if team == 1 {
            self.backgroundImage.layer.borderWidth = 2.0;
            self.backgroundImage.layer.borderColor = UIColor(red:0.56, green:0.27, blue:0.68, alpha:1.0).cgColor;
        } else if team == 2 {
            self.backgroundImage.layer.borderWidth = 2.0;
            self.backgroundImage.layer.borderColor = UIColor(red:0.95, green:0.47, blue:0.21, alpha:1.0).cgColor;
        }
        
    }
    
    func endGame() {
        self.createAlert(title: "Game Over!", message: "The game is over!")
    }
    
    func createAlert (title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sendClue(_ sender: Any) {
        ref = Database.database().reference()
        
        if (txtInput.text! == "") {
            return
        }
        
        let clue = txtInput.text
        
        txtOutput.text = ""
        txtInput.text = ""
        txtInput.resignFirstResponder()
        
        let post = [
            "word": clue,
            "number": selectedNum
        ] as [String: Any]
        
         // Needs to be updated
        let cardsRef = ref?.child("game").child("\(gameID)").child("clue");
        cardsRef?.childByAutoId().setValue(post)
        
        doneWithTurn()
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
