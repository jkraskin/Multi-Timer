//
//  ViewController.swift
//  TimerApp
//
//  Created by Josh Kraskin on 12/19/20.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var labelInput: UITextField!
    
    @IBOutlet weak var hourInput: UITextField!
    
    @IBOutlet weak var minuteInput: UITextField!
    
    @IBOutlet weak var secondInput: UITextField!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var timerCountdown: UILabel!
    
    var timer: Timer = Timer()
    var t: Int = 0
    var timerCounting: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startTimer(_ sender: Any) {
        let h = Int(hourInput.text!)!
        let m = Int(minuteInput.text!)!
        let s = Int(secondInput.text!)!
        
    
        t = ((h*3600) + (m*60) + s)
  
        timerLabel.text = labelInput.text
        
        if(timerCounting){
            timerCounting = false
            timer.invalidate()
        }
        
        else{
            timerCounting = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerCounter() -> Void
    {
        if t > -1 {
            
        let time = convertSeconds(seconds: t)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
            timerCountdown.text = timeString
        
            t = t-1}
        
        else {
            timer.invalidate()
        }
    }
       
    
    //print(makeTimeString(hours: time.0, minutes: time.1, seconds: time.2))
    
    
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
        t = t+0
    }
    @IBAction func resetTimer(_ sender: Any) {
        self.t = 0
        self.timer.invalidate()
        self.timerCountdown.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
    }
}

    
    

    


