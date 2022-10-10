//
//  DetailViewController.swift
//  Table
//
//  Created by 김동현 on 2022/10/09.
//

import UIKit

class DetailViewController: UIViewController {

    var receiveItem = ""
    var receiveItemsTime = ""
    
    @IBOutlet var lblItem: UILabel!
    @IBOutlet var lblItemTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblItem.text = receiveItem
        lblItemTime.text = receiveItemsTime
    }
    
    func receiveItem(_ item: String, itemTime: Int){
        receiveItem = item
        receiveItemsTime = String(itemTime) + "분"
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
