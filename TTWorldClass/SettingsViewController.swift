//
//  SettingsViewController.swift
//  TTWorldClass
//
//  Created by 김동현 on 2022/12/19.
//

import UIKit

var songTitle: String = "gun.wav"

struct Section {
    let title: String
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}

struct SettingsSwitchOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
    var isOn: Bool
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        return table
    }()
    
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    func configure() {
        models.append(Section(title: "알람 설정", options: [
            .switchCell(model: SettingsSwitchOption(title: "100분 제한", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemRed, handler: {
                print("100분 제한 클릭")
            }, isOn: true)),
            .staticCell(model: SettingsOption(title: "알람음", icon: UIImage(systemName: "sound"), iconBackgroundColor: .systemBlue){
                
            }),
            
        ]))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = models[section]
        return model.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingTableViewCell.identifier,
                for: indexPath
            ) as? SettingTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.identifier,
                for: indexPath
            ) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        
        switch type.self {
        case .staticCell(let model):
            model.handler()
        case .switchCell(let model):
            model.handler()
        }
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

//extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
//
//        if #available(iOS 14.0, *) {
//            var content = cell.defaultContentConfiguration()
//            content.text = settingItems[(indexPath as NSIndexPath).row]
//            cell.contentConfiguration = content
//        } else {
//            cell.textLabel?.text = settingItems[(indexPath as NSIndexPath).row]
//        }
//
//
//        if (indexPath as NSIndexPath).row == 0 {
//            let switchView = UISwitch(frame: .zero)
//            switchView.setOn(timerLimitActivate, animated: true)
//            switchView.tag = indexPath.row
//            switchView.addTarget(self, action: #selector(self.switchDidChange(_:)), for: .valueChanged)
//            cell.accessoryView = switchView
//            cell.selectionStyle = .none
//            return cell
//        }
//
//        return cell
//    }
//
//    @objc func switchDidChange(_ sender: UISwitch) {
//        timerLimitActivate = !timerLimitActivate
//    }
//
//}
//
//class ringtoneSettingCell: UITableViewCell {
//
//
//
//}
