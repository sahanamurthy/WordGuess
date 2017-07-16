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

class GameViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
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
        
        var game = GameState()
        game.createCards()
        
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

        ref = Database.database().reference()
        
//        ref?.observe(.value, with: { snapshot in
//            print("*******")
//            print(snapshot.value!)
//            print("*******")
//            
//            let something = snapshot.value!
//            print(something["card"][0])
//        })
//        let cardRef = ref?.child("card").child("\(1)")
//        print("*******")
//        print(cardRef!)
//        print("********")

        handle = ref?.child("card").child("\(1)").observe(.value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            let word: String? = value!.object(forKey: "word") as? String
            print(word!)
            let team: Int? = value!.object(forKey: "team") as? Int
            print(team!)
            self.btn.setTitle(word, for: .normal)
            self.btn.tag = team!
        })
        
        handle = ref?.child("card").child("\(2)").observe(.value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            let word: String? = value!.object(forKey: "word") as? String
            print(word!)
            let team: Int? = value!.object(forKey: "team") as? Int
            print(team!)
            self.btn2.setTitle(word, for: .normal)
            self.btn2.tag = team!
        })

//        handle = self.ref?.child("card").observe(.childAdded, with: { (snapshot) in
//            if let result = snapshot.children.allObjects as? [DataSnapshot] {
//                print(result)
//            }
//                var word = result[1]
//                print(word)
        
//            let value = snapshot.value as? NSDictionary
////            let word = value?["word"] as? String
////            let team = value?["team"]
////            self.btn2.setTitle(word, for: .normal)
////            self.btn.tag = team as! Int
//            print(value)
                
//        })
        

//        btn2.setTitle(shuffledCards[1] as? String, for: .normal); btn2.tag = shuffledTeams[1] as! Int
//
//        btn3.setTitle(shuffledCards[2] as? String, for: .normal); btn3.tag = shuffledTeams[2] as! Int
//
//        btn4.setTitle(shuffledCards[3] as? String, for: .normal); btn4.tag = shuffledTeams[3] as! Int
//
//        btn5.setTitle(shuffledCards[4] as? String, for: .normal); btn5.tag = shuffledTeams[4] as! Int
//
//        btn6.setTitle(shuffledCards[5] as? String, for: .normal); btn6.tag = shuffledTeams[5] as! Int
//
//        btn7.setTitle(shuffledCards[6] as? String, for: .normal); btn7.tag = shuffledTeams[6] as! Int
//
//        btn8.setTitle(shuffledCards[7] as? String, for: .normal); btn8.tag = shuffledTeams[7] as! Int
//
//        btn9.setTitle(shuffledCards[8] as? String, for: .normal); btn9.tag = shuffledTeams[8] as! Int
//
//        btn10.setTitle(shuffledCards[9] as? String, for: .normal); btn10.tag = shuffledTeams[9] as! Int
//
//        btn11.setTitle(shuffledCards[10] as? String, for: .normal); btn11.tag = shuffledTeams[10] as! Int
//
//        btn12.setTitle(shuffledCards[11] as? String, for: .normal); btn12.tag = shuffledTeams[11] as! Int
//
//        btn13.setTitle(shuffledCards[12] as? String, for: .normal); btn13.tag = shuffledTeams[12] as! Int
//
//        btn14.setTitle(shuffledCards[13] as? String, for: .normal); btn14.tag = shuffledTeams[13] as! Int
//
//        btn15.setTitle(shuffledCards[14] as? String, for: .normal); btn15.tag = shuffledTeams[14] as! Int
//
//        btn16.setTitle(shuffledCards[15] as? String, for: .normal); btn16.tag = shuffledTeams[15] as! Int
//
//        btn17.setTitle(shuffledCards[16] as? String, for: .normal); btn17.tag = shuffledTeams[16] as! Int
//
//        btn18.setTitle(shuffledCards[17] as? String, for: .normal); btn18.tag = shuffledTeams[17] as! Int
//
//        btn19.setTitle(shuffledCards[18] as? String, for: .normal); btn19.tag = shuffledTeams[18] as! Int
//
//        btn20.setTitle(shuffledCards[19] as? String, for: .normal); btn20.tag = shuffledTeams[19] as! Int
//
//        btn21.setTitle(shuffledCards[20] as? String, for: .normal); btn21.tag = shuffledTeams[20] as! Int
//
//        btn22.setTitle(shuffledCards[21] as? String, for: .normal); btn22.tag = shuffledTeams[21] as! Int
//
//        btn23.setTitle(shuffledCards[22] as? String, for: .normal); btn23.tag = shuffledTeams[22] as! Int
//
//        btn24.setTitle(shuffledCards[23] as? String, for: .normal); btn24.tag = shuffledTeams[23] as! Int
//
//        btn25.setTitle(shuffledCards[24] as? String, for: .normal); btn25.tag = shuffledTeams[24] as! Int

//        btn2.setTitleColor(.red, for: .normal)
//        btn.layer.borderWidth = 2.0;
//        btn.layer.borderColor = myColor.cgColor;
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
    }
    
    @IBAction func didTouchButton(_ sender: UIButton) {
        if (sender.tag == 1) {
            sender.layer.backgroundColor = UIColor(red:0.75, green:0.56, blue:0.83, alpha:1.0).cgColor;
        } else if (sender.tag == 2) {
            sender.layer.backgroundColor = UIColor(red:0.95, green:0.47, blue:0.29, alpha:1.0).cgColor;
        } else if (sender.tag == 3) {
            sender.layer.backgroundColor = UIColor(red:0.99, green:0.89, blue:0.65, alpha:1.0).cgColor;
        } else if (sender.tag == 4) {
            sender.layer.backgroundColor = UIColor(red:0.42, green:0.48, blue:0.54, alpha:1.0).cgColor;
        }
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
//        label.text = numbers[row]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtInput.resignFirstResponder()
        return false
    }
    
    @IBAction func sendClue(_ sender: Any) {
        if (txtInput.text! == "") {
            return
        }
        
        let clue = txtInput.text
        
        txtOutput.text = ""
        txtOutput.text = clue
        txtInput.text = ""
        txtInput.resignFirstResponder()
        
        label.text = selectedNum
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
