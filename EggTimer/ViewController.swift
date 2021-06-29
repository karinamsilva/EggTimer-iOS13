//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var progress: UIProgressView!
    
    
    let eggTimes = ["Soft":300, "Medium": 420, "Hard": 720 ]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var alert : AVAudioPlayer!
    
    
   
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        
        guard let title = sender.currentTitle else {return}
        guard let eggTime = eggTimes[title] else {return }
      totalTime = eggTime
        
        progress.progress = 0
        secondsPassed = 0
        label.text = title
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)

    }
    
    func play() {
        let sound = Bundle.main.path(forResource: "alarm_sound.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: sound)
        do{
            alert = try AVAudioPlayer(contentsOf: url)
            alert.play()
        }catch{
            print("error")
        }
        
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progress.progress = Float(secondsPassed) / Float( totalTime)
           
            
            
        }
       else {
        timer.invalidate()
        play()
        label.text = "Done"
        
        
            
        }
    }
}
