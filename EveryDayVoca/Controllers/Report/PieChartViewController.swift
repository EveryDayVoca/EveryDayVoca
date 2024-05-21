//
//  PieChartViewController.swift
//  EveryDayVoca
//
//  Created by 문기웅 on 5/21/24.
//
//
import UIKit
import Charts
import DGCharts

final class PieChartViewController: BaseViewController {
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }


}
