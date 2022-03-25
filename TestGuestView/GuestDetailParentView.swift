//
//  GuestDetailParentView.swift
//  PREFME
//
//  Created by admin on 09/04/21.
//  Copyright © 2021 Prefme Matrix LLC. All rights reserved.
//

import Foundation
import UIKit


protocol GuestDetailParentViewDelegate {
    func addGuestViewDelegate(guest:GuestView)
}

class GuestDetailParentView: UIView, GuestViewDetailsViewDelegate {
    var tagging = 1
    var delegate : GuestDetailParentViewDelegate!

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var expandIndex = -1
    var viewArray = NSMutableArray()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    }
   
    func addGuest(isPrimary:Bool)
    {
            // SAVE AND CANCLE BUTTON
            var difference1 = CGFloat(0)
            var initialY = self.heightConstraint.constant
            let guest :GuestView = GuestView(frame:CGRect(x: 0,
                                                          y:initialY,
                                                          width: kScreenWidth,
                                                          height:474))
            self.guestSetting(guest: guest)
            guest.delegate = self
            self.addSubview(guest)
            self.viewArray.add(guest)
            self.heightConstraint.constant = self.heightConstraint.constant + 474 - difference1
        self.tagging = self.tagging + 1
    }
    
    func updateFrame(tag:NSInteger, difference:CGFloat, isFromRemove:Bool? = false)
    {
        for i in tag..<(self.viewArray.count){
            let guest = self.viewArray.object(at: i) as! GuestView
            guest.sequenceNo = i
            if isFromRemove!
            {
                if guest.isShrink == false
                {
                    self.expandIndex = i
                }
            }
            guest.frame = CGRect(x: 0,
                                 y:guest.frame.minY + difference,
                                 width: kScreenWidth,
                                 height:guest.frame.size.height)
            
        }
    }
    
    func openOptions(isForward:Bool,tag:NSInteger, prefmeNo:String)
    {
        
    }

    
    func removeGuest(tag:NSInteger, sequence:NSInteger)
    {
            let tagVal = String(format: "G_%d", tag)
            let guest = self.viewArray.object(at: sequence) as! GuestView
            self.heightConstraint.constant = self.heightConstraint.constant - guest.frame.height
            if guest.isShrink == false
            {
                self.expandIndex = -1
            }
            guest.removeFromSuperview()
            self.viewArray.removeObject(at: sequence)
            self.updateFrame(tag: sequence, difference: -(guest.frame.height),isFromRemove:true)

    }
    func saveGuest(tag:NSInteger)
    {
        let guest = self.viewArray.object(at: tag) as! GuestView
        if guest.isSave == 2
        {
            let tagString = String(format:"G_%d",guest.tag)
//            let guestValue = guest.getDetailsForLocalSave(tag:tagString)
//            self.delegate.checkAndUpdateGuestIfUse(guestInfo: guestValue)
        }
        let previousHeight = guest.frame.size.height
        guest.userInfoView.isHidden = false
        guest.userDetailsView.isHidden = true
        guest.view.isUserInteractionEnabled = true
        
        
        if guest.prefmeNumberTf.text!.count > 0
        {
            guest.prefmeLineLbl.isHidden = true
        }
        guest.isShrink = true
        guest.userDetailsView.isHidden = true
        guest.isSave = 1
        guest.btnExpand.isSelected = false
        
        guest.pinNumberTf.isHidden = true
        guest.infoButton.isHidden = true

        guest.lblPinUndeline.isHidden = true
        guest.guestNameLbl.text = String(format:"G_%d",guest.tag)
        guest.frame = CGRect(x: 0,
                             y:guest.frame.minY,
                             width: self.frame.width,
                             height:87)
        self.heightConstraint.constant = self.heightConstraint.constant - previousHeight + 87
        let difference = previousHeight - guest.frame.height
        self.updateFrame(tag: (tag + 1), difference: -difference)
    }
    
    
    func cancelGuest(tag:NSInteger)
    {
        
    }
    func expandGuest(tag:NSInteger)
    {
        var difference1 = CGFloat(0)
        var initialY = self.heightConstraint.constant
        self.expandIndex = tag
        let guest = self.viewArray.object(at: tag) as! GuestView

        guest.isShrink = false
        let previousHeight = guest.frame.size.height

        guest.userInfoView.isHidden = false
        guest.userDetailsView.isHidden = false
        guest.coTravelerViewContainer.isHidden = true
        guest.saveView.isHidden = true
        guest.genderView.isHidden = true
        guest.pinNumberTf.isHidden = true
        guest.lblPinUndeline.isHidden = true

        
        var height = CGFloat(374)
        if guest.isPrimary
        {
            guest.prefmeNumberView.isHidden = true
            height = CGFloat(320)
        }
        else
        {
            guest.prefmeNumberView.isHidden = false
        }
        if tag == (self.viewArray.count - 1){
            self.heightConstraint.constant = self.heightConstraint.constant - previousHeight + height - difference1
            guest.frame = CGRect(x: 0,
                                 y:guest.frame.minY,
                                 width: kScreenWidth,
                                 height:height)
        }
        else
        {
            self.heightConstraint.constant = self.heightConstraint.constant - previousHeight + height - difference1
            guest.frame = CGRect(x: 0,
                                 y:guest.frame.minY,
                                 width: kScreenWidth,
                                 height:height)

        }
        let difference = previousHeight - guest.frame.height
        self.updateFrame(tag: (tag + 1), difference: -difference)
    }
    
    func shrinkGuestDetail(tag:NSInteger)
    {
        let guest = self.viewArray.object(at: tag) as! GuestView
        guest.isShrink = true
        self.expandIndex = -1
        let previousHeight = guest.frame.size.height
       
        guest.userInfoView.isHidden = false
        guest.userDetailsView.isHidden = true
        if tag == (self.viewArray.count - 1){
            self.heightConstraint.constant = self.heightConstraint.constant - previousHeight + 87.0
            guest.frame = CGRect(x: 0,
                                 y:guest.frame.minY,
                                 width: self.frame.width,
                                 height:87.0)
        }
        else
        {
            self.heightConstraint.constant = self.heightConstraint.constant - previousHeight + 87.0
            guest.frame = CGRect(x: 0,
                                 y:guest.frame.minY,
                                 width: self.frame.width,
                                 height:87.0)
            let difference = previousHeight - guest.frame.height
            self.updateFrame(tag: (tag + 1), difference: -difference)
        }
    }
    
    
    
    func checkIfPrefmeNumberExist(prefme:String)->NSInteger
    {
        return 1
    }
    func openCountryChooseView(tag:NSInteger)
    {
        
    }
    func gotoUnsaveState(tag:NSInteger)->Bool
    {
        return true
    }
    
    func guestSetting(guest:GuestView)
    {
        guest.coTravelerViewContainer.isHidden = false
        guest.userInfoView.isHidden = true

        guest.btnExpand.tag = self.viewArray.count
        guest.btnDelete.tag = self.viewArray.count
        guest.btnCancel.tag = self.viewArray.count
        guest.btnSave.tag = self.viewArray.count
        guest.userDetailsView.isHidden = false
        guest.tag = self.tagging
        guest.sequenceNo = self.viewArray.count
        guest.adultButton.isSelected = true
        guest.pinNumberTf.isHidden = false
        guest.lblPinUndeline.isHidden = false
        guest.infoButton.isHidden = false

        guest.prefmeNumberTf.isUserInteractionEnabled = true
        guest.pinNumberTf.isUserInteractionEnabled = true
        guest.coTravelerTF.isUserInteractionEnabled = true
        guest.btnExpand.isSelected = true

        guest.userInfoView.isHidden = true
        guest.userDetailsView.isHidden = false
        guest.coTravelerViewContainer.isHidden = false
        guest.genderView.isHidden = false
        guest.prefmeNumberView.isHidden = false
        guest.saveView.isHidden = false
    }
}




