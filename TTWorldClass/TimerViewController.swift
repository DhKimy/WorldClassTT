//
//  TimerViewController.swift
//  TTWorldClass
//
//  Created by 김동현 on 2022/10/09.
//

import UIKit

class TimerViewController: UIViewController {
    
    
    @IBOutlet weak var lblTaskName: UILabel!
    @IBOutlet weak var lblRemainTaskCount: UILabel!
    
    @IBOutlet weak var lblRemainEntireTime: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var setChapter = 0
    var timer = Timer()
    var isTimerStarted = false
    var timerTime = 0
    var timerTaskName = ""
    var remainTaskCount = 0
    var remainEntireTimersTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerTime = itemsTime[setChapter] * 60
        timerTaskName = items[setChapter]
        remainTaskCount = items.count - setChapter
        remainEntireTimersTime = sum(numbers: itemsTime) * 60
        
        lblTaskName.text = timerTaskName
        lblRemainTaskCount.text = String(remainTaskCount) + "개"
        lblRemainEntireTime.text = formatTimeForEntireTime()
        lblTime.text = formatTime()
        
        // Do any additional setup after loading the view.
    }
    
    func sum(numbers: [Int]) -> Int {
        return numbers.reduce(0, +)
    }
    
    @IBAction func btnPlayTapped(_ sender: Any) {
        resetButton.isEnabled = true
        resetButton.alpha = 1.0
        
        if !isTimerStarted{
            startTimer()
            isTimerStarted = true
            startButton.setTitle("일시정지", for: .normal)
            startButton.setTitleColor(UIColor.orange, for: .normal)
            
        }else{
            timer.invalidate()
            isTimerStarted = false
            startButton.setTitle("계속하기", for: .normal)
            startButton.setTitleColor(UIColor.green, for: .normal)
            
        }
               
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        timerTime -= 1
        lblTime.text = formatTime()
        if timerTime == 0 {
            timer.invalidate()
            setChapter += 1
        }
    }
    
    func formatTimeForEntireTime() -> String {
        let hour = Int(remainEntireTimersTime / 3600)
        let minutes = Int(remainEntireTimersTime) / 60 % 60
        let seconds = Int(remainEntireTimersTime) % 60
        return String(format: "%02i:%02i:%02i", hour, minutes, seconds)
        
    }
    
    func formatTime() -> String{
        let hour = Int(timerTime / 3600)
        let minutes = Int(timerTime) / 60 % 60
        let seconds = Int(timerTime) % 60
        return String(format: "%02i:%02i:%02i", hour, minutes, seconds)
        
    }

    @IBAction func btnReset(_ sender: Any) {
        resetButton.isEnabled = false
        resetButton.alpha = 0.5
        timer.invalidate()
        timerTime = itemsTime[setChapter] * 60
        isTimerStarted = false
        lblTime.text = formatTime()
        startButton.setTitle("시작", for: .normal)
        startButton.setTitleColor(UIColor.blue, for: .normal)
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
