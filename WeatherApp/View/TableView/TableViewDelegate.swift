//
//  TableViewDelegate.swift
//  WeatherApp
//
//  Created by NG on 22.01.2021.
//

import UIKit

class TableViewDelegate: NSObject, UITableViewDelegate {
    
    weak var delegate: MainViewControllerDelegate?
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.navigateToMore()
    }
}
