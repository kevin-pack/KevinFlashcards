//
//  ViewController.swift
//  KevinFlashcards
//
//  Created by Kevin Pack on 2/15/20.
//  Copyright © 2020 Kevin Pack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var AnswerLabel: UILabel!
    @IBOutlet weak var QuestionLabel: UILabel!
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        QuestionLabel.isHidden=true;
    }
    
}

