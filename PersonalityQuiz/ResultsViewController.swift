//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Ashwin V Prabhu on 7/20/17.
//  Copyright © 2017 Ashwin Venkatesh Prabhu. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var responses: [Answer]!
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true
        CalculatePersonalityResult()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func CalculatePersonalityResult() {
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        let responseTypes = responses.map { $0.type }
        
        for response in responseTypes {
            frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
        }
        
        let frequentAnswersSorted = frequencyOfAnswers.sorted(by: {
            (pair1, pair2) -> Bool in
                return pair1.value > pair2.value
        })
        let mostCommonAnswer = frequentAnswersSorted.first!.key
        
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
