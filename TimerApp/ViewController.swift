//
//  ViewController.swift
//  TimerApp
//
//  Created by Josh Kraskin on 12/19/20.
//

import UIKit
import UserNotifications


class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light 
        self.dismissKeyboard()
        UNUserNotificationCenter.current().delegate = self
        self.view.backgroundColor = UIColor(red: 0.11, green: 0.21, blue: 0.34, alpha: 1.00)
        timer1View.layer.cornerRadius = 10
        timer1View.layer.shadowColor = UIColor.black.cgColor
        timer1View.layer.shadowOffset = CGSize(width:2, height: 2)
        timer1View.layer.shadowRadius = 10
        timer1View.layer.shadowOpacity = 0.7
        
        timer1View.backgroundColor = timer1color
        Start1Button.tintColor = buttonColor
        Pause1Button.tintColor = buttonColor
        Restart1Button.tintColor = buttonColor
        
        timer2View.layer.cornerRadius = 10
        timer2View.layer.shadowColor = UIColor.black.cgColor
        timer2View.layer.shadowOffset = CGSize(width:2, height: 2)
        timer2View.layer.shadowRadius = 10
        timer2View.layer.shadowOpacity = 0.7
        
        timer2View.backgroundColor = timer2color
        Start2Button.tintColor = buttonColor
        Pause2Button.tintColor = buttonColor
        Restart2Button.tintColor = buttonColor
        
        timer3View.layer.cornerRadius = 10
        timer3View.layer.shadowColor = UIColor.black.cgColor
        timer3View.layer.shadowOffset = CGSize(width:2, height: 2)
        timer3View.layer.shadowRadius = 10
        timer3View.layer.shadowOpacity = 0.7
        
        timer3View.backgroundColor = timer3color
        Start3Button.tintColor = buttonColor
        Pause3Button.tintColor = buttonColor
        Restart3Button.tintColor = buttonColor
        
        timer4View.layer.cornerRadius = 10
        timer4View.layer.shadowColor = UIColor.black.cgColor
        timer4View.layer.shadowOffset = CGSize(width:2, height: 2)
        timer4View.layer.shadowRadius = 10
        timer4View.layer.shadowOpacity = 0.7
        
        timer4View.backgroundColor = timer4color
        Start4Button.tintColor = buttonColor
        Pause4Button.tintColor = buttonColor
        Restart4Button.tintColor = buttonColor
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
        completionHandler([ .sound, .banner, .badge])
        }
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    didReceive response: UNNotificationResponse,
                                    withCompletionHandler completionHandler: @escaping () -> Void) {
            if response.notification.request.identifier == Timer1.timerID {
                resetTimer1(self)}
            if response.notification.request.identifier == Timer2.timerID {
                resetTimer2(self)
                }
            if response.notification.request.identifier == Timer3.timerID {
                resetTimer3(self)
                }
            if response.notification.request.identifier == Timer4.timerID {
                resetTimer4(self)
                }
    
            completionHandler()
    
        }
    
    var timer1color = UIColor(red: 0.16, green: 0.44, blue: 0.59, alpha: 1.00)
    var timer2color = UIColor(red: 0.17, green: 0.49, blue: 0.63, alpha: 1.00)
    var timer3color = UIColor(red: 0.27, green: 0.56, blue: 0.69, alpha: 1.00)
    var timer4color = UIColor(red: 0.38, green: 0.65, blue: 0.76, alpha: 1.00)

    //Timer 1 
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
                timer1View.backgroundColor = timer1color
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
        timer1View.backgroundColor = timer1color
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [Timer1.timerID])
    }


    
    
    
    
    
    
