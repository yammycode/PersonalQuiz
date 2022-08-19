//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by brubru on 18.08.2022.
//

import UIKit

final class ResultViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet var animalLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    // MARK: - Public Properties
    // 1. Передать массив с ответами на экран с результатами
    var answerChosen: [Answer] = []

    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // 4. Избавиться от кнопки возврата назад на экране результатов
        navigationItem.setHidesBackButton(true, animated: false)

        // 2. Определить наиболее часто встречающийся тип животного
        let resultAnimalType = getChoicesCountByAnimals().max { $0.value < $1.value }?.key

        // 3. Отобразить результаты в соотвствии с этим животным
        if let resultAnimalType = resultAnimalType {
            animalLabel.text = String(resultAnimalType.rawValue)
            descriptionLabel.text = resultAnimalType.definition
        } else {
            animalLabel.text = "Что-то не так..."
            descriptionLabel.text = "Все животные разбежались... Sorry..."
        }
    }
 
    // MARK: - IBAction
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    // MARK: - Private Methods
    /// Return dictionary, key - AnimalType, value - count of choices this animal type]
    private func getChoicesCountByAnimals() -> [AnimalType: Int] {
        var animalChoiceCount: [AnimalType: Int] = [:]

        answerChosen.forEach {
            let currentCount = animalChoiceCount[$0.type] ?? 0
            animalChoiceCount[$0.type] = currentCount + 1
        }

        return animalChoiceCount
    }

}
