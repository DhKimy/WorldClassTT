//
//  TimerViewController.swift
//  TTWorldClass
//
//  Created by 김동현 on 2022/10/09.
//

import UIKit

class TimerViewController: UIViewController {
    
    
    @IBOutlet weak var lblTime: UILabel!
    
    var timer = Timer()
    var isTimerStarted = false
    var time = 1500
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPlayTapped(_ sender: Any) {
        if !isTimerStarted{
            startTimer()
            isTimerStarted = true
            
        }else{
            timer.invalidate()
            isTimerStarted = false
            
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
        timer.invalidate()
        time = 1500
        isTimerStarted = false
        lblTime.text = "00:25:00"
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
