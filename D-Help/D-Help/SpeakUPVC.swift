//
//  SpeakUPVC.swift
//  D-Help
//
//  Created by Rizki Syaputra on 11/23/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit
import Speech

class SpeakUPVC: UIViewController, SFSpeechRecognizerDelegate {

    @IBOutlet weak var labelPerintah: UILabel!
    @IBOutlet weak var teksOutput: UITextView!
    @IBOutlet weak var buttonSpeak: UIButton!

    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "id"))!

    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private var audioSession : AVAudioSession?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        buttonSpeak.isEnabled = false

        speechRecognizer.delegate = self

        SFSpeechRecognizer.requestAuthorization { (authStatus) in

            var isButtonEnabled = false

            switch authStatus {
            case .authorized:
                isButtonEnabled = true

            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")

            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")

            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }

            OperationQueue.main.addOperation() {
                self.buttonSpeak.isEnabled = isButtonEnabled
            }
        }
    }

    @IBAction func btnKlikSpeak(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            buttonSpeak.isEnabled = false
            labelPerintah.text = "Start Recording"
            buttonSpeak.setTitle("Start Recording", for: .normal)
        } else {
            startRecording()
            labelPerintah.text = "Stop Recording"
            buttonSpeak.setTitle("Stop Recording", for: .normal)
        }
    }

    func startRecording() {

        if recognitionTask != nil {  //1
            recognitionTask?.cancel()
            recognitionTask = nil
        }

        let audioSession = AVAudioSession.sharedInstance()  //2
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()  //3

         let inputNode = audioEngine.inputNode

        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        } //5

        recognitionRequest.shouldReportPartialResults = true  //6

        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in  //7

            var isFinal = false  //8

            if result != nil {

                self.teksOutput.text = result?.bestTranscription.formattedString  //9
                isFinal = (result?.isFinal)!
            }

            if error != nil || isFinal {  //10
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil

                self.buttonSpeak.isEnabled = true
            }
        })

        let recordingFormat = inputNode.outputFormat(forBus: 0)  //11
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()  //12

        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }

        teksOutput.text = "Say something, I'm listening!"

    }

    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            buttonSpeak.isEnabled = true
        } else {
            buttonSpeak.isEnabled = false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

