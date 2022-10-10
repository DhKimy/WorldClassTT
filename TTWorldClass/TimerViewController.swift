//
//  TimerViewController.swift
//  TTWorldClass
//
//  Created by 김동현 on 2022/10/09.
//

import UIKit

class TimerViewController: UIViewController {
    
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var timer = Timer()
    var isTimerStarted = false
    var time = 1500
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        time -= 1
        lblTime.text = formatTime()
    }
    
    func formatTime() -> String{
        let hour = Int(time / 3600)
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hour, minutes, seconds)
        
    }

    @IBAction func btnReset(_ sender: Any) {
        resetButton.isEnabled = false
        resetButton.alpha = 0.5
        timer.invalidate()
        time = 1500
        isTimerStarted = false
        lblTime.text = "00:25:00"
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
