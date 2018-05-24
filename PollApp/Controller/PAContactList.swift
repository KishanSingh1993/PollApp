//
//  PAContactList.swift
//  PollApp
//
//  Created by Ankleshwar on 24/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class PAContactList: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var contactArray = [["name": "Ankleshwar Prasad", "phone": 7503732194], ["name": "Jay", "phone": 1234888], ["name": "Krishan Kumar", "phone": 884038484023], ["name": "Puspayendra", "phone": 678] , ["name": "+917503732194", "phone": 7503732194]]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        contactArray = contactArray.sorted(by:  {($0["name"] as! String) < ($1["name"] as! String) })
        
        self.tableView.register(UINib(nibName: "GroupCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
       
    }

    func setDefaultImage(name: String) {
 
    }
    
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    public func pickColor(alphabet: Character) -> UIColor {
        let alphabetColors = [0x5A8770, 0xB2B7BB, 0x6FA9AB, 0xF5AF29, 0x0088B9, 0xF18636, 0xD93A37, 0xA6B12E, 0x5C9BBC, 0xF5888D, 0x9A89B5, 0x407887, 0x9A89B5, 0x5A8770, 0xD33F33, 0xA2B01F, 0xF0B126, 0x0087BF, 0xF18636, 0x0087BF, 0xB2B7BB, 0x72ACAE, 0x9C8AB4, 0x5A8770, 0xEEB424, 0x407887]
        let str = String(alphabet).unicodeScalars
        let unicode = Int(str[str.startIndex].value)
        if 65...90 ~= unicode {
            let hex = alphabetColors[unicode - 65]
            return UIColor(red: CGFloat(Double((hex >> 16) & 0xFF)) / 255.0, green: CGFloat(Double((hex >> 8) & 0xFF)) / 255.0, blue: CGFloat(Double((hex >> 0) & 0xFF)) / 255.0, alpha: 1.0)
        }
        return  #colorLiteral(red: 0.5568627451, green: 0.1294117647, blue: 0.5882352941, alpha: 1)
    }
    

}

extension PAContactList:UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.contactArray.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell") as! GroupCell
        
        let strName = self.contactArray[indexPath.section]["name"] as? String
        let strPhone = self.contactArray[indexPath.section]["phone"] as! Int
        cell.lblName?.text = strName
        cell.lblPhone?.text = String(strPhone)
        
        cell.lblImage.text = String(strName![(strName?.startIndex)!])
        cell.lblImage.backgroundColor = pickColor(alphabet: strName![(strName?.startIndex)!])
        cell.lblImage.isEnabled = true
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
}
