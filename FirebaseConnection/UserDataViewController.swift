//
//  UserDataViewController.swift
//  FirebaseConnection
//
//  Created by Elzem on 7.12.2018.
//  Copyright © 2018 Elzem. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class UserDataViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var yorumText: UITextField!
    @IBOutlet weak var isimText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ImajSec))
        userImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func ImajSec() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present( imagePicker, animated: true, completion: nil)
        
        
        //print ("ImageView'a Basıldı")
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        userImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion:nil)
    }
    
    
    @IBAction func kaydetTapped(_ sender: Any) {
        let storageRef = Storage.storage().reference()
        let imageFolderRef = storageRef.child("ImageFolder")
        
        if let data = userImageView.image?.jpegData(compressionQuality: 0.8)
        {
            let uuid = NSUUID().uuidString
            let imageFolderRef = imageFolderRef.child("\(uuid).jpg")
            
            imageFolderRef.putData(data, metadata: nil){ (StorageMetadata, error) in
                
                if error != nil{
                    let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: .alert)
                    let alertaction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
                    alert.addAction(alertaction)
                    
                    self.present(alert, animated: true, completion: nil)
                        
                    }
                else{
                    
                    imageFolderRef.downloadURL(completion: {(url, error) in
                        
                        if error == nil{
                            let imageURL = url?.absoluteString
                            let databaseRef = Database.database().reference()
                            
                            let icerik = ["Gorsel": imageURL!, "Kim": Auth.auth().currentUser?.email!, "isim": self.isimText.text!, "Yorum": self.yorumText.text!, "uuid": uuid] as [String: Any]
                            
                            databaseRef.child("Kullanici").child(((Auth.auth().currentUser?.uid)!)).child("Gonderi").childByAutoId().setValue(icerik)
                        }
                    })
                }
            }
        }
    }
}