/*
 
 
 protocol GuestDetailParentViewDelegate {
     func addGuestViewDelegate(guest:GuestView)
     
     func openCountryCodeView(tag:NSInteger)
     func openIDProofOptions(isForward:Bool, tag:NSInteger, prefmeNo:String)
     func checkValidGuestToDelete(tag:String)->Bool
     func showMessage(resposeType:ResponseType, message:String)
     func updateAddGuestBtn(isEnabled:Bool)
     func updateBookingUnderOptions(numberOfGuests:NSInteger, tag:String)

     func updateContentInsetForGuest(guestView:GuestView, numberOfGuests:NSInteger)
     func checkAndUpdateGuestIfUse(guestInfo:NSDictionary)
     func updateViewEditing()
     func setBookingUnderOnInitial(name:String, tag:String)
 }

 class GuestDetailParentView: UIView, GuestViewDetailsViewDelegate {

     var tagging = 1
     var delegate : GuestDetailParentViewDelegate!
     var guestDetailsValues:[Any] = []

     @IBOutlet weak var heightConstraint: NSLayoutConstraint!
     var expandIndex = -1
     var viewArray = NSMutableArray()
     override init(frame: CGRect) {
         super.init(frame: frame)
         self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
     }

     required init?(coder aDecoder: NSCoder) {
     super.init(coder: aDecoder)
     }
    
     func addGuest(isPrimary:Bool)
     {
         // Info View Expanded
         if isPrimary
         {
             let guest :GuestView = GuestView(frame:CGRect(x: 0,
                                                           y:self.heightConstraint.constant,
                                                           width: self.frame.width,
                                                           height:87))
            
             guest.userInfoView.isHidden = false
             guest.userDetailsView.isHidden = true
             self.expandIndex = -1
             guest.isShrink = true
             guest.isSave = 1
             guest.btnExpand.tag = self.viewArray.count
             guest.btnDelete.tag = self.viewArray.count
             guest.btnCancel.tag = self.viewArray.count
             guest.btnSave.tag = self.viewArray.count
             guest.tag = self.tagging
             guest.sequenceNo = self.viewArray.count
             guest.pinNumberTf.isHidden = true
             guest.adultButton.isSelected = true
             guest.childrenRadio.image = UIImage(named: "radioSelectedbtn")
             guest.adultRadio.image = UIImage(named: "radioUnselectedbtn")
             guest.lblPinUndeline.isHidden = true
 //            guest.heightGenderConstraint.constant = 0
             guest.delegate = self
             guest.prefmeNumberTf.isUserInteractionEnabled = false
             guest.pinNumberTf.isUserInteractionEnabled = false
             guest.btnExpand.isSelected = true
             guest.isPrimary = true
             self.addSubview(guest)
             self.viewArray.add(guest)
             self.delegate.addGuestViewDelegate(guest: guest)
             self.heightConstraint.constant = self.heightConstraint.constant + 87
             guest.settextFieldTag()
             guest.setAsPrimaryGuest(isPrimary: true)
             let tagValue = String(format: "G_%d", self.tagging)
             self.delegate.setBookingUnderOnInitial(name: ProfileInfo.sharedProfileInstance.prepareName(), tag: tagValue)
         }
         else
         {
             // SAVE AND CANCLE BUTTON
             var difference1 = CGFloat(0)
             var initialY = self.heightConstraint.constant
             if self.expandIndex != -1
             {
                 let guest = self.viewArray.object(at: self.expandIndex) as! GuestView
                 guest.isShrink = true
                 self.expandIndex = -1
                 guest.btnExpand.isSelected = false
                 let previousHeight = guest.frame.size.height
                 
                 guest.userInfoView.isHidden = false
                 guest.userDetailsView.isHidden = true

                 guest.frame = CGRect(x: 0,
                                  y:guest.frame.minY,
                                  width: self.frame.width,
                                  height:87)
                 difference1 = previousHeight - guest.frame.height
                 self.updateFrame(tag: (guest.sequenceNo + 1), difference: -difference1)
                 initialY = initialY - difference1
             }

             
             let guest :GuestView = GuestView(frame:CGRect(x: 0,
                                                           y:initialY,
                                                           width: kScreenWidth,
                                                           height:474))//625))
             
             guest.coTravelerViewContainer.isHidden = false
             guest.userInfoView.isHidden = true

             guest.btnExpand.tag = self.viewArray.count
             guest.btnDelete.tag = self.viewArray.count
             guest.btnCancel.tag = self.viewArray.count
             guest.btnSave.tag = self.viewArray.count
             guest.userDetailsView.isHidden = false
             guest.tag = self.tagging
             guest.sequenceNo = self.viewArray.count
             guest.adultButton.isSelected = true
             guest.childrenRadio.image = UIImage(named: "radioSelectedbtn")
             guest.adultRadio.image = UIImage(named: "radioUnselectedbtn")

             guest.pinNumberTf.isHidden = false
             guest.lblPinUndeline.isHidden = false
             guest.infoButton.isHidden = false

             guest.prefmeNumberTf.isUserInteractionEnabled = true
             guest.pinNumberTf.isUserInteractionEnabled = true
             guest.coTravelerTF.isUserInteractionEnabled = true
             guest.btnExpand.isSelected = true

             guest.userInfoView.isHidden = true
             guest.userDetailsView.isHidden = false
             guest.coTravelerViewContainer.isHidden = false
             guest.genderView.isHidden = false
             guest.prefmeNumberView.isHidden = false
             guest.saveView.isHidden = false

             guest.delegate = self
             self.addSubview(guest)
             self.viewArray.add(guest)
             self.delegate.addGuestViewDelegate(guest: guest)
             self.heightConstraint.constant = self.heightConstraint.constant + 474 - difference1
             guest.settextFieldTag()
             if self.viewArray.count == 1
             {
                 guest.setAsPrimaryGuest(isPrimary: true)
             }
             
         }
         self.tagging = self.tagging + 1
     }
   
     func cancelGuest(tag:NSInteger)
     {
         let guest = self.viewArray.object(at: tag) as! GuestView
         let guestTag = guest.tag
         if tag == self.expandIndex
         {
             self.expandIndex = -1
         }
         self.heightConstraint.constant = self.heightConstraint.constant - guest.frame.height
         guest.removeFromSuperview()
         self.viewArray.removeObject(at: tag)
         self.delegate.updateAddGuestBtn(isEnabled:true)
         let tagVal = String(format: "G_%d", guestTag)
         self.delegate.updateBookingUnderOptions(numberOfGuests: self.viewArray.count, tag:tagVal)
     }

     func removeGuest(tag: NSInteger, sequence: NSInteger)
     {
         let tagVal = String(format: "G_%d", tag)
         if self.delegate.checkValidGuestToDelete(tag:tagVal)
         {
             self.delegate.showMessage(resposeType:ResponseType(rawValue: ResponseType.Error.rawValue)!,
                                       message:"This Guest information is already in use.".localized())
         }
         else
         {
             let guest = self.viewArray.object(at: sequence) as! GuestView
             self.heightConstraint.constant = self.heightConstraint.constant - guest.frame.height
             if guest.isShrink == false
             {
                 self.expandIndex = -1
             }
             guest.removeFromSuperview()
             self.viewArray.removeObject(at: sequence)
             self.updateFrame(tag: sequence, difference: -(guest.frame.height),isFromRemove:true)
             let tagValue = String(format: "G_%d", guest.tag)
             self.delegate.updateBookingUnderOptions(numberOfGuests: self.viewArray.count, tag:tagValue)
             var alreadySaved = 0
             for i in 0..<(self.viewArray.count){
                 let guest = self.viewArray.object(at: i) as! GuestView
                 if guest.isSave == 1
                 {
                     alreadySaved = alreadySaved + 1
                 }
             }
             if alreadySaved == self.viewArray.count
             {
                 self.delegate.updateAddGuestBtn(isEnabled: true)
             }
         }
     }
     
     func gotoUnsaveState(tag:NSInteger)->Bool
     {
         let guest = self.viewArray.object(at: tag) as! GuestView
         let previousHeight = guest.frame.size.height
         guest.userDetailsView.isHidden = false
         if guest.isPrimary
         {
             guest.frame = CGRect(x: 0,
                            y:guest.frame.origin.y,
                            width: kScreenWidth,
                            height:366)
             guest.userInfoView.isHidden = false
             guest.coTravelerViewContainer.isHidden = true
             guest.genderView.isHidden = true
             guest.prefmeNumberView.isHidden = true

         }
         else
         {
             guest.frame = CGRect(x: 0,
                            y:guest.frame.origin.y,
                            width: kScreenWidth,
                            height:474)
             guest.userInfoView.isHidden = true
             guest.coTravelerViewContainer.isHidden = false
             guest.genderView.isHidden = false
             guest.prefmeNumberView.isHidden = false
         }
         guest.saveView.isHidden = false
         guest.isSave = 2
         self.expandIndex = -1
         guest.coTravelerViewContainer.isHidden = false
         guest.btnExpand.tag = tag
         guest.btnDelete.tag = tag
         guest.btnCancel.tag = tag
         guest.btnSave.tag = tag
         guest.pinNumberTf.isHidden = false
         guest.lblPinUndeline.isHidden = false
         guest.coTravelerTF.isUserInteractionEnabled = true
         guest.btnExpand.isSelected = true
         guest.userDetailsView.isHidden = false
         self.heightConstraint.constant = self.heightConstraint.constant - previousHeight + guest.frame.height
         let difference = previousHeight - guest.frame.height
         self.updateFrame(tag: (tag + 1), difference: -difference)
         self.delegate.updateAddGuestBtn(isEnabled: false)
         return true
     }
     
     func saveGuest(tag:NSInteger)
     {
         
         let guest = self.viewArray.object(at: tag) as! GuestView
         if guest.isSave == 2
         {
             let tagString = String(format:"G_%d",guest.tag)
             let guestValue = guest.getDetailsForLocalSave(tag:tagString)
             self.delegate.checkAndUpdateGuestIfUse(guestInfo: guestValue)
         }
         let previousHeight = guest.frame.size.height
         guest.userInfoView.isHidden = false
         guest.userDetailsView.isHidden = true
         guest.view.isUserInteractionEnabled = true
         
         
         if guest.prefmeNumberTf.text!.count > 0
         {
             guest.prefmeLineLbl.isHidden = true
         }
         guest.isShrink = true
         guest.userDetailsView.isHidden = true
         guest.isSave = 1
         guest.btnExpand.isSelected = false
         
         guest.pinNumberTf.isHidden = true
         guest.infoButton.isHidden = true

         guest.lblPinUndeline.isHidden = true
         guest.guestNameLbl.attributedText = attr.val(str:guest.coTravelerTF.text!, fontVal: FontBook.regular.of(size: ftype.body))
         guest.frame = CGRect(x: 0,
                              y:guest.frame.minY,
                              width: self.frame.width,
                              height:87)
         self.heightConstraint.constant = self.heightConstraint.constant - previousHeight + 87
         let difference = previousHeight - guest.frame.height
         self.updateFrame(tag: (tag + 1), difference: -difference)
         self.delegate.updateAddGuestBtn(isEnabled: true)
         self.delegate.updateContentInsetForGuest(guestView: guest, numberOfGuests: self.viewArray.count)
         self.delegate.updateViewEditing()
     }
     
     
     func shrinkGuestDetail(tag:NSInteger)
     {
         let guest = self.viewArray.object(at: tag) as! GuestView
         guest.isShrink = true
         self.expandIndex = -1
         let previousHeight = guest.frame.size.height
        
         guest.userInfoView.isHidden = false
         guest.userDetailsView.isHidden = true
         if tag == (self.viewArray.count - 1){
             self.heightConstraint.constant = self.heightConstraint.constant - previousHeight + 87.0
             guest.frame = CGRect(x: 0,
                                  y:guest.frame.minY,
                                  width: self.frame.width,
                                  height:87.0)
         }
         else
         {
             self.heightConstraint.constant = self.heightConstraint.constant - previousHeight + 87.0
             guest.frame = CGRect(x: 0,
                                  y:guest.frame.minY,
                                  width: self.frame.width,
                                  height:87.0)
             let difference = previousHeight - guest.frame.height
             self.updateFrame(tag: (tag + 1), difference: -difference)
         }
         self.delegate.updateViewEditing()
     }
     
     func expandGuest(tag:NSInteger)
     {
         var difference1 = CGFloat(0)
         var initialY = self.heightConstraint.constant
         if self.expandIndex != -1
         {
             
             let guest = self.viewArray.object(at: self.expandIndex) as! GuestView
             if guest.isShrink == false
             {
                 guest.isShrink = true
                 guest.btnExpand.isSelected = false
                 let previousHeight = guest.frame.size.height
                 guest.userInfoView.isHidden = false
                 guest.userDetailsView.isHidden = true
                 guest.coTravelerViewContainer.isHidden = true
                 guest.frame = CGRect(x: 0,
                                  y:guest.frame.minY,
                                  width: self.frame.width,
                                  height:87.0)
                 difference1 = previousHeight - guest.frame.height
                 self.updateFrame(tag: (guest.sequenceNo + 1), difference: -difference1)
                 initialY = initialY - difference1
             }
         }
         
         
         
         let guest = self.viewArray.object(at: tag) as! GuestView
         self.expandIndex = tag
         guest.isShrink = false
         let previousHeight = guest.frame.size.height

         guest.userInfoView.isHidden = false
         guest.userDetailsView.isHidden = false
         guest.coTravelerViewContainer.isHidden = true
         guest.saveView.isHidden = true
         guest.genderView.isHidden = true
         guest.pinNumberTf.isHidden = true
         guest.lblPinUndeline.isHidden = true

         
         var height = CGFloat(374)
         if guest.isPrimary
         {
             guest.prefmeNumberView.isHidden = true
             height = CGFloat(320)
         }
         else
         {
             guest.prefmeNumberView.isHidden = false
         }
         if tag == (self.viewArray.count - 1){
             self.heightConstraint.constant = self.heightConstraint.constant - previousHeight + height - difference1
             guest.frame = CGRect(x: 0,
                                  y:guest.frame.minY,
                                  width: kScreenWidth,
                                  height:height)
         }
         else
         {
             self.heightConstraint.constant = self.heightConstraint.constant - previousHeight + height - difference1
             guest.frame = CGRect(x: 0,
                                  y:guest.frame.minY,
                                  width: kScreenWidth,
                                  height:height)

         }
         let difference = previousHeight - guest.frame.height
         self.updateFrame(tag: (tag + 1), difference: -difference)
     }
     
     func openCountryChooseView(tag:NSInteger)
     {
         self.delegate.openCountryCodeView(tag: tag)
     }
     
     func updateCountryCodeForTag(tagVal:NSInteger, codeVal:String)
     {
         let guestView = self.viewArray[tagVal] as? GuestView
         guestView!.setMobileOnTextField(numberString:(guestView?.mobileTF.text)!, countryCode:codeVal)
     }
   
     func updateFrame(tag:NSInteger, difference:CGFloat, isFromRemove:Bool? = false)
     {
         for i in tag..<(self.viewArray.count){
             let guest = self.viewArray.object(at: i) as! GuestView
             guest.sequenceNo = i
             if isFromRemove!
             {
                 if guest.isShrink == false
                 {
                     self.expandIndex = i
                 }
             }
             guest.settextFieldTag()
             guest.frame = CGRect(x: 0,
                                  y:guest.frame.minY + difference,
                                  width: kScreenWidth,
                                  height:guest.frame.size.height)
             
         }
     }
     
     func checkIfPrefmeNumberExist(prefme:String)->NSInteger
     {
         var index = -1
         for i in 0 ..< self.viewArray.count
         {
             let guestDetailsView = self.viewArray.object(at: i) as! GuestView
             if guestDetailsView.prefmeNumberTf.text! == prefme
             {
                 index = i
                 break
             }
         }
         return index
     }
     
     func openOptions(isForward:Bool,tag:NSInteger, prefmeNo:String)
     {
         self.delegate.openIDProofOptions(isForward: isForward, tag:tag, prefmeNo:prefmeNo)
     }
    
     func setImageonLocal(tag:NSInteger, image:UIImage, imageData:Data, isForward:Bool)->UIImageView
     {
         if isForward
         {
             let guest = self.viewArray[tag] as? GuestView
             guest?.frontImageData = imageData
             guest?.frontImgView.image = image
           
             guest?.actualFrontURL = ""
             guest?.frontURL = ""

             return guest?.frontImgView! as! UIImageView
         }
         else
         {
             let guest = self.viewArray[tag] as? GuestView
             guest?.rearImageData = imageData
             guest?.rearImgView.image = image
             
             guest?.actualRearURL = ""
             guest?.rearURL = ""
             
             return guest?.rearImgView! as! UIImageView
         }
     }
     
     func selectedID(dict:NSDictionary, tag:NSInteger)
     {
         if dict.object(forKey: "id_type") != nil
         {
             let guestView = self.viewArray.object(at: tag) as! GuestView
             var mainGuestFrontURL = ""
             var mainGuestRearURL = ""
             guestView.frontURL = ""
             guestView.rearURL = ""
             guestView.actualRearURL = ""
             guestView.actualFrontURL = ""
             if dict.object(forKey: "id_front") != nil
             {
                 mainGuestFrontURL = dict.object(forKey: "id_front") as! String
                 guestView.actualFrontURL = mainGuestFrontURL
             }
             if dict.object(forKey: "id_rear") != nil
             {
                 mainGuestRearURL = dict.object(forKey:"id_rear") as! String
                 guestView.actualRearURL = mainGuestRearURL
             }
             if dict.object(forKey: "id_front_name") != nil
             {
                 let frontName = dict.object(forKey:"id_front_name" ) as! String
                 guestView.frontURL = frontName
             }
             if dict.object(forKey: "id_rear_name") != nil
             {
                 let rearName = dict.object(forKey:"id_rear_name" ) as! String
                 guestView.rearURL = rearName
             }

             
             self.loadIDIfSelf(mainGuestFrontURL: mainGuestFrontURL, mainGuestRearURL: mainGuestRearURL, guestView: guestView)
         }
     }
     
     func loadIDIfSelf(mainGuestFrontURL:String, mainGuestRearURL:String, guestView:GuestView)
     {
         DispatchQueue.main.async
         {
             if guestView.prefmeNumberTf.text == String(describing: kAppdelegate.currentUserInfo.SuggestedPrefmeVal)
             {
                 if mainGuestFrontURL.count > 0
                 {
                     guestView.frontImgView.loadEncryptedDataUsingCache(withUrl: mainGuestFrontURL, placeholderString: "guest_detail_front", isWhite: true)
                 }
                 else
                 {
                     guestView.frontImgView.image = UIImage(named: "guest_detail_front")
                 }
                 
                 if mainGuestRearURL.count > 0
                 {
                     guestView.rearImgView.loadEncryptedDataUsingCache(withUrl: mainGuestRearURL, placeholderString: "guest_detail_back", isWhite: true)
                 }
                 else
                 {
                     guestView.rearImgView.image = UIImage(named: "guest_detail_back")
                 }
             }
         }
     }
     
     func setBookUnder(tag:NSInteger)->Bool
     {
         var prefmeNo = ""
         for i in 0..<(self.viewArray.count){
             let guest = self.viewArray.object(at: i) as! GuestView
             if i == tag{
                 guest.isMainGuest = "true"
                 prefmeNo = guest.prefmeNumberTf.text!
                 guest.setAsPrimaryGuest(isPrimary: true)
             }
             else
             {
                 guest.isMainGuest = "false"
                 guest.setAsPrimaryGuest(isPrimary: false)
             }
         }
         let myPrefmeNo = String(describing: kAppdelegate.currentUserInfo.SuggestedPrefmeVal)
         if myPrefmeNo == prefmeNo{
             return true
         }
         else
         {
             return false
         }
     }
     
     func getGuestsDetails()->[AnyObject]
     {
         var guestDetailsValues:[AnyObject] = []
         for i in 0 ..< viewArray.count
         {
             let guestView = self.viewArray.object(at: i) as! GuestView
             if guestView.isSave == 1 || guestView.isSave == 2{
                 let tagString = String(format:"G_%d",guestView.tag)
                 let guestValue = guestView.getDetailsForLocalSave(tag:tagString)
                 guestDetailsValues.append(guestValue)
             }
         }
         return guestDetailsValues
     }
     
     func getAllGuestViews()->[GuestView]
     {
         var guestDetailsValues:[GuestView] = []
         for i in 0 ..< viewArray.count
         {
             let guestView = self.viewArray.object(at: i) as! GuestView
             if guestView.isSave == 1 || guestView.isSave == 2{
                 guestDetailsValues.append(guestView)
             }
         }
         return guestDetailsValues
     }
     
     
     func checkTextFiledAndProcess(textFiled:UITextField, replaceChar:String)->Bool
     {
         let tag = textFiled.tag
         if tag != -1 || tag < self.viewArray.count
         {
             let guestView = self.viewArray.object(at: tag) as? GuestView
             return (guestView!.checkShouldTextFiled(textField:textFiled, val:replaceChar))
             
         }
         return true
     }
     
     func getGuestsDetailsForPreCheckin(isMainGuest:Bool)->(String, Bool)
     {
         var isValid = true
         var guestDetailsValues:[Any] = []
         for i in 0 ..< self.viewArray.count
         {
             let guestDetailsView = self.viewArray.object(at: i) as! GuestView
             let tagString = String(format:"G_%d",guestDetailsView.tag)
             if isMainGuest == false
             {
                 if i == 0
                 {
                     guestDetailsView.isMainGuest = "true"
                 }
             }
             if guestDetailsView.isPrimary
             {
                 let guestValue = guestDetailsView.getDetails(tag:tagString)
                 guestDetailsValues.append(guestValue)
             }
             else
             {
                 if guestDetailsView.checkValidation()
                 {
                     let guestValue = guestDetailsView.getDetails(tag:tagString)
                     guestDetailsValues.append(guestValue)
                 }
                 else
                 {
                     isValid = false
                 }
             }
         }
         if guestDetailsValues.count == 0
         {
             return ("", false)
         }
         return (json(from: guestDetailsValues)!, isValid)
     }
   
     func json(from object:Any) -> String? {
         guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
             return nil
         }
         return String(data: data, encoding: String.Encoding.utf8)
     }

     func checkTextFields(textField:UITextField)//->Bool
     {
         var sequence = -1
         for i in tag..<(self.viewArray.count){
             let guestView = self.viewArray.object(at: i) as! GuestView
             if guestView.prefmeNumberTf == textField || guestView.mobileTF == textField
             {
                 sequence = guestView.sequenceNo
             }
         }
         if sequence != -1
         {
             let guestView = self.viewArray.object(at: sequence) as! GuestView
             if guestView.isSave == 0 || guestView.isSave == 2
             {
             }
             else
             {
                 let isNeedEdit = self.gotoUnsaveState(tag: sequence)
             }
           //  return isNeedEdit
         }
        // return true
     }
     
     func resetIsMainGuest()
     {
         for i in tag..<(self.viewArray.count){
             let guestView = self.viewArray.object(at: i) as! GuestView
             guestView.isMainGuest = "false"
         }
     }
     
     func setAsPrimaryGuest()
     {
         if self.viewArray.count == 1
         {
             let guestView = self.viewArray.object(at: 0) as! GuestView
             guestView.setAsPrimaryGuest(isPrimary: true)
         }
     }
 }

 
 */
