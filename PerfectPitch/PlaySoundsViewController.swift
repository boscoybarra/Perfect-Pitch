//
//  PlaySoundsViewController.swift
//  PerfectPitch
//
//  Created by J B on 5/16/17.
//  Copyright © 2017 J B. All rights reserved.
//  Copyright © 2017 from Udacity. This code is originally from the
//  Nanodegree program at Udacity.

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // MARK: Properties
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    // Control rate  
    
    let slowRate: Float = 0.5
    let fastRate: Float = 1.5
    let chipmunkPitch: Float = 1000
    let vaderPitch: Float = -1000
    
    
    // This enumeration allows us to map the tag values to an enumeration value
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }

    // MARK: Actions
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: slowRate)
        case .fast:
            playSound(rate: fastRate)
        case .chipmunk:
            playSound(pitch: chipmunkPitch)
        case .vader:
            playSound(pitch: vaderPitch)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }

}
