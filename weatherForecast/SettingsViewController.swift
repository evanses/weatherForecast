//
//  SettingsViewController.swift
//  weatherForecast
//
//  Created by eva on 19.09.2024.
//
import UIKit

class SettingsViewController: UIViewController {
    
    var settingsTempMetricMode: Bool
    var settingsWindMetricMode: Bool
    
    // MARK: Subviews
    
    private lazy var centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .tableCell
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.layer.cornerRadius = 6
        view.clipsToBounds = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Настройки"
        
        return label
    }()

    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Температура"
        
        return label
    }()
    
    private lazy var tempCLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "C"
        
        return label
    }()

    private lazy var tempFLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "F"
        
        return label
    }()
    
    private lazy var tempLeftView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightRoze
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tempRightView: UIView = {
        let view = UIView()
        view.backgroundColor = .main
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tempStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        
        stackView.layer.cornerRadius = 6
        
        stackView.layer.masksToBounds = true
        
        stackView.axis = .horizontal
        
        stackView.addArrangedSubview(tempLeftView)
        tempLeftView.addSubview(tempCLabel)
        stackView.addArrangedSubview(tempRightView)
        tempRightView.addSubview(tempFLabel)
        
        stackView.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(toogleTempMode)
        )
        tap.numberOfTapsRequired = 1
        stackView.addGestureRecognizer(tap)
        
        return stackView
    }()
    
    
    private lazy var windMLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Mi"
        
        return label
    }()

    private lazy var windKLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Km"
        
        return label
    }()
    
    private lazy var windLeftView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightRoze
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var windRightView: UIView = {
        let view = UIView()
        view.backgroundColor = .main
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var windStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        
        stackView.layer.cornerRadius = 6
        
        stackView.layer.masksToBounds = true
        
        stackView.axis = .horizontal
        
        stackView.addArrangedSubview(windLeftView)
        windLeftView.addSubview(windMLabel)
        stackView.addArrangedSubview(windRightView)
        windRightView.addSubview(windKLabel)
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(toogleWindMode)
        )
        tap.numberOfTapsRequired = 1
        stackView.addGestureRecognizer(tap)
        
        return stackView
    }()

    private lazy var windLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Скорость ветра"
        
        return label
    }()
    
    private lazy var setButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.clipsToBounds = false
        button.setTitle("Установить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)

        button.backgroundColor = .orangeButton
        return button
    }()

    // MARK: Lifecycle
    
    init() {
        self.settingsTempMetricMode = SettingsStore.shared.getTempMetricMode()
        self.settingsWindMetricMode = SettingsStore.shared.getWindMetricMode()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .main
        
        addSubviews()
        setupConstraints()
        setupView()
        setupActions()
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: Private
    
    private func setupActions() {
        setButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
    }
    
    private func setupView() {
        if settingsTempMetricMode {
            tempCLabel.textColor = .black
            tempLeftView.backgroundColor = .lightRoze
            
            tempFLabel.textColor = .white
            tempRightView.backgroundColor = .main
        } else {
            tempCLabel.textColor = .white
            tempLeftView.backgroundColor = .main
            
            tempFLabel.textColor = .black
            tempRightView.backgroundColor = .lightRoze
        }
        
        if settingsWindMetricMode {
            windKLabel.textColor = .black
            windRightView.backgroundColor = .lightRoze
            
            windMLabel.textColor = .white
            windLeftView.backgroundColor = .main
        } else {
            windKLabel.textColor = .white
            windRightView.backgroundColor = .main
            
            windMLabel.textColor = .black
            windLeftView.backgroundColor = .lightRoze
        }
    }
    
    private func addSubviews() {
        view.addSubview(centerView)
        centerView.addSubview(titleLabel)
        centerView.addSubview(tempLabel)
        
        centerView.addSubview(tempStackView)
        
        centerView.addSubview(windLabel)
        centerView.addSubview(windStackView)

        centerView.addSubview(setButton)
    }

    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate( [
            centerView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            centerView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor),
            centerView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
            centerView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16.0),
            centerView.heightAnchor.constraint(equalToConstant: view.bounds.height / 3),
            
            titleLabel.topAnchor.constraint(equalTo: centerView.topAnchor, constant: 16.0),
            titleLabel.leadingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: 16.0),
            
            // Температура
            tempLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20.0),
            tempLabel.leadingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: 16.0),
            
            tempStackView.trailingAnchor.constraint(equalTo: centerView.trailingAnchor, constant: -25.0),
            tempStackView.centerYAnchor.constraint(equalTo: tempLabel.centerYAnchor),
            tempStackView.widthAnchor.constraint(equalToConstant: 80.0),
            tempStackView.heightAnchor.constraint(equalToConstant: 35.0),
            
            tempLeftView.leadingAnchor.constraint(equalTo: tempStackView.leadingAnchor),
            tempLeftView.trailingAnchor.constraint(equalTo: tempStackView.centerXAnchor),
            tempLeftView.heightAnchor.constraint(equalTo: tempStackView.heightAnchor),
            
            tempCLabel.centerXAnchor.constraint(equalTo: tempLeftView.centerXAnchor),
            tempCLabel.centerYAnchor.constraint(equalTo: tempLeftView.centerYAnchor),
            
            tempRightView.leadingAnchor.constraint(equalTo: tempStackView.centerXAnchor),
            tempRightView.trailingAnchor.constraint(equalTo: tempStackView.trailingAnchor),
            tempRightView.heightAnchor.constraint(equalTo: tempStackView.heightAnchor),
            
            tempFLabel.centerXAnchor.constraint(equalTo: tempRightView.centerXAnchor),
            tempFLabel.centerYAnchor.constraint(equalTo: tempRightView.centerYAnchor),
            
            // Ветер
            windLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 20.0),
            windLabel.leadingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: 16.0),
            
            windStackView.trailingAnchor.constraint(equalTo: centerView.trailingAnchor, constant: -25.0),
            windStackView.centerYAnchor.constraint(equalTo: windLabel.centerYAnchor),
            windStackView.widthAnchor.constraint(equalToConstant: 80.0),
            windStackView.heightAnchor.constraint(equalToConstant: 35.0),
            
            windLeftView.leadingAnchor.constraint(equalTo: windStackView.leadingAnchor),
            windLeftView.trailingAnchor.constraint(equalTo: windStackView.centerXAnchor),
            windLeftView.heightAnchor.constraint(equalTo: windStackView.heightAnchor),
            
            windMLabel.centerXAnchor.constraint(equalTo: windLeftView.centerXAnchor),
            windMLabel.centerYAnchor.constraint(equalTo: windLeftView.centerYAnchor),
            
            tempRightView.leadingAnchor.constraint(equalTo: windStackView.centerXAnchor),
            tempRightView.trailingAnchor.constraint(equalTo: windStackView.trailingAnchor),
            tempRightView.heightAnchor.constraint(equalTo: windStackView.heightAnchor),
            
            windKLabel.centerXAnchor.constraint(equalTo: windRightView.centerXAnchor),
            windKLabel.centerYAnchor.constraint(equalTo: windRightView.centerYAnchor),
            
            
            setButton.bottomAnchor.constraint(equalTo: centerView.bottomAnchor, constant: -16.0),
            setButton.centerXAnchor.constraint(equalTo: centerView.centerXAnchor),
            setButton.heightAnchor.constraint(equalToConstant: 40.0),
            setButton.trailingAnchor.constraint(equalTo: centerView.trailingAnchor, constant: -25.0),
            setButton.leadingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: 25.0)
        ])
    }
    
    // MARK: Actions
    
    @objc private func toogleTempMode() {
        settingsTempMetricMode.toggle()
        setupView()
    }
    
    @objc private func toogleWindMode() {
        settingsWindMetricMode.toggle()
        setupView()
    }
    
    @objc private func saveButtonPressed() {
        SettingsStore.shared.setTempMetricMode(value: settingsTempMetricMode)
        SettingsStore.shared.setWindMetricMode(value: settingsWindMetricMode)
        
        self.navigationController?.popViewController(animated: true)
    }

}
