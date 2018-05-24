//
//  PAProfile.swift
//  PollApp
//
//  Created by Ankleshwar on 13/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import Contacts



class PAProfile: BaseViewController {

    @IBOutlet weak var viewPersonal: UIView!
    
     @IBOutlet weak var viewCorporate: UIView!
    @IBOutlet weak var lblPersonal: UILabel!
    
    @IBOutlet weak var lblCorporates: UILabel!
    @IBOutlet weak var viewEvent: UIView!
    
    @IBOutlet weak var lblEvent: UILabel!
    
    @IBOutlet weak var viewMain: UIView!
    
    let contactStore = CNContactStore()
    var contacts = [CNContact]()
    let keys = [
        CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
        CNContactPhoneNumbersKey,
        CNContactEmailAddressesKey
        ] as [Any]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView().setShadow(viewMain)
        setShadow(viewPersonal)
        setShadow(viewCorporate)
        setShadow(viewEvent)
        
        print(self.appUserObject?.access_token)
        lblPersonal.numberOfLines = 0
        lblPersonal.text = "Personal\nProfile"
        lblCorporates.text = "Corporate\nProfile"
         lblEvent.text = "Event\nProfile"
        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            
            self.getContact()
        }
        
    }

    @IBAction func clickToDone(_ sender: Any) {
        let vc = PAHomeVC(nibName: "PAHomeVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        UserDefaults.standard.set(3, forKey: "isLogin")
        UserDefaults.standard.synchronize()
    }
    
    func setShadow(_ view: UIView){
        
        
    
 
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 2
        view.layer.borderColor = #colorLiteral(red: 0.9568627451, green: 0.6196078431, blue: 0.007843137255, alpha: 1).cgColor
    }
    

  @objc  func getContact(){
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        do {
            try contactStore.enumerateContacts(with: request){
                (contact, stop) in
                // Array containing all unified contacts from everywhere
                self.contacts.append(contact)
                for phoneNumber in contact.phoneNumbers {
                    if let number = phoneNumber.value as? CNPhoneNumber, let label = phoneNumber.label {
                        let localizedLabel = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
                        print("\(contact.givenName) \(contact.familyName) tel:\(localizedLabel) -- \(number.stringValue), email: \(contact.emailAddresses)")
                    }
                }
            }
            print(contacts)
        } catch {
            print("unable to fetch contacts")
    }
}
    @IBAction func clickToPersonal(_ sender: Any) {
   
    }
    
    
    
    
}
