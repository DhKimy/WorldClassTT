//
//  SignInViewController.swift
//  TTWorldClass
//
//  Created by 김동현 on 2022/11/06.
//

import UIKit

class SignInViewController: UIViewController {

    
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        if idField.text == "" || passwordField.text == "" {
            let alert = UIAlertController(title : "로그인 실패", message: "아이디 또는 비밀번호를 입력하세요.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default) {
                (action) in
            }
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
            return
        }
        
        UserInformation.shared.id = idField.text
        UserInformation.shared.password = passwordField.text
        self.navigationController?.popViewController(animated: true)
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
