//
//  secondSignupVC.swift
//  Speedo Transfer
//


import UIKit
import FittedSheets

class secondSignupVC: UIViewController, CountrySelectionDelegate {
    
    var tempUser: TempUser?
    
    @IBOutlet weak var signCountryTxtField: CustomTextField!
    @IBOutlet weak var signDateTxtField: CustomTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TxtFields()
        
        // Print tempUser to verify it's being passed correctly
        if let tempUser = tempUser {
            print("TempUser: \(tempUser)")
        } else {
            print("TempUser is nil")
        }
        
    }
    
    private func TxtFields(){
        signCountryTxtField.setType(.country)
        signCountryTxtField.placeholder = "Select your country"
        
        signCountryTxtField.addTarget(self, action: #selector(showCountryPicker), for: .editingDidBegin)
        
        signDateTxtField.setType(.dateOfBirth)
        signDateTxtField.placeholder = "dd/MM/yyyy"
        
    }
    
    @IBAction func continueBtnTapped(_ sender: Any) {
        //        let cardNumber = "1234567890123456"
        //               let cardHolderName = "Ahmed adel"
        //               let expirationDate = "26/8"
        //               let cvv = "123"
        //
        //               let card = Speedo_Transfer.CardDTO(
        //                   cardNumber: cardNumber,
        //                   cardHolderName: cardHolderName,
        //                   expirationDate: expirationDate,
        //                   cvv: cvv
        //               )
        //        submitCard(card: card)
        
        guard let tempUser = tempUser else {
            // Handle missing user data
            return
        }
        //
        //        let fullname = tempUser.username
        //        let email = tempUser.email
        //        let password = tempUser.password
        //        let address = tempUser.address
        //        let phoneNumber = tempUser.phoneNumber
        //        let gender = tempUser.gender
        //        let dateOfBirth = tempUser.dateOfBirth
        //        let country = tempUser.country
        //
        //        let user = UserRegistrationRequest(
        //    username: fullname,
        //    email: email,
        //    address: address,
        //    country: country,
        //    gender: gender,
        //    phoneNumber: phoneNumber,
        //    dateOfBirth: dateOfBirth,
        //    password: password
        
        //
        //               let card = CardDTO(
        //                   cardNumber: "1234567890123456",
        //                   cardHolderName: tempUser.username,
        //                   expirationDate: "26/8",
        //                   ccvv: "123"
        //               )
        
        let user = UserRegistrationRequest(
            username: tempUser.username,
            email: tempUser.email,
            address: tempUser.address,
            country: tempUser.country,
            gender: tempUser.gender,
            phoneNumber: tempUser.phoneNumber,
            dateOfBirth: tempUser.dateOfBirth,
            password: tempUser.password
        )
        
        
        
        // Print the user object to verify its content
        print("User object to be sent: \(user)")
        
        //        AuthService.registerUser(with: user) { result in
        //            DispatchQueue.main.async {
        //                switch result {
        //                case .success(let response):
        //                    // Print the response from the API for debugging
        //                    print("API Response: \(response)")
        //
        // Navigate to the login screen
        self.goToLoginScreen()
        
        //                case .failure(let error):
        //                    // Print the error message for debugging
        //                    print("API Error: \(error.localizedDescription)")
        //
        //                    // Navigate to the login screen
        //                    self.goToLoginScreen()
    }

            
        
    
    
    func submitCard(card: Speedo_Transfer.CardDTO) {
        // Perform the API call for card submission
        // Handle the API response and errors
        // Example of logging API error
        let errorResponse = "Invalid response or data error 400."
        print("API Error: \(errorResponse)")
    }
    
    private func goToLoginScreen() {
        let SignIn = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInViewController
        self.navigationController?.pushViewController(SignIn, animated: true)
    }
    
    
    
    
    @objc func showCountryPicker() {
        guard let countrySheet = storyboard?.instantiateViewController(withIdentifier: "countrySheetVC") as? countrySheetVC else {
            print("Could not instantiate countrySheetVC")
            return
        }
        countrySheet.delegate = self
        
        let sheetController = SheetViewController(controller: countrySheet, sizes: [.fixed(500), .percent(0.5), .intrinsic])
        sheetController.cornerRadius=50
        sheetController.gripColor=UIColor(named: "LabelColor")
        self.present(sheetController, animated: true, completion: nil)
    }
    
    func didSelectCountry(country: Country) {
        signCountryTxtField.text = country.label
    }
}
