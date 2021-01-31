//
//  ViewController.swift
//  TimerApp
//
//  Created by Josh Kraskin on 12/19/20.
//

import UIKit
import UserNotifications


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,  UNUserNotificationCenterDelegate {

    @IBOutlet weak var navNewTimer: UIBarButtonItem!
    
    @IBOutlet var table: UITableView!
    
    //  let newTimer = TimerClass()
    var timers: [TimerClass] = []
    var timerNameArray: [Int] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        //timers.append(newTimer)
        addNewTimer(self)
        //timerNameArray.append(1)
    
        LocalNotificationManager.autherizeLocalNotifications()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(timers.count)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimerCell", for: indexPath) as! TimerCell
        
        
        //let timerDefaultName = "Timer \(timerNameArray.count)"
        //print(timerDefaultName)

  
        
        cell.configure(CellIndex: String(indexPath.row))
        //cell.timerLabel.text = timerDefaultName
        cell.timerLabel.text = "New Timer"
        cell.cellIndex = String(indexPath.row)
        
        print(timers[indexPath.row].timerID)

        return cell
    
}
    
    @IBAction func addNewTimer(_ sender: Any) {
        timers.append(TimerClass())
        timerNameArray.append(1)
        table.beginUpdates()
        table.insertRows(at: [IndexPath(row: timers.count-1, section: 0)], with: .automatic)
        table.endUpdates()
        
        //print(timers)
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tableView.indexPathForSelectedRow!)
    }
    

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        //print(indexPath.row)
        
        return .delete
        
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            
            let cellIndexPath = String(indexPath.row)
            //timers[indexPath.row].resetTimer()
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [cellIndexPath])
            timers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            //tableView.reloadData()
            
           // print(timers)
        }
    }
  
}

extension UIViewController {
func dismissKeyboard() {
       let tap: UITapGestureRecognizer = UITapGestureRecognizer( target:     self, action:    #selector(UIViewController.dismissKeyboardTouchOutside))
       tap.cancelsTouchesInView = false
       view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
       view.endEditing(true)
    }
}
