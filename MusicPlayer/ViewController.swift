//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Nhật Minh on 11/23/16.
//  Copyright © 2016 Nhật Minh. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var audio = AVAudioPlayer()
    
    var playing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: ".mp3")!) as URL)
        
        audio.prepareToPlay()
        
        audio.currentTime = 0
        
        addThumbImgForSlider()
        
        playandpause()
        
        audio.numberOfLoops = -1
        
        audio.delegate = self
        
        duration_sld.maximumValue = Float(audio.duration)
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimeLeft), userInfo: nil, repeats: true)
        
        convertTime(Float(audio.duration), self.timetotal_lbl)
        
    }
    @IBOutlet weak var duration_sld: UISlider!
    
    @IBOutlet weak var timetotal_lbl: UILabel!
    
    @IBOutlet weak var timeplayed_lbl: UILabel!
    
    @IBOutlet weak var play_btn: UIButton!
    
    @IBOutlet weak var volume_sld: UISlider!
    
    @IBAction func play_action(_ sender: UIButton)
    {
        
        playandpause()
        
    }
    @IBAction func duration_action(_ sender: UISlider)
    {
        audio.stop()
        
        duration_sld.isContinuous = true
        
        audio.currentTime = TimeInterval(duration_sld.value)
        
        play_btn.setImage(UIImage(named: "pause.png"), for: .normal)
        
        playing = true
        
        audio.prepareToPlay()
        
        audio.play()
    }
    
    @IBAction func volume_action(_ sender: UISlider)
    {
        
        audio.volume = sender.value
        
    }
    
    @IBAction func repeat_action(_ sender: UISwitch)
    {
        
        if sender.isOn
        {
            audio.numberOfLoops = -1
        }
        else
        {
            audio.numberOfLoops = 0
        }
    }
    
    
    func updateSlider()
    {
        duration_sld.value = Float(audio.currentTime)
    }
    
    func convertTime(_ time: Float,_ lbl: UILabel)
    {
        
        let phut: Int = Int(time / 60)
        let giay: Int = Int(time.truncatingRemainder(dividingBy: 60))
        
        if (phut < 10 && giay < 10)
        {
            lbl.text = "0\(phut):0\(giay)"
        }
        else
        {
            if giay < 10
            {
                lbl.text = "\(phut):0\(giay)"
            }
            else if phut < 10
            {
                lbl.text = "0\(phut):\(giay)"
            }
            else
            {
                lbl.text = "\(phut):\(giay)"
            }
        }
        
    }
    
    func updateTimeLeft()
    {
        
        convertTime(Float(audio.currentTime),timeplayed_lbl)
        
    }
    
    func playandpause()
    {
        playing = !playing
        
        if playing
        {
            audio.play()
            play_btn.setImage(UIImage(named: "pause.png"), for: .normal)
        }
        else
        {
            audio.pause()
            play_btn.setImage(UIImage(named: "play.png"), for: .normal)
        }
        
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
        
        
        play_btn.setImage(UIImage(named: "play.png"), for: .normal)
        playing = !playing
        
        
    }
    
    func addThumbImgForSlider()
    {
        
        duration_sld.setThumbImage(UIImage(named: "duration.png"), for: .normal)
        
        volume_sld.setThumbImage(UIImage(named: "thumb.png"), for: .normal)
        
        volume_sld.setThumbImage(UIImage(named: "thumbHightLight.png"), for: .highlighted)
        
    }
}

