//
//  TimerViewController.swift
//  TTWorldClass
//
//  Created by 김동현 on 2022/10/09.
//

import UIKit

class TimerViewController: UIViewController {
    
    // 본 화면 구성에서 바뀌는 변수 라벨
    @IBOutlet weak var lblTaskName: UILabel!
    @IBOutlet weak var lblRemainTaskCount: UILabel!
    @IBOutlet weak var lblRemainEntireTime: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    // 버튼 클릭 시 바뀌는 효과를 위한 아웃렛 처리
    
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
        
    var timer = Timer()
    var entireTimer = Timer()
    var isTimerStarted = false
    
    var setChapter = 0
    
    var timerTaskName = ""
    var remainTaskCount = 0
    
    var remainEntireTimersTime = 0
    var timerTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerTime = itemsTime[setChapter] * 60
        timerTaskName = items[setChapter]
        remainTaskCount = items.count - (setChapter + 1)
        remainEntireTimersTime = (sum(numbers: itemsTime) - sum(numbers: Array(itemsTime.prefix(setChapter)) )) * 60
        
        lblTaskName.text = timerTaskName
        lblRemainTaskCount.text = String(remainTaskCount) + "개"
        lblRemainEntireTime.text = formatTimeForEntireTime()
        lblTime.text = formatTime()
        
        if setChapter == 0{
            previousButton.isEnabled = false
            previousButton.alpha = 0.5
            nextButton.isEnabled = true
            nextButton.alpha = 1.0
        }else if setChapter > 0 && setChapter < (items.count - 1) {
            previousButton.isEnabled = true
            previousButton.alpha = 1.0
            nextButton.isEnabled = true
            nextButton.alpha = 1.0
        } else {
            previousButton.isEnabled = true
            previousButton.alpha = 1.0
            nextButton.isEnabled = false
            nextButton.alpha = 0.5
        }
        
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
            entireTimer.invalidate()
            isTimerStarted = false
            startButton.setTitle("계속하기", for: .normal)
            startButton.setTitleColor(UIColor.green, for: .normal)
            
        }
               
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        entireTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimerForEntireTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        timerTime -= 1
        lblTime.text = formatTime()
        if timerTime == 0 {
            timer.invalidate()
            entireTimer.invalidate()
            print("소리 나야 됨")
            setChapter += 1
            startButton.setTitle("다음 할 일로", for: .normal)
            viewDidLoad()
            
        }
    }
    
    @objc func updateTimerForEntireTimer(){
        remainEntireTimersTime -= 1
        lblRemainEntireTime.text = formatTimeForEntireTime()
        if remainEntireTimersTime == 0 {
            entireTimer.invalidate()
            startButton.isHidden = true
            resetButton.isHidden = true
            print("완료!")
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
        entireTimer.invalidate()
        remainEntireTimersTime = sum(numbers: itemsTime) * 60
        setChapter = 0
        timerTaskName = items[0]
        remainTaskCount = 0
        isTimerStarted = false
        startButton.setTitle("시작", for: .normal)
        startButton.setTitleColor(UIColor.blue, for: .normal)
        viewDidLoad()
    }

    @IBAction func btnPreviousWork(_ sender: Any) {
        setChapter -= 1
        timer.invalidate()
        entireTimer.invalidate()
        startButton.setTitle("시작", for: .normal)
        startButton.setTitleColor(UIColor.blue, for: .normal)
        viewDidLoad()
    }
    
    @IBAction func btnNextWork(_ sender: Any) {
        setChapter += 1
        timer.invalidate()
        entireTimer.invalidate()
        startButton.setTitle("시작", for: .normal)
        startButton.setTitleColor(UIColor.blue, for: .normal)
        viewDidLoad()
        
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
