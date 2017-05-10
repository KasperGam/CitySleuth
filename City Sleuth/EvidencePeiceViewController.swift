//
//  EvidencePeiceViewController.swift
//  City Sleuth
//
//  Created by Kasper Gammeltoft on 5/8/17.
//  Copyright © 2017 Locative Media Group 17' ITU. All rights reserved.
//


import UIKit

class EvidencePeiceViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var audioPlayer: AudioPlayerView!
    
    @IBOutlet weak var webView: UIWebView!
    
    var curEvidence : Evidence?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = curEvidence?.name
        descriptionLabel.text = curEvidence?.description
        
        if (curEvidence?.type == Evidence.TYPE_PICTURE) {
            imageView.image = UIImage(named: (curEvidence?.filename)!)
        } else {
            imageView.isHidden = true
        }
        
        if (curEvidence?.type == Evidence.TYPE_WEB) {
            webView.loadRequest(URLRequest(url: URL(string: (curEvidence?.filename)!)!))
        } else {
            webView.isUserInteractionEnabled = false
            webView.isHidden = true
        }
        
        if (curEvidence?.type == Evidence.TYPE_TEXT) {
            textView.text = curEvidence?.filename
        } else {
            textView.isHidden = true
            textView.isUserInteractionEnabled = false
        }
        
        if (curEvidence?.type == Evidence.TYPE_AUDIO) {
            let url = URL(fileURLWithPath: Bundle.main.path(forResource: curEvidence?.filename, ofType: "mp3")!)
            audioPlayer.songURL = url
            audioPlayer.setupPlayer()
        } else {
            audioPlayer.isHidden = true
            audioPlayer.setEnabled(enabled: false)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
