//
//  TimerClass.swift
//  TimerApp
//
//  Created by Josh Kraskin on 1/12/21.
//

import UIKit
//import AVFoundation

class TimerClass {
    
    
    var timer: Timer = Timer()
//    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    var timerName: String
    var id: String
    var defaultName: String
    
    var inputH = 0
    var inputM = 0
    var inputS = 0
    var inputT = 0
    
    var t: Int = 0
    

//    var startTimeComponents = DateComponents()
    
//    var pausedTimeStamp = Date()
//    var pausedTimeComponents = DateComponents()
    
    
    var isPaused: Bool = false
    var isRunning: Bool = false
    
    var notificationComponents = DateComponents()
//    var pausedEndTime = Date()
    var dateT = Date()
    var dateTComponents = DateComponents()
//    var pausedDateComponents = DateComponents()
//    var pausedTimeLeft = DateComponents()
    var timeLeft = DateComponents()
//    var pausedEventDate = Date()
    
    var timerID = ""
    var notificationID = ""
    
    
    var timeLeftInt: Int = 0
    var timeLeftString = "00:00:00"
    
    
    
//    let sound = Bundle.main.path(forResource: "digitalbells", ofType: "wav")
//    var audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
//    var audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
    
    
    init(timerName: String, id: String){
        self.timerName = timerName
        self.id = id
        self.defaultName = timerName
    }
    
//    func playSound() {
//        print("playSound")
//        if let soundURL = Bundle.main.url(forResource: "digitalbells", withExtension: "wav") {
//
//            do {
//                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
//            }
//            catch {
//                print(error)
//            }
//
//            audioPlayer.play()
//        } else{
//            print("Unable to locate audio file")
//        }
//    }
    
    
    func pauseTimer(){
        
        timer.invalidate()
//        let pauset = ((timeLeft.hour! * 3600) + (timeLeft.minute!*60) + timeLeft.second!)
//        print(pauset)
        print("Timer Class PAUSED")
//        timer.invalidate()
//        isRunning = false
        isPaused = true
//        pausedTimeLeft = timeLeft
    }
    
    func resetTimer(){
        
//        print("\(self.timerName) ")
//        audioPlayer.stop()
        self.t = 0
        inputT = 0
        isPaused = false
        isRunning = false
        timerName = defaultName
        timer.invalidate()
        timeLeftString = "00:00:00"
        //print("Time Reset")
        print("\(self.timerName) RESET with t = \(self.t) ")
        
    }
    
    func timeExpired(){
//        print("Timer Class TIME EXPIRED")
        if isRunning == true{
            //print("Time Expired")
        
        timer.invalidate()
        isPaused = false
        isRunning = false
//        resetTimer()
        //Add alert code
        //print("Time Expired")
        
    }
    }
    
    func startTimer(t: Int, labelName: String){
//        print("Timer Class STARTED")
        self.t = t
        self.timerID = labelName
        self.timerName = labelName
        
        isRunning = true
        
        timer = Timer.scheduledTimer(timeInterval: (0.5), target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)

//        if(isRunning){
//
//            isRunning = false
//            timer.invalidate()
//
//
//        }
//
//       else{
//        isRunning = true
//        timer = Timer.scheduledTimer(timeInterval: (0.5), target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
//
//
//
//        }
        
        if isPaused == false {
            
            print(self.t)
            dateT = Date().addingTimeInterval(Double(self.t))
            dateTComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateT)
            notificationComponents = dateTComponents
   
        }
        
        if isPaused == true {
            
            self.t = ((timeLeft.hour! * 3600) + (timeLeft.minute!*60) + timeLeft.second!)
            print(self.t)
            dateT = Date().addingTimeInterval(Double(self.t))
            dateTComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateT)
            notificationComponents = dateTComponents
            
        }

        isPaused = false
        
    }
    
    @objc func updateTime() -> String {
        
        var updatingTime: String
        
        let userCalendar = Calendar.current
        // Set Current Date
        let date = Date()
        let components = userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: date)
        let currentDate = userCalendar.date(from: components)!
        //print(currentDate)
        
        // Convert eventDateComponents to the user's calendar
        let eventDate = userCalendar.date(from: dateTComponents as DateComponents)!
        
        
        // Change the seconds to days, hours, minutes and seconds
        timeLeft = userCalendar.dateComponents([.hour, .minute, .second, .month, .day], from: currentDate, to: eventDate)
        
        // Display Countdown
        
        let hours = Int(timeLeft.hour!)
        let minutes = Int(timeLeft.minute!)
        let seconds = Int(timeLeft.second!)
        
        
        updatingTime = String(format:"%02d:%02d:%02d", hours, minutes, seconds)
       
        timeLeftString = updatingTime
        
        timeLeftInt = ((timeLeft.hour! * 3600) + (timeLeft.minute!*60) + timeLeft.second!)
        
        
        
        print(timeLeftInt)
        
        if currentDate >= eventDate {
            
//                timeExpired()
            
//          resetTimer()
            print("\(self.timerName) timer expired")

            updatingTime = String(format:"%02d:%02d:%02d", 0, 0, 0)
//            isRunning = false
//            isPaused = false
        }
        
        return updatingTime
    
        
    }

}
