//
//  MyPageVC.swift
//  JJackProject
//
//  Created by SangIl Mo on 01/07/2019.
//  Copyright © 2019 SangIl Mo. All rights reserved.
//

import UIKit
import SideMenu

class MyPageVC: UIViewController {
    
    @IBOutlet weak var ownBerry: UILabel!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var email: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        print("----------------- My Page ------------------")
    }
    override func viewWillAppear(_ animated: Bool) {
        setup()
    }

    func setup() {
        self.ownBerry.text = String(UserDefaults.standard.integer(forKey: "ownBerry"))
        self.nickName.text = UserDefaults.standard.string(forKey: "nickname")
        self.email.text = UserDefaults.standard.string(forKey: "email")
    }
    
    @IBAction func goHome(_ sender: Any) {
        backHome()
    }
    // SideMenu 열기
    @IBAction func openMenu(_ sender: Any) {
        showMenu()
    }
    // Nickname, email 다음 뷰로 넘겨주기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "goEditSegue":
            let sendNickname = self.nickName.text
            let sendEmail = self.email.text
            let dvc = segue.destination as! EditAccoutVC
            dvc.paramName = sendNickname!
            dvc.paramEmail = sendEmail!
        default:
            break
        }
    }
    @IBAction func viewHistory(_ sender: Any) {
        guard let dvc = storyboard?.instantiateViewController(withIdentifier: "UseHistoryVC")as? UseHistoryVC else {return}
        navigationController?.pushViewController(dvc, animated: true)
        
    }
    
    @IBAction func logoutBtn(_ sender: UIButton) {
        simpleAlertwithHandler(title: "로그아웃 하시겠습니까?", message: "", okHandler: {res in
            self.performSegue(withIdentifier: "toLogin", sender: self)
            UserDefaults.standard.set(false, forKey: "didSignup")
            UserDefaults.standard.set("", forKey: "email")
            UserDefaults.standard.set("", forKey: "password")
            print("\n\n\n$ 로그아웃 $ \n")
        }, cancleHandler: nil)
       
    }
    
}
