import UIKit
import AVFoundation
import UserNotifications

var isTimerOnForSendOtherController = false
var isTimerOnForEntire = false
var isTimerOnForCurrent = false
var currentTime = 0
var entireTime = 0

class TimerViewController: UIViewController {
    
    @IBOutlet weak var taskNameThisTime: UILabel!
    @IBOutlet weak var remainTaskCount: UILabel!
    
    @IBOutlet weak var entireTimerLabel: UILabel!
    @IBOutlet weak var currentTimerLabel: UILabel!
    
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var player:AVAudioPlayer!
    
    // 하고 있는 일이 몇 번째인지 알려주는 인덱스 변수
    var setChapter = 0
    let center = UNUserNotificationCenter.current()

    // 전체 남은 시간 표시에 필요한 필드
    var entireTimer: Timer? = nil
    var timeWhenGoBackgroundForEntire: Date?
    var timeEntireSecond = entireTime {
        willSet(newValue) {
            var hours = String(newValue / 3600)
            var minutes = String((newValue - Int(hours)! * 3600) / 60)
            var seconds = String((newValue - Int(minutes)! * 60) % 60)
            if hours.count == 1 { hours = "0"+hours }
            if minutes.count == 1 { minutes = "0"+minutes }
            if seconds.count == 1 { seconds = "0"+seconds }
            entireTimerLabel.text = "\(hours):\(minutes):\(seconds)"
        }
    }
    
    // 이번 할 일 남은 시간 표시에 필요한 필드
    var currentTimer: Timer? = nil

    var timeWhenGoBackgroundForCurrentSecond: Date?
    var timeCurrentSecond = currentTime {
        willSet(newValue) {
            var hours = String(newValue / 3600)
            var minutes = String((newValue - Int(hours)! * 3600) / 60)
            var seconds = String((newValue - Int(minutes)! * 60) % 60)
            if hours.count == 1 { hours = "0"+hours }
            if minutes.count == 1 { minutes = "0"+minutes }
            if seconds.count == 1 { seconds = "0"+seconds }
            currentTimerLabel.text = "\(hours):\(minutes):\(seconds)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isTimerOnForEntire && !isTimerOnForCurrent {
            calTimeEntireValue()
            calTimeCurrnetValue()
        }
        prevNextButtonColorSet()
        taskNameThisTime.text = items[setChapter]
        remainTaskCount.text = "\(itemsTime.count - setChapter - 1)개"
        
        self.navigationItem.leftBarButtonItem = backButton
        
        // 백그라운드로 넘어갈 때 타이머 멈춘 후에 실행하기 위해 필요한 변수
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    func calTimeEntireValue() {
        print(timeEntireSecond)
        print(isTimerOnForEntire)
        if setChapter == 0{
            timeEntireSecond = sum(numbers: itemsTime) * 60
            entireTime = timeEntireSecond
        } else {
            timeEntireSecond = (sum(numbers: itemsTime) - sum(numbers:  Array(itemsTime.prefix(setChapter)))) * 60
        }
    }
    
    func calTimeCurrnetValue() {
            timeCurrentSecond = itemsTime[setChapter] * 60
            currentTime = timeCurrentSecond
        
        
    }
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBAction func closeModal(_ sender: Any) {
        let alert = UIAlertController(title:"경고",message: "시작 후 앱의 이전 화면으로 이동하면 알람이 꺼집니다. 그래도 이동하시겠습니까?",preferredStyle: UIAlertController.Style.alert)
        let cancle = UIAlertAction(title: "돌아갈께요", style: .default, handler: nil)
        //확인 버튼 만들기
        let ok = UIAlertAction(title: "나갈래요", style: .destructive, handler: {_ in
            isTimerOnForEntire = false
            isTimerOnForCurrent = false
            self.entireTimer?.invalidate()
            self.currentTimer?.invalidate()
            self.entireTimer = nil
            self.currentTimer = nil
            self.center.removeAllPendingNotificationRequests()
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(cancle)
        //확인 버튼 경고창에 추가하기
        alert.addAction(ok)
        present(alert,animated: true,completion: nil)
        

    }
    
    
    /**
        실제 알람 소리, 푸시 알림을 주는 알람(View와 관련 없음)
     */
    func setReminder(thisTime: Int) {
        let content = UNMutableNotificationContent()
        content.title = "도전 100분"
        content.body = "이번 할 일이 끝났습니다."
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: UserDefaults.standard.string(forKey: "songTitle") ?? "총 난사"))
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(thisTime), repeats: false)
        
        let alarmName = "alarm"
        
        let request = UNNotificationRequest(identifier: alarmName, content: content, trigger: trigger)
        center.add(request) { (error) in
            if error != nil {
                print("에러 발생")
            }
        }
    }
 
