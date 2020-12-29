//
//  ViewController.swift
//  TimerApp
//
//  Created by Josh Kraskin on 12/19/20.
//

import UIKit
import UserNotifications



class ViewController: UIViewController, UNUserNotificationCenterDelegate {


    @IBOutlet weak var timer1View: UIView!
    
    @IBOutlet weak var Label1Input: UITextField!
    
    @IBOutlet weak var Hour1Input: UITextField!
    
    @IBOutlet weak var Minute1Input: UITextField!
    
    @IBOutlet weak var Seconds1Input: UITextField!
    
    @IBOutlet weak var Timer1Countdown: UILabel!
    
    @IBOutlet weak var Start1Button: UIButton!
    
    @IBOutlet weak var Pause1Button: UIButton!
    
    @IBOutlet weak var Restart1Button: UIButton!
    
    var timer: Timer = Timer()
    var h = 0
    var m = 0
    var s = 0
    var t: Int = 0
    var pausedEndTime = Date()
    var dateT = Date()
    var dateTComponents = DateComponents()
    var pausedTimeLeft = DateComponents()
    var pausedEventDate = Date()
    var animInt: Int = 0
    
    var buttonColor = UIColor(red: 0.95, green: 0.98, blue: 0.93, alpha: 1.00)

    let Timer1 = TimerClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        self.view.backgroundColor = UIColor(red: 0.11, green: 0.21, blue: 0.34, alpha: 1.00)
        timer1View.layer.cornerRadius = 10
        timer1View.layer.shadowColor = UIColor.black.cgColor
        timer1View.layer.shadowOffset = CGSize(width:2, height: 2)
        timer1View.layer.shadowRadius = 10
        timer1View.layer.shadowOpacity = 0.7
        
        timer1View.backgroundColor = UIColor(red: 0.27, green: 0.48, blue: 0.62, alpha: 1.00)
        Start1Button.tintColor = buttonColor
        Pause1Button.tintColor = buttonColor
        Restart1Button.tintColor = buttonColor
        
        
    }
    
    //Notification set up
    func notification(dateComponents: DateComponents, timerID: String){
        
        
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "\(timerID) Complete"
        content.body = "\(timerID) is complete!"
        content.sound = .default

        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                
                
        let request = UNNotificationRequest(identifier: timerID, content: content, trigger: trigger)
                
            center.add(request) { (error) in
                }
        
        
    }
        //Reset timer when user responds to notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        completionHandler([.sound, .banner, .badge])
        }
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    didReceive response: UNNotificationResponse,
                                    withCompletionHandler completionHandler: @escaping () -> Void) {
            if response.notification.request.identifier == Timer1.timerID {
                    resetTimer1(self)
                }
    
            completionHandler()
    
        }
    
    func labelVisibility(inputHidden: Bool){
        if inputHidden{
    Hour1Input.isHidden = true
    Minute1Input.isHidden = true
    Seconds1Input.isHidden = true
    Timer1Countdown.isHidden = false
        }
        else{
            Hour1Input.isHidden = false
            Minute1Input.isHidden = false
            Seconds1Input.isHidden = false
            Timer1Countdown.isHidden = true
        }
    }

    func anim(){
        
        UIView.animate(withDuration: 8, delay: 0, options: UIView.AnimationOptions.allowUserInteraction, animations: {self.timer1View.backgroundColor = UIColor(red: 0.90, green: 0.22, blue: 0.27, alpha: 1.0)}, completion: nil)
    }
    
    @IBAction func startTimer1(_ sender: UIButton) {
    
    
        h = Int(Hour1Input.text ?? "") ?? 0
        m = Int(Minute1Input.text ?? "") ?? 0
        s = Int(Seconds1Input.text ?? "") ?? 0
        t = ((h*3600) + (m*60) + s)
        
        Seconds1Input.isHidden = true
        
        Timer1.startTimer(t: t, timerID: Label1Input.text ?? "Timer 1")
        
        notification(dateComponents: Timer1.notificationComponents, timerID: Timer1.timerID)
        
        labelVisibility(inputHidden: true)
    

    
        
        timer = Timer.scheduledTimer(timeInterval: (0.5), target: self, selector: #selector(updateTimer1Countdown), userInfo: nil, repeats: true)

        }
    
        @objc func updateTimer1Countdown() {
        Timer1Countdown.text = Timer1.updateTime()
            animInt = Timer1.myint
            if animInt <= 10{
                anim()
            }
            if animInt < 0{
                timer1View.backgroundColor = UIColor(red: 0.27, green: 0.48, blue: 0.62, alpha: 1.00)
            }
        }

    
    @IBAction func pauseTimer1(_ sender: Any) {
    
         timer.invalidate()
         Timer1.pauseTimer()
        
        
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [Timer1.timerID])
        
    }
    
    @IBAction func resetTimer1(_ sender: Any) {
    
        Timer1.resetTimer()
        Label1Input.text = Timer1.timerID
        timer.invalidate()
        labelVisibility(inputHidden: false)

        Hour1Input.text = "00"
        Minute1Input.text = "00"
        Seconds1Input.text = "00"
        Timer1Countdown.text = "00:00:00"
        timer1View.backgroundColor = UIColor(red: 0.27, green: 0.48, blue: 0.62, alpha: 1.00)
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [Timer1.timerID])
    }
}

    
    

    


