//
//  ViewController.swift
//  FirebaseConnection
//
//  Created by Elzem on 6.12.2018.
//  Copyright © 2018 Elzem. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIV"iewController {
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var sifreText: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    @IBAction func kayitOlTapped(_ sender: Any) {
        if self.emailText.text != "" && self.sifreText.text != ""
        {
            Auth.auth().createUser(withEmail: self.emailText.text!, password: self.sifreText.text!)
            {
                (userdata, error) in
                
                if error != nil
                {
                    let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: .alert)
                    let alertaction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
                    alert.addAction(alertaction)
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    
                }
            }
        }
        else {
            let alert = UIAlertController(title: "Hata", message: "E-Mail ya da Şifre Boş Olamaz", preferredStyle: .alert)
            let alertaction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
            alert.addAction(alertaction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func girisTapped(_ sender: Any) {
        if self.emailText.text != "" && self.sifreText.text != ""
        {
            Auth.auth().signIn(withEmail: self.emailText.text!, password: self.sifreText.text!) {(userdata, error) in
                
                if error != nil {
                    let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: .alert)
                    let alertaction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
                    alert.addAction(alertaction)
                    
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    self.performSegue(withIdentifier: "girisYapildi", sender: nil)
                }
            }
        }
        else{
            
            let alert = UIAlertController(title: "Hata", message: "E-Mail ya da Şifre Boş Olamaz ", preferredStyle: .alert)
            let alertaction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
            alert.addAction(alertaction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}



