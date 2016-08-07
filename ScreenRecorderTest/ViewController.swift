//
//  ViewController.swift
//  ScreenRecorderTest
//
//  Created by Vyacheslav Nagornyak on 5/19/16.
//  Copyright © 2016 Vyacheslav Nagornyak. All rights reserved.
//

import UIKit
import ReplayKit

class ViewController: UIViewController, RPPreviewViewControllerDelegate, RPScreenRecorderDelegate {
    
    @IBOutlet weak var previewButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    weak var previewVC : RPPreviewViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func buttonPressed(_ sender: UIButton) {
        let r = CGFloat(arc4random()) / CGFloat(UINT32_MAX)
        let g = CGFloat(arc4random()) / CGFloat(UINT32_MAX)
        let b = CGFloat(arc4random()) / CGFloat(UINT32_MAX)
        
        self.view.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    @IBAction func startRecordingPressed(_ sender: UIButton) {
        let recorder = RPScreenRecorder.shared()
        if recorder.isAvailable {
			recorder.startRecording { (error) in
				if let error = error as? NSError {
					print("\(error.userInfo)")
				} else {
					self.recordingLabel.isHidden = false
				}
			}
        }
    }
    
    @IBAction func stopRecordingPressed(_ sender: UIButton) {
        let recorder = RPScreenRecorder.shared()
        recorder.stopRecording { (previewViewController, error) in
            if let preview = previewViewController {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                else {
                    self.previewVC = preview
                    preview.previewControllerDelegate = self
                }
            }
        }
        
        self.recordingLabel.isHidden = true
    }
    
    @IBAction func previewPressed(_ sender: UIButton) {
        if let vc = previewVC {
            self.present(vc, animated: true, completion: nil)
        }
    }
}