    // 전체 남은 시간용 appMovedToBackground() 메서드
    @objc func appMovedToBackground() {
        print("App moved to background!")
        if isTimerOnForEntire {
            self.currentTimer?.invalidate()
            self.entireTimer?.invalidate()
            timeWhenGoBackgroundForEntire = Date()
            timeWhenGoBackgroundForCurrentSecond = Date()
            
            print("Save")
        }
    }

    // 전체 남은 시간용 appMoveToForeground() 메서드
    @objc func appMovedToForeground() {
        print("App moved to foreground")
        
        if let backTime = timeWhenGoBackgroundForEntire {
            let elapsed = Date().timeIntervalSince(backTime)
            let duration = Int(elapsed)
            
            if timeEntireSecond - duration <= 1 {
                setChapter = 0
                
                calTimeEntireValue()
                calTimeCurrnetValue()
                
                timeWhenGoBackgroundForEntire = nil
                timeWhenGoBackgroundForCurrentSecond = nil
                entireTimer = nil
                currentTimer = nil
                
                isTimerOnForEntire = !isTimerOnForEntire
                timeButton.setTitle("START", for: .normal)
                taskNameThisTime.text = items[setChapter]
                remainTaskCount.text = "\(itemsTime.count - setChapter - 1)개"
                
            }else if !(timeEntireSecond - duration <= 1) && timeCurrentSecond - duration <= 1{
                setChapter += 1
                
                calTimeEntireValue()
                calTimeCurrnetValue()
                
                timeWhenGoBackgroundForEntire = nil
                timeWhenGoBackgroundForCurrentSecond = nil
                entireTimer = nil
                currentTimer = nil
            
                isTimerOnForEntire = !isTimerOnForEntire
                timeButton.setTitle("START", for: .normal)
                taskNameThisTime.text = items[setChapter]
                remainTaskCount.text = "\(itemsTime.count - setChapter - 1)개"
                
                // 정지가 안된 상태로 백그라운드로 갔다가 올 때
            } else if isTimerOnForEntire {
                print("정지 안된 상태로 백그라운드로 갔다가 올때")
                timeEntireSecond -= duration
                timeCurrentSecond -= duration
                
                timeWhenGoBackgroundForEntire = nil
                timeWhenGoBackgroundForCurrentSecond = nil
//                calTimeEntireValue()
//                calTimeCurrnetValue()
                self.entireTimer = nil
                self.currentTimer = nil
                
                
                self.entireTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {entireTimer in
                    self.timeEntireSecond -= 1
                    entireTime -= 1
                    
                    if self.timeEntireSecond <= 1 {
                        //                    self.playSound(title: "alarm_sound")
                        //                    self.finalEndingAlert()
                        self.currentTimer?.invalidate()
                        self.entireTimer?.invalidate()
                        //self.center.removeAllPendingNotificationRequests()
                        
                        self.currentTimer = nil
                        self.entireTimer = nil
                        self.setChapter = 0
                        self.calTimeCurrnetValue()
                        self.calTimeEntireValue()
                        self.taskNameThisTime.text = items[self.setChapter]
                        self.remainTaskCount.text = "\(itemsTime.count - self.setChapter - 1)개"
                        self.timeButton.setTitle("START", for: .normal)
                        isTimerOnForEntire = !isTimerOnForEntire
                        
                    }
                    print("\(self.timeEntireSecond)")
                }
                
                
                
                
                self.currentTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {currentTimer in
                    self.timeCurrentSecond -= 1
                    currentTime -= 1
                    
                    if self.timeCurrentSecond <= 0 && self.timeEntireSecond != 0
                    {
                        //                    self.playSound(title: "alarm_sound")
                        //                    self.endingAlert()
                        
                        self.currentTimer?.invalidate()
                        self.entireTimer?.invalidate()
                        self.setChapter += 1
                        self.calTimeCurrnetValue()
                        self.calTimeEntireValue()
                        self.timeButton.setTitle("START", for: .normal)
                        self.taskNameThisTime.text = items[self.setChapter]
                        self.remainTaskCount.text = "\(itemsTime.count - self.setChapter - 1)개"
                        isTimerOnForEntire = !isTimerOnForEntire
                    }
                    print(self.center)
                    print("\(self.timeCurrentSecond)")
                }
                timeButton.setTitle("STOP", for: .normal)
                
                
                if !isTimerOnForEntire {
                    RunLoop.current.add(self.entireTimer!, forMode: .common)
                    RunLoop.current.add(self.currentTimer!, forMode: .common)
                }
            }
            
            
            // 정지된 상태로 백그라운드로 갔다가 올 때
        }
        
    }

    
    @IBAction func timeBtnClicked(_ sender: Any) {
 
        if isTimerOnForEntire {
            resetButton.isEnabled = true
            resetButton.alpha = 1.0
            
            currentTimer?.invalidate()
            entireTimer?.invalidate()
            center.removeAllPendingNotificationRequests()
            
            timeButton.setTitle("START", for: .normal)
            
        } else {
            // 백, 포그라운드로 왔을 때 문제 되는 부분.
            
            isTimerOnForSendOtherController = true
            resetButton.isEnabled = true
            resetButton.alpha = 1.0
            self.setReminder(thisTime: timeCurrentSecond)
            
            print(self.center)
            self.entireTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {entireTimer in
                self.timeEntireSecond -= 1
                entireTime -= 1
                
                if self.timeEntireSecond <= 1 {
                    self.currentTimer?.invalidate()
                    self.entireTimer?.invalidate()
                    self.currentTimer = nil
                    self.entireTimer = nil
                    self.setChapter = 0
                    self.calTimeCurrnetValue()
                    self.calTimeEntireValue()
                    self.taskNameThisTime.text = items[self.setChapter]
                    self.remainTaskCount.text = "\(itemsTime.count - self.setChapter - 1)개"
                    self.timeButton.setTitle("START", for: .normal)
                    isTimerOnForEntire = !isTimerOnForEntire
                    
                }
                print("전체시간 : \(self.timeEntireSecond)")
            }
            
            self.currentTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {currentTimer in
                self.timeCurrentSecond -= 1
                currentTime -= 1
                
                if self.timeCurrentSecond <= 1 && self.timeEntireSecond != 0 {
                    
                    self.currentTimer?.invalidate()
                    self.entireTimer?.invalidate()
                    
                    self.setChapter += 1
                    self.calTimeCurrnetValue()
                    self.timeButton.setTitle("START", for: .normal)
                    self.taskNameThisTime.text = items[self.setChapter]
                    self.remainTaskCount.text = "\(itemsTime.count - self.setChapter - 1)개"
                    isTimerOnForEntire = !isTimerOnForEntire
                }
                print("현재시간 : \(self.timeCurrentSecond)")
            }
            
            if !isTimerOnForEntire {
                RunLoop.current.add(self.entireTimer!, forMode: .common)
                RunLoop.current.add(self.currentTimer!, forMode: .common)
            }
            timeButton.setTitle("STOP", for: .normal)
        }
        isTimerOnForCurrent = !isTimerOnForCurrent
        isTimerOnForEntire = !isTimerOnForEntire
    }
    
    
    // 전체 시간 계산에 필요한 sum 함수
    func sum(numbers: [Int]) -> Int {
        return numbers.reduce(0, +)
    }
    
