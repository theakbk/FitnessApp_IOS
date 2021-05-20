//
//  ViewController.swift
//  FitnessApp
//
//  Created by Thea Kampmann on 01/04/2021.
//

import UIKit
//import Firebase

let fs = FirebaseService()

class ViewController: UIViewController{//}, Updateable{
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue)
    {}

    override func viewDidLoad() {
        super.viewDidLoad()
        //fS.parent = self
        fs.storageRef = fs.storage.reference()
        fs.startListener() // here you know, that Firebase has been initialized
        print("viewCOntroller - did load")
    }
    
    


}

