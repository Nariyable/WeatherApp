//
//  ViewController.swift
//  WeatherApp
//
//  Created by NG on 22.01.2021.
//

import UIKit

protocol MainViewControllerDelegate: class {
    // Для перехода на другой экран
    func navigateToMore()
}

class MainViewController: UIViewController, UITableViewDataSource {
    
    let tableView = UITableView()
    
    var viewModel = WeatherViewModel()
   
    var tavleViewDelegate = TableViewDelegate()
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        
        viewModel = WeatherViewModel()
        viewModel.startLocationService()
        
        setTableView()
        tavleViewDelegate.delegate = self
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func setNavigation() {
        navigationItem.title = "Wheather for today"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    @objc func refresh(_ sender: AnyObject) {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = tavleViewDelegate
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainViewController: MainViewControllerDelegate {
    // MARK: Для перехода на другой экран
    func navigateToMore() {
        let viewController = SecondViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

     // MARK: UITableViewDataSource
extension MainViewController {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithRegistration(type: CityCell.self, indexPath: indexPath)
        cell.configure(viewModel: viewModel)
        return cell
    }
}


