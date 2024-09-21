//
//  RootViewModel.swift
//  weatherForecast
//
//  Created by eva on 17.09.2024.
//

import UIKit

class RootViewModel {
    init() {
        
    }
    
    func checkFirsRun(navigationController: UINavigationController) {

        if SettingsStore.shared.isFirstRun() {
            let onboardingViewController = OnboardingViewController()
            onboardingViewController.modalPresentationStyle = .fullScreen
            navigationController.present(onboardingViewController, animated: true)
        }
        
    }
}
