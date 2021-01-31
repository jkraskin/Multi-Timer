//
//  TimerCell.swift
//  TimerApp
//
//  Created by Josh Kraskin on 1/6/21.
//

import UIKit
import UserNotifications



class TimerCell: UITableViewCell, UNUserNotificationCenterDelegate {
    
    
    //Notification set up
    func notification(dateComponents: DateComponents, timerID: String, notificationID: String){
    
    
            let center = UNUserNotificationCenter.current()
    
            let content = UNMutableNotificationContent()
            content.title = "\(timerID) Complete"
            content.body = "\(timerID) is complete!"
            content.sound = .default
            
    
    
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    
    
            let request = UNNotificationRequest(identifier: cellIndex, content: content, trigger: trigger)
    
                center.add(request) { (error) in
                    }
    
    
        }
    //Reset timer when user responds to notification
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
//        completionHandler([ .sound, .banner, .badge])
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse,
//                                withCompletionHandler completionHandler: @escaping () -> Void) {
//        if response.notification.request.identifier == cellIndex {
//            newTimer.resetTimer()}
//
//        //completionHandler()
//
//    }
    
    @IBOutlet weak var timerLabel: UITextField!
    
    @IBOutlet weak var hourInput: UITextField!
    
    @IBOutlet weak var minuteInput: UITextField!
    
    @IBOutlet weak var secondInput: UITextField!
    
    @IBOutlet weak var countdownLabel: UILabel!
    
    @IBOutlet weak var startPauseButton: UIButton!
    
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var cardView: UIView!
    
    
    
    var timer: Timer = Timer()
    
    var cellIndex = ""
    
    var h = 0
    var m = 0
    var s = 0
    var t: Int = 0
    
    var timerName = ""
    var notificationID = ""
    var notificaitonCellID = ""
    
    var cellIsRunning = false

    
    let newTimer = TimerClass()
    
//
//    func removeNotification(){
//        let center = UNUserNotificationCenter.current()
//        center.removePendingNotificationRequests(withIdentifiers: [notificationID])
//    }
   
    

    @IBAction func pauseButton(_ sender: UIButton) {
        
        cellIsRunning = false
        pauseButton.isEnabled = false
        
        timer.invalidate()
        newTimer.pauseTimer()
        
        
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [cellIndex])
        //center.removePendingNotificationRequests(withIdentifiers: [newTimer.timerID])
        //center.removePendingNotificationRequests(withIdentifiers: [notificaitonCellID])
        
        if newTimer.isRunning == true {
            startPauseButton.isEnabled = false
        }
        
        else {
            startPauseButton.isEnabled = true
        }
        
    }
    
    @IBAction func resetButton(_ sender: UIButton?) {
        
        cellIsRunning = false
        pauseButton.isEnabled = false
        
        
        startPauseButton.isEnabled = true
        newTimer.resetTimer()
        timerLabel.text = "New Timer"
        timer.invalidate()
        //labelVisibility(inputHidden: false)
        
        hourInput.text = "00"
        minuteInput.text = "00"
        secondInput.text = "00"
        countdownLabel.text = "00:00:00"
        
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [cellIndex])
//        center.removePendingNotificationRequests(withIdentifiers: [newTimer.timerID])
//        center.removePendingNotificationRequests(withIdentifiers: [notificaitonCellID])
        
        if newTimer.isRunning == true {
            startPauseButton.isEnabled = false
        }
        
        else {
            startPauseButton.isEnabled = true
        }
    }
    

    
    @IBAction func startButton(_ sender: Any) {
        
       //let notificationCellID = String(cellIndex!.row)
    //let notificationCellID = cellIndex
        
        print(cellIndex)
        
        pauseButton.isEnabled = true
        cellIsRunning = true
       
        
        h = Int(hourInput.text ?? "") ?? 0
        m = Int(minuteInput.text ?? "") ?? 0
        s = Int(secondInput.text ?? "") ?? 0
        t = ((h*3600) + (m*60) + s)
        
        timerName = timerLabel.text!
        
        //print(notificationID)
        
        newTimer.startTimer(t: t, labelName: timerName)
        
        notification(dateComponents: newTimer.notificationComponents, timerID: newTimer.timerID, notificationID: cellIndex)
        
        timer = Timer.scheduledTimer(timeInterval: (0.5), target: self, selector: #selector(updateTimerCountdown), userInfo: nil, repeats: true)
            
        if newTimer.isRunning == true {
            startPauseButton.isEnabled = false
        }
        
        else {
            startPauseButton.isEnabled = true
        }

    }
    
    @objc func updateTimerCountdown() {
        countdownLabel.text = newTimer.updateTime()
        if countdownLabel.text == "00:00:00"{
            
            startPauseButton.isEnabled = true
            pauseButton.isEnabled = true
        }
    }

    func configure(CellIndex: String) {
        
        cardView.backgroundColor = UIColor.white
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cardView.layer.masksToBounds = false
        cardView.layer.shadowOpacity = 1.0
        cardView.layer.cornerRadius = 8.0
        if cellIsRunning == false{
            pauseButton.isEnabled = false
    }
        if cellIsRunning == true{
            pauseButton.isEnabled = true
        }
        
    }

}

    
    








