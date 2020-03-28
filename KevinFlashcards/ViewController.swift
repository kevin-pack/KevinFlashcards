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
            updateFlashcard(question: "How many bits are in a byte?", answer: "8", isExisting: true)
            option1.setTitle("1", for: .normal)
            option2.setTitle("3", for: .normal)
            option3.setTitle("8", for: .normal)
        }
        else{
            updateLabels()
            updateNextPrevButtons()
        }
        
        //print("\(flashcards[0].question) KEVINKEVINKEVIN \(flashcards[0].answer)")
        
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
        
        print("\(flashcards.count)")
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
        flipFlashcard()
    }
    
    func flipFlashcard(){
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {if(self.questionLabel.isHidden){
            self.questionLabel.isHidden=false
        }
        else{
            self.questionLabel.isHidden=true
            }})
    }
    
    func animateCardOut(){
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)},
                       completion: {finished in
                        self.updateLabels()
                        self.animateCardIn()})
    }
    
    func animateCardIn(){
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        UIView.animate(withDuration: 0.3, animations: {self.card.transform = CGAffineTransform.identity})
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
        animateCardOut()
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex-1
        
        updateLabels()
        
        updateNextPrevButtons()
    }
    
    func updateFlashcard(question: String, answer: String, isExisting: Bool) {
        
        let flashcard = Flashcard(question: question, answer: answer)
        print("flashcards count: \(flashcards.count)\ncurrent index: \(currentIndex)")
        if isExisting && flashcards.count > 0{
            flashcards[currentIndex] = flashcard
        }
        else{
            flashcards.append(flashcard)
            
            print("appended flashcard")
            print("we now have \(flashcards.count) flashcard(s)")
            
            currentIndex = flashcards.count - 1
            print("current index is \(currentIndex)")
            /*
            option1.setTitle(".", for: .normal)
            option2.setTitle("..", for: .normal)
            option3.setTitle(answer, for: .normal)
            */
            updateLabels()
            updateNextPrevButtons()
            saveAllFlashcardsToDisk()
        }
    }
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        
        questionLabel.text = currentFlashcard.question
        
        answerLabel.text = currentFlashcard.answer
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete this flashcard?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in self.deleteCurrentFlashcard()}
        
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func deleteCurrentFlashcard(){
        if flashcards.count > 1{
            flashcards.remove(at: currentIndex)
            if currentIndex > flashcards.count - 1 {
                currentIndex = flashcards.count - 1
            }
            updateLabels()
            updateNextPrevButtons()
        }
        else{
            let cardAlert = UIAlertController(title: "Cannot delete", message: "You must have at least one card", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            
            cardAlert.addAction(okAction)
            
            present(cardAlert, animated: true)
        }
    }
    
    func updateNextPrevButtons(){
        // disable next button at end
        if currentIndex == (flashcards.count - 1){
            nextButton.isEnabled = false
        }
        else{
            nextButton.isEnabled = true
        }
        
        // disable prev button at start
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

