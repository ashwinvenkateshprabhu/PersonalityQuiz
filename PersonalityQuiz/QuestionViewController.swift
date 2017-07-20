//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Ashwin V Prabhu on 7/20/17.
//  Copyright © 2017 Ashwin Venkatesh Prabhu. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    var questionIndex = 0
    var questions: [Question] = [
        Question(text: "Which food do you like the most?",
                 type: .single,
                 answer: [
                    Answer(text: "Steak", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Carrot", type: .rabbit),
                    Answer(text: "Corn", type: .turtle),
        ]),
        Question(text: "Which activities do you enjoy?",
                 type: .multiple,
                 answer: [
                    Answer(text: "Swimming", type: .turtle),
                    Answer(text: "Sleeping", type: .cat),
                    Answer(text: "Cuddling", type: .rabbit),
                    Answer(text: "Eating", type: .dog),
        ]),
        Question(text: "How much do you enjoy car rides?",
                 type: .ranged,
                 answer: [
                    Answer(text: "I dislike them", type: .cat),
                    Answer(text: "I get a little nervous", type: .rabbit),
                    Answer(text: "I barely notice them", type: .turtle),
                    Answer(text: "I love them", type: .dog),
        ])
    ]
    var answerChosen: [Answer] = []
    
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    @IBAction func SingleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answer
        
        switch sender {
        case singleButton1:
            answerChosen.append(currentAnswers[0])
        case singleButton2:
            answerChosen.append(currentAnswers[1])
        case singleButton3:
            answerChosen.append(currentAnswers[2])
        case singleButton4:
            answerChosen.append(currentAnswers[3])
        default:
            break
        }
        
        NextQuestion()
    }
    
    @IBAction func MultipleAnswerButtonPressed(_ sender: Any) {
        let currentAnswers = questions[questionIndex].answer
        
        if multiSwitch1.isOn {
            answerChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answerChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answerChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answerChosen.append(currentAnswers[3])
        }
        
        NextQuestion()
    }
    
    @IBAction func RangedAnswerButtonPressed(_ sender: Any) {
        let currentAnswers = questions[questionIndex].answer
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answerChosen.append(currentAnswers[index])
        
        NextQuestion()
    }
    
    func NextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            UpdateUI()
        } else {
            performSegue(withIdentifier: "ResultSegue", sender: answerChosen)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UpdateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UpdateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answer
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex+1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            UpdateSingleStackView(using: currentAnswers)
        case .multiple:
            UpdateMultipleStackView(using: currentAnswers)
        case .ranged:
            UpdateRangedStackView(using: currentAnswers)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answerChosen
        }
    }
    
    func UpdateSingleStackView(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func UpdateMultipleStackView(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    func UpdateRangedStackView(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
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
