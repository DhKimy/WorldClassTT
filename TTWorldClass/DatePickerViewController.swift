//
//  DatePickerViewController.swift
//  TTWorldClass
//
//  Created by 김동현 on 2022/10/10.
//

import UIKit

protocol SendDelegate {
    func didMessageSendDone(_ controller: DatePickerViewController, message: String)
}

class DatePickerViewController: UIViewController {

    
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var lblTimeSet: UILabel!
    
    @IBOutlet weak var lblTimeOverMessage: UILabel!
    @IBOutlet weak var btnTimeSet: UIButton!
    
    var timeInt : Int = 1
    var delegate : SendDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnTimeSet.isHidden = false
        lblTimeOverMessage.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        self.timeInt = Int(self.timePicker.countDownDuration) / 60
        self.lblTimeSet.text = String(timeInt) + "분"

        if timeInt > 100{
            btnTimeSet.isHidden = true
            lblTimeOverMessage.isHidden = false


        }else{
            btnTimeSet.isHidden = false
            lblTimeOverMessage.isHidden = true
        }

    }
    
    
    @IBAction func btnTimeSet(_ sender: UIButton) {
        if delegate != nil{
            delegate?.didMessageSendDone(self, message: String(timeInt))
        }
        _ = navigationController?.popViewController(animated: true)
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
