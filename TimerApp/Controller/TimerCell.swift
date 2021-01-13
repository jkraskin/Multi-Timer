//
//  TimerCell.swift
//  TimerApp
//
//  Created by Josh Kraskin on 1/6/21.
//

import UIKit

class TimerCell: UITableViewCell {
    
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
    var timerName: String = ""
    let timer1 = TimerClass()
    
    
    func configure() {
        
        cardView.backgroundColor = UIColor.white
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cardView.layer.masksToBounds = false 
        cardView.layer.shadowOpacity = 1.0
        cardView.layer.cornerRadius = 8.0
        
    }
    
    
    
    @IBAction func startStopPress(_ sender: Any) {
        let h = Int(hourInput.text ?? "") ?? 0
        let m = Int(minuteInput.text ?? "") ?? 0
        let s = Int(secondInput.text ?? "") ?? 0
        let t = ((h*3600) + (m*60) + s)
        print(timer1.isRunning)
        print(timer1.isPaused)
        
            timer1.startTimer(t:t, labelName: timerLabel.text!)
        
    
        timer = Timer.scheduledTimer(timeInterval: (0.5), target: self, selector: #selector(updateTimerCountdown), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimerCountdown() {
        countdownLabel.text = timer1.updateTime()
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        
        timer1.timer.invalidate()
        timer.invalidate()
        timer1.pauseTimer()
        
    
//        let center = UNUserNotificationCenter.current()
//        center.removePendingNotificationRequests(withIdentifiers: [Timer1.timerID])
    }
    @IBAction func resetButton(_ sender: Any) {
        timer1.resetTimer()
        //Label1Input.text = timer1.timerID
        timer.invalidate()
        timer1.timer.invalidate()
        //labelVisibility(inputHidden: false)
        
        hourInput.text = "00"
        minuteInput.text = "00"
        secondInput.text = "00"
        countdownLabel.text = "00:00:00"
    }
}






