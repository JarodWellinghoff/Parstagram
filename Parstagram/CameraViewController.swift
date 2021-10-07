//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Jarod Wellinghoff on 10/6/21.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var commentTextField: UITextField!

    override func viewDidLoad() {
		super.viewDidLoad()

		commentTextField.layer.cornerRadius = 16.0
		commentTextField.layer.masksToBounds = true
		commentTextField.layer.borderColor = UIColor.black.cgColor
		commentTextField.layer.borderWidth = 1.0

        // Do any additional setup after loading the view.
    }
	@IBAction func onCameraButton(_ sender: Any) {
		let picker = UIImagePickerController()
		picker.delegate = self
		picker.allowsEditing = true

		if UIImagePickerController.isSourceTypeAvailable(.camera) {
			picker.sourceType = .camera
		} else {
			picker.sourceType = .photoLibrary
		}

		present(picker, animated: true, completion: nil)
	}

	func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		let image = info[.editedImage] as! UIImage
		let size = CGSize(width: 300, height: 300)
		let scaledImage = image.af.imageScaled(to: size)
		imageView.image = scaledImage

		dismiss(animated: true, completion: nil)
	}


	@IBAction func onSubmitButton(_ sender: Any) {
		let post = PFObject(className: "Posts")
		let imageData = imageView.image!.pngData()!
		let file = PFFileObject(name: "image.png", data: imageData)

		post["caption"] = commentTextField.text!
		post["author"] = PFUser.current()!
		post["image"] = file

		post.saveInBackground { (success, error) in
			if success {
				self.dismiss(animated: true, completion: nil)
				print("saved")

			} else {
				self.dismiss(animated: true, completion: nil)
				print("error")
			}

		}

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
