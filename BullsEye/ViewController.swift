//
//  ViewController.swift
//  BullsEye
//
//  Created by Jessie on 14-12-15.
//  Copyright (c) 2014年 Jessie. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score = 0
    var round = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        //startNewRound()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        
        let thumbImageHighLighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageNormal, forState: .Highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage?.resizableImageWithCapInsets(insets)
        slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")
        let trackRightResizable = trackRightImage?.resizableImageWithCapInsets(insets)
        slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        
        startNewGame()
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func shouAlert() {
        let difference = abs(targetValue - currentValue)
        let points = 100 - difference
        score += points
        
        var title: String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference < 10 {
            title = "Pretty Good!"
        } else {
            title = "Not Even Close..."
        }
        
        let message = "The value of the slider is: \(currentValue)" + "\nThe target value is: \(targetValue)" + "\nThe difference if \(difference)" + "\nYou scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "OK", style: .Default, handler: { action in
                                                                            self.startNewRound()
                                                                            self.updateLabels()
                                                                          })
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
        
        //startNewRound()
        //updateLabels()
    }
    
    @IBAction func sliderMoved(slider: UISlider) {
        //println("The value of the slider is now: \(slider.value)")
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.addAnimation(transition, forKey: nil)
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
}

