//
//  DeleteCityTableCell.swift
//  weatherForecast
//
//  Created by eva on 26.09.2024.
//

import UIKit

class DeleteCityTableCell : UITableViewCell {
    
    //MARK: - Subviews
    
    /// кнопка
    lazy var mainTextButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.backgroundColor = .deleteCell
        
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Удалить город", for: .normal)
        
        button.layer.cornerRadius = 10
        button.clipsToBounds = false
        
        button.isEnabled = false
    
        return button
    }()
    
    // MARK: - Lifecycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: .default,
            reuseIdentifier: reuseIdentifier
        )
        
        setupView()
        setupSubviews()
        setupLayouts()
    }
    
    // MARK: - Private
    
    private func setupView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .clear
        
    }
    
    private func setupSubviews() {
        contentView.addSubview(mainTextButton)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            mainTextButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainTextButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainTextButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainTextButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainTextButton.heightAnchor.constraint(equalToConstant: 50),
            
            contentView.bottomAnchor.constraint(equalTo: mainTextButton.bottomAnchor)
        ])
    }
}
