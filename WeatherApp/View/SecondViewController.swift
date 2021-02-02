//
//  SecondViewController.swift
//  WeatherApp
//
//  Created by NG on 25.01.2021.
//
 
import UIKit

class SecondViewController: UIViewController, UITableViewDataSource {
    
    var daysTableViewDelegate = DaysTableViewDelegate()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 30)
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 60)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let huminity: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 18)
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 18)
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let daysTableView = UITableView()
    let forcastCell = DayCell()
    
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
            viewModel?.huminity.observe {
                [unowned self] in
                self.huminity.text = $0
            }
            viewModel?.feelsLike.observe {
                [unowned self] in
                self.feelsLikeLabel.text = $0
            }
            viewModel?.forecasts.observe {
                [unowned self] (forecasts) in
                self.foreCastData = forecasts
                
            }
        }
    }
    
    var foreCastData: [ForecastCellViewModel] = [] {
        didSet {
            daysTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel = WeatherViewModel()
        viewModel?.startLocationService()
        
        setLayers()
        setTableView()
    }
    
    private func setTableView() {
        
        daysTableView.tableFooterView = UIView()
        daysTableView.estimatedRowHeight = UITableView.automaticDimension
        daysTableView.reloadData()
        daysTableView.delegate = daysTableViewDelegate
        daysTableView.dataSource = self
       
    }
    
    private func setLayers() {
        
        let weatherTypeStackView = UIStackView(arrangedSubviews: [huminity, feelsLikeLabel])
        weatherTypeStackView.axis = .vertical
        weatherTypeStackView.alignment = .center
        weatherTypeStackView.spacing = 4
        weatherTypeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let mainStackView = UIStackView(arrangedSubviews: [cityLabel,temperatureLabel, weatherTypeStackView])
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainStackView)
        view.addSubview(daysTableView)
        daysTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 88)
        ])
        
        NSLayoutConstraint.activate([
            daysTableView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 16),
            daysTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            daysTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            daysTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

// MARK: UITableViewDataSource

extension SecondViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foreCastData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithRegistration(type: DayCell.self, indexPath: indexPath)
        cell.configure(viewModel: foreCastData[indexPath.row])
        return cell
    }
}
