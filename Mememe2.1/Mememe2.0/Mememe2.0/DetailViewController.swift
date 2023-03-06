//
//  DetailViewController.swift
//  memeME1
//
//  Created by abdiqani on 08/01/23.
//
import Foundation
import UIKit
class DetailViewController: UIViewController {
    
    var meme: Meme!
    
    var indexD: Int?
    
    @IBOutlet weak var memeImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        memeLabel.text = self.meme.name
        memeImage.image = UIImage(named: meme.imageName)
        self.tabBarController?.tabBar.isHidden = true
//       let object = UIApplication.shared.delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        let memeUpdated = appDelegate.memes[indexD ?? Int()]
//        memeImage.image = memeUpdated.
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    @IBAction func editSavedMeme(_ sender: Any) {
        let ViewController = self.storyboard!.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        ViewController.savedMemeForEdit
        ViewController.indexE = indexD
        
        navigationController?.present(ViewController, animated: true, completion: nil)
            ViewController.imagePickerView.contentMode = .scaleAspectFill
        
        ViewController.memeIsModified = true

    }
    
}
