//
//  ResultsViewController.swift
//  PersonalQuiz
//
//  Created by Alexey Efimov on 31.08.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var animalLabel: UILabel!
    @IBOutlet weak var animalDescriptionLabel: UILabel!
    
    var chosenAnswers: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        let animal = defineAnimal(in: chosenAnswers)
        
        animalLabel.text = "Вы - \(animal.rawValue)"
        animalDescriptionLabel.text = animal.definition
    }
    
    private func defineAnimal(in answers: [Answer]) -> AnimalType {
        var answersSortedByAnimals = [AnimalType: Int]()
        
        let groupedAnswers = answers.reduce([AnimalType: [Answer]]()) { (result, answer) -> [AnimalType: [Answer]] in
            var result = result
            result[answer.type] = (result[answer.type] ?? []) + [answer]
            return result
        }
        
        for (animalType, answers) in groupedAnswers {
            answersSortedByAnimals.updateValue(answers.count, forKey: animalType)
        }
        
        let arraySortedByAnimals = answersSortedByAnimals.sorted(by: {$0.value > $1.value})
        let animal = arraySortedByAnimals.first!.key
      
        return animal
    }
}
