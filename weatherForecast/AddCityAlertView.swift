//
//  AddCityAlertView.swift
//  weatherForecast
//
//  Created by eva on 23.09.2024.
//
import UIKit

final class AddCityAlertView {
    static let picker = AddCityAlertView()
    
    func show(in viewController: UIViewController, completion: @escaping ((_ text: String) -> Void)) {
        let alert = UIAlertController(
            title: "Введите город",
            message: nil,
            preferredStyle: .alert
        )
        alert.addTextField { textField in
            textField.placeholder = "Москва"
        }
        
        let addButton = UIAlertAction(title: "Добавить", style: .default) { _ in
            if let text = alert.textFields?[0].text {
                completion(text)
            }
        }
        
        let cancelButton = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(addButton)
        alert.addAction(cancelButton)
        
        viewController.present(alert, animated: true)
    }
}
