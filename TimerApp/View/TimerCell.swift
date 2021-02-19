//
//  TimerCell.swift
//  TimerApp
//
//  Created by Josh Kraskin on 1/6/21.
//

import UIKit
import UserNotifications
import AVFoundation

protocol TimerCellProtocol: AnyObject {
    func startTimer(index: Int, t: Int, labelName: String)
    func pauseTimer(index: Int)
    func resetTimer(index: Int)
    func showAlert(index: Int)
    //    func showActionSheet(index: Int, t: Int, name: String)
}


class TimerCell: UITableViewCell, UNUserNotificationCenterDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    func allTimers() {
        print("delegate All Timers successful")
    }
    
    weak var delegate: TimerCellProtocol?
    
    var audioPlayer: AVAudioPlayer!
    
    
    var timer: Timer = Timer()
    
    var cellIndex = ""
    var indexP: Int = 0
    
    var h = 0
    var m = 0
    var s = 0
    var t: Int = 0
    
    var timerName = ""
    var notificationID = ""
    var notificaitonCellID = ""
    
//    var cellIsRunning = false
    
    //    let newTimer = TimerClass()
    var timers: [TimerClass] = []
    
    var secondsArray = Array(0...59)
    var minutesArray = Array(0...59)
    var hoursArray = Array(0...23)
    var pickerTotal = 0
    
    let playSymbol = UIImage(systemName: "play.circle.fill")
    let pauseSymbol = UIImage(systemName: "pause.circle.fill")
    
    //picker code
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return hoursArray.count
        }
        
        if component == 1 {
            return minutesArray.count
        }
        
        return secondsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attributedString: NSAttributedString!
        if component == 0 {
            attributedString = NSAttributedString(string: String(hoursArray[row]) + " h", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        if component == 1 {
            attributedString = NSAttributedString(string: String(minutesArray[row]) + " m", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            
        }
        if component == 2 {
            attributedString = NSAttributedString(string: String(secondsArray[row]) + " s", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            
        }
        return attributedString
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            h = hoursArray[row]
            timers[indexP].inputH = h
        }
        
        if component == 1 {
            m = minutesArray[row]
            timers[indexP].inputM = m
        }
        if component == 2 {
            s = secondsArray[row]
            timers[indexP].inputS = s
        }
        
//        pickerTotal = hoursArray[row] + minutesArray[row] + secondsArray[row]
        pickerTotal = h + m + s
        timers[indexP].inputT = ((h*3600) + (m*60) + s)
        
        if timers[indexP].isRunning == false {
        if pickerTotal == 0 {
            startPauseButton.isEnabled = false
        }
        else {
            startPauseButton.isEnabled = true
            
//            let pulse = CASpringAnimation(keyPath: "transform.scale")
//             pulse.duration = 30
//             pulse.fromValue = 1
//             pulse.toValue = 1.2
//            pulse.timingFunction = CAMediaTimingFunction(name:.easeInEaseOut)
//             pulse.autoreverses = true
//             pulse.repeatCount = .infinity
//             pulse.initialVelocity = 0.5
//             pulse.damping = 0.5
//             startPauseButton.layer.add(pulse, forKey: nil)
            
        }
        }
    }
    
    func pickerReset() {
        secondsPicker.selectRow(0, inComponent: 0, animated: false)
        secondsPicker.selectRow(0, inComponent: 1, animated: false)
        secondsPicker.selectRow(0, inComponent: 2, animated: false)
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if component == 0 {
                h = hoursArray[0]
            }
            
            if component == 1 {
                m = minutesArray[0]
            }
            if component == 2 {
                s = secondsArray[0]
            }
            
        }
        
    }
    
    //Notification set up
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
    
    func cancelNotification(){
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [timers[indexP].id])
    }
    
    
    
    @IBOutlet weak var timerLabel: UITextField!
    
    @IBOutlet weak var hourInput: UITextField!
    
    @IBOutlet weak var minuteInput: UITextField!
    
    @IBOutlet weak var secondInput: UITextField!
    
    @IBOutlet weak var countdownLabel: UILabel!
    
    @IBOutlet weak var startPauseButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var secondsPicker: UIPickerView!
    
    func invokeTimer() {
        timer = Timer.scheduledTimer(timeInterval: (0.5), target: self, selector: #selector(updateTimerCountdown), userInfo: nil, repeats: true)
    }
    
    func defaultState(){
        secondsPicker.isHidden = false
        countdownLabel.isHidden = true
        resetButton.isEnabled = false
        
        
        startPauseButton.setImage(UIImage(named: "playbutton"), for: .normal)
        startPauseButton.tintColor = UIColor.systemGreen
        pickerReset()
        h = 0
        m = 0
        s = 0
        pickerTotal = 0
        
        if pickerTotal == 0 {
            startPauseButton.isEnabled = false
        }
        else{
            startPauseButton.isEnabled = true
        }
    }
    
    @IBAction func resetButton(_ sender: UIButton?) {
        
        secondsPicker.isHidden = false
        countdownLabel.isHidden = true
//        cellIsRunning = false
        //        pauseButton.isEnabled = false
        
        startPauseButton.setImage(UIImage(named: "playbutton"), for: .normal)
        startPauseButton.tintColor = UIColor.systemGreen
        
        startPauseButton.isEnabled = true
        timers[indexP].resetTimer()
        
        timer.invalidate()
        
        cancelNotification()
//        let center = UNUserNotificationCenter.current()
//        center.removePendingNotificationRequests(withIdentifiers: [cellIndex])
        
        defaultState()
        
        
    }
    
    
    @IBAction func startButton(_ sender: Any) {
        
        if timers[indexP].isRunning == false && timers[indexP].isPaused == false {
            
            print("is Running FALSE and is PAUSED FALSE")
            
            
            
            startPauseButton.setImage(UIImage(named: "pausebutton"), for: .normal)
            startPauseButton.tintColor = UIColor.systemRed
            
            resetButton.isEnabled = false
            secondsPicker.isHidden = true
            countdownLabel.isHidden = false
            
            //        pauseButton.isEnabled = true
            //            cellIsRunning = true
            
            t = ((h*3600) + (m*60) + s)
            
            timerName = timerLabel.text!
            
            delegate?.startTimer(index: indexP, t: t, labelName: timerName)
            
            timers[indexP].startTimer(t: t, labelName: timerName)
            
            
            notification(dateComponents: timers[indexP].notificationComponents, timerID: timers[indexP].timerID, notificationID: timers[indexP].id)
            
//            notification(dateComponents: timers[indexP].notificationComponents, timerID: timers[indexP].timerID, notificationID: cellIndex)
            
            invokeTimer()
        }
        
        else if timers[indexP].isRunning == true && timers[indexP].isPaused == true {
            
            
            startPauseButton.setImage(UIImage(named: "pausebutton"), for: .normal)
            startPauseButton.tintColor = UIColor.systemRed
            
            resetButton.isEnabled = false
            secondsPicker.isHidden = true
            countdownLabel.isHidden = false
            
            
            t = ((h*3600) + (m*60) + s)
            
            timerName = timerLabel.text!
            
            delegate?.startTimer(index: indexP, t: t, labelName: timerName)
            
            timers[indexP].startTimer(t: t, labelName: timerName)
            
            notification(dateComponents: timers[indexP].notificationComponents, timerID: timers[indexP].timerID, notificationID: timers[indexP].id)
            
//            notification(dateComponents: timers[indexP].notificationComponents, timerID: timers[indexP].timerID, notificationID: cellIndex)
            
            invokeTimer()
        }
        
        else if timers[indexP].isRunning == true && timers[indexP].isPaused == false {
            print("is RUNNING TRUE and is PAUSED FALSE")
            startPauseButton.setImage(UIImage(named: "playbutton"), for: .normal)
            startPauseButton.tintColor = UIColor.systemGreen
            
            delegate?.pauseTimer(index: indexP)
            
            resetButton.isEnabled = true
            secondsPicker.isHidden = true
            countdownLabel.isHidden = false
            //            cellIsRunning = false
            
            timer.invalidate()
            timers[indexP].pauseTimer()
            
            cancelNotification()
//            let center = UNUserNotificationCenter.current()
//            center.removePendingNotificationRequests(withIdentifiers: [cellIndex])
            
        }
        
        else if timers[indexP].isRunning == false && timers[indexP].isPaused == true {
            
            startPauseButton.setImage(UIImage(named: "pausebutton"), for: .normal)
            startPauseButton.tintColor = UIColor.systemRed
            
            resetButton.isEnabled = false
            secondsPicker.isHidden = true
            countdownLabel.isHidden = false
            
            
            t = ((h*3600) + (m*60) + s)
            
            timerName = timerLabel.text!
            
            delegate?.startTimer(index: indexP, t: t, labelName: timerName)
            timers[indexP].startTimer(t: t, labelName: timerName)
            
            
            notification(dateComponents: timers[indexP].notificationComponents, timerID: timers[indexP].timerID, notificationID: timers[indexP].id)
            
//            notification(dateComponents: timers[indexP].notificationComponents, timerID: timers[indexP].timerID, notificationID: cellIndex)
            
            invokeTimer()
            
        }
        
        
    }
    
    @objc func updateTimerCountdown() {
        
        if timers[indexP].isRunning == true && timers[indexP].isPaused == false {
            countdownLabel.text = timers[indexP].updateTime()
            
            if timers[indexP].timeLeftInt == 0{
                
                //            timers[indexP].playSound()
                startPauseButton.setImage(UIImage(named: "playbutton"), for: .normal)
                startPauseButton.tintColor = UIColor.systemGreen
                defaultState()
                timers[indexP].resetTimer()
                
                
                timer.invalidate()
                delegate?.showAlert(index: indexP)
            }
        }
    }
    
    func configure(CellIndex: String) {
        
        print("Configure Cell")
        //        timerLabel.text = timers[indexP].timerName
        secondsPicker.dataSource = self
        secondsPicker.delegate = self
        timerLabel.delegate = self
        cardView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cardView.layer.masksToBounds = false
        cardView.layer.shadowOpacity = 1.0
        cardView.layer.cornerRadius = 8.0
        
        
        
//        startPauseButton.layer.shadowRadius = 0
       
        
    }
    
    func setTimerCell (timer: TimerClass){
        
        print("set Timer Cell")
        for timer in timers{
            print("\(timer.timerName) is Running:\(timer.isRunning) is Paused: \(timer.isPaused) inputT \(timer.inputT)")
        }
        
        
        
        timerLabel.text = timer.timerID
        
        
        if timer.isRunning == false && timer.isPaused == false {
            //            countdownLabel.text = timer.updateTime()
            countdownLabel.isHidden = true
            secondsPicker.isHidden = false
            startPauseButton.setImage(UIImage(named: "playbutton"), for: .normal)
            startPauseButton.tintColor = UIColor.systemGreen
            
            timerLabel.text = timer.timerName
            
            if timer.inputT == 0{
            defaultState()
            }
            else if timer.inputT > 0{
                let hrow = timer.inputH
                let mrow = timer.inputM
                let srow = timer.inputS
                secondsPicker.selectRow(hrow, inComponent: 0, animated: false)
                secondsPicker.selectRow(mrow, inComponent: 1, animated: false)
                secondsPicker.selectRow(srow, inComponent: 2, animated: false)
                
                
            }
        }
        
        else if timer.isRunning == false && timer.isPaused == true {
            
            countdownLabel.isHidden = false
            secondsPicker.isHidden = true
            startPauseButton.setImage(UIImage(named: "playbutton"), for: .normal)
            startPauseButton.tintColor = UIColor.systemGreen
            
            startPauseButton.isEnabled = true
            
            timerLabel.text = timer.timerName
        }
        
        else if timer.isRunning == true && timer.isPaused == false {
            invokeTimer()
            countdownLabel.isHidden = false
            secondsPicker.isHidden = true
            startPauseButton.setImage(UIImage(named: "pausebutton"), for: .normal)
            startPauseButton.tintColor = UIColor.systemRed
            startPauseButton.isEnabled = true
            
            timerLabel.text = timer.timerName
        }
        
        else if timer.isRunning == true && timer.isPaused == true {
            
            countdownLabel.text = timer.timeLeftString
            timer.pauseTimer()
            timer.timer.invalidate()
            
            countdownLabel.isHidden = false
            secondsPicker.isHidden = true
            startPauseButton.setImage(UIImage(named: "playbutton"), for: .normal)
            startPauseButton.tintColor = UIColor.systemGreen
            startPauseButton.isEnabled = true
            
            timerLabel.text = timer.timerName
        }
        
        
        
    }
    
    
}

extension TimerCell {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
}











