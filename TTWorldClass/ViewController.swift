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
    }

    @IBAction func swipeAction(_ sender: Any) {
        number += 1
        if number == 4{
            stepsImages.isHidden = true
            dots.isHidden = true
        } else{
            stepsImages.image = UIImage(named: "step\(String(number))")
            dots.currentPage = number - 1
        }
    }
    
}

