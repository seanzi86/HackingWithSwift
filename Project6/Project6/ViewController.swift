//
//  ViewController.swift
//  Project2
//
//  Created by Sean Carrington on 22/02/2019.
//  Copyright © 2019 seanzi86. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var questionNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries.append("estonia")
        countries.append("france")
        countries.append("germany")
        countries.append("ireland")
        countries.append("italy")
        countries.append("monaco")
        countries.append("nigeria")
        countries.append("poland")
        countries.append("russia")
        countries.append("spain")
        countries.append("uk")
        countries.append("us")
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil){
        questionNumber += 1
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in:0...2)
        title = "Question: \(questionNumber). Score: \(score). Find \(countries[correctAnswer].uppercased())"
    }
    
    func restartGame(action: UIAlertAction! = nil){
        questionNumber = 0;
        score = 0;
        askQuestion();
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        let message = "That is the flag for \(countries[sender.tag])."
        
        if (sender.tag == correctAnswer){
            title = "Correct"
            score += 1
        } else {
            title = "Incorrect"
            score -= 1
        }
        
        if (questionNumber == 10) {
            let alertController = UIAlertController(title: "Game Over", message: "Your final score is \(score).", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title:"Restart", style: .default, handler: restartGame))
            present(alertController, animated: true)
        } else {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(alertController, animated: true)
        }
        
    }
    
}

