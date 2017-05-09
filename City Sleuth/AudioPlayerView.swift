//
//  AudioPlayerView.swift
//  City Sleuth
//
//  Created by Kasper Gammeltoft on 5/8/17.
//  Copyright © 2017 Locative Media Group 17' ITU. All rights reserved.
//

import UIKit
import AVFoundation


@IBDesignable class AudioPlayerView : UIView, AVAudioPlayerDelegate {
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var playIndicator: UISlider!
    
    var player : AVAudioPlayer?
    
    var songURL : URL?
    
    var view : UIView!
    
    var isEnabled = true
    
    func setup()
    {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
    }
    
    
    func loadViewFromNib() -> UIView
    {
        let bundle = Bundle(for :type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return nibView
    }
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setupPlayer() {
        do {
            try player = AVAudioPlayer(contentsOf: songURL!)
            guard player != nil else {return }
            player?.delegate = self
            player?.prepareToPlay()
            
        } catch let error as NSError {
            print(error.description)
        }
        
        let asset = AVURLAsset(url: songURL!)
        let duration = asset.duration
        let secs = CMTimeGetSeconds(duration)
        
        playIndicator.maximumValue = Float(secs)
        playIndicator.minimumValue = 0
        playIndicator.value = Float((player?.currentTime)!)
    }
    
    func setEnabled(enabled : Bool) {
        isEnabled = enabled
        playIndicator.isEnabled = isEnabled
        playButton.isEnabled = isEnabled
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playButton.setImage(UIImage(named: "pausedIcon"), for: UIControlState.normal)
        self.playIndicator.value = playIndicator.minimumValue
    }
    
    
    @IBAction func playPausePressed(_ sender: Any) {
        if (player != nil) {
            if (player?.isPlaying)! {
                player?.pause()
                playButton.setImage(UIImage(named: "playIcon"), for: UIControlState.normal)
            } else {
                player?.play()
                playButton.setImage(UIImage(named: "pausedIcon"), for: UIControlState.normal)
                DispatchQueue.global(qos: .background).async {
                    while (self.player?.isPlaying)! {
                        sleep(1)
                        DispatchQueue.main.async {
                            self.playIndicator.value = Float((self.player?.currentTime)!)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func userChangeValue(_ sender: Any) {
        if (player != nil) {
            if (player?.isPlaying)! {
                player?.pause()
                playButton.setImage(UIImage(named: "playIcon"), for: UIControlState.normal)
            }
            player?.currentTime = TimeInterval(playIndicator.value)
            }
    }
    
}

class PlayerSliderView : UISlider {
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.minX, y: bounds.minY + bounds.height/4, width: bounds.width, height: bounds.height/2)
    }
    
}
