//
//  EmoticonSelectViewController.swift
//  TTWorldClass
//
//  Created by 김동현 on 2022/10/14.
//

import UIKit

protocol EmoticonSendDelegate {
    func didEmoticonSendDone(_ controller: EmoticonSelectViewController, message: String)
}

class EmoticonSelectViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let MAX_ARRAY_NUM = 45
    let PICKER_VIEW_COLUMN = 1
    var imageFileName = ["건배", "노트북", "덤벨", "라면", "러닝", "러닝2", "러닝머신", "맥주","모니터", "모래시계", "변기", "변기2", "생일케이크", "설거지", "세탁기", "쇼핑", "스마트폰", "시계", "쓰레기통", "악기", "알람시계", "양식", "원암덤벨컬", "유튜브", "음악재생", "자전거", "전화", "조이스틱", "진공청소기", "진공청소기2", "진공청소기3", "책", "청소도구", "청소도구2", "체크", "커피", "커피2", "코딩", "피자조각", "하트", "하트2", "휴지통", "cart", "clock", "pencil"]
    
    var delegate : EmoticonSendDelegate?
    var imageName : String = "건배"
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // 보여줄 컬럼의 수를 세팅합니다.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN
    }
    
    // 이모티콘의 숫자대로 row를 생성합니다.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imageFileName[row]
    }
    
    @IBAction func btnEmoticonSet(_ sender: UIButton) {
        if delegate != nil{
            delegate?.didEmoticonSendDone(self, message: String(imageName))
        }
        _ = navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }

}
