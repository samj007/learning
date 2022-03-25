
//
//  GuestView.swift
//  PREFME
//
//  Created by admin on 05/06/19.
//  Copyright © 2021 Advantal. All rights reserved.
//

import UIKit

protocol GuestViewDetailsViewDelegate {
    func openOptions(isForward:Bool,tag:NSInteger, prefmeNo:String)

    func addGuest(isPrimary:Bool)
    func removeGuest(tag:NSInteger, sequence:NSInteger)
    func saveGuest(tag:NSInteger)
    func cancelGuest(tag:NSInteger)
    func expandGuest(tag:NSInteger)
    func shrinkGuestDetail(tag:NSInteger)
    func checkIfPrefmeNumberExist(prefme:String)->NSInteger
    func openCountryChooseView(tag:NSInteger)
    func gotoUnsaveState(tag:NSInteger)->Bool

}




class GuestView: UIView {
    var isPrimary = false
    var isSave = 0
    // 0 = false
    // 1 = true
    // 2 = Unsaved
    var sequenceNo = -1
    var isShrink = false
    var delegate : GuestViewDetailsViewDelegate!
    
    var activeField: UITextField?
    var isMainGuest = "false"
    var frontImageData = Data()
    var rearImageData = Data()
    var isValidatePrefmeFromServer = false
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
//    @IBOutlet weak var fileProgressIndicator: UIActivityIndicatorView!
    @IBOutlet weak var userInfoView: UIView!
    
    @IBOutlet weak var userDetailsView: UIView!
    @IBOutlet weak var primaryLbl: UILabel!
    @IBOutlet weak var primaryIcon: UIImageView!

//    @IBOutlet weak var heightbtnSave: NSLayoutConstraint! // By Default - 55 and 0
//    @IBOutlet weak var heightGenderConstraint: NSLayoutConstraint! // By Default - 75 and 0

    @IBOutlet weak var genderView: UIView!

    @IBOutlet weak var guestNameLbl: UILabel!

    @IBOutlet weak var childrenButton: UIButton!
    @IBOutlet weak var adultButton: UIButton!

    @IBOutlet weak var childrenRadio: UIImageView!
    @IBOutlet weak var adultRadio: UIImageView!

    var lastValidPrefmeNo = ""
    var lastValidPin = ""

    @IBOutlet weak var btnExpand: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var saveView: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var btnSave: UIButton!
    
    
    @IBOutlet weak var coTravelerViewContainer: UIView!
    

    @IBOutlet weak var mobileCode: UILabel!
    @IBOutlet weak var mobileCodeBtn: UIButton!

    var mobileVal = ""

    @IBOutlet weak var prefmeNumberView: UIView!
// PSTextField
    @IBOutlet weak var coTravelerTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var prefmeNumberTf: UITextField!
    @IBOutlet weak var pinNumberTf: UITextField!

    @IBOutlet weak var lblPinUndeline: UILabel!
    @IBOutlet weak var prefmeLineLbl: UILabel!

    @IBOutlet weak var infoButton: UIButton!

//    @IBOutlet weak var headingLbl: UILabel!

    @IBOutlet weak var secondHeadingLbl: UILabel!
    
    @IBOutlet weak var addViewLbl: UILabel!
    @IBOutlet weak var idProodView: UIView!

    @IBOutlet weak var frontImgBtn: UIButton!
    @IBOutlet weak var rearImgBtn: UIButton!
    @IBOutlet weak var frontImgView: UIImageView!
    @IBOutlet weak var rearImgView: UIImageView!

    var frontURL = ""
    var rearURL = ""

    var actualFrontURL = ""
    var actualRearURL = ""
    
    var view: UIView!
    var uploadingCount = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomerView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    
    func getUploadedFileString(fileName:String)->String
    {

        return fileName
    }

    
    @IBAction func saveAction(_ sender: UIButton) {
        self.delegate.saveGuest(tag: sender.tag)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.delegate.removeGuest(tag: self.tag, sequence: self.sequenceNo)
    }
    
