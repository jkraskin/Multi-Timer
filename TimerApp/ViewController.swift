//
//  ViewController.swift
//  TimerApp
//
//  Created by Josh Kraskin on 12/19/20.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    

    @IBOutlet weak var Timer1Stack: NSLayoutConstraint!
    
    @IBOutlet weak var labelInput: UITextField!
    
    @IBOutlet weak var hourInput: UITextField!
    
    @IBOutlet weak var minuteInput: UITextField!
    
    @IBOutlet weak var secondInput: UITextField!
    
    //@IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var timerCountdown: UILabel!
    
    
    
    
    var timer: Timer = Timer()
    var t: Int = 0
    var pausedt: Int = 0
    var timerCounting: Bool = false
    var isPaused: Bool = false
    //let dateComponents = DateComponents()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        
    }
    
    func notification(dateComponents: DateComponents){
        
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Timer Complete"
        content.body = "Your timer is Complete!"
        content.sound = .default

        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                
        //let uuidString = UUID().uuidString
                
        let request = UNNotificationRequest(identifier: "Timer1", content: content, trigger: trigger)
                
            center.add(request) { (error) in
                }
        
        
    }
    
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            let id = notification.request.identifier
            print("Received in-app notification identifier= \(id)")
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            completionHandler([.alert, .sound])
        }
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    didReceive response: UNNotificationResponse,
                                    withCompletionHandler completionHandler: @escaping () -> Void) {
            if response.notification.request.identifier == "Timer1" {
                    resetTimer(self)
                    print("hello")
    
                }
    
            completionHandler()
    
        }

    
    
    @IBAction func startTimer(_ sender: Any) {
        
        let h = Int(hourInput.text!)!
        let m = Int(minuteInput.text!)!
        let s = Int(secondInput.text!)!
        t = ((h*3600) + (m*60) + s)
        
        if(timerCounting){
            timerCounting = false
            timer.invalidate()
            //t = pausedt
            
        }
        
        else{
            timerCounting = true
            timer = Timer.scheduledTimer(timeInterval: (1.0), target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            timer.tolerance = 0
            
        }
  
        //timerLabel.text = labelInput.text
        
        
        if isPaused == false {
        
        let date = Date().addingTimeInterval(Double(t))
        //print(date)
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        notification(dateComponents: dateComponents)
        }
        
        if isPaused == true {
        
        let date = Date().addingTimeInterval(Double(pausedt))
        //print(date)
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        notification(dateComponents: dateComponents)
        }
        
    }

    //TODO: update timer functionality to be based on timestamp 
    
    @objc func timerCounter() -> Void
    {
        if isPaused == false {
            if t > -1 {
            
            let time = convertSeconds(seconds: t)
            let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
            timerCountdown.text = timeString
            
            t = t-1
                
                if t == 0 {
                //notification()
                timerCounting = false
                resetTimer(self)
                }
                
            }
            
            else {
                timer.invalidate()
            }
        }
        
        if isPaused == true {
            if pausedt > -1 {
            
            let time = convertSeconds(seconds: pausedt)
            let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
            timerCountdown.text = timeString
            
            pausedt = pausedt-1
                
                if pausedt == 0 {
                //notification()
                timerCounting = false
                resetTimer(self)
                }
            }
            
        
        else {
            timer.invalidate()
        }
        }
    }
       
    
    ///print(makeTimeString(hours: time.0, minutes: time.1, seconds: time.2))
    
    
    func convertSeconds(seconds: Int) -> (Int, Int, Int)
    {
        return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
    }
        
    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String
    {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += ":"
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    
    @IBAction func pauseTimer(_ sender: Any) {
        timer.invalidate()
        timerCounting = false
        isPaused = true
        pausedt = t
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["Timer1"])
        //print(pausedt)
        
    }
    @IBAction func resetTimer(_ sender: Any) {
        self.t = 0
        self.pausedt = 0
        self.isPaused = false
        self.timer.invalidate()
        self.hourInput.text = "00"
        self.minuteInput.text = "00"
        self.secondInput.text = "00"
        self.timerCountdown.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["Timer1"])
    }
}

    
    

    


