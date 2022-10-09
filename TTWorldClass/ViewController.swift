//
//  ViewController.swift
//  TTWorldClass
//
//  Created by 김동현 on 2022/10/09.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var stepsImages: UIImageView!
    var number: Int = 1
    @IBOutlet weak var dots: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let i = UserDefaults.standard.string(forKey: "Tutorial")
//        if i == "Done" {
//            stepsImages.isHidden = true
//            dots.isHidden = true
//        }
    }
    @IBAction func swipeAction(_ sender: Any) {
        number += 1
        if number == 4{
            stepsImages.isHidden = true
            dots.isHidden = true
            UserDefaults.standard.set("Done", forKey: "Tutorial")
        } else{
            stepsImages.image = UIImage(named: "step\(String(number))")
            dots.currentPage = number - 1
        }
    }
    
    
    @IBAction func moveToMain(_ sender: UIButton) {
    }
}

