//
//  TableViewController.swift
//  Table
//
//  Created by 김동현 on 2022/10/09.
//

import UIKit

// 앱 시작 시 기본적으로 나타낼 목록
var items = ["장보기", "책상 정리", "빨래 널기"]
var itemsImageFile = ["cart", "clock", "pencil"]
var itemsTime: [Int] = [20, 10, 5]

class TableViewController: UITableViewController {
    
    @IBOutlet var tvListView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    

    @IBAction func btnTimerStart(_ sender: Any) {
        if items.count == 0 {
            let alert = UIAlertController(title : "시작 불가", message: "할 일을 아무것도 추가하지 않았어요!", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default) {
                (action) in
            }
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
            
            return
        }
    }
    
    func sum(numbers: [Int]) -> Int {
        return numbers.reduce(0, +)
    }
    
    // 뷰가 노출될 때마다 리스트의 데이터를 다시 불러오는 함수
    override func viewWillAppear(_ animated: Bool) {
        tvListView.reloadData()
    }
    
    // MARK: - Table view data source

    // 테이블 안의 섹션 개수를 1개로 설정한다.
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // 섹션당 열의 개수를 전달한다.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    //items, itemsImageFile 값을 셀에 삽입한다.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .white
        
        cell.textLabel?.text = items[(indexPath as NSIndexPath).row]
        cell.detailTextLabel?.text = {
            let tempTime = itemsTime[(indexPath as NSIndexPath).row]
                    
            if tempTime < 60 {
                return "\(tempTime):00"
            }else {
                let hours = tempTime / 60
                let minutes = tempTime % 60
                if minutes < 10 {
                    return "\(hours):0\(minutes):00"
                }
                return "\(hours):\(minutes):00"
            }
        }()
        
        cell.imageView?.image = UIImage(named: itemsImageFile[(indexPath as NSIndexPath).row])
        
        return cell
    }

    
    // Override to support editing the table view.
    // 목록 삭제 함수
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // items와 itemsImageFile에서 해당 리스트를 삭제한다.
            items.remove(at: (indexPath as NSIndexPath).row)
            itemsImageFile.remove(at: (indexPath as NSIndexPath).row)
            itemsTime.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // 삭제 버튼 "Delete" 대신 "삭제"로 나타나게 구현
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    
    // Override to support rearranging the table view.
    // 목록 순서바꾸기
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = items[(fromIndexPath as NSIndexPath).row]
        let itemImageToMove = itemsImageFile[(fromIndexPath as NSIndexPath).row]
        let itemTimeToMove = itemsTime[(fromIndexPath as NSIndexPath).row]
        items.remove(at: (fromIndexPath as NSIndexPath).row)
        itemsImageFile.remove(at: (fromIndexPath as NSIndexPath).row)
        itemsTime.remove(at: (fromIndexPath as NSIndexPath).row)
        items.insert(itemToMove, at: (to as NSIndexPath).row)
        itemsImageFile.insert(itemImageToMove, at: (to as NSIndexPath).row)
        itemsTime.insert(itemTimeToMove, at: (to as NSIndexPath).row)
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgDetail" {
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            let detailView = segue.destination as! DetailViewController
            detailView.receiveItem(items[((indexPath! as NSIndexPath).row)], itemTime: itemsTime[((indexPath! as NSIndexPath).row)], itemImage: itemsImageFile[((indexPath! as NSIndexPath).row)])
        }
    }
    

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


}
