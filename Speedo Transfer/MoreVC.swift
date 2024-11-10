//
//  MoreVC.swift
//  Speedo Transfer Project
//


import UIKit
import FittedSheets

class MoreVC: UIViewController {
    
    @IBOutlet weak var firstView: UIView!
    
    
    @IBOutlet weak var FavouritesView: UIView!
    
    @IBOutlet weak var ProfileView: UIView!
    
    @IBOutlet weak var HelpView: UIView!
    @IBOutlet weak var LogoutView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addBottomBorder(to: firstView, color: UIColor.init(named: "MoreBGColor")!, thickness: 1.0)
        addBottomBorder(to: FavouritesView, color: UIColor.init(named: "MoreBGColor")!, thickness: 1.0)
        addBottomBorder(to: ProfileView, color: UIColor.init(named: "MoreBGColor")!, thickness: 1.0)
        addBottomBorder(to: HelpView, color: UIColor.init(named: "MoreBGColor")!, thickness: 1.0)
        addBottomBorder(to: LogoutView, color: UIColor.init(named: "MoreBGColor")!, thickness: 1.0)
        
    }
    
    func addBottomBorder(to view: UIView, color: UIColor, thickness: CGFloat) {
        // Remove any existing border layers
        view.layer.sublayers?.filter { $0.name == "bottomBorder" }.forEach { $0.removeFromSuperlayer() }
        
        // Add a bottom border
        let bottomBorder = CALayer()
        bottomBorder.name = "bottomBorder"
        bottomBorder.frame = CGRect(x: 0, y: view.frame.size.height - thickness, width: view.frame.size.width, height: thickness)
        bottomBorder.backgroundColor = color.cgColor
        view.layer.addSublayer(bottomBorder)
    }
    
    @IBAction func goToHelpButton(_ sender: Any) {
        guard let countrySheet = storyboard?.instantiateViewController(withIdentifier: "HelpVC") as? HelpVC else {
            print("Could not instantiate favouritsVC")
            return
        }
        
        let sheetController = SheetViewController(controller: countrySheet, sizes: [.fixed(300), .percent(0.5), .intrinsic])
        sheetController.cornerRadius=50
        sheetController.gripColor=UIColor(named: "LabelColor")
        self.present(sheetController, animated: true, completion: nil)
        
    }
    
    @IBAction func goToFavouritesButton(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let favouritesVCViewController = sb.instantiateViewController(withIdentifier: "FavouritesVCViewController") as! FavouritesVCViewController
        let backItem = UIBarButtonItem()
        backItem.title = " "
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(favouritesVCViewController , animated: true)
        
    }
    
    @IBAction func profileBtnTapped(_ sender: Any) {
        let profile = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(profile, animated: true)
    }
    
    @IBAction func logOutBtnTapped(_ sender: Any) {
        let SignIn = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInViewController
        self.navigationController?.pushViewController(SignIn, animated: true)
    }
    
}
