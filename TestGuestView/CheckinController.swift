//
//  CheckinController.swift
//  TestGuestView
//
//  Created by admin on 14/12/21.
//

import UIKit

class CheckinController: UIViewController {
    
    let blockManager = BlockCodeManager()

    @IBOutlet weak var latitude: UITextField!
    
    @IBOutlet weak var longitude: UITextField!
    
    @IBOutlet weak var blockCode: UITextField!
    
    
    
    @IBOutlet weak var convertedValue: UITextField!
    
    @IBOutlet weak var topHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewGuests: UIView!
    
    @IBOutlet weak var viewSpecialReq: UIView!
    
    @IBOutlet weak var viewBookingUnder: UIView!

    
    @IBOutlet weak var viewNeedPickup: UIView!
    var fraction = 0.0
    
    
    @IBOutlet weak var guestParentView: GuestDetailParentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startAnimation()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func getBlockCode(_ sender: Any) {
        
        let pataaCode = self.blockManager.calculatePataaCode(x: Double(self.latitude.text!)!, y: Double(self.longitude.text!)!, p: false)
        self.blockCode.text = "Block Code:- \(pataaCode)"

    }
    
    @IBAction func getLatlong(_ sender: Any) {
        self.blockManager.getLatlongFromPataaCode(words:self.blockCode.text!)
    }
    
    func startAnimation()
    {
        fraction  =  (Double(self.view.frame.size.height) / Double(CGFloat(812.0)))
        
        let topPadding1 = (Double(self.view.frame.size.height) / 2) * fraction
        
        self.topHeightConstraint.constant = CGFloat(topPadding1*fraction)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.startSplashAnimation()
        })
    }
    
    
    func startSplashAnimation() {
        self.topHeightConstraint.constant = 70
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
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
    
    @IBAction func addGuest(_ sender: Any) {
        self.guestParentView.addGuest(isPrimary: false)
    }
    
    
    @IBAction func dateSelection(_ sender: UIButton) {
        
        if sender.tag == 1
        {
            self.viewGuests.alpha = 1.0
            self.viewGuests.isUserInteractionEnabled = true
            self.viewGuests.isHidden = false
            self.viewSpecialReq.isHidden = false
            self.viewBookingUnder.isHidden = false
            self.viewNeedPickup.isHidden = false
        }
        
    }
}



