//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Jarod Wellinghoff on 10/6/21.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	var posts = [PFObject]()

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return posts.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as! PostTableViewCell
		let post = posts[indexPath.row]

		let user = post["author"] as! PFUser
		cell.usernameLabel.text = user.username

		cell.captionLabel.text = post["caption"] as? String

		let imageFile = post["image"]	as! PFFileObject
		let urlString = imageFile.url!
		let url = URL(string: urlString)!

		cell.photoView.af.setImage(withURL: url)

		return cell
	}

	@IBOutlet var feedTableView: UITableView!

	override func viewDidLoad() {
        super.viewDidLoad()
		feedTableView.delegate = self
		feedTableView.dataSource = self

		let query = PFQuery(className: "Posts")
		query.includeKey("author")
		query.limit = 20

		query.findObjectsInBackground { (posts, error) in
			if posts != nil {
				self.posts = posts!
				self.feedTableView.reloadData()
			}
		}

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
