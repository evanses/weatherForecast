//
//  EverydayForecastViewController.swift
//  weatherForecast
//
//  Created by eva on 19.09.2024.
//

import UIKit

class MoreForecastViewController: UIViewController {
    
    // MARK: Data
    
    var model: CityModelForecastByDay
    
    private enum ReuseID: String {
        case day = "DayForecaseCell_ReuseID"
        case night = "NightForecaseCell_ReuseID"
        case sun = "SunForecaseCell_ReuseID"
    }

    // MARK: Subviews
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .plain
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        
        return tableView
    }()

    
    // MARK: Lifecycle
    
    init(model: CityModelForecastByDay, cityTitle: String) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = cityTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addSubviews()
        setupConstraints()
        
        tuneTableView()
    }
    
    // MARK: Private
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate( [
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16.0),
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
        ])
    }
    
    private func tuneTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
         
        tableView.tableHeaderView = UIView(frame: .zero)
        tableView.tableFooterView = UIView(frame: .zero)
        
        tableView.register(
            MoreDayTempTableCell.self,
            forCellReuseIdentifier: ReuseID.day.rawValue
        )
        
        tableView.register(
            MoreDayTempTableCell.self,
            forCellReuseIdentifier: ReuseID.night.rawValue
        )
        
        tableView.register(
            MoreDaySunTableView.self,
            forCellReuseIdentifier: ReuseID.sun.rawValue
        )
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
    }
}

// MARK: UITableViewDataSource

extension MoreForecastViewController: UITableViewDataSource {
    
    // Не разобрался как сделать отступы между ячейка. Зато придумал как это сделать через секции и вью как футер каждой :)
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ReuseID.day.rawValue,
                for: indexPath
            ) as? MoreDayTempTableCell else {
                fatalError("could not dequeueReusableCell")
            }
            
            cell.setupView(mode: .day, model: model)
            
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ReuseID.night.rawValue,
                for: indexPath
            ) as? MoreDayTempTableCell else {
                fatalError("could not dequeueReusableCell")
            }
            
            cell.setupView(mode: .night, model: model)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ReuseID.sun.rawValue,
                for: indexPath
            ) as? MoreDaySunTableView else {
                fatalError("could not dequeueReusableCell")
            }
            
            cell.setup(with: model.astro)
            
            return cell
        }
    }
}

// MARK: UITableViewDelegate

extension MoreForecastViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        UITableView.automaticDimension
    }
}
