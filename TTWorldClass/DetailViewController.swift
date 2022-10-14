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
    var receiveItemEmo = UIImage(named: "건배")
    
    @IBOutlet weak var lblItem: UILabel!
    @IBOutlet weak var lblItemTime: UILabel!
    @IBOutlet weak var lblItemEmo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblItem.text = receiveItem
        lblItemTime.text = receiveItemsTime
        lblItemEmo.image = receiveItemEmo
    }
    
    func receiveItem(_ item: String, itemTime: Int, itemImage: String){
        receiveItem = item
        receiveItemsTime = String(itemTime) + "분"
        receiveItemEmo = UIImage(named: itemImage)
    }

    @IBAction func btnModelClose(_ sender: Any) {
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
