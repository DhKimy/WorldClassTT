import UIKit
import AVFoundation

class TimerViewController: UIViewController {
    
    @IBOutlet weak var stackTimerLabel: UILabel!
    @IBOutlet weak var entireTimerLabel: UILabel!
    @IBOutlet weak var currentTimerLabel: UILabel!
    
    @IBOutlet weak var timeButton: UIButton!
    
    /*
    // 실제로 지나간 시간 표시에 필요한 필드
    var stackTimer: Timer? = nil
    var isTimerOnForStackSecond = false
    var timeWhenGoBackgroundForStackSecond: Date?
    var timeStackSecond = 0 {
        willSet(newValue) {
            var hours = String(newValue / 3600)
            var minutes = String(newValue / 60)
            var seconds = String(newValue % 60)
            if hours.count == 1 { hours = "0"+hours }
            if minutes.count == 1 { minutes = "0"+minutes }
            if seconds.count == 1 { seconds = "0"+seconds }
            stackTimerLabel.text = "\(hours):\(minutes):\(seconds)"
        }
    }
     */
    
    // 전체 남은 시간 표시에 필요한 빌드
    var entireTimer: Timer? = nil
    var isTimerOnForEntire = false
    var timeWhenGoBackgroundForEntire: Date?
    var timeEntireSecond = 60 {
        willSet(newValue) {
            var hours = String(newValue / 3600)
            var minutes = String(newValue / 60)
            var seconds = String(newValue % 60)
            if hours.count == 1 { hours = "0"+hours }
            if minutes.count == 1 { minutes = "0"+minutes }
            if seconds.count == 1 { seconds = "0"+seconds }
            entireTimerLabel.text = "\(hours):\(minutes):\(seconds)"
        }
    }
    
    // 이번 할 일 남은 시간 표시에 필요한 빌드
    var currentTimer: Timer? = nil
    var isTimerOnForCurrent = false
    var timeWhenGoBackgroundForCurrentSecond: Date?
    var timeCurrentSecond = 60 {
        willSet(newValue) {
            var hours = String(newValue / 3600)
            var minutes = String(newValue / 60)
            var seconds = String(newValue % 60)
            if hours.count == 1 { hours = "0"+hours }
            if minutes.count == 1 { minutes = "0"+minutes }
            if seconds.count == 1 { seconds = "0"+seconds }
            currentTimerLabel.text = "\(hours):\(minutes):\(seconds)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
//    // 전체 남은 시간용 appMovedToBackground() 메서드
//    @objc func appMovedToBackground() {
//        print("App moved to background!")
//        if isTimerOnForStackSecond {
//            timeWhenGoBackgroundForStackSecond = Date()
//            print("Save")
//        }
//    }
    
//    // 전체 남은 시간용 appMoveToForeground() 메서드
//    @objc func appMovedToForeground() {
//        print("App moved to foreground")
//        if let backTime = timeWhenGoBackgroundForStackSecond {
//            let elapsed = Date().timeIntervalSince(backTime)
//            let duration = Int(elapsed)
//            timeStackSecond += duration
//            timeEntireSecond -= duration
//            timeCurrentSecond -= duration
//            timeWhenGoBackgroundForStackSecond = nil
//            print("DURATION: \(duration)")
//        }
//    }
    
    
    @objc func appMovedToBackground() {
        print("App moved to background!")
        if isTimerOnForEntire {
            timeWhenGoBackgroundForEntire = Date()
            print("Save")
        }
    }
    
    @objc func appMovedToForeground() {
        print("App moved to foreground")
        if let backTime = timeWhenGoBackgroundForEntire {
            let elapsed = Date().timeIntervalSince(backTime)
            let duration = Int(elapsed)
            if timeEntireSecond - duration <= 0 {
                timeEntireSecond = 0
                timeCurrentSecond = 0
                timeWhenGoBackgroundForEntire = nil
                isTimerOnForEntire = !isTimerOnForEntire
            }else {
                timeEntireSecond -= duration
                timeCurrentSecond -= duration
                timeWhenGoBackgroundForEntire = nil
                isTimerOnForEntire = !isTimerOnForEntire
            }
            print("DURATION: \(duration)")
        }
    }
    

    
    @IBAction func timeBtnClicked(_ sender: Any) {
        
        if isTimerOnForEntire {
            currentTimer?.invalidate()
            entireTimer?.invalidate()
            timeButton.setTitle("START", for: .normal)
            
        } else {
            
//            // 전체 흐른 시간용 타이머
//            self.stackTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { stackTimer in
//                self.timeStackSecond += 1
//                print("\(self.timeStackSecond)")
//
//            }
//            RunLoop.current.add(self.stackTimer!, forMode: .common)
            
            self.entireTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {entireTimer in
                self.timeEntireSecond -= 1
                if self.timeEntireSecond == 0 {
                    self.finalEndingAlert()
                    self.timeCurrentSecond -= 1
                    self.currentTimer?.invalidate()
                    self.entireTimer?.invalidate()
                    self.timeButton.setTitle("Start", for: .normal)
                    self.isTimerOnForEntire = !self.isTimerOnForEntire
                    
                }
                print("\(self.timeEntireSecond)")
            }
            
            RunLoop.current.add(self.entireTimer!, forMode: .common)
            
            
            self.currentTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {currentTimer in
                self.timeCurrentSecond -= 1
                if self.timeCurrentSecond == 0 && self.timeEntireSecond != 0
                {
                    self.endingAlert()
                    self.timeEntireSecond -= 1
                    self.currentTimer?.invalidate()
                    self.entireTimer?.invalidate()
                    self.timeButton.setTitle("New Start", for: .normal)
                    self.isTimerOnForEntire = !self.isTimerOnForEntire
                }
                
                print("\(self.timeCurrentSecond)")
            }
            RunLoop.current.add(self.currentTimer!, forMode: .common)
            
            timeButton.setTitle("STOP", for: .normal)
            
        }
            
       
        isTimerOnForCurrent = !isTimerOnForCurrent
        isTimerOnForEntire = !isTimerOnForEntire
    }
    
    
    var player:AVAudioPlayer!
    // 시간 도과 시 울리는 알람에 필요한 메서드
    func playSound(title: String?){
            let url = Bundle.main.url(forResource: "Balynt - Memory", withExtension: "mp3")
            player = try!AVAudioPlayer(contentsOf: url!)
            player!.play()
        }
         
    func stopSound(){
        player?.stop()
    }

    func endingAlert(){
        self.playSound(title: "Alarm_sound")
        let alert = UIAlertController(title : "완료!", message:"축하합니다. 이번 할 일을 모두 끝냈습니다.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "알람 소리 끄기", style: .default) {
            (action) in
            self.stopSound()
        }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
        
        return
    }

    func finalEndingAlert() {
        self.playSound(title: "Alarm_sound")
        let alert = UIAlertController(title : "완료!", message:"축하합니다. 모든 할 일을 모두 끝냈습니다.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "알람 소리 끄기", style: .default) {
            (action) in
            self.stopSound()
        }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
        
        return
        
    }
}
