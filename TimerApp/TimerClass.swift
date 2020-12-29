//
//  TimerClass.swift
//  TimerApp
//
//  Created by Josh Kraskin on 12/25/20.
//

import Foundation
import UIKit
import UserNotifications

class TimerClass {
    var timer: Timer = Timer()
    var h = 0
    var m = 0
    var s = 0
    var t: Int = 0
    var timerCounting: Bool = false
    var isPaused: Bool = false
    var notificationComponents = DateComponents()
    var pausedEndTime = Date()
    var dateT = Date()
    var dateTComponents = DateComponents()
    var pausedDateComponents = DateComponents()
    var pausedTimeLeft = DateComponents()
    var timeLeft = DateComponents()
    var pausedEventDate = Date()
    var timerID = ""
    var myint: Int = 0
    
    
    
    init(){
    }
    
    func pauseTimer(){
            timer.invalidate()
            timerCounting = false
            isPaused = true
            pausedTimeLeft = timeLeft
    }
    
    func resetTimer(){
        t = 0
        self.timerID = "Timer 1"
        isPaused = false
        timerCounting = false
        timer.invalidate()
    }
    
    func startTimer(t: Int, timerID: String){
        
        self.t = t
        self.timerID = timerID
        
        
        if(self.timerCounting){
            self.timerCounting = false
            timer.invalidate()

        }
        
        else{
            self.timerCounting = true
            self.timer = Timer.scheduledTimer(timeInterval: (0.5), target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)

            
        }
  
        
        if isPaused == false {
        
            dateT = Date().addingTimeInterval(Double(t))
            dateTComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateT)
            notificationComponents = dateTComponents
            
        }
       
        if isPaused == true {
        
        pausedEventDate = Calendar.current.date(byAdding: pausedTimeLeft, to: Date())!
        pausedDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: pausedEventDate)
            notificationComponents = pausedDateComponents

        }
        
        
    }
    
    
    @objc func updateTime() -> String {
        
        var updatingTime: String
        
        if isPaused == false {
        
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
                //print(timeLeft)

                // Display Countdown
               
            let hours = Int(timeLeft.hour!)
            let minutes = Int(timeLeft.minute!)
            let seconds = Int(timeLeft.second!)
        
            let timeInterval1 = eventDate.timeIntervalSince1970
            let timeInterval2 = currentDate.timeIntervalSince1970
            myint = Int(timeInterval1) - Int(timeInterval2)
            
            
            updatingTime = String(format:"%02d:%02d:%02d", hours, minutes, seconds)
            
            if currentDate >= eventDate {
                resetTimer()
                timer.invalidate()
                updatingTime = String(format:"%02d:%02d:%02d", 0, 0, 0)
            }
            
            return updatingTime
            
    }
        if isPaused == true {

            let userCalendar = Calendar.current
                    // Set Current Date
                    let date = Date()
                    let components = userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: date)
                    let currentDate = userCalendar.date(from: components)!
                    //print(currentDate)
            
                    // Convert eventDateComponents to the user's calendar
                    //using pausedEventDate set in starTimer function
            
                    
                    // Change the seconds to days, hours, minutes and seconds
            timeLeft = userCalendar.dateComponents([.hour, .minute, .second], from: currentDate, to: pausedEventDate)
                    //print(timeLeft)
                    
                    // Display Countdown
                let hours = Int(timeLeft.hour!)
                let minutes = Int(timeLeft.minute!)
                let seconds = Int(timeLeft.second!)
            
            let timeInterval1 = pausedEventDate.timeIntervalSince1970
            let timeInterval2 = currentDate.timeIntervalSince1970
            myint = Int(timeInterval1) - Int(timeInterval2)
            print(myint)

            
            updatingTime = String(format:"%02d:%02d:%02d", hours, minutes, seconds)
            
        if currentDate >= pausedEventDate {
            updatingTime = String(format:"%02d:%02d:%02d", 0, 0, 0)
            resetTimer()
            timer.invalidate()
        }
            return updatingTime

        }

        return updateTime()}
}
