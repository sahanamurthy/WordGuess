//
//  FirstViewController.swift
//  wordguess practice
//
//  Created by Sahana Murthy on 7/16/17.
//  Copyright © 2017 Sahana Murthy. All rights reserved.
//

import UIKit
import FirebaseAuth

class FirstViewController: UIViewController {
    
    @IBOutlet weak var userLabel: UILabel!
    
    var whatToDo:Bool = false
    
    @IBAction func newGame(_ sender: Any) {
        whatToDo = true
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    @IBAction func existingGame(_ sender: Any) {
        whatToDo = false
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameController = segue.destination as! GameViewController
        gameController.doThis = whatToDo
        print(whatToDo)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var currentUser = Auth.auth().currentUser?.email
        userLabel.text = currentUser
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
