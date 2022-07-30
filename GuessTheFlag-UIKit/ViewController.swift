//
//  ViewController.swift
//  GuessTheFlag-UIKit
//
//  Created by newbie on 29.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstFlag: UIButton!
    @IBOutlet weak var secondFlag: UIButton!
    @IBOutlet weak var thirdFlag: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    private var flags = [String]()
    private var score = 0
    private var correctAnswer = 0
    private var totalQuestions = 5
    private var currentQuestion = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flags.append(contentsOf: ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "spain", "uk", "us"])
        
        firstFlag.layer.borderWidth = 1
        secondFlag.layer.borderWidth = 1
        thirdFlag.layer.borderWidth = 1
        
        firstFlag.layer.borderColor = UIColor.lightGray.cgColor
        secondFlag.layer.borderColor = UIColor.lightGray.cgColor
        thirdFlag.layer.borderColor = UIColor.lightGray.cgColor
        
        prepareQuestion()
    }
    
    @IBAction func flagButtonPressed(_ sender: UIButton) {
        sender.layer.borderWidth = 2
        currentQuestion += 1
        if sender.tag == correctAnswer {
            sender.layer.borderColor = UIColor.green.cgColor
            score += 1
        } else {
            sender.layer.borderColor = UIColor.red.cgColor
        }
        scoreLabel.text = "Score: \(score)"
        
        if currentQuestion % totalQuestions == 0 {
            let ac = UIAlertController(title: "Your score is: \(score)", message: "Do you want to proceed?", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Proceed", style: .default))
            ac.addAction(UIAlertAction(title: "Restart", style: .cancel, handler: reset))
            
            present(ac, animated: true)
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { [weak self] timer in
            sender.layer.borderColor = UIColor.gray.cgColor
            sender.layer.borderWidth = 1
            self?.prepareQuestion()
        })
    }
    
    
    private func prepareQuestion(action: UIAlertAction! = nil) {
        flags.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        title = flags[correctAnswer].uppercased()
        
        firstFlag.setImage(UIImage(named: flags[0]), for: .normal)
        secondFlag.setImage(UIImage(named: flags[1]), for: .normal)
        thirdFlag.setImage(UIImage(named: flags[2]), for: .normal)
    }

    private func reset(action: UIAlertAction! = nil) {
        score = 0
        currentQuestion = 0
        scoreLabel.text = "Score: \(score)"
        prepareQuestion()
    }

}

