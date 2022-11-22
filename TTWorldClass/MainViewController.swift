//
//  MainViewController.swift
//  TTWorldClass
//
//  Created by 김동현 on 2022/11/06.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /**
         싱글턴 클래스에 임시 저장해놓았던 데이터 사용
         */
        if let sharedData: String = UserInformation.shared.id {
            self.idLabel.text = sharedData
        }
        if let sharedData: String = UserInformation.shared.password {
            self.passwordLabel.text = sharedData
        }
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