//
//  SignupVC.swift
//  Speedo Transfer
//

import UIKit

class SignupVC: UIViewController {
    
    @IBOutlet weak var signNameTxtField: CustomTextField!
    @IBOutlet weak var signEmailTxtField: CustomTextField!
    @IBOutlet weak var signPasswordTxtField: CustomTextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TxtFields()
        setupNavBar()
          
    }
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
      
        if isValidData() {
            let fullName = signNameTxtField.text?.trimmed ?? ""
            let email = signEmailTxtField.text?.trimmed ?? ""
            let password = signPasswordTxtField.text?.trimmed ?? ""
            
            
            let card = CardDTO(cardNumber: "1234567890123456", cardHolderName: fullName, expirationDate: "26/8", cvv: "123")

            let tempUser = TempUser(username: fullName,
                                    email: email,
                                    phoneNumber: "01120100709",
                                    address: "giza",
                                    country: "Egypt",
                                    gender: "Male",
                                    dateOfBirth: "12-12-1990", 
                                    password: password)
            
            goToCompleteRegisterScreen(with: tempUser)
            registerUser(tempUser)
            signUpUser(user: tempUser)


        }

    }
    func signUpUser(user: TempUser) {
          // Perform the API call for user registration
          // Handle the API response and errors
          // Example of logging API error
          let errorResponse = "Invalid response or data error 400."
          print("API Error: \(errorResponse)")
      }
    
    
    
     func registerUser(_ tempUser: TempUser) {
           let userRegistrationRequest = UserRegistrationRequest(
               username: tempUser.username,
               email: tempUser.email,
               address: tempUser.address,
               country: tempUser.country,
               gender: tempUser.gender,
               phoneNumber: tempUser.phoneNumber,
               dateOfBirth: tempUser.dateOfBirth,
               password: tempUser.password
             //  card: tempUser.card
           )
           
           guard let url = URL(string: "http://3.70.134.143/api/register") else { return }
           
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           
           do {
               let jsonData = try JSONEncoder().encode(userRegistrationRequest)
               request.httpBody = jsonData
           } catch {
               print("Error encoding data: \(error)")
               return
           }
           
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   print("API Error: \(error)")
                   return
               }
               
               guard let httpResponse = response as? HTTPURLResponse else { return }
               
               if httpResponse.statusCode == 200 {
                   print("User registered successfully.")
                   DispatchQueue.main.async {
                       self.goToCompleteRegisterScreen(with: tempUser)
                   }
               } else {
                   print("API Error: Invalid response or data error \(httpResponse.statusCode).")
               }
           }
           
           task.resume()
       }
    
    
    
    
    
    
    
     func goToCompleteRegisterScreen(with tempUser: TempUser) {
        let SignUp2 = self.storyboard?.instantiateViewController(withIdentifier: "secondSignupVC") as! secondSignupVC
        SignUp2.tempUser = tempUser
        self.navigationController?.pushViewController(SignUp2, animated: true)
    }
    
    @IBAction func signInBtnTapped(_ sender: Any) {
        let SignIn = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInViewController
        self.navigationController?.pushViewController(SignIn, animated: true)
    }
    
     func isValidData() -> Bool {
        guard let name = signNameTxtField.text?.trimmed, !name.isEmpty else {
            showALert(title: "Sorry", message: "Please enter your name!")
            return false
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.com"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        guard let email = signEmailTxtField.text?.trimmed, !email.isEmpty, emailPredicate.evaluate(with: email) else {
            showALert(title: "Sorry", message: "Please enter a valid email address!")
            return false
        }
        
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        guard let password = signPasswordTxtField.text?.trimmed, !password.isEmpty, passwordPredicate.evaluate(with: password) else {
            showALert(title: "Sorry", message: "Password must be at least 8 characters long, with at least one uppercase letter, one lowercase letter, and one number.")
            return false
        }
        
        return true
    }
    
     func setupNavBar(){
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "DRop down 1")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "DRop down 1")
        navigationItem.leftItemsSupplementBackButton = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        title = "Sign Up"
    }
    
     func TxtFields() {
        signNameTxtField.setType(.name)
        signNameTxtField.placeholder = "Enter your name"
        
        signEmailTxtField.setType(.email)
        signEmailTxtField.placeholder = "Enter your Email"
        
        signPasswordTxtField.setType(.password)
        signPasswordTxtField.placeholder = "Enter your Password"
    }
}
