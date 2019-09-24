//
//  StudioVC.swift
//  Trackd
//
//  Created by Lucky on 2018/11/15.
//  Copyright © 2018 Trident Cloud Limited. All rights reserved.
//

import UIKit
import AudioKit

class StudioVC: UIViewController {
    @IBOutlet weak var collectionStudio: UICollectionView!
    var micMixer: AKMixer!
    var recorder: AKNodeRecorder!
    var player: AKPlayer!
    var tape: AKAudioFile!
    //var micBooster: AKBooster!
    var moogLadder: AKMoogLadder!
    var mainMixer: AKMixer!
    let mic = AKMicrophone()
    
    var m_trackInfos = [TrackInfo]()
    
    var m_nSelected = -1
    
    
    var auManager = AKAudioUnitManager()
    var mixer = AKMixer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initAudio()
        setReadyRecording()
    }
    
    func initAudio(){
        
        // Clean tempFiles !
        AKAudioFile.cleanTempDirectory()
        
        // Session settings
        AKSettings.bufferLength = .medium
        
        do {
            try AKSettings.setSession(category: .playAndRecord, with: .mixWithOthers)
        } catch {
            AKLog("Could not set session category.")
        }
        
        AKSettings.defaultToSpeaker = true
        
        // Patching
        let monoToStereo = AKStereoFieldLimiter(mic, amount: 1)
        micMixer = AKMixer(monoToStereo)
        //micBooster = AKBooster(micMixer)

        // Will set the level of microphone monitoring
        //micBooster.gain = 0
        recorder = try? AKNodeRecorder(node: micMixer)
        
        if let file = recorder.audioFile {
            player = AKPlayer(audioFile: file)
        }

        //player.isLooping = true
        //player.completionHandler = playingEnded
        
//        moogLadder = AKMoogLadder(player)
//        mainMixer = AKMixer(moogLadder, micBooster)
        
//        moogLadder = AKMoogLadder()
        
        //Create Track Info to use
        for i in 0..<4{
            m_trackInfos.append(TrackInfo(index: i))
//            if let file = recorder.audioFile {
//                m_trackInfos[i].player = AKPlayer(audioFile: file)
//                m_trackInfos[i].player! >>> moogLadder
//            }
        }
        
//        mainMixer = AKMixer(moogLadder)
//
//        AudioKit.output = mainMixer
        do {
            try AudioKit.start()
        } catch {
            AKLog("AudioKit did not start!")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func playingEnded() {
        DispatchQueue.main.async {
            //self.setupUIForPlaying ()
        }
    }
    
    func record(){
        //state = .recording
        // microphone will be monitored while recording
        // only if headphones are plugged
        /*if AKSettings.headPhonesPlugged {
            micBooster.gain = 1
        }*/
        do {
            //Reset to not continue from previous recording
            try recorder.reset()
            
            try recorder.record()

        } catch { AKLog("Errored recording.") }
    }
    
    func stopRecord(index: Int){
        //micBooster.gain = 0
        tape = recorder.audioFile!
        player.load(audioFile: tape)
//        m_trackInfos[index].player?.load(audioFile: tape)
        
//        if let _ = m_trackInfos[index].player?.audioFile?.duration {
        if let _ = player.audioFile?.duration {
            recorder.stop()
            m_trackInfos[index].tracked = true
            let sFileName = "audio\(index).m4a"
            tape.exportAsynchronously(name: sFileName,
                                      baseDir: .documents,
                                      exportFormat: .m4a) {_, exportError in
                                        if let error = exportError {
                                            AKLog("Export Failed \(error)")
                                        } else {
                                            AKLog("Export succeeded " + sFileName)
                                        }
            }
            setReadyRecording()
        }
    }
    
    func play(){
        try? AudioKit.stop()
        
        /*let sName = "audio0.m4a"
        do{
            let file = try AKAudioFile(readFileName: sName, baseDir: .documents)
            player.load(audioFile: file)
            
            player! >>> mixer
            auManager.input = player
            
            auManager.output = mixer
            AudioKit.output = mixer
            try? AudioKit.start()
            player.play()
        }catch{
            AKLog("aaa")
        }*/
        
        for i in 0..<4{
            let sName = "audio\(i).m4a"
            if(m_trackInfos[i].tracked){
                do{
                    let file = try AKAudioFile(readFileName: sName, baseDir: .documents)
                    m_trackInfos[i].player = AKPlayer(audioFile: file)
                    m_trackInfos[i].player! >>> mixer
                    auManager.input = m_trackInfos[i].player
                }catch{
                    AKLog("aaa")
                }
            }
        }

        auManager.output = mixer
        AudioKit.output = mixer
        try? AudioKit.start()

        for i in 0..<4{
            if(m_trackInfos[i].tracked){
                m_trackInfos[i].player?.play()
            }
        }

        //infoLabel.text = "Playing..."
        //mainButton.setTitle("Stop", for: .normal)
        //state = .playing
        //plot?.node = player
    }
    
    func stopPlaying(){
        player.stop()
        
//        for i in 0..<4{
//            m_trackInfos[i].player?.stop()
//        }
    }
    
    @IBAction func onPlay(_ sender: Any) {
        play()
    }
    
    @IBAction func onRemove(_ sender: UIButton) {
        let index = collectionStudio.getIndexPathOf(subview: sender)
        m_trackInfos[index.row].state = .waitForRecord
        m_trackInfos[index.row].tracked = false
        setReadyRecording()
    }
    
    func refreshUI(){
        collectionStudio.reloadData()
    }
}

extension StudioVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func getRecordingIndex() -> Int{
        for i in 0..<4{
            if m_trackInfos[i].state == .recording{
                return i
            }
        }
        return -1
    }
    
    func setReadyRecording(){
        var nSetIndex = -1
        for i in 0..<4{
            if m_trackInfos[i].state == .waitForRecord && nSetIndex < 0{
                m_trackInfos[i].state = .readyToRecord
                nSetIndex = i
            }
            if(m_trackInfos[i].state == .readyToRecord){
                if nSetIndex == -1{
                    nSetIndex = i
                }else if i > nSetIndex{
                    m_trackInfos[i].state = .waitForRecord
                }
            }
        }
        refreshUI()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellStudio", for: indexPath) as! StudioCVCell
        cell.index = indexPath.row
        cell.state = m_trackInfos[indexPath.row].state
        cell.setupUI()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        m_nSelected = indexPath.row
        if m_trackInfos[indexPath.row].state == .readyToRecord{
            m_trackInfos[indexPath.row].state = .recording
            record()
            refreshUI()
        } else if m_trackInfos[indexPath.row].state == .recording {
            m_trackInfos[indexPath.row].state = .readyToPlay
            stopRecord(index: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.size.width
        let width = screenWidth / 2
        
        return CGSize(width: width, height: width)
    }
}
