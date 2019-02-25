//
//  ViewController.swift
//  Project5
//
//  Created by Sean Carrington on 22/02/2019.
//  Copyright © 2019 seanzi86. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
            if let startWords = try? String(contentsOfFile: startWordsPath) {
                allWords = startWords.components(separatedBy: "\n")
            } else {
                loadDefaultWords()
            }
        } else {
            loadDefaultWords()
        }
        
        startGame()
    }
    
    func loadDefaultWords() {
        allWords = ["silkworm"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    func startGame(){
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    func showError(title: String, message:String) {
        let alertController = UIAlertController(title: title, message:message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style:.default))
        present(alertController, animated: true)
    }
    
    func submit(answer:String){
        let lowerAnswer = answer.lowercased()
        
        if(lowerAnswer.count < 3){
            showError(title:"Word too short", message:"A word must be longer than 3 characters")
            return
        }
        
        if (lowerAnswer == title) {
            showError(title:"Word is not an anagram", message: "You can't just enter the original word, you know!")
            return
        }
        
        if (!isOriginal(word: lowerAnswer)) {
            showError(title: "Word used already", message: "Be more original!")
            return
        }
        
        if (!isPossible(word: lowerAnswer)) {
            showError(title: "Word not possible", message: "You can't spell that word from '\(title!.lowercased())'!")
            return
        }
        
        if (!isReal(word: lowerAnswer)){
            showError(title: "Word not recognised", message: "You can't just make them up, you know!")
            return
        }
        
        usedWords.insert(answer, at: 0);
        let indexPath = IndexPath(row:0, section:0)
        tableView.insertRows(at:[indexPath], with: .automatic)
        
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = title!.lowercased()
        
        for letter in word {
            if let position = tempWord.range(of: String(letter)){
                tempWord.remove(at:position.lowerBound)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word:String) -> Bool {
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    @objc func promptForAnswer(){
        let alertController = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style:.default) {
            [unowned self, alertController] (action: UIAlertAction) in
            let answer = alertController.textFields![0]
            self.submit(answer: answer.text!)
        }
        
        alertController.addAction(submitAction)
        present(alertController, animated: true)
    }


}

