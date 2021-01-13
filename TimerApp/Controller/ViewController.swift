//
//  ViewController.swift
//  TimerApp
//
//  Created by Josh Kraskin on 12/19/20.
//

import UIKit
import UserNotifications


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var navNewTimer: UIBarButtonItem!
    
    @IBOutlet var table: UITableView!
    
    var timerArr = [String]()
    var timers: [TimerClass] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        timerArr.append("Timer \(timerArr.count)")
        timers.append(TimerClass())
    
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timers.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimerCell") as! TimerCell
        
        let timerDefaultName = "Timer \(indexPath.row + 1)"
        print(timerDefaultName)
        //let timerDefaultName1 = TimerClass()
        
        timers.append(TimerClass())
  
        cell.configure()
        cell.timerLabel.text = timerDefaultName
        
        print(timers)
        
        
        return cell
    
}
    
    @IBAction func addNewTimer(_ sender: UIButton) {
        timerArr.append("Timer \(timerArr.count)")
        table.insertRows(at: [IndexPath(row: timerArr.count - 1, section: 0)], with: .automatic)
    
    }
    

}
