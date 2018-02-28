//
//  ViewController.swift
//  insta
//
//  Created by Biswash Adhikari on 2/22/18.
//  Copyright © 2018 Biswash Adhikari. All rights reserved.
//

import UIKit
import Parse


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 250
        tableView.estimatedRowHeight = 250
        
        // Do any additional setup after loading the view, typically from a nib.
        retrievePostFromParse()
    }
    
    func retrievePostFromParse() {
        // construct query
        let query = PFQuery(className: "Post")
        
        // fetch data asynchronously
        query.findObjectsInBackground { (object: [PFObject]?, error: Error?) in
            if object != nil {
                self.posts = object as! [Post]
            } else {
                print(error?.localizedDescription)
            }
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
    
        cell.post = posts[indexPath.row]
        
        let post = posts[indexPath.row]
        let postImage = post.object(forKey: "media") as? PFFile
        postImage?.getDataInBackground(block: { (imagedata: Data?, error: Error?) in
            if error == nil {
                let posterImage = UIImage(data: imagedata!)
                cell.imageOutlet.image = posterImage
            }
        })
            
        
        

        return cell
    }
    
     @IBAction func logOutButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
     }
    
        
    

}