//Timer 2

    
    @IBOutlet weak var timer2View: UIView!
    
    @IBOutlet weak var Label2Input: UITextField!
    
    @IBOutlet weak var Hour2Input: UITextField!
    
    @IBOutlet weak var Minute2Input: UITextField!
    
    @IBOutlet weak var Seconds2Input: UITextField!
    
    @IBOutlet weak var Timer2Countdown: UILabel!
    
    @IBOutlet weak var Start2Button: UIButton!
    
    @IBOutlet weak var Pause2Button: UIButton!
    
    @IBOutlet weak var Restart2Button: UIButton!

    
    var timer2: Timer = Timer()
    var h2 = 0
    var m2 = 0
    var s2 = 0
    var t2: Int = 0
    var pausedEndTime2 = Date()
    var dateT2 = Date()
    var dateTComponents2 = DateComponents()
    var pausedTimeLeft2 = DateComponents()
    var pausedEventDate2 = Date()
    var animInt2: Int = 0
    
    let Timer2 = TimerClass()
    
    func labelVisibility2(inputHidden: Bool){
        if inputHidden{
    Hour2Input.isHidden = true
    Minute2Input.isHidden = true
    Seconds2Input.isHidden = true
    Timer2Countdown.isHidden = false
        }
        else{
            Hour2Input.isHidden = false
            Minute2Input.isHidden = false
            Seconds2Input.isHidden = false
            Timer2Countdown.isHidden = true
        }
    }

    func anim2(){
        
        UIView.animate(withDuration: 8, delay: 0, options: UIView.AnimationOptions.allowUserInteraction, animations: {self.timer2View.backgroundColor = UIColor(red: 0.90, green: 0.22, blue: 0.27, alpha: 1.0)}, completion: nil)
    }
    
    

    @IBAction func startTimer2(_ sender: Any) {
        
        h2 = Int(Hour2Input.text ?? "") ?? 0
        m2 = Int(Minute2Input.text ?? "") ?? 0
        s2 = Int(Seconds2Input.text ?? "") ?? 0
        t2 = ((h2*3600) + (m2*60) + s2)
        
        
        Timer2.startTimer(t: t2, timerID: Label2Input.text ?? "Timer 2")
        
        notification(dateComponents: Timer2.notificationComponents, timerID: Timer2.timerID)
        
        labelVisibility2(inputHidden: true)
    
        
        timer2 = Timer.scheduledTimer(timeInterval: (0.5), target: self, selector: #selector(updateTimer2Countdown), userInfo: nil, repeats: true)
    }

        @objc func updateTimer2Countdown() {
        Timer2Countdown.text = Timer2.updateTime()
            animInt2 = Timer2.myint
            if animInt2 <= 10{
                anim2()
            }
            if animInt2 < 0{
                timer2View.backgroundColor = timer2color
            }
        }
    
    
    @IBAction func pauseTimer2(_ sender: Any) {
        
             timer2.invalidate()
             Timer2.pauseTimer()
            
            
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [Timer2.timerID])
    }
    
    @IBAction func resetTimer2(_ sender: Any) {
        Timer2.resetTimer()
        Label2Input.text = Timer2.timerID
        timer2.invalidate()
        labelVisibility2(inputHidden: false)
        

        Hour2Input.text = "00"
        Minute2Input.text = "00"
        Seconds2Input.text = "00"
        Timer2Countdown.text = "00:00:00"
        timer2View.backgroundColor = timer2color
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [Timer2.timerID])
    }

//Timer 3
    
    @IBOutlet weak var timer3View: UIView!

    @IBOutlet weak var Label3Input: UITextField!

    @IBOutlet weak var Hour3Input: UITextField!
    
    @IBOutlet weak var Minute3Input: UITextField!
    
    @IBOutlet weak var Seconds3Input: UITextField!

    @IBOutlet weak var Timer3Countdown: UILabel!

    @IBOutlet weak var Start3Button: UIButton!

    @IBOutlet weak var Pause3Button: UIButton!
    
    @IBOutlet weak var Restart3Button: UIButton!
 


    var timer3: Timer = Timer()
    var h3 = 0
    var m3 = 0
    var s3 = 0
    var t3: Int = 0
    var pausedEndTime3 = Date()
    var dateT3 = Date()
    var dateTComponents3 = DateComponents()
    var pausedTimeLeft3 = DateComponents()
    var pausedEventDate3 = Date()
    var animInt3: Int = 0

    let Timer3 = TimerClass()

    func labelVisibility3(inputHidden: Bool){
        if inputHidden{
    Hour3Input.isHidden = true
    Minute3Input.isHidden = true
    Seconds3Input.isHidden = true
    Timer3Countdown.isHidden = false
        }
        else{
            Hour3Input.isHidden = false
            Minute3Input.isHidden = false
            Seconds3Input.isHidden = false
            Timer3Countdown.isHidden = true
        }
    }

    func anim3(){

        UIView.animate(withDuration: 8, delay: 0, options: UIView.AnimationOptions.allowUserInteraction, animations: {self.timer3View.backgroundColor = UIColor(red: 0.90, green: 0.22, blue: 0.27, alpha: 1.0)}, completion: nil)
    }



    
    @IBAction func startTimer3(_ sender: Any) {
    


        h3 = Int(Hour3Input.text ?? "") ?? 0
        m3 = Int(Minute3Input.text ?? "") ?? 0
        s3 = Int(Seconds3Input.text ?? "") ?? 0
        t3 = ((h3*3600) + (m3*60) + s3)


        Timer3.startTimer(t: t3, timerID: Label3Input.text ?? "Timer 3")

        notification(dateComponents: Timer3.notificationComponents, timerID: Timer3.timerID)

        labelVisibility3(inputHidden: true)


        timer3 = Timer.scheduledTimer(timeInterval: (0.5), target: self, selector: #selector(updateTimer3Countdown), userInfo: nil, repeats: true)
    }

        @objc func updateTimer3Countdown() {
        Timer3Countdown.text = Timer3.updateTime()
            animInt3 = Timer3.myint
            if animInt3 <= 10{
                anim3()
            }
            if animInt3 < 0{
                timer3View.backgroundColor = timer3color
            }
        }

    
    
    @IBAction func pauseTimer3(_ sender: Any) {
    
    

             timer3.invalidate()
             Timer3.pauseTimer()


            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [Timer3.timerID])
    }

        
    @IBAction func resetTimer3(_ sender: Any) {
    
        Timer3.resetTimer()
        Label3Input.text = Timer3.timerID
        timer3.invalidate()
        labelVisibility3(inputHidden: false)


        Hour3Input.text = "00"
        Minute3Input.text = "00"
        Seconds3Input.text = "00"
        Timer3Countdown.text = "00:00:00"
        timer3View.backgroundColor = timer3color
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [Timer3.timerID])
    }

    
