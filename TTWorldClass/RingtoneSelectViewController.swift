//
//  RingtoneSelectView.swift
//  TTWorldClass
//
//  Created by 김동현 on 2022/12/27.
//

import UIKit
import AVFoundation

protocol SongSendProtocol {
    func dataSend(data: String)
}

class RingtoneSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        return table
    }()
    
    var models = [Section]()
    private var player: AVAudioPlayer?
    var delegate: SongSendProtocol?
    
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
            if model.title == songTitle {
                cell.accessoryType = .checkmark
                temp = indexPath
            }
            cell.configure(with: model.self)
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
    
    var temp: IndexPath?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        
        switch type.self {
        case .staticCell(let model):
            model.handler()
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.cellForRow(at: temp ?? indexPath)?.accessoryType = .none
            temp = indexPath
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            print("셀이 탭되었습니다.")
        case .switchCell(let model):
            model.handler()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare")
        if segue.destination is SettingsViewController {
            let vc = segue.destination as? SettingsViewController
            vc?.viewDidLoad()
            print("vc?.viewDidLoad() 실행")
        }
    }
    
    
    
//    func timeSetDelegate(dataSent: String) {
//        self.tfAddTime.text = dataSent
//        print("데이터 세팅함. 데이터 : \(dataSent)")
//    }
//
//    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
//        print("prepare 메서드 내부")
//        if segue.identifier == "timeSet" {
//            guard let viewController: DatePickerViewController = segue.destination as? DatePickerViewController else {return}
//            viewController.delegate = self
//        }else if segue.identifier == "emoticonSet" {
//            guard let viewController: EmoticonSelectViewController = segue.destination as? EmoticonSelectViewController else {return}
//            viewController.delegate = self
//        }
//    }

}


