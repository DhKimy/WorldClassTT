//
//  AddViewController.swift
//  Table
//
//  Created by 김동현 on 2022/10/09.
//

import UIKit

class AddViewController: UIViewController, SendDelegate {

    

    @IBOutlet var tfAddItem: UITextField!
    @IBOutlet var tfAddTime: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // 새 목록 추가하기
    @IBAction func btnAddItem(_ sender: UIButton) {
        
        if tfAddItem == "" || tfAddTime == 0 || tfAddTime == nil {
            let alert = UIAlertController(title : "생성 불가", message: "제목 또는 시간을 입력하지 않았어요!")
            let okAction = UIAlertAction(title: "다시 만들기", style: .default) {
                (action) in
            }
            alert.addAction(okAction)
            
        }
        
        
        
        
        items.append(tfAddItem.text!)
        itemsImageFile.append("clock")
        itemsTime.append(Int(tfAddTime.text!)!)
        tfAddItem.text = ""
        tfAddTime.text = ""
        _ = navigationController?.popViewController(animated: true)
    }
    
    func didMessageSendDone(_ controller: DatePickerViewController, message: String) {
        tfAddTime.text = message
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        let datePickerViewController = segue.destination as! DatePickerViewController
        datePickerViewController.delegate = self
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
