//
//  RecordSoundsViewController.swift
//  PerfectPitch
//
//  Created by J B on 5/16/17.
//  Copyright © 2017 J B. All rights reserved.
//  Copyright © 2017 Udacity. This code is part of their Nanodegree Program.

import AVFoundation
import UIKit


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    // MARK: Outlets
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    
    // MARK: Properties
    
    var audioRecorder: AVAudioRecorder!
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // This disables the stop recording button by default
        stopRecordingButton.isEnabled = false
        
    }
    
    
    // MARK: IBActions


    @IBAction func recordAudio(_ sender: Any) {
        
        // Configure UI for recording
        configureInterface(flag: false, message: "Recording in progress...")
        
        // Fetching the audio file
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        //print(filePath)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func stopRecording(_ sender: Any) {
        
        // Configure UI to stop recording
        configureInterface(flag: true, message: "Tap to record...")
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    
    // Method to configure the UI
    
    func configureInterface(flag: Bool, message: String) {
        recordingLabel.text = message
        recordButton.isEnabled = flag
        stopRecordingButton.isEnabled = !flag
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording was not successful.")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // We check if this is the segue we want it to pass
        if segue.identifier == "stopRecording" {
            // We grab the viewController to the destination with a forced outcast
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            // We grab the sender, if we go back and check where we recorded the sender we can confirm so in the performSegue
            let recordedAudioURL = sender as! URL
            // We set the recorded URL in the playSoundsVC. We are now ready for playback
            playSoundsVC.recordedAudioURL = recordedAudioURL
        
        }
    }
}

