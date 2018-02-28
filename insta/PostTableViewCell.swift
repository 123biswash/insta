//
//  PostTableViewCell.swift
//  insta
//
//  Created by Biswash Adhikari on 2/26/18.
//  Copyright © 2018 Biswash Adhikari. All rights reserved.
//

import UIKit
import Parse

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var captionOutlet: UILabel!
        var post: PFObject? {
        didSet {
            //print("this is image \((post?["image"])!)")
            getImage()
         //   imageOutlet.image = self.imageOutlet.image
            captionOutlet.text = post?["caption"] as? String
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
    
    
    func getImage() {
        if let imageFile = post?.value(forKey: "image") {
            //            let imageFile = imageFile as! PFFile
            (imageFile as! PFFile).getDataInBackground(block: { (imageData: Data?, error: Error?) in
                let image = UIImage(data: imageData!)
                if image != nil {
                    self.imageOutlet.image = image
                }
            })
        }
    }
}
