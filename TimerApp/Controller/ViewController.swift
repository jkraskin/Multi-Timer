//
//  ViewController.swift
//  TimerApp
//
//  Created by Josh Kraskin on 12/19/20.
//

import UIKit
import UserNotifications



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,  UNUserNotificationCenterDelegate, TimerCellProtocol {
    
    func startTimer(index: Int, t: Int, labelName: String) {
        return
    }
     

    
    var timers: [TimerClass] = []
    var timerCells: [TimerCell] = []
    var timerNameArray: [Int] = []
    var maxLimit = 10
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //keyboard code
        self.dismissKeyboard()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        table.delegate = self
        table.dataSource = self
        addNewTimer(self)
        UNUserNotificationCenter.current().delegate = self
        LocalNotificationManager.autherizeLocalNotifications()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = table.bounds
        gradientLayer.colors = [UIColor.purple.cgColor,UIColor.systemBlue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)

        let backgroundView = UIView(frame: table.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)

        table.backgroundView = backgroundView
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)

    }
    
    @IBOutlet weak var navNewTimer: UIBarButtonItem!
    
    @IBOutlet var table: UITableView!
    
    //keyboard code
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            table.contentInset = .zero
        } else {
            table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        table.scrollIndicatorInsets = table.contentInset
        table.scrollToNearestSelectedRow(at: .bottom, animated: true)
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(timers.count)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimerCell", for: indexPath) as! TimerCell
        
 
        cell.cellIndex = String(indexPath.row)
        cell.indexP = indexPath.row
        cell.timers = timers
        cell.delegate = self
        
        cell.configure(CellIndex: String(indexPath.row))
        cell.setTimerCell(timer: timers[indexPath.row])
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(timers[indexPath.row].id)
    }
        
    
        @IBAction func addNewTimer(_ sender: Any) {
        if timers.count < maxLimit {
            timers.append(TimerClass(timerName: "Timer \(timers.count + 1)", id: UUID().uuidString))
            timerCells.append(TimerCell())
            timerNameArray.append(1)
            table.beginUpdates()
            table.insertRows(at: [IndexPath(row: timers.count-1, section: 0)], with: .automatic)
            table.endUpdates()
            if timers.count == maxLimit {
                navNewTimer.isEnabled = false
            }
        }

    }
    
    func startAll(action: UIAlertAction) {
        for timer in timers {
            if timer.inputT > 0 {
            timer.startTimer(t: timer.inputT, labelName: timer.timerName)
            notification(dateComponents: timer.notificationComponents, timerID: timer.timerID, notificationID: timer.id)
            }
        }

        table.reloadData()
    }
    
    
    func pauseAll(action: UIAlertAction) {
        for timer in timers {
            if timer.isRunning{
            timer.pauseTimer()
                let center = UNUserNotificationCenter.current()
                center.removeAllPendingNotificationRequests()
            }
        }
        table.reloadData()
    }
    
    func resetAll(action: UIAlertAction) {
        for timer in timers {
            
            timer.resetTimer()
            
            let center = UNUserNotificationCenter.current()
            center.removeAllPendingNotificationRequests()
            
        }
        table.reloadData()
    }
    
    func deleteAll(action: UIAlertAction) {
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
       
        for timer in timers {
            timer.resetTimer()
        }
        timers.removeAll()
        table.reloadData()
        navNewTimer.isEnabled = true
    }
    
    @IBAction func allTimerButton(_ sender: Any) {
        print("allTimer")
        
        let ac = UIAlertController(title: "Choose an option", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Start All", style: .default, handler:startAll))
        ac.addAction(UIAlertAction(title: "Pause All", style: .default, handler:pauseAll))
        ac.addAction(UIAlertAction(title: "Reset All", style: .default, handler:resetAll))
        ac.addAction(UIAlertAction(title: "Delete All", style: .destructive, handler:deleteAll))
        ac.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        
        present(ac, animated: true)

        
    }
    
    func notification(dateComponents: DateComponents, timerID: String, notificationID: String){
        
        print("Notification called for \(timerID)")
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "\(timerID) Complete"
        content.body = "\(timerID) is complete!"
        content.sound = .default
        
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        
        let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
//        let request = UNNotificationRequest(identifier: cellIndex, content: content, trigger: trigger)
        
        center.add(request) { (error) in
        }
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        //print(indexPath.row)
        
        return .delete
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            
//            let cellIndexPath = String(indexPath.row)
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [timers[indexPath.row].id])
            timers[indexPath.row].resetTimer()
            timers.remove(at: indexPath.row)
            navNewTimer.isEnabled = true
            tableView.deleteRows(at: [indexPath], with: .fade)
            table.reloadDataSavingSelections()
            
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

extension ViewController {

    
        
        
    func resetTimer(index: Int) {
        print("Reset data passed for cell \(index)")
    }
    
    func pauseTimer(index: Int) {
        print("Pause data passed for cell \(index)")
    }
    
    func showAlert(index: Int) {
        print("Alert data passed")
//        let alert = UIAlertController(title: "\(timers[index].timerName) Complete", message: "\(timers[index].timerName) is complete!", preferredStyle: .alert)
//        
//        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel)) //, handler: { action in self.timers[index].resetTimer() }))
        
//        present(alert, animated: true)
    }
    
    
}

extension ViewController {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}

extension UITableView {
    /// Reloads a table view without losing track of what was selected.
    func reloadDataSavingSelections() {
        let selectedRows = indexPathsForSelectedRows

        reloadData()

        if let selectedRow = selectedRows {
            for indexPath in selectedRow {
                selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
        }
    }
}
