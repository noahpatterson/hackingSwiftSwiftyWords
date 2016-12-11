//
//  ViewController.swift
//  SwiftyWords
//
//  Created by Noah Patterson on 12/11/16.
//  Copyright © 2016 noahpatterson. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    var letterButtons    = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions     = [String]()
    
    var score = 0
    var level = 1

    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func submitTapped() {
    }
    
    @IBAction func clearTapped() {
    }
    
    func letterTapped(button: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //targets all the buttons by their common tag
        for subview in view.subviews where subview.tag == 1001 {
            let btn = subview as! UIButton
            letterButtons.append(btn)
            
            //adds a action to a button through code
            btn.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
        }
        loadLevel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFilePath = Bundle.main.path(forResource: "level\(level)", ofType: "txt") {
            if let levelContents = try? String(contentsOfFile: levelFilePath) {
                var lines = levelContents.components(separatedBy: "\n")
                lines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as! [String]
                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ":")
                    
                    let answer = parts[0]
                    let clue   = parts[1]
                    
                    clueString += "\(index + 1) \(clue)\n"
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionWord.characters.count) letters\n"
                    solutions.append(solutionWord)
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
        }
        
        //now configure the buttons and labels
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: letterBits) as! [String]
        
        if letterBits.count == letterButtons.count {
            for i in 0..<letterBits.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }


}

