//
//  AddViewController.swift
//  Table
//
//  Created by 김동현 on 2022/10/09.
//

import UIKit

class AddViewController: UIViewController, MyProtocol{
   
    func timeSetDelegate(dataSent: String) {
        
        self.tfAddTime.text = dataSent
        print("데이터 세팅함. 데이터 : \(dataSent)")
        
    }
    func emoSetDelegate(dataSent: String){
        self.tfTestAddEmo.text = dataSent
    }
        
    
    @IBOutlet weak var workTitleLabel: UILabel!
    @IBOutlet weak var workTimeLabel: UILabel!
    @IBOutlet weak var workEmoLabel: UILabel!
    
    @IBOutlet var tfAddItem: UITextField!
    @IBOutlet weak var tfAddTime: UILabel!
    
    @IBOutlet weak var tfTestAddEmo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // 새 목록 추가하기
    @IBAction func btnAddItem(_ sender: UIButton) {
        
        if tfAddItem.text == "" || tfAddTime.text == "0" || tfAddTime == nil {
            let alert = UIAlertController(title : "생성 불가", message: "제목 또는 시간을 입력하지 않았어요!", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "다시 만들기", style: .default) {
                (action) in
            }
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
            
            return
        }else if sum(numbers: itemsTime) + Int(tfAddTime.text!)! > 100  {
            let nowSum = sum(numbers: itemsTime)
            let availSetTime = 100 - sum(numbers: itemsTime)
            
            let alert = UIAlertController(title : "생성 불가", message:"이 할 일을 추가하면 총 시간이 100분이 넘습니다. 더 이상 생성할 수 없어요!\n" + "현재 생성한 시간 : \(nowSum)분\n" + "생성 가능한 시간 : \(availSetTime)분", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "돌아가기", style: .default) {
                (action) in
            }
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
            
            return
        }
                
        items.append(tfAddItem.text!)
        itemsImageFile.append("clock")
        itemsTime.append(Int(tfAddTime.text!)!)
        tfAddItem.text = ""
        tfAddTime.text = ""
        labelRadius()
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        self.view.endEditing(true)
        
    }
    
    func labelRadius(){
        workTimeLabel.clipsToBounds = true
        workTitleLabel.clipsToBounds = true
        workEmoLabel.clipsToBounds = true
        workTimeLabel.layer.cornerRadius = 60
        workTitleLabel.layer.cornerRadius = 60
        workEmoLabel.layer.cornerRadius = 60
    }
    
    func sum(numbers: [Int]) -> Int {
        return numbers.reduce(0, +)
    }
   
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        print("prepare 메서드 내부")
        if segue.identifier == "timeSet" {
            guard let viewController: DatePickerViewController = segue.destination as? DatePickerViewController else {return}
            viewController.delegate = self
        }else if segue.identifier == "emoticonSet" {
            guard let viewController: EmoticonSelectViewController = segue.destination as? EmoticonSelectViewController else {return}
            viewController.delegate = self
        }
    }
//
//    func timePrepare(for segue:UIStoryboardSegue, sender: Any?) {
//
//        let datePickerViewController = segue.destination as! DatePickerViewController
//        print("prepare 내부 : \(datePickerViewController) \n 끝")
//        datePickerViewController.delegate = self
//    }
//
//
//    func emoticonPrepare(for segue:UIStoryboardSegue, sender: Any?) {
//        let emoticonSelectViewController = segue.destination as! EmoticonSelectViewController
//        emoticonSelectViewController.delegate = self
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
