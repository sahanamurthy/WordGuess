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
    
    @IBOutlet weak var userLabel: UILabel!
    
    var doThis:Bool = false
    var ref:DatabaseReference?
    var handle:DatabaseHandle?
    
    let numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    @IBOutlet weak var txtOutput: UITextView!
    @IBOutlet weak var txtInput: UITextField!
    @IBOutlet weak var label: UILabel!
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtInput.placeholder = "Clue"
        var currentUser = Auth.auth().currentUser?.email
        var currentUid = Auth.auth().currentUser?.uid
        userLabel.text = currentUser
        ref = Database.database().reference()

        if doThis == true {
            var game = GameState()
            game.createCards()
            game.createPlayers()
            game.addPlayer()
        }
        
        var playerCount = 0
        let handlePlayers = ref?.child("players").child("uids").observe(.value, with: { snapshot in
            playerCount = Int(snapshot.childrenCount)
        })
        
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

        
        
        var index = 0
        
        for button in buttons {
            handle = ref?.child("card").child("\(index)").observe(.value, with: { snapshot in
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
        
        handle = ref?.child("card").observe(.value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            
            for button in self.buttons {
                if button.isEnabled == false {
                    if button.tag == 1 {
                        button.setBackgroundImage(#imageLiteral(resourceName: "Purplecom"), for: .disabled)
                    } else if (button.tag == 2) {
                        button.setBackgroundImage(#imageLiteral(resourceName: "Orange"), for: .disabled)
                    } else if (button.tag == 3) {
                        button.setBackgroundImage(#imageLiteral(resourceName: "Neutral"), for: .disabled)
                    } else if (button.tag == 4) {
                        button.setBackgroundImage(#imageLiteral(resourceName: "grey"), for: .disabled)
                    }
                    
                }
            }

        })
        
        handle = ref?.child("clue").queryLimited(toLast: 1).observe(.childAdded, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            let word: String? = value!.object(forKey: "word") as? String
            let number: String? = value!.object(forKey: "number") as? String
            self.txtOutput.text = word!
            self.label.text = number!
        })

        
//        btn2.setTitleColor(.red, for: .normal)
//        btn.layer.borderWidth = 2.0;
//        btn.layer.borderColor = myColor.cgColor;
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.

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
        print(index!)
        let cardsRef = ref?.child("card");
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
        
        let cardsRef = ref?.child("clue");
        cardsRef?.childByAutoId().setValue(post)
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