    // 이전 할 일 버튼
    @IBAction func btnPreviousWork(_ sender: Any) {
        if isTimerOnForEntire {
            setChapter -= 1
            currentTimer?.invalidate()
            entireTimer?.invalidate()
            center.removeAllPendingNotificationRequests()
            
            taskNameThisTime.text = items[setChapter]
            remainTaskCount.text = "\(itemsTime.count - setChapter - 1)개"
            isTimerOnForEntire = false
            isTimerOnForCurrent = false
            timeButton.setTitle("START", for: .normal)
            viewDidLoad()
        }else {
            setChapter -= 1
            taskNameThisTime.text = items[setChapter]
            remainTaskCount.text = "\(itemsTime.count - setChapter - 1)개"
            isTimerOnForEntire = false
            isTimerOnForCurrent = false
            timeButton.setTitle("START", for: .normal)
            viewDidLoad()
        }
    }
    
    // 다음 할 일 버튼
    @IBAction func btnNextWork(_ sender: Any) {
        if isTimerOnForEntire {
            setChapter += 1
            
            currentTimer?.invalidate()
            entireTimer?.invalidate()
            center.removeAllPendingNotificationRequests()
            
            taskNameThisTime.text = items[setChapter]
            remainTaskCount.text = "\(itemsTime.count - setChapter - 1)개"
            isTimerOnForEntire = false
            isTimerOnForCurrent = false
            timeButton.setTitle("START", for: .normal)
            viewDidLoad()
        } else {
            setChapter += 1
            taskNameThisTime.text = items[setChapter]
            remainTaskCount.text = "\(itemsTime.count - setChapter - 1)개"
            isTimerOnForEntire = false
            isTimerOnForCurrent = false
            timeButton.setTitle("START", for: .normal)
            viewDidLoad()
        }
    }
    
