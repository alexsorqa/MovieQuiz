import UIKit

final class MovieQuizViewController: UIViewController {
    
    private struct QuizQuestion {
      let image: String
      let text: String
      let correctAnswer: Bool
    }
    
    private struct QuizStepViewModel {
      let image: UIImage
      let question: String
      let questionNumber: String
    }
    
    private struct QuizResultsViewModel {
      let title: String
      let text: String
      let buttonText: String
    }
    
    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    private let questions: [QuizQuestion] = [
           QuizQuestion(
               image: "The Godfather",
               text: "Рейтинг этого фильма больше чем 6?",
               correctAnswer: true
           ),
           QuizQuestion(
               image: "The Dark Knight",
               text: "Рейтинг этого фильма больше чем 6?",
               correctAnswer: true
           ),
           QuizQuestion(
               image: "Kill Bill",
               text: "Рейтинг этого фильма больше чем 6?",
               correctAnswer: true
           ),
           QuizQuestion(
               image: "The Avengers",
               text: "Рейтинг этого фильма больше чем 6?",
               correctAnswer: true
           ),
           QuizQuestion(
               image: "Deadpool",
               text: "Рейтинг этого фильма больше чем 6?",
               correctAnswer: true
           ),
           QuizQuestion(
               image: "The Green Knight",
               text: "Рейтинг этого фильма больше чем 6?",
               correctAnswer: true
           ),
           QuizQuestion(
               image: "Old",
               text: "Рейтинг этого фильма больше чем 6?",
               correctAnswer: false
           ),
           QuizQuestion(
               image: "The Ice Age Adventures of Buck Wild",
               text: "Рейтинг этого фильма больше чем 6?",
               correctAnswer: false
           ),
           QuizQuestion(
               image: "Tesla",
               text: "Рейтинг этого фильма больше чем 6?",
               correctAnswer: false
           ),
           QuizQuestion(
               image: "Vivarium",
               text: "Рейтинг этого фильма больше чем 6?",
               correctAnswer: false
           )
       ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        show(quiz: convert(model: questions[currentQuestionIndex]))
        imageView.layer.cornerRadius = 20
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let image = UIImage(named: model.image) ?? UIImage()
        let question = model.text
        let questionNumber: String
        
        if questions.count == 0 {
            questionNumber = "0/0"
        } else {
            questionNumber = "\(currentQuestionIndex + 1)/\(questions.count)"
        }
        return QuizStepViewModel(image: image, question: question, questionNumber: questionNumber)
    }
    
    private func show(quiz step: QuizStepViewModel) {
        imageView.layer.borderWidth = 0
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
        
        setButtonsEnabled(true)
    }
    
    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
            imageView.layer.borderColor = UIColor.ypGreen.cgColor
            correctAnswers += 1
        } else {
            imageView.layer.borderColor = UIColor.ypRed.cgColor
        }
        
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.cornerRadius = 20
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
           self.showNextQuestionOrResults()
        }
    }
    
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questions.count - 1 {
            let text = "Ваш результат: \(correctAnswers)/10"
            let viewModel = QuizResultsViewModel(title: "Этот раунд окончен!", text: text, buttonText: "Сыграть ещё раз")
            show(quiz: viewModel)
        } else {
            currentQuestionIndex += 1
            let nextQuestion = questions[currentQuestionIndex]
            let viewModel = convert(model: nextQuestion)
            show(quiz: viewModel)
        }
    }

    private func show(quiz result: QuizResultsViewModel) {
        let alert = UIAlertController(
            title: "Этот раунд окончен!",
            message: "Ваш результат \(correctAnswers)/10",
            preferredStyle: .alert)

        let action = UIAlertAction(title: result.buttonText, style: .default) { _ in
            self.currentQuestionIndex = 0
            self.correctAnswers = 0
            
            let firstQuestion = self.questions[self.currentQuestionIndex]
            let viewModel = self.convert(model: firstQuestion)
            self.show(quiz: viewModel)
        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        }
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var textLabel: UILabel!
    @IBOutlet weak private var counterLabel: UILabel!
    
    @IBOutlet weak private var yesButton: UIButton!
    @IBOutlet weak private var noButton: UIButton!
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        setButtonsEnabled(false)
        if questions[currentQuestionIndex].correctAnswer {
            showAnswerResult(isCorrect: true)
        } else {
            showAnswerResult(isCorrect: false)
        }
    }
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        setButtonsEnabled(false)
        if questions[currentQuestionIndex].correctAnswer == false {
            showAnswerResult(isCorrect: true)
        } else {
            showAnswerResult(isCorrect: false)
        }
    }
    
    private func setButtonsEnabled(_ isEnabled: Bool) {
        yesButton.isEnabled = isEnabled
        noButton.isEnabled = isEnabled
    }
}
