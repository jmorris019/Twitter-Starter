//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by James Morris on 2/12/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    
  
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    
    @IBOutlet weak var retweetB: UIButton!
    @IBOutlet weak var favB: UIButton!
    
    @IBAction func favorite(_ sender: Any) {
        let toBeFaved = !favorited
        if (toBeFaved) {
            TwitterAPICaller.client?.favorTweet(tweetId: tweetId, success: {
                self.setFaved(isFaved: true)
            }, failure: { (Error) in
                print("Couldn't Favorite!")
            })
        } else {
            TwitterAPICaller.client?.unFavorTweet(tweetId: tweetId, success: {
                self.setFaved(isFaved: false)
            }, failure: { (Error) in
                print("Couldn't unfavorite!")
            })
            
        }
    }
   
    @IBAction func retweetA(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
               self.setRetweeted(true)
               }, failure: { (Error) in
                   print("Error in retweeting \(Error)")
               })
    }
    
    var favorited:Bool = false
    var tweetId: Int  = -1

    
    func setFaved(isFaved: Bool) {
        favorited = isFaved
        if (favorited) {
            favB.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        } else {
            favB.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted: Bool) {
        if (isRetweeted) {
                retweetB.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
                  retweetB.isEnabled = false
                     } else {
                         retweetB.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
                  retweetB.isEnabled = true
                     }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
