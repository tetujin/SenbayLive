//
//  SettingViewController.swift
//  SenbayLive
//
//  Created by Yuuki Nishiyama on 2019/01/17.
//  Copyright © 2019 Yuuki Nishiyama. All rights reserved.
//

import UIKit
import SenbayKit

class SettingViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var serverUrlTextField: UITextField!
    @IBOutlet weak var streamKeyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serverUrlTextField.delegate = self
        streamKeyTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let serverUrl = LiveStreamConfig.serverUrl{
            serverUrlTextField.text = serverUrl
        }
        if let streamUrl = LiveStreamConfig.streamKey {
            streamKeyTextField.text = streamUrl
        }
    }
    

    @IBAction func pushedDoneButton(_ sender: Any) {
        
        LiveStreamConfig.serverUrl = serverUrlTextField.text
        LiveStreamConfig.streamKey = streamKeyTextField.text
        
        self.presentingViewController?.dismiss(animated: true, completion: {
            
        })
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        serverUrlTextField.resignFirstResponder()
        streamKeyTextField.resignFirstResponder()
    }
}
