//
//  ViewController.swift
//  KevinFlashcards
//
//  Created by Kevin Pack on 2/15/20.
//  Copyright © 2020 Kevin Pack. All rights reserved.
//

import UIKit

struct Flashcard{
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    var flashcards = [Flashcard]()
    
    // flashcard index
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        readSavedFlashcards()
        if flashcards.count == 0{
            updateFlashcard(question: "Your question goes here", answer: "Happy Studying :)", op1: "", op2: "")
        }
        else{
            updateLabels()
            updateNextPrevButtons()
        }
        
        answerLabel.clipsToBounds=true
        answerLabel.layer.cornerRadius=20.0
        
        questionLabel.layer.cornerRadius=20.0
        questionLabel.clipsToBounds=true
        
        card.layer.cornerRadius=20.0
        card.layer.shadowRadius=10.0
        card.layer.shadowOpacity=0.3
        card.layer.masksToBounds=false
        
        option1.layer.cornerRadius=20.0
        option1.layer.borderWidth=3.0
        option1.layer.borderColor=#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        option2.layer.cornerRadius=20.0
        option2.layer.borderWidth=3.0
        option2.layer.borderColor=#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        option3.layer.cornerRadius=20.0
        option3.layer.borderWidth=3.0
        option3.layer.borderColor=#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    }
    
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if(questionLabel.isHidden){
            questionLabel.isHidden=false
        }
        else{
            questionLabel.isHidden=true
        }
    }
    @IBAction func didTapOption1(_ sender: Any) {
        //option1.layer.borderColor=#colorLiteral(red: 1, green: 0.1325082183, blue: 0, alpha: 1)
    }
    @IBAction func didTapOption2(_ sender: Any) {
        //option2.layer.borderColor=#colorLiteral(red: 1, green: 0.1325082183, blue: 0, alpha: 1)
    }
    @IBAction func didTapOption3(_ sender: Any) {
        //option3.layer.borderColor=#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        if(questionLabel.isHidden){
            questionLabel.isHidden=false
        }
        else{
            questionLabel.isHidden=true
        }
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex+1
        
        updateLabels()
        
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex-1
        
        updateLabels()
        updateNextPrevButtons()
    }
    
    func updateFlashcard(question: String, answer: String, op1: String, op2: String) {
        
        let flashcard = Flashcard(question: question, answer: answer)
        
        flashcards.append(flashcard)
        
        print("appended flashcard")
        print("we now have \(flashcards.count) flashcard(s)")
        
        currentIndex = flashcards.count - 1
        
        option1.setTitle(op1, for: .normal)
        option2.setTitle(op2, for: .normal)
        option3.setTitle(answer, for: .normal)
        
        saveAllFlashcardsToDisk()
    }
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        
        questionLabel.text = currentFlashcard.question
        
        answerLabel.text = currentFlashcard.answer
    }
    
    func updateNextPrevButtons(){
        // disable next button at end
        if currentIndex == (flashcards.count - 1){
            nextButton.isEnabled = false
        }
        else{
            nextButton.isEnabled = true
        }
        
        if currentIndex == 0{
            prevButton.isEnabled = false
        }
        else{
            prevButton.isEnabled = true
        }
    }
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    func saveAllFlashcardsToDisk(){
        
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("flashcards saved to disk")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // destination of the segue is the navigation controller
        let navigationController = segue.destination as! UINavigationController
        
        // the navigation controller contiains the creation controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        // set the creation controller's flashcardsController to this current file
        creationController.flashcardsController = self
        
        if segue.identifier == "EditSegue"{
            creationController.initialQuestion = questionLabel.text
            creationController.initialAnswer = answerLabel.text
        }
    }
}

