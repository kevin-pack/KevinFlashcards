//
//  CreationViewController.swift
//  KevinFlashcards
//
//  Created by Kevin Pack on 3/6/20.
//  Copyright © 2020 Kevin Pack. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    var flashcardsController: ViewController!
    
    
    @IBOutlet weak var questionInput: UITextField!
    
    @IBOutlet weak var answerInput: UITextField!
    
    @IBOutlet weak var ExtraAnswer1: UITextField!
    @IBOutlet weak var ExtraAnswer2: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionInput.text = initialQuestion
        answerInput.text = initialAnswer
        
        // Do any additional setup after loading the view.
    }
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionInput.text
        
        let answerText = answerInput.text
        
        var isExisting = false
        if initialQuestion != nil{
            isExisting = true
        }
        
        if answerText == nil || questionText == nil || answerText!.isEmpty || questionText!.isEmpty
        {
            // show error
            let alert = UIAlertController(title: "Missing text", message: "You need to enter a question and an answer", preferredStyle: .alert)
            present(alert, animated: true)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
        }
        else{
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, isExisting: isExisting)
            flashcardsController.updateLabels()
            dismiss(animated: true)
        }
    }
}
