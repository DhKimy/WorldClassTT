//
//  RingtoneSelectView.swift
//  TTWorldClass
//
//  Created by 김동현 on 2022/12/27.
//

import UIKit
import AVFoundation

class RingtoneSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        return table
    }()
    
    var models = [Section]()
    private var player: AVAudioPlayer?
    
    let musics = ["clap.wav", "cloudAndClap.wav","gun.wav","madBird.wav", "ScreamingMan.wav", "Train.wav", "Song.wav","siren.wav"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        player?.stop()
    }
    
    func configure() {
        models.append(Section(title: "알람음", options: [
            .staticCell(model: SettingsOption(title: "박수 소리", subtitle: songTitle == title ? "ㅇ" : "" , icon: UIImage(systemName: "music.note"), iconBackgroundColor: .lightGray){
                self.playSound("clap")
                songTitle = "박수 소리"
            }),
            .staticCell(model: SettingsOption(title: "박수와 함성소리", subtitle: "", icon: UIImage(systemName: "music.note"), iconBackgroundColor: .lightGray){
                self.playSound("cloudAndClap")
                songTitle = "박수와 함성소리"
                self.viewDidLoad()
            }),
            .staticCell(model: SettingsOption(title: "총 난사", subtitle: "", icon: UIImage(systemName: "music.note"), iconBackgroundColor: .lightGray){
                self.playSound("gun")
                songTitle = "총 난사"
            }),
            .staticCell(model: SettingsOption(title: "미쳐버린 새", subtitle: "", icon: UIImage(systemName: "music.note"), iconBackgroundColor: .lightGray){
                self.playSound("madBird")
                songTitle = "미쳐버린 새"
            }),
            .staticCell(model: SettingsOption(title: "소리지르는 남자", subtitle: "", icon: UIImage(systemName: "music.note"), iconBackgroundColor: .lightGray){
                self.playSound("ScreamingMan")
                songTitle = "소리지르는 남자"
            }),
            .staticCell(model: SettingsOption(title: "기차", subtitle: "", icon: UIImage(systemName: "music.note"), iconBackgroundColor: .lightGray){
                self.playSound("Train")
                songTitle = "기차"
            }),
            .staticCell(model: SettingsOption(title: "이름모를 노래", subtitle: "", icon: UIImage(systemName: "music.note"), iconBackgroundColor: .lightGray){
                self.playSound("Song")
                songTitle = "이름모를 노래"
            }),
            .staticCell(model: SettingsOption(title: "사이렌", subtitle: "", icon: UIImage(systemName: "music.note"), iconBackgroundColor: .lightGray){
                self.playSound("siren")
                songTitle = "사이렌"
            }),
            
        ]))
    }
    
    func playSound(_ ringName: String) {
        player?.stop()
        let soundName = ringName
        // forResource: 파일 이름(확장자 제외) , withExtension: 확장자(mp3, wav 등) 입력
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            player?.numberOfLoops = 0
            player?.play()
        } catch let error {
            print(error.localizedDescription)
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
            cell.configure(with: model.self)
            if model.title == songTitle {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
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
