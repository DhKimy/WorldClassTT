//
//  SettingsViewController.swift
//  TTWorldClass
//
//  Created by 김동현 on 2022/12/19.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingTableView: UITableView!
    
    var settingItems: [String] = ["100분 제한"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settingTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.settingTableView.delegate = self
        self.settingTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.textColor = .black
        cell.textLabel?.text = settingItems[(indexPath as NSIndexPath).row]
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(timerLimitActivate, animated: true)
        switchView.tag = indexPath.row
        switchView.addTarget(self, action: #selector(self.switchDidChange(_:)), for: .valueChanged)
        cell.accessoryView = switchView
        
        return cell
    }
    
    
    
    
    
    
    @objc func switchDidChange(_ sender: UISwitch) {
        timerLimitActivate = !timerLimitActivate
    }
    
}
