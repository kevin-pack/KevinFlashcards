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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionInput.text
        
        let answerText = answerInput.text
        
    flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
        
        dismiss(animated: true)
    }
}
