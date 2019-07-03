//
//  MyPageVC.swift
//  JJackProject
//
//  Created by SangIl Mo on 01/07/2019.
//  Copyright © 2019 SangIl Mo. All rights reserved.
//

import UIKit

class MyPageVC: UIViewController {

    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var email: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // SideMenu 열기
    @IBAction func openMenu(_ sender: Any) {
        guard let dvc = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenuVC")as? SideMenuVC else { return }
        navigationController?.pushViewController(dvc, animated: true)
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
        guard let dvc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "FirstView") as? ViewController else {return}
        simpleAlertwithHandler(title: "로그아웃 하시겠습니까?", message: "진짜로?", okHandler: {res in
            self.present(dvc, animated: true, completion: nil)
        }, cancleHandler: nil)
    }
    

}