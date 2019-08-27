//
//  VideoPlayerViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 11/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class VideoPlayerViewController: UIViewController {

    @IBOutlet weak var videoPlayer: WKYTPlayerView!
    var videoID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        videoPlayer.load(withVideoId: videoID)
    }
}
