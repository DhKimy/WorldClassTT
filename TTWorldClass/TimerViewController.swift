import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    
    
    
    @IBOutlet weak var timeButton: UIButton!
    
    
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
            timerLabel.text = "\(hours):\(minutes):\(seconds)"
        }
    }
    
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
            timerLabel.text = "\(hours):\(minutes):\(seconds)"
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
            timerLabel.text = "\(hours):\(minutes):\(seconds)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    
    @objc func appMovedToBackground() {
        print("App moved to background!")
        if isTimerOnForStackSecond {
            timeWhenGoBackgroundForStackSecond = Date()
            print("Save")
        }
    }
    
    @objc func appMovedToForeground() {
        print("App moved to foreground")
        if let backTime = timeWhenGoBackgroundForStackSecond {
            let elapsed = Date().timeIntervalSince(backTime)
            let duration = Int(elapsed)
            timeStackSecond += duration
            timeEntireSecond -= duration
            timeCurrentSecond -= duration
            timeWhenGoBackgroundForStackSecond = nil
            print("DURATION: \(duration)")
        }
    }
    
    @IBAction func timeBtnClicked(_ sender: Any) {
        if isTimerOnForStackSecond {
            stackTimer?.invalidate()
            currentTimer?.invalidate()
            entireTimer?.invalidate()
            timeButton.setTitle("START", for: .normal)
        } else {
            self.stackTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { stackTimer in
                self.timeStackSecond += 1
                print("\(self.timeStackSecond)")
                
            }
            RunLoop.current.add(self.stackTimer!, forMode: .common)
            self.entireTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {entireTimer in
                self.timeEntireSecond -= 1
                print("\(self.timeEntireSecond)")
            }
            RunLoop.current.add(self.entireTimer!, forMode: .common)
            self.currentTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {currentTimer in
                self.timeCurrentSecond -= 1
                print("\(self.timeCurrentSecond)")
            }
            RunLoop.current.add(self.currentTimer!, forMode: .common)
            
            timeButton.setTitle("STOP", for: .normal)
        }
        isTimerOnForStackSecond = !isTimerOnForStackSecond
    }
}
