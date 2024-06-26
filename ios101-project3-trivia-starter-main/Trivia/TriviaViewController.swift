//
//  TriviaViewController.swift
//  Trivia
//  This ViewController remains focused on managing the trivia game flow
//  Created by Antwon Walls on 3/7/24.
//

import UIKit

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

/*Contains the logic for displaying trivia questions, handling user input for answering questions, updating the game state, etc.*/
class TriviaViewController: UIViewController {
    /*Contains IBOutlets for displaying the trivia question number, question asked, and answer choices, IBActions for handling button taps when the user selects an answer, and handles presenting the game over popup when the game ends*/
    @IBOutlet weak var QuestionAsked: UILabel!
    @IBOutlet weak var questionHeader: UILabel!
    
    
    /*IBOutlets allows me to reference the buttons
     in the code and modify its physical properties*/
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    
    @IBAction func answerButton1(_ sender: UIButton) {
    }
    
    @IBAction func answerButton2(_ sender: UIButton) {
    }
    
    @IBAction func answerButton3(_ sender: UIButton) {
    }
    
    @IBAction func answerButton4(_ sender: UIButton) {
    }
    
    let maxClickCount = 3
    
    var correctAnswer = ""
    var gameOverTitle = "Game Over!"
    var gameOverMessage = ""
    var clickCount = 0
    var correctCount = 0
    
    struct TriviaStruct {
        var questionHeaderText: String
        var question: String
        var answerOption1: String
        var answerOption2: String
        var answerOption3: String
        var answerOption4: String
    }
    var triviaQuestions: [TriviaStruct] = [
        TriviaStruct(questionHeaderText: "Question: 1/3", question: "What country ranks #1 for hosting international students?", answerOption1: "New Zealand", answerOption2: "United States", answerOption3: "Brazil", answerOption4: "Germany"), //index 0
        TriviaStruct(questionHeaderText: "Question: 2/3", question: "What was the shortest war in history?", answerOption1: "The Falklands War", answerOption2: "The Georgian-Armenian War", answerOption3: "The Anglo-Zanibar War", answerOption4: "The Sino-Vietnamese War"), //index 1
        TriviaStruct(questionHeaderText: "Question: 3/3", question: "What Amendment to the U.S. Constitution took 200 years, 7 months and 10 days to ratify?", answerOption1: "2nd Amendment", answerOption2: "13th Amendment", answerOption3: "24th Amendment", answerOption4: "27th Amendment"), //index 2
    ]
    
    /*Computed property observer in Swift. Used to trigger the configure()
      method whenever the currentQuestionIndex is updated*/
    var currentQuestionIndex = 0 {
        /*Property observer that watches for changes to currentQuestionIndex*/
        didSet {
            //When currentQuestionIndex's value changes, didSet is executed*/
            configure()
        }
    }
    
    //Function checks if the game has ended (if the user has hit 3 questions)
    func checkGameEnd() -> Bool {
        if (clickCount >= 3) {
            /*If the user has answered the max number of questions (3 clicks),
             shows the game over alert*/
            return true
        }
        return false //implied else statement
    }
    
    func setCorrectAnswer() {
        guard let currentQuestion = triviaQuestions[safe: currentQuestionIndex] else {
            print("Error: Unable to set correct answer. Invalid question index.")
            return
        }
        
        /*The ? in titleLabel is an optional chaining operator.
         Allows accessing properties and methods on an
         optional value*/
        /*The ?? after .text is a nil-coalescing operator. It
         provides a default value (e.g. "") if the text's
         value is nil*/
        switch currentQuestionIndex {
        case 0:
            correctAnswer = currentQuestion.answerOption2
        case 1:
            correctAnswer = currentQuestion.answerOption3
        case 2:
            correctAnswer = currentQuestion.answerOption4
        default:
            break
        }
    }
    
    func showAlert(_ message: String) {
        gameOverMessage = "Final score: \(correctCount)/3"
        if (currentQuestionIndex == triviaQuestions.count - 1) {
            // Creates aUIAlertController with the specified title and message
            let restartAction = UIAlertController(title: gameOverTitle, message: gameOverMessage, preferredStyle: .alert)
            
            //Adds an action to the alert controller
            restartAction.addAction(UIAlertAction(title: "Restart", style: .default, handler: { action in
                self.resetGame() //resets the game when the user taps Restart button
            }))
            
            //presents the alert with animation
            self.present(restartAction, animated: true, completion: nil)
        }
    }
    
    /*When the user taps the restart button (after answering 3 questions),
     resets the game state*/
    @IBAction func resetGame() {
        // Resets number of clicks
        clickCount = 0
        correctCount = 0
        currentQuestionIndex = 0
    }
    
    func configure() {
        // Guard statement to ensure currentQuestionIndex stays within bounds
        guard (currentQuestionIndex < triviaQuestions.count) else {
            return
        }
        
        /*Sets the properties of each Storyboard Object depending on what
          question the user ison*/
        let currentQuestion = triviaQuestions[currentQuestionIndex]
        questionHeader.text = currentQuestion.questionHeaderText
        QuestionAsked.text = currentQuestion.question
        answerButton1.setTitle(currentQuestion.answerOption1, for: .normal)
        answerButton2.setTitle(currentQuestion.answerOption2, for: .normal)
        answerButton3.setTitle(currentQuestion.answerOption3, for: .normal)
        answerButton4.setTitle(currentQuestion.answerOption4, for: .normal)
        
        //Call setCorrectAnswer before it's needed
        setCorrectAnswer()
    }
    
    /*Triggered when the user taps an answer button. Updates the score when the user clicks on the button AND checks if
        the game has ended*/
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        // Increments click count if the game hasn't ended
        if (checkGameEnd() == false) {
            clickCount += 1
        }
        
        /*Guard is used to safely unwrap an optional value. Essentialy, it
         first checks if the optional value is NOT nil. If NOT nil, safely
         unwraps it and assigns it to a non-optional variable*/
        guard let selectedAnswer = sender.titleLabel?.text else {
            return
        }
        
        if (selectedAnswer == correctAnswer) {
            correctCount += 1
        }
        
        //Check if game has ended
        if (clickCount >= maxClickCount) {
            showAlert(gameOverMessage)
        }
        
        else if (currentQuestionIndex < triviaQuestions.count - 1) {
            configure()
            currentQuestionIndex += 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*ensures that the correct answer is executed before ANY user
          interaction occurs, including the first button tap*/
        setCorrectAnswer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        /*So I don't have to set the # of lines of text and infinitely
         wrap the words so that it doesn't clip across the screen*/
        QuestionAsked.numberOfLines = 0
        QuestionAsked.lineBreakMode = .byWordWrapping
        
        /*Sets the corner radius of each object to half of the height
         to create a circular shape, and make sure the view clips
         to the bounds to apply the rounded corners*/
        QuestionAsked.layer.cornerRadius = QuestionAsked.frame.height / 30
        QuestionAsked.clipsToBounds = true
        answerButton1.layer.cornerRadius = answerButton1.frame.height / 7.5
        answerButton1.clipsToBounds = true
        answerButton2.layer.cornerRadius = answerButton2.frame.height / 7.5
        answerButton2.clipsToBounds = true
        answerButton3.layer.cornerRadius = answerButton3.frame.height / 7.5
        answerButton3.clipsToBounds = true
        answerButton4.layer.cornerRadius = answerButton4.frame.height / 7.5
        answerButton4.clipsToBounds = true
    }
}