    @IBAction func expandOrShrinkAction(_ sender: UIButton) {
        if self.isShrink
        {
            self.isShrink = false
            sender.setTitle("Open", for: UIControl.State.normal)

            sender.isSelected = true
            self.delegate.expandGuest(tag: self.sequenceNo)
//            self.btnExpand.transform = CGAffineTransform(rotationAngle: CGFloat((Double.pi / 2) * 2))

        }
        else
        {
            sender.setTitle("Close", for: UIControl.State.normal)
            self.isShrink = true
            sender.isSelected = false
            self.delegate.shrinkGuestDetail(tag: self.sequenceNo)
//            self.btnExpand.transform = CGAffineTransform(rotationAngle: CGFloat((Double.pi / 2) * 2))
        }
      
    }
}




/*

protocol GuestViewDetailsViewDelegate {
    func openOptions(isForward:Bool,tag:NSInteger, prefmeNo:String)

    func addGuest(isPrimary:Bool)
    func removeGuest(tag:NSInteger, sequence:NSInteger)
    func saveGuest(tag:NSInteger)
    func cancelGuest(tag:NSInteger)
    func expandGuest(tag:NSInteger)
    func shrinkGuestDetail(tag:NSInteger)
    func checkIfPrefmeNumberExist(prefme:String)->NSInteger
    func openCountryChooseView(tag:NSInteger)
    func gotoUnsaveState(tag:NSInteger)->Bool

}




class GuestView: UIView {
    var isPrimary = false
    var isSave = 0
    // 0 = false
    // 1 = true
    // 2 = Unsaved
    var sequenceNo = -1
    var isShrink = false
    var delegate : GuestViewDetailsViewDelegate!
    
    var activeField: UITextField?
    var isMainGuest = "false"
    var frontImageData = Data()
    var rearImageData = Data()
    var isValidatePrefmeFromServer = false
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
//    @IBOutlet weak var fileProgressIndicator: UIActivityIndicatorView!
    @IBOutlet weak var userInfoView: UIView!
    
    @IBOutlet weak var userDetailsView: UIView!
    @IBOutlet weak var primaryLbl: UILabel!
    @IBOutlet weak var primaryIcon: UIImageView!

//    @IBOutlet weak var heightbtnSave: NSLayoutConstraint! // By Default - 55 and 0
//    @IBOutlet weak var heightGenderConstraint: NSLayoutConstraint! // By Default - 75 and 0

    @IBOutlet weak var genderView: UIView!

    @IBOutlet weak var guestNameLbl: UILabel!

    @IBOutlet weak var childrenButton: UIButton!
    @IBOutlet weak var adultButton: UIButton!

    @IBOutlet weak var childrenRadio: UIImageView!
    @IBOutlet weak var adultRadio: UIImageView!

    var lastValidPrefmeNo = ""
    var lastValidPin = ""

    @IBOutlet weak var btnExpand: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var saveView: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var btnSave: UIButton!
    
    
    @IBOutlet weak var coTravelerViewContainer: UIView!
    
    @IBOutlet weak var coTravelerTF: PSTextField!
    @IBOutlet weak var mobileTF: PSTextField!
    @IBOutlet weak var mobileCode: UILabel!
    @IBOutlet weak var mobileCodeBtn: UIButton!

    var mobileVal = ""

    @IBOutlet weak var prefmeNumberView: UIView!

    @IBOutlet weak var prefmeNumberTf: PSTextField!
    @IBOutlet weak var pinNumberTf: PSTextField!
    @IBOutlet weak var lblPinUndeline: UILabel!
    @IBOutlet weak var prefmeLineLbl: UILabel!

    @IBOutlet weak var infoButton: UIButton!

//    @IBOutlet weak var headingLbl: UILabel!

    @IBOutlet weak var secondHeadingLbl: UILabel!
    
    @IBOutlet weak var addViewLbl: UILabel!
    @IBOutlet weak var idProodView: UIView!

    @IBOutlet weak var frontImgBtn: UIButton!
    @IBOutlet weak var rearImgBtn: UIButton!
    @IBOutlet weak var frontImgView: BorderImageView!
    @IBOutlet weak var rearImgView: BorderImageView!

    var frontURL = ""
    var rearURL = ""

    var actualFrontURL = ""
    var actualRearURL = ""
    
    var view: UIView!
    var uploadingCount = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        self.setUPUI()
        self.setValidation()
        self.prefmeNumberTf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.pinNumberTf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        self.setUPUI()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomerView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    func updateDetail()
    {
        self.prefmeNumberTf.attributedText = attr.val(str:String(describing: kAppdelegate.currentUserInfo.SuggestedPrefmeVal),
                                            fontVal: FontBook.GilroyLight.of(size: ftype.body))

        
        self.pinNumberTf.attributedText = attr.val(str:kAppdelegate.currentUserInfo.securePin,
                                            fontVal: FontBook.GilroyLight.of(size: ftype.body))

        self.guestNameLbl.attributedText = attr.val(str:ProfileInfo.sharedProfileInstance.prepareName(),
                                            fontVal: FontBook.GilroyMedium.of(size: ftype.body))
        self.coTravelerTF.attributedText = attr.val(str:ProfileInfo.sharedProfileInstance.prepareName(),
                                            fontVal: FontBook.GilroyLight.of(size: ftype.body))

        self.setMobileOnTextField(numberString:kAppdelegate.currentUserInfo.MobileNumberVal, countryCode:kAppdelegate.currentUserInfo.mobileCountryCode)
        self.lastValidPrefmeNo = self.prefmeNumberTf.text!
        self.lastValidPin = self.pinNumberTf.text!
    }
    
    func getUploadedFileString(fileName:String)->String
    {

        return fileName
    }
    
    func setUPUI(){
        self.btnSave.setAttributedTitle(attr.val(str: "Save".localized(),
                                                 fontVal: FontBook.GilroyMedium.of(size: ftype.headline)), for: .normal)

        self.btnCancel.setAttributedTitle(attr.val(str: "Cancel".localized(),
                                                 fontVal: FontBook.GilroyMedium.of(size: ftype.headline), color: ThemeColor.offWhite.value), for: .normal)

        self.coTravelerTF.attributedPlaceholder = attr.val(str: "Co- Traveller's Name".localized() + "*", fontVal: FontBook.GilroyLight.of(size: ftype.headline), color: ThemeColor.halfWhite.value)
        
        self.setMobileOnTextField(numberString:"", countryCode:kAppdelegate.currentUserInfo.mobileCountryCode)
        
        self.mobileCode.attributedText = NSMutableAttributedString.getMobileCodeWithArrow(countryCode:kAppdelegate.currentUserInfo.mobileCountryCode, fontName: KSlimButtonFontName, fontSize:ftype.body.rawValue, r: 254.0, g:254.0, b: 254.0)

        self.mobileTF.attributedPlaceholder = attr.val(str: "Mobile Number".localized(), fontVal: FontBook.GilroyLight.of(size: ftype.headline), color: ThemeColor.halfWhite.value)

        self.prefmeNumberTf.attributedPlaceholder = attr.val(str: "Prefme Number".localized(), fontVal: FontBook.GilroyLight.of(size: ftype.headline), color: ThemeColor.halfWhite.value)

        self.pinNumberTf.attributedPlaceholder = attr.val(str: "Enter Pin".localized(), fontVal: FontBook.GilroyLight.of(size: ftype.headline), color: ThemeColor.halfWhite.value)

        
        let addViewStr = attr.val(str: "Add/View Details".localized(), fontVal: FontBook.GilroyLight.of(size: ftype.footnote), color: ThemeColor.white.value.withAlphaComponent(0.8))
        addViewStr.addUnderLine()
        self.addViewLbl.attributedText = addViewStr
        self.secondHeadingLbl.attributedText = attr.val(str: "Please upload government approved ID".localized(), fontVal: FontBook.GilroyLight.of(size: ftype.caption1), color: ThemeColor.halfWhite.value)

        self.frontImgBtn.setAttributedTitle(attr.val(str: "Front".localized(), fontVal: FontBook.GilroyLight.of(size: ftype.caption1), color: ThemeColor.halfWhite.value), for: .normal)
        
        self.rearImgBtn.setAttributedTitle(attr.val(str: "Rear/Other".localized(), fontVal: FontBook.GilroyLight.of(size: ftype.caption1), color: ThemeColor.halfWhite.value), for: .normal)
     
        self.adultButton.setAttributedTitle(attr.val(str: "    " + "Adult".localized(), fontVal: FontBook.GilroyRegular.of(size: ftype.body)), for: .normal)
        self.childrenButton.setAttributedTitle(attr.val(str: "    " + "Child".localized(), fontVal: FontBook.GilroyRegular.of(size: ftype.body)), for: .normal)
 


    }
    
    
    func setAsPrimaryGuest(isPrimary:Bool)
    {
        if isPrimary
        {
            self.primaryLbl.isHidden = false
            self.primaryIcon.isHidden = false
        }
        else
        {
            self.primaryLbl.isHidden = true
            self.primaryIcon.isHidden = true
        }
    }
    
    @IBAction func ageTypebuttonClicked(_ sender: UIButton) {
        if self.isSave == 1
        {
            self.delegate.gotoUnsaveState(tag: self.sequenceNo)
        }
        if sender.tag == 0
        {
            childrenRadio.image = UIImage(named: "radioSelectedbtn")
            adultRadio.image = UIImage(named: "radioUnselectedbtn")
            self.adultButton.isSelected = true
            self.childrenButton.isSelected = false

        }
        else
        {
            childrenRadio.image = UIImage(named: "radioUnselectedbtn")
            adultRadio.image = UIImage(named: "radioSelectedbtn")
            self.childrenButton.isSelected = true
            self.adultButton.isSelected = false

        }
    }
    
    
    @IBAction func aboutSecurityPin(_ sender: Any) {
        SharedManager.sharedInstance.showDraggablePopup(isInvalidSession:false,withTitle: "Message!", withDesc: "Security Pin, a unique identifier associated with your Prefme profile, can be used with Prefme number to request pre-check-in when you plan to travel with someone, or register your spouse, etc. Please keep your Security Pin information safe and do not share it unless required.".localized())
    }
    
    @IBAction func imageButtonClicked(_ sender: UIButton) {
        if self.delegate != nil
        {
            if self.isSave == 1
            {
                self.delegate.gotoUnsaveState(tag: self.sequenceNo)
            }
            if sender.tag == 0
            {
                self.delegate.openOptions(isForward: true, tag:self.sequenceNo, prefmeNo:self.prefmeNumberTf.text!)
            }
            else
            {
                self.delegate.openOptions(isForward: false, tag:self.sequenceNo, prefmeNo:self.prefmeNumberTf.text!)
            }
        }
    }
    
    func setInvalidPrefmeNumberFromServer()
    {
        if !self.prefmeNumberTf.validateCheck(withCustomMessageMessage: KinValidPrefmeNumber, withValidityCheck: false)
        {   }
        self.isValidatePrefmeFromServer = false
    }
    
    func resetValues()
    {
        self.prefmeNumberTf.text = ""
        self.pinNumberTf.text = ""
        self.coTravelerTF.text = ""
        self.childrenButton.layer.borderColor = UIColor(red: 101.0/255.0, green: 101.0/255.0, blue: 102.0/255.0, alpha: 1.0).cgColor
        self.childrenButton.backgroundColor = UIColor.clear
        self.childrenButton.setAttributedTitle(NSMutableAttributedString.setAttributedTextValueOnLabelWithAlphaAndColor("Child".localized(), fontSize: 19.0, fontName: KButtonFontName, alpha: 0.5, withR: 254.0, withG: 254.0, withB: 254.0), for: .normal)
        self.adultButton.backgroundColor = UIColor(red: 254.0/255.0, green: 254.0/255.0, blue: 254.0/255.0, alpha: 1.0)
        self.adultButton.layer.borderColor = UIColor(red: 254.0/255.0, green: 254.0/255.0, blue: 254.0/255.0, alpha: 1.0).cgColor
        self.adultButton.setAttributedTitle(NSMutableAttributedString.setAttributedTextValueOnLabelWithAlphaAndColor("Adult".localized(), fontSize: 19.0, fontName: KButtonFontName, alpha: 1.0, withR: 36.0, withG: 38.0, withB: 31.0), for: .normal)
        self.frontImgView.image = UIImage.init(named: "guest_detail_front")
        self.rearImgView.image = UIImage.init(named: "guest_detail_back")
        self.frontURL = ""
        self.rearURL = ""
    }
    
// 0 -> No Need to add
// -1 -> Invalidate
// 1 -> Valid go Ahead


    func getDetails(tag:String)->NSDictionary
    {
        var ageType = ""
        if self.adultButton.isSelected
        {
            ageType = "Adult"
        }
        else if self.childrenButton.isSelected
        {
             ageType = "Child"
        }
         else
        {
             ageType = ""
        }
        let tagValue = tag
        let valueInfo = ["g_type":ageType,
                         "g_prefmeno":self.prefmeNumberTf.text!,
                         "g_pin":self.pinNumberTf.text!,
                         "g_name":(self.coTravelerTF.text!).addingPercentEncoding(withAllowedCharacters: .alphanumerics),
                         "g_rearImageURL":self.rearURL,
                         "g_frontImageURL":self.frontURL,
                         "g_tag":tagValue,
                         "mobile":self.mobileTF.text!,
                         "mobcode":self.mobileVal.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? "",
                         "is_main_guest":isMainGuest
                        ] as [String : Any]
        return valueInfo as NSDictionary
    }
    
    func getDetailsForLocalSave(tag:String)->NSDictionary
    {
       var ageType = ""
       if self.adultButton.isSelected
       {
           ageType = "Adult"
       }
       else if self.childrenButton.isSelected
       {
            ageType = "Child"
       }
        else
       {
            ageType = ""
       }
        
       let tagValue = tag
       let valueInfo = ["g_type":ageType,
                        "g_prefmeno":self.prefmeNumberTf.text!,
                        "g_pin":self.pinNumberTf.text!,
                        "g_name":self.coTravelerTF.text!,
                        "g_rearImageURL":self.rearURL,
                        "g_frontImageURL":self.frontURL,
                        "g_frontActualURL":self.actualFrontURL,
                        "g_rearActualURL":self.actualRearURL,
                        "mobile":self.mobileTF.text!,
                        "mobcode":self.mobileVal.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? "",
                        "g_tag":tagValue
                        ]
       return valueInfo as NSDictionary
    }
    
    func setValidation()
    {
        self.prefmeNumberTf.dataValidationType = PSDataValidationType.prefmeNumber
        self.pinNumberTf.dataValidationType = PSDataValidationType.securePIN
        self.coTravelerTF.dataValidationType = PSDataValidationType.name
        self.mobileTF.dataValidationType = .mobileNumber
    }

    
    func setRemoteValue(prefmeNumber:String, securePin:String, guestName:String, ageType:String)
    {
        
        if ageType == "Adult".localized()
        {
            self.childrenButton.layer.borderColor = UIColor(red: 101.0/255.0, green: 101.0/255.0, blue: 102.0/255.0, alpha: 1.0).cgColor
            self.childrenButton.backgroundColor = UIColor.clear
            self.childrenButton.setAttributedTitle(NSMutableAttributedString.setAttributedTextValueOnLabelWithAlphaAndColor("Child".localized(), fontSize: 19.0, fontName: KButtonFontName, alpha: 0.5, withR: 254.0, withG: 254.0, withB: 254.0), for: .normal)
            self.adultButton.backgroundColor = UIColor(red: 254.0/255.0, green: 254.0/255.0, blue: 254.0/255.0, alpha: 1.0)
            self.adultButton.layer.borderColor = UIColor(red: 254.0/255.0, green: 254.0/255.0, blue: 254.0/255.0, alpha: 1.0).cgColor
        self.adultButton.setAttributedTitle(NSMutableAttributedString.setAttributedTextValueOnLabelWithAlphaAndColor("Adult".localized(), fontSize: 19.0, fontName: KButtonFontName, alpha: 1.0, withR: 36.0, withG: 38.0, withB: 31.0), for: .normal)
        }
        else
        {
            self.adultButton.layer.borderColor = UIColor(red: 101.0/255.0, green: 101.0/255.0, blue: 102.0/255.0, alpha: 1.0).cgColor
            self.childrenButton.setAttributedTitle(NSMutableAttributedString.setAttributedTextValueOnLabelWithAlphaAndColor("Child".localized(), fontSize: 19.0, fontName: KButtonFontName,  alpha: 1.0, withR: 36.0, withG: 38.0, withB: 31.0), for: .normal)
            self.childrenButton.backgroundColor = UIColor(red: 254.0/255.0, green: 254.0/255.0, blue: 254.0/255.0, alpha: 1.0)
            self.adultButton.backgroundColor = UIColor.clear
            self.childrenButton.layer.borderColor  = UIColor(red: 254.0/255.0, green: 254.0/255.0, blue: 254.0/255.0, alpha: 1.0).cgColor
            self.adultButton.setAttributedTitle(NSMutableAttributedString.setAttributedTextValueOnLabelWithAlphaAndColor("Adult".localized(), fontSize: 19.0, fontName: KButtonFontName, alpha: 1.0, withR: 36.0, withG: 38.0, withB: 31.0), for: .normal)
        }
        self.prefmeNumberTf.attributedText = NSMutableAttributedString.setAttributedTextValueOnLabel(isLocalizable:false, rVal: 254.0, gVal: 254.0, bVal: 254.0, alphaVal: 1.0, prefmeNumber.localized(), fontSize:19.0, fontName: KSlimButtonFontName)
        self.pinNumberTf.attributedText = NSMutableAttributedString.setAttributedTextValueOnLabel(isLocalizable:false, rVal: 254.0, gVal: 254.0, bVal: 254.0, alphaVal: 1.0, securePin, fontSize:19.0, fontName: KSlimButtonFontName)
        self.coTravelerTF.attributedText = NSMutableAttributedString.setAttributedTextValueOnLabel(isLocalizable:false, rVal: 254.0, gVal: 254.0, bVal: 254.0, alphaVal: 1.0, guestName, fontSize:19.0, fontName: KSlimButtonFontName)
    }
    
    func updateMobileCode(countryCode:String)
    {
        self.mobileCode.attributedText = NSMutableAttributedString.getCodeWithArrowAppendInEasyCheckIn(titleLabel: "", isArrowRequired: true, countryCodeAppha: 1.0, value: countryCode)
//        self.mobileTF.attributedText = attr.setAttributedTextValueOnLabel(isLocalizable:false, rVal: kFullRGB, gVal: kFullRGB, bVal: kFullRGB, alphaVal: 1.0, numberString, fontSize: 16.0, fontName: KSlimButtonFontName)
//        self.mobileCode = countryCode
    }
    
   
    
    @IBAction func codeButtonAction(_ sender:Any)
    {
        if self.isSave == 1
        {
            self.delegate.gotoUnsaveState(tag: self.sequenceNo)
        }
        self.delegate.openCountryChooseView(tag: self.sequenceNo)
    }

    @IBAction func addGuestAction(_ sender: Any) {
        self.delegate.addGuest(isPrimary:false)
    }
    
    @IBAction func expandOrShrinkAction(_ sender: UIButton) {
        if self.isShrink
        {
            sender.isSelected = true
            self.delegate.expandGuest(tag: self.sequenceNo)
//            self.btnExpand.transform = CGAffineTransform(rotationAngle: CGFloat((Double.pi / 2) * 2))

        }
        else
        {
            sender.isSelected = false
            self.delegate.shrinkGuestDetail(tag: self.sequenceNo)
//            self.btnExpand.transform = CGAffineTransform(rotationAngle: CGFloat((Double.pi / 2) * 2))
        }
    }
    
    @IBAction func removeGuestAction(_ sender: Any) {
        self.delegate.removeGuest(tag: self.tag, sequence: self.sequenceNo)
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        if self.checkValidation()
        {
            self.proceedTouploadIDProof()
//            self.delegate.saveGuest(tag: sender.tag)
        }
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        if self.isSave == 2
        {
            self.delegate.removeGuest(tag: self.tag, sequence: self.sequenceNo)
        }
        else
        {
            self.delegate.cancelGuest(tag: self.sequenceNo)
        }
    }
}

extension GuestView//:UITextFieldDelegate
{
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        activeField = textField
//        return true
//    }
//    func textField(_ textField: UITextField,
//                   shouldChangeCharactersIn range: NSRange,
//                   replacementString string: String) -> Bool
//
//    {
//        self.invalidateAllError()
//        if textField == self.prefmeNumberTf || textField == self.pinNumberTf
//        {
//            if textField.text!.count == 8
//            {
//                let number = String(format:"%@%@",textField.text!, string)
//                if number.count == 9
//                {
//                    let index = self.delegate.checkIfPrefmeNumberExist(prefme: number)
//                    if index != -1
//                    {
//                        let message = String(format: "%@ prefme no is already in use with other guest details".localized(),number)
//                        SharedManager.sharedInstance.showResponseState(title: "Prefme".localized(),
//                                                                       message: message,
//                                                                       responseType:ResponseType.Error.rawValue)
//                        {(response) in }
//                        return false
//                    }
//                }
//            }
//        }
//        return true
//    }
//    
//    // firstView.convert(buttons.frame, from:secondView)
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        activeField?.resignFirstResponder()
//        activeField = nil
//        return true
//    }
//    
    
    func settextFieldTag()
    {
        self.coTravelerTF.tag = self.sequenceNo
        self.prefmeNumberTf.tag = self.sequenceNo
        self.pinNumberTf.tag = self.sequenceNo
    }


    @objc func textFieldDidChange(_ textField: UITextField) {
        checkPrefmeValidation(activeField: textField)
    }

    func checkShouldTextFiled(textField:UITextField, val:String)->Bool
    {
        self.invalidateAllError()
        if textField == self.prefmeNumberTf || textField == self.pinNumberTf
        {
            if textField.text!.count == 8
            {
                let number = String(format:"%@%@",textField.text!, val)
                if number.count == 9
                {
                    let index = self.delegate.checkIfPrefmeNumberExist(prefme: number)
                    if index != -1
                    {
                        let message = String(format: "%@ prefme no is already in use with other guest details".localized(),number)
                        SharedManager.sharedInstance.showResponseState(title: "Prefme".localized(),
                                                                       message: message,
                                                                       responseType:ResponseType.Error.rawValue)
                        {(response) in }
                        return false
                    }
                }
            }
        }
        return true
    }
    
    func checkPrefmeValidation(activeField:UITextField)
    {
        if activeField == self.prefmeNumberTf
        {
            if self.prefmeNumberTf.text?.count == 9
            {
                if self.pinNumberTf.text?.count == 4
                {
                    self.progressIndicator.startAnimating()
                    self.getProfileInformation(prefme_no: self.prefmeNumberTf.text!, pin:self.pinNumberTf.text!)
                }
                else
                {
                    self.pinNumberTf.becomeFirstResponder()
                }
            }
            if activeField.text != self.lastValidPin{
                self.isUserInteractionEnabled = true
            }
            else
            {
                if activeField.text?.count == 9
                {
                    self.coTravelerTF.isUserInteractionEnabled = false
                }
            }
        }
        else if activeField == self.pinNumberTf
        {
            if self.pinNumberTf.text?.count == 4
            {
                if self.prefmeNumberTf.text?.count == 9
                {
                    self.progressIndicator.startAnimating()
                    self.getProfileInformation(prefme_no: self.prefmeNumberTf.text!, pin:self.pinNumberTf.text!)
                }
                else
                {
                    self.prefmeNumberTf.becomeFirstResponder()
                }
            }
            if activeField.text != self.lastValidPrefmeNo{
               self.coTravelerTF.isUserInteractionEnabled = true
            }
            else
            {
                if activeField.text?.count == 4
                {
                    self.coTravelerTF.isUserInteractionEnabled = false
                }
            }
        }
    }

    func getProfileInformation(prefme_no: String, pin:String)
    {
        self.btnSave.isUserInteractionEnabled = false
        
        var value = [String:Any]()
        value["prefme_no"] = prefme_no
        value["security_pin"] = pin
        value["lang"] = Localize.currentLanguage()

        let manager = NetworkManager()
        manager.getProfileInformation(parmas: value, showLoader: false) { (response, error) in
            DispatchQueue.main.async {
                self.btnSave.isUserInteractionEnabled = true

                if(error == nil) {
                    self.progressIndicator.stopAnimating()
                    if response?.status == 200
                    {
                        self.coTravelerTF.text = response?.spouseName
                        self.lastValidPin = pin
                        self.lastValidPrefmeNo = prefme_no
                    }
                    else
                    {
                        if !self.prefmeNumberTf.validateCheck(withCustomMessageMessage: KinValidPrefmeNumber, withValidityCheck: false)
                        {   }
                    }
                }
            }
        }
    }
    
    func checkValidation()->Bool
    {
        var isValid = true
        if self.lastValidPrefmeNo.count > 0
        {
            if self.prefmeNumberTf.text!.count > 0
            {
                if self.prefmeNumberTf.text != self.lastValidPrefmeNo
                {
                  self.prefmeNumberTf.addErrorIcon(KinValidPrefmeNumber)
                  isValid = false
                }
            }
        }else
        {
            if self.prefmeNumberTf.text!.count > 0
            {
                self.prefmeNumberTf.addErrorIcon(KinValidPrefmeNumber)
                isValid = false
            }
        }
        if self.lastValidPin.count > 0
        {
            if self.pinNumberTf.text!.count > 0
            {
                if self.pinNumberTf.text != self.lastValidPin
                {
                  self.pinNumberTf.addErrorIcon(KinValidPin)
                  isValid = false
                }
            }
        }else
        {
            if self.pinNumberTf.text!.count > 0
            {
                self.pinNumberTf.addErrorIcon(KinValidPin)
                isValid = false
            }
        }
        
        if !self.coTravelerTF.validateCheck(withCustomMessageMessage: KinValidName){
            isValid = false
        }
       
        if self.mobileTF.validate(withMessage: "Invalid mobile number".localized(), andCountryCode: self.mobileVal, countryErrorMessage: "Invalid country code".localized()) == false
        {
            isValid = false
            self.view.shakeWithVibration()
        }
        return isValid
    }
    
    func setMobileOnTextField(numberString:String, countryCode:String)
    {
        self.mobileVal = countryCode
        self.mobileCode.attributedText = NSMutableAttributedString.getCodeWithArrowAppendInEasyCheckIn(titleLabel: "", isArrowRequired: true, countryCodeAppha: 1.0, value: countryCode)
        mobileTF.attributedText = attr.val(str: numberString, fontVal: FontBook.GilroyLight.of(size: ftype.body))
    }
   
    func invalidateAllError()
    {
        self.prefmeNumberTf.inValidateInput()
        self.pinNumberTf.inValidateInput()
        self.coTravelerTF.inValidateInput()
        self.mobileTF.inValidateInput()
    }
}

extension GuestView:FileUploadHelperDelegate
{
    func proceedTouploadIDProof()
    {
        if self.frontImageData.count > 0
        {
            if self.frontURL == ""
            {
                self.startFtpFileTransFer(isForFront: true, imagedata: self.frontImageData)
                self.uploadingCount = self.uploadingCount + 1
            }
        }
        if self.rearImageData.count > 0
        {
            if self.rearURL == ""
            {
                self.startFtpFileTransFer(isForFront: false, imagedata: self.rearImageData)
                self.uploadingCount = self.uploadingCount + 1
            }
        }
        self.processToSave()
    }
    
    func startFtpFileTransFer(isForFront:Bool, imagedata:Data)
    {
        self.view.isUserInteractionEnabled = false
        let uploader = FileUploadHelper()
        uploader.delegate = self
        let fileURL = AppConstant.appInstance.fileUplaodURL
        let keyData = kAppdelegate.currentUserInfo.KnegotiationKey.data(using: String.Encoding.utf8)
        if let encData = AESCrypt.encryptDataValue(imagedata, password: keyData)
        {
           uploader.upload_GuestIDProof_request(fileURL:fileURL, postData: encData as NSData,isForFront:isForFront,viewIndex:-1)
        }
    }
      
    func fileUploadHelperResponseMethod(isStatus:Int,
                                               remoteURL:String,
                                               fileName:String,
                                               isForFront:Bool,
                                               imagedata:NSData,
                                               viewIndex:NSInteger)
    {
        self.uploadingCount = self.uploadingCount - 1
        self.isUserInteractionEnabled = true
        if isStatus == 200
        {
            DispatchQueue.main.async {
                if isForFront
                {
                    self.frontURL = fileName
                    self.actualFrontURL = remoteURL
                }
                else
                {
                    self.rearURL = fileName
                    self.actualRearURL = remoteURL
                }
                self.processToSave()
            }
        }
        else
        {
            DispatchQueue.main.async {
                self.processToSave()
            }
        }
    }
    
    func processToSave()
    {
        if self.uploadingCount == 0
        {
            self.view.isUserInteractionEnabled = true
//            self.prefmeNumberTf.isUserInteractionEnabled = false
//            self.mobileCodeBtn.isUserInteractionEnabled = false
//            self.prefmeNumberTf.isUserInteractionEnabled = false
//            self.idProodView.isUserInteractionEnabled = false
            self.delegate.saveGuest(tag: self.sequenceNo)
        }
    }
}

*/
