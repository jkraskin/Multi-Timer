////
////  TimerCell.swift
////  TimerApp
////
////  Created by Josh Kraskin on 1/6/21.
////
//
//import UIKit
//
//class TimerCell2: UITableViewCell {
//    
//    @IBOutlet weak var timerLabel: UITextField!
//    
//    @IBOutlet weak var hourInput: UITextField!
//    
//    @IBOutlet weak var minuteInput: UITextField!
//    
//    @IBOutlet weak var secondInput: UITextField!
//    
//    @IBOutlet weak var countdownLabel: UILabel!
//    
//    @IBOutlet weak var startPauseButton: UIButton!
//    
//    @IBOutlet weak var pauseButton: UIButton!
//    
//    @IBOutlet weak var resetButton: UIButton!
//    
//    @IBOutlet weak var cardView: UIView!
//    
//    var timer: Timer = Timer()
//    var isRunning = false
//    var isPaused = false
//    
//    
//    var h = 0
//    var m = 0
//    var s = 0
//    var t: Int = 0
//    
//    var timerName = ""
//    var startTime = Date()
//    var endTime = Date()
//    var endTimeComponents = DateComponents()
//    
//    var pausedEndTime = Date()
//    var pausedTimeLeft = DateComponents()
//    var pausedTimeComponents = DateComponents()
//    var timeLeft = DateComponents()
//    
//    
//    
//    func configure() {
//        
//        cardView.backgroundColor = UIColor.white
//        cardView.layer.shadowColor = UIColor.gray.cgColor
//        cardView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//        cardView.layer.masksToBounds = false
//        cardView.layer.shadowOpacity = 1.0
//        cardView.layer.cornerRadius = 8.0
//        
//    }
//    
//    func resetTimer(){
//        t = 0
//        isPaused = false
//        isRunning = false
//        timer.invalidate()
//        
//    }
//    
//    @IBAction func pauseButton(_ sender: UIButton) {
//        
//        
//        timer.invalidate()
//        //isRunning = false
//        isPaused = true
//        pausedTimeLeft = timeLeft
//        
//        print(isRunning)
//        print(isPaused)
//        
//        
//        
//        
//        //        let center = UNUserNotificationCenter.current()
//        //        center.removePendingNotificationRequests(withIdentifiers: [Timer1.timerID])
//    }
//    @IBAction func resetButton(_ sender: Any) {
//        t = 0
//        isPaused = false
//        isRunning = false
//        timer.invalidate()
//        
//        hourInput.text = "00"
//        minuteInput.text = "00"
//        secondInput.text = "00"
//        countdownLabel.text = "00:00:00"
//    }
//    
//    @IBAction func startButton(_ sender: Any) {
//        
//        
//        print(isRunning)
//        print(isPaused)
//        
//        h = Int(hourInput.text ?? "") ?? 0
//        m = Int(minuteInput.text ?? "") ?? 0
//        s = Int(secondInput.text ?? "") ?? 0
//        t = ((h*3600) + (m*60) + s)
//        
//        timerName = countdownLabel.text!
//        
//        
//        
//        
//        
//        if isRunning == false{
//            
//            determinePause(isPaused: isPaused)
//            isRunning = true
//            startTimer()
//           
//        }
//        
//        
//        
//        else {
//            
//            isRunning = false
//            timer.invalidate()
//        }
//        
//        
//        if isPaused == false{
//            endTime = startTime.addingTimeInterval(Double(t))
//            endTimeComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: endTime)
//        }
//        
//        
//        if isPaused == true{
//            pausedEndTime = Calendar.current.date(byAdding: pausedTimeLeft, to: Date())!
//            pausedTimeComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: pausedEndTime)
//            //notificationComponents = pausedDateComponents
//            print("Condition Accessed")
//            //startTimer()
//            
//        }
//    }
//
//        
//        
//        
//        func startTimer(){
//            timer = Timer.scheduledTimer(timeInterval: (0.5), target: self, selector: #selector(updateTimerCountdown), userInfo: nil, repeats: true)
//        }
//        
//    
//    @objc func updateTimerCountdown() {
//        
//        var updatingTime = ""
//        
//        if isPaused == false{
//            
//            let userCalendar = Calendar.current
//            // Set Current Date
//            let date = Date()
//            let components = userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: date)
//            let currentDate = userCalendar.date(from: components)!
//            //print(currentDate)
//            
//            // Convert eventDateComponents to the user's calendar
//            let eventDate = userCalendar.date(from: endTimeComponents as DateComponents)!
//            
//            
//            // Change the seconds to days, hours, minutes and seconds
//            let timeLeft = userCalendar.dateComponents([.hour, .minute, .second, .month, .day], from: currentDate, to: eventDate)
//            //print(timeLeft)
//            
//            // Display Countdown
//            
//            let hours = Int(timeLeft.hour!)
//            let minutes = Int(timeLeft.minute!)
//            let seconds = Int(timeLeft.second!)
//            
//            
//            updatingTime = String(format:"%02d:%02d:%02d", hours, minutes, seconds)
//            countdownLabel.text = updatingTime
//            print(updatingTime)
//            
//            if currentDate >= eventDate {
//                resetTimer()
//                timer.invalidate()
//                updatingTime = String(format:"%02d:%02d:%02d", 0, 0, 0)
//            }
//        }
//        if isPaused == true {
//            
//            let userCalendar = Calendar.current
//            // Set Current Date
//            let date = Date()
//            let components = userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: date)
//            let currentDate = userCalendar.date(from: components)!
//            //print(currentDate)
//            
//            // Convert eventDateComponents to the user's calendar
//            //using pausedEventDate set in starTimer function
//            
//            
//            // Change the seconds to days, hours, minutes and seconds
//            timeLeft = userCalendar.dateComponents([.hour, .minute, .second], from: currentDate, to: pausedEndTime)
//            //print(timeLeft)
//            
//            // Display Countdown
//            let hours = Int(timeLeft.hour!)
//            let minutes = Int(timeLeft.minute!)
//            let seconds = Int(timeLeft.second!)
//            
//            //                let timeInterval1 = pausedEventDate.timeIntervalSince1970
//            //                let timeInterval2 = currentDate.timeIntervalSince1970
//            //                myint = Int(timeInterval1) - Int(timeInterval2)
//            //                print(myint)
//            
//            
//            updatingTime = String(format:"%02d:%02d:%02d", hours, minutes, seconds)
//            
//            if currentDate >= pausedEndTime {
//                updatingTime = String(format:"%02d:%02d:%02d", 0, 0, 0)
//                resetTimer()
//                timer.invalidate()
//            }
//            
//        }
//        
//        
//        
//        
//    }
//    
//    func determinePause(isPaused: Bool){
//        if isPaused == true{
//            pausedEndTime = Calendar.current.date(byAdding: pausedTimeLeft, to: Date())!
//            pausedTimeComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: pausedEndTime)
//            //notificationComponents = pausedDateComponents
//            print("Condition Accessed")
//            startTimer()
//            
//        
//        }
//    }
//    
//}
//
//
//
//
//
//
//
