//
//  PageViewController.swift
//  weatherForecast
//
//  Created by eva on 17.09.2024.
//

import UIKit

class PageViewController: UIViewController {
    
    // MARK: Data
    
    var viewModel: RootViewModel
    
    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController
    
    // MARK: Lifecycle

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ model: RootViewModel) {
        self.viewModel = model
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let emptyPage = EmptyContentViewController()
        
        if SettingsStore.shared.isAutoLocation() {
            let coords: (Double, Double) = LocationService.shared.getCurrentLocation()
            let page = ContentCurrentViewController(
                lat: coords.0,
                lon: coords.1
            )
            
            pages.append(page)
        }
        
        let savedCities = CoreDataManager.shared.getCities()
        for city in savedCities {
            let page = ContentCurrentViewController(
                lat: city.0,
                lon: city.1
            )
            pages.append(page)
        }

        
        pages.append(emptyPage)
        
        self.currentVC = pages.first!
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .main
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
        
        navigationBarSetup()
    }
    
    // MARK: Private
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
    }
    
    private func navigationBarSetup() {
        leftBarButtonSetup()
        rightBarButtonSetup()
    }
    
    private func leftBarButtonSetup() {
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        menuBtn.setImage(UIImage(named:"barBurger"), for: .normal)
        menuBtn.tintColor = .black
        menuBtn.addTarget(self, action: #selector(showMenuButton), for: UIControl.Event.touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 20)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 20)
        currHeight?.isActive = true
        navigationItem.leftBarButtonItem = menuBarItem
    }
    
    private func rightBarButtonSetup() {
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        menuBtn.setImage(UIImage(named:"barPointPicker"), for: .normal)
        menuBtn.tintColor = .black
        menuBtn.addTarget(self, action: #selector(showMenuButton), for: UIControl.Event.touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 18)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
        currHeight?.isActive = true
        navigationItem.rightBarButtonItem = menuBarItem
    }
    
    // MARK: Action
    
    @objc private func showMenuButton() {
        let nextViewController = SettingsViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc private func gpsPickerButton() {
        
    }
    
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            return getPreviousViewController(from: viewController)
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            return getNextViewController(from: viewController)
        }

        private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
            guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
            self.currentVC = pages[index - 1]
            
            return pages[index - 1]
        }

        private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
            guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
            self.currentVC = pages[index + 1]
            
            return pages[index + 1]
        }

        func presentationCount(for pageViewController: UIPageViewController) -> Int {
            return pages.count
        }

        func presentationIndex(for pageViewController: UIPageViewController) -> Int {
            return pages.firstIndex(of: self.currentVC) ?? 0
        }
}
