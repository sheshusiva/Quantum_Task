//
//  ViewController.swift
//  LoginData
//
//  Created by apple on 02/09/23.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleSignIn
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var gmailTap: UIButton!
    @IBOutlet weak var sPname: UITextField!
    @IBOutlet weak var loginTapp: UIButton!
    
    //MARK:- Variables
    
    
    //MARK:- ViewDidLoad Method
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewDesigns()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    //MARK:- Login Tapped
    @IBAction func lgnTapped(_ sender: Any) {
        ValidationCode()
        self.createUSerDetailsFromFirebase(email: fName.text ?? "", password: sPname.text ?? "")
    }
    
    func createUSerDetailsFromFirebase(email: String, password: String)  {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else if let user = user {
                self.getUSerDetailsFromFirebase(email: self.fName.text ?? "", password: self.sPname.text ?? "")
            }
        }

    }
    
    func getUSerDetailsFromFirebase(email: String, password: String)  {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let secondVC = self?.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {
                return
            }
            secondVC.email = email
            self?.navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    
    //MARK:- gmail integration
    @IBAction func gmailTap(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            self.createUSerDetailsFromFirebase(email: signInResult?.user.profile?.email ?? "", password: signInResult?.user.profile?.name ?? "")
        }
    }
    
    //MARK:- View corner Frame line design
    func viewDesigns() {
        firstView.clipsToBounds = true
        firstView.layer.cornerRadius = 15
        firstView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner,.layerMaxXMinYCorner]
        firstView.backgroundColor = .systemTeal
        firstView.layer.borderColor = UIColor.white.cgColor
        firstView.layer.borderWidth = 1
        
        secondView.clipsToBounds = true
        secondView.layer.cornerRadius = 15
        secondView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner,.layerMaxXMinYCorner]
        secondView.backgroundColor = .systemTeal
        secondView.layer.borderColor = UIColor.white.cgColor
        secondView.layer.borderWidth = 1
        loginTapp.layer.cornerRadius = 20
        gmailTap.layer.cornerRadius = 20
    }
}

//MARK:- Email & Password Validations
extension ViewController {
    
    fileprivate func ValidationCode() {
        if let email = fName.text, let password = sPname.text {
            if !email.validateEmailId(){
                openAlert(title: "Alert", message: "Email address not found.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])
            }else if !password.validatePassword(){
                openAlert(title: "Alert", message: "Please enter valid password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])
            }else{
                // Navigation - Home Screen
            }
        }else{
            openAlert(title: "Alert", message: "Please add detail.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Okay clicked!")
            }])
        }
    }
    
}


