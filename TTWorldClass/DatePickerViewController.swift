//
//  DatePickerViewController.swift
//  TTWorldClass
//
//  Created by 김동현 on 2022/10/10.
//

import UIKit

protocol MyProtocol {
    func timeSetDelegate(dataSent: String)
    func emoSetDelegate(dataSent: String)
}

class DatePickerViewController: UIViewController {

    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var lblTimeSet: UILabel!
    
    @IBOutlet weak var lblTimeOverMessage: UILabel!
    @IBOutlet weak var btnTimeSet: UIButton!
    
    var timeInt : Int = 1
   
    var delegate : MyProtocol?
    
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
    
    
    @IBAction func btnTimeSet(_ sender: Any) {

        let stringTimeInt:String = String(timeInt)
        delegate?.timeSetDelegate(dataSent: stringTimeInt)
        print("데이터 전달됨. 데이터 : \(stringTimeInt)")
        self.dismiss(animated: true, completion: nil)
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
