//
//  CityCell.swift
//  WeatherApp
//
//  Created by NG on 22.01.2021.
//

import UIKit

class CityCell: UITableViewCell {
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 25)
        label.text = "City"
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 20)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 30)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var viewModel: WeatherViewModel? {
        didSet {
            viewModel?.location.observe {
                [unowned self] in
                self.cityLabel.text = $0
            }
            viewModel?.temperature.observe {
                [unowned self] in
                self.temperatureLabel.text = $0
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayers()
        updateTime()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTime() {
        // Показ времени
        let now = Int(NSDate().timeIntervalSince1970)
        
        let timeToStr = timeFromUnix(unixTime: now)
        self.timeLabel.text = "\(timeToStr)"
    }
    
    func configure(viewModel: WeatherViewModel) {
        updateTime()
        self.viewModel = viewModel
    }
    
    //Получение времени
    func timeFromUnix(unixTime: Int) -> String {
        let timeInSecond = TimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSecond)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: weatherDate as Date)
    }
    
    private func setLayers() {
        addSubview(containerView)
        addSubview(cityLabel)
        addSubview(timeLabel)
        addSubview(temperatureLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            timeLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            
            cityLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            cityLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            cityLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            
            temperatureLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            temperatureLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}
