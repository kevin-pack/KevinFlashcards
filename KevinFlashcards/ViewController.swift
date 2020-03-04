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
        AnswerLabel.clipsToBounds=true;
        AnswerLabel.layer.cornerRadius=20.0;
        
        QuestionLabel.layer.cornerRadius=20.0;
        QuestionLabel.clipsToBounds=true;
        
        card.layer.cornerRadius=20.0;
        card.layer.shadowRadius=10.0;
        card.layer.shadowOpacity=0.3;
        card.layer.masksToBounds=false;
        
        option1.layer.cornerRadius=20.0;
        option1.layer.borderWidth=3.0;
        option1.layer.borderColor=#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1);
        
        option2.layer.cornerRadius=20.0;
        option2.layer.borderWidth=3.0;
        option2.layer.borderColor=#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1);
        
        option3.layer.cornerRadius=20.0;
        option3.layer.borderWidth=3.0;
        option3.layer.borderColor=#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1);
    }
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var AnswerLabel: UILabel!
    @IBOutlet weak var QuestionLabel: UILabel!
    
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if(QuestionLabel.isHidden){
            QuestionLabel.isHidden=false;
        }
        else{
            QuestionLabel.isHidden=true;
        }
    }
    @IBAction func didTapOption1(_ sender: Any) {
        option1.layer.borderColor=#colorLiteral(red: 1, green: 0.1325082183, blue: 0, alpha: 1);
    }
    @IBAction func didTapOption2(_ sender: Any) {
        option2.layer.borderColor=#colorLiteral(red: 1, green: 0.1325082183, blue: 0, alpha: 1);
    }
    @IBAction func didTapOption3(_ sender: Any) {
        option3.layer.borderColor=#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1);
        QuestionLabel.isHidden=true;
    }
    
}