    func prevNextButtonColorSet() {
        if setChapter == 0 && items.count != 1 {
            previousButton.isEnabled = false
            previousButton.alpha = 0.5
            nextButton.isEnabled = true
            nextButton.alpha = 1.0
        }else if items.count == 1 {
            previousButton.isEnabled = false
            previousButton.alpha = 0.5
            nextButton.isEnabled = false
            nextButton.alpha = 0.5
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
    }
    
    // 리셋 버튼
    @IBAction func btnReset(_ sender: Any) {
        setChapter = 0
        resetButton.isEnabled = false
        resetButton.alpha = 0.5
        currentTimer?.invalidate()
        timeCurrentSecond = itemsTime[setChapter] * 60
        entireTimer?.invalidate()
        timeEntireSecond = sum(numbers: itemsTime) * 60
        center.removeAllPendingNotificationRequests()
        
        taskNameThisTime.text = items[setChapter]
        remainTaskCount.text = "\(itemsTime.count - setChapter - 1)개"
        isTimerOnForEntire = false
        isTimerOnForCurrent = false
        timeButton.setTitle("START", for: .normal)
        viewDidLoad()
    }
}









/*
// 내부 알림창으로 알람 종료 표현하기 위해 필요한 메서드

// 시간 도과 시 울리는 알람에 필요한 메서드
func playSound(title: String?){
        let url = Bundle.main.url(forResource: "Balynt - Memory", withExtension: "mp3")
        player = try!AVAudioPlayer(contentsOf: url!)
        player.play()
    }
     


func endingAlert(){
    let alert = UIAlertController(title : "완료!", message:"축하합니다. 이번 할 일을 모두 끝냈습니다.", preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title: "알람 소리 끄기", style: .default) {
        (action) in
        self.player.stop()
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
        self.player.stop()
    }
    alert.addAction(okAction)
    present(alert, animated: false, completion: nil)
    
    return
    
}
 */
     
     
/*
 
// 추후 쓸 수도 있는 메서드 모음
 
// 전체 남은 시간용 appMovedToBackground() 메서드
@objc func appMovedToBackground() {
    print("App moved to background!")
    if isTimerOnForStackSecond {
        timeWhenGoBackgroundForStackSecond = Date()
        print("Save")
    }
}

// 전체 남은 시간용 appMoveToForeground() 메서드
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
*/