//Timer 4
    
    
    @IBOutlet weak var timer4View: UIView!
    

    @IBOutlet weak var Label4Input: UITextField!
    
    
    @IBOutlet weak var Hour4Input: UITextField!
    

    @IBOutlet weak var Minute4Input: UITextField!
 
    @IBOutlet weak var Seconds4Input: UITextField!


    @IBOutlet weak var Timer4Countdown: UILabel!

    @IBOutlet weak var Start4Button: UIButton!
    
    @IBOutlet weak var Pause4Button: UIButton!

    @IBOutlet weak var Restart4Button: UIButton!




    var timer4: Timer = Timer()
    var h4 = 0
    var m4 = 0
    var s4 = 0
    var t4: Int = 0
    var pausedEndTime4 = Date()
    var dateT4 = Date()
    var dateTComponents4 = DateComponents()
    var pausedTimeLeft4 = DateComponents()
    var pausedEventDate4 = Date()
    var animInt4: Int = 0

    let Timer4 = TimerClass()

    func labelVisibility4(inputHidden: Bool){
        if inputHidden{
    Hour4Input.isHidden = true
    Minute4Input.isHidden = true
    Seconds4Input.isHidden = true
    Timer4Countdown.isHidden = false
        }
        else{
            Hour4Input.isHidden = false
            Minute4Input.isHidden = false
            Seconds4Input.isHidden = false
            Timer4Countdown.isHidden = true
        }
    }

    func anim4(){

        UIView.animate(withDuration: 8, delay: 0, options: UIView.AnimationOptions.allowUserInteraction, animations: {self.timer4View.backgroundColor = UIColor(red: 0.90, green: 0.22, blue: 0.27, alpha: 1.0)}, completion: nil)
    }




    @IBAction func startTimer4(_ sender: Any) {
    



        h4 = Int(Hour4Input.text ?? "") ?? 0
        m4 = Int(Minute4Input.text ?? "") ?? 0
        s4 = Int(Seconds4Input.text ?? "") ?? 0
        t4 = ((h4*3600) + (m4*60) + s4)


        Timer4.startTimer(t: t4, timerID: Label4Input.text ?? "Timer 4")

        notification(dateComponents: Timer4.notificationComponents, timerID: Timer4.timerID)

        labelVisibility4(inputHidden: true)


        timer4 = Timer.scheduledTimer(timeInterval: (0.5), target: self, selector: #selector(updateTimer4Countdown), userInfo: nil, repeats: true)
    }

        @objc func updateTimer4Countdown() {
        Timer4Countdown.text = Timer4.updateTime()
            animInt4 = Timer4.myint
            if animInt4 <= 10{
                anim4()
            }
            if animInt4 < 0{
                timer4View.backgroundColor = timer4color
            }
        }


    @IBAction func pauseTimer4(_ sender: Any) {
    

             timer4.invalidate()
             Timer4.pauseTimer()


            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [Timer4.timerID])
    }


    @IBAction func resetTimer4(_ sender: Any) {


        Timer4.resetTimer()
        Label4Input.text = Timer4.timerID
        timer4.invalidate()
        labelVisibility4(inputHidden: false)


        Hour4Input.text = "00"
        Minute4Input.text = "00"
        Seconds4Input.text = "00"
        Timer4Countdown.text = "00:00:00"
        timer4View.backgroundColor = timer4color
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [Timer4.timerID])
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

    


