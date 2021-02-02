//
//  DayCell.swift
//  WeatherApp
//
//  Created by NG on 25.01.2021.
//

import UIKit

class DayCell: UITableViewCell {
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 25)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 24)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 25)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var foreCastData: ForecastCellViewModel? {
        didSet {
            foreCastData?.temperature.observe {
                [unowned self] in
                self.temperatureLabel.text = $0
            }
            foreCastData?.time.observe {
                [unowned self] in
                self.timeLabel.text = $0
            }
            foreCastData?.dateTime.observe {
                [unowned self] in
                self.dateLabel.text = $0
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: ForecastCellViewModel) {
        self.foreCastData = viewModel
    }
    
    private func setLayers() {
        
        let leftStackView = UIStackView(arrangedSubviews: [timeLabel, dateLabel])
        leftStackView.axis = .vertical
        leftStackView.spacing = 4
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let rightStackVeiw = UIStackView(arrangedSubviews: [temperatureLabel])
        rightStackVeiw.axis = .horizontal
        rightStackVeiw.translatesAutoresizingMaskIntoConstraints = false
        addSubview(leftStackView)
        addSubview(rightStackVeiw)
        
        NSLayoutConstraint.activate([
            leftStackView.topAnchor.constraint(equalTo: self.topAnchor),
            leftStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            leftStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            rightStackVeiw.topAnchor.constraint(equalTo: self.topAnchor),
            rightStackVeiw.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            rightStackVeiw.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        
    }
}
