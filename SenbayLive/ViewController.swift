//
//  ViewController.swift
//  SenbayLive
//
//  Created by Yuuki Nishiyama on 2019/01/16.
//  Copyright © 2019 Yuuki Nishiyama. All rights reserved.
//

import UIKit
import SenbayKit

class ViewController: UIViewController,SenbayCameraDelegate {

    var camera:SenbayCamera?
    var captureStatus = false
    
    @IBOutlet weak var preview: UIImageView!
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var recordTimeLabel: UILabel!
    @IBOutlet weak var fpsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let CONFIG = SenbayCameraConfig.init { (config) in
            config.maxFPS = 30
            config.videoSize = AVCaptureSession.Preset.hd1280x720
            // config.isCamouflageQRCode = true
            config.isExportSenbayVideo = false
            config.isExportOriginalVideo = false
            config.qrcodeSize = Int32(1280 * 0.15);
        }
        
        camera = SenbayCamera.init(previewView: self.preview, config: CONFIG)
        
        camera?.delegate = self;
        if let manager = camera?.sensorManager {
            manager.location.activateGPS()
            manager.imu.activateAccelerometer()
            // manager.weather.activate()
        }
        
        camera?.activate()
    }

    @IBAction func pushedCaptureButton(_ sender: UIButton) {
        
        if captureStatus {
            captureButton.setImage(UIImage.init(named: "start_button"), for: .normal)
            captureStatus = false
            
            camera?.stopRecording()
            camera?.finishBroadcast()

        }else{
            captureButton.setImage(UIImage.init(named: "stop_button"), for: .normal)
            captureStatus = true
            
            camera?.startRecording()
            
            if let serverUrl = LiveStreamConfig.serverUrl,
                let streamUrl = LiveStreamConfig.streamKey{
                camera?.startBroadcast(withStreamName: streamUrl, endpointURL: serverUrl)
            }
            
        }
    }
    
    func didUpdateCurrentFPS(_ currentFPS: Int32){
        fpsLabel.text = "\(currentFPS) FPS"
    }
    
    func didUpdateFormattedRecordTime(_ recordTime: String!){
        recordTimeLabel.text = recordTime
    }
    
    func didUpdateQRCodeContent(_ qrcodeContent: String!){
        
    }

}

public class LiveStreamConfig {
    
    public static var streamKey: String? {
        set {
            let userDefault = UserDefaults.standard
            userDefault.set( newValue, forKey: "com.senbaylive.ios.setting.streamkey" )
            userDefault.synchronize()
        }
        
        get {
            return UserDefaults.standard.string(forKey: "com.senbaylive.ios.setting.streamkey")
        }
    }
    
    public static var serverUrl: String? {
        set {
            let userDefault = UserDefaults.standard
            userDefault.set( newValue, forKey: "com.senbaylive.ios.setting.serverurl" )
            userDefault.synchronize()
        }
        
        get{
            return UserDefaults.standard.string(forKey: "com.senbaylive.ios.setting.serverurl")
        }
    }
    
}
