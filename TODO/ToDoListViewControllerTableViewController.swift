//
//  ToDoListViewControllerTableViewController.swift
//  TODO
//
//  Created by 安子和 on 2020/2/13.
//  Copyright © 2020 安子和. All rights reserved.
//

import UIKit

class ToDoListViewControllerTableViewController: UITableViewController {
    
    var itemArr = [ToDoItem]()
    //let defaults = UserDefaults.standard
    let dataFilePathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ToDoItems.plist")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        print(itemArr)
        for i in 1...50{
            itemArr.append(ToDoItem(name: "事件No.\(i)"))
        }
//        if let arr = defaults.array(forKey: "itemArr"){
//            //itemArr = arr as! [String]
//            //print(itemArr)
//        }
        loadToDoItems()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArr.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = itemArr[indexPath.row].name
        cell.accessoryType = itemArr[indexPath.row].hasDone ? .checkmark : .none
        cell.backgroundColor = UIColor.systemPink

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArr[indexPath.row].name)
        let item = itemArr[indexPath.row]
        itemArr[indexPath.row].hasDone = item.hasDone ? false : true
        saveToDoItems()
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .none)
        tableView.endUpdates()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func loadToDoItems(){
        let decoder = PropertyListDecoder()
        do{
            let data = try Data(contentsOf: dataFilePathURL!)
            itemArr = try decoder.decode([ToDoItem].self, from: data)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func saveToDoItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArr)
            try data.write(to: dataFilePathURL!)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var textField : UITextField!
        let alert = UIAlertController(title: "尊敬的用户", message: "确定要新建待处理事项么？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let affirmAction = UIAlertAction(title: "添加", style: .default){action in
            print(textField.text!)
            self.itemArr.append(ToDoItem(name:textField.text!))
            //self.defaults.set(self.itemArr, forKey: "itemArr")
            //print(self.defaults.array(forKey: "itemArr")!)
            self.saveToDoItems()
            self.tableView.reloadData()
        }

        alert.addAction(cancelAction)
        alert.addAction(affirmAction)
        alert.addTextField(configurationHandler: {alertTextField in
            alertTextField.placeholder="请输入事项"
            textField = alertTextField
        })
        self.present(alert, animated: true, completion: nil)
    }
    
}
