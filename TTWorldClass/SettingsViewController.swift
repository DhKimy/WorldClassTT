//
//  SettingsViewController.swift
//  TTWorldClass
//
//  Created by 김동현 on 2022/12/19.
//

import UIKit



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
    var subtitle: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SongSendProtocol {
    
    var songTitle: String = UserDefaults.standard.string(forKey: "songTitle") ?? "총 난사"
    
    func dataSend(data: String) {
        
    }
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        return table
    }()
    
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Settingconfigure()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    public func backToSettingView() {
        self.viewDidLoad()
    }
    
    func Settingconfigure() {
        models.append(Section(title: "알람 설정", options: [
            .switchCell(model: SettingsSwitchOption(title: "100분 제한", icon: UIImage(systemName: "lock"), iconBackgroundColor: .systemRed, handler: {
                
            }, isOn: UserDefaults.standard.bool(forKey: "timerLimitActivate") )),
            .staticCell(model: SettingsOption(title: "알람음", subtitle: songTitle, icon: UIImage(systemName: "music.note"), iconBackgroundColor: .lightGray){
                self.ringtoneAction()
                
            }),
            
        ]))
    }
    
    func ringtoneAction() {
        if self.storyboard?.instantiateViewController(identifier: "RingtoneSelector") is RingtoneSelectViewController {
            performSegue(withIdentifier: "RingtoneSelector", sender: nil)
        }
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
            if model.title == "알람음" {
                songSelectIndex = indexPath
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
    
    var songSelectIndex: IndexPath?
}
