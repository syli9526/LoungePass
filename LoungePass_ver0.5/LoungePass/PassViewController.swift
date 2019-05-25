//
//  passViewController.swift
//  LoungePass
//
//  Created by MacBook on 20/05/2019.
//  Copyright © 2019 LimSoYul. All rights reserved.
//

import UIKit

class PassViewController: UIViewController,PassView {
    
    @IBOutlet var qrImageView: UIImageView!
    @IBOutlet var qrImageViewBorder: UIImageView!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userImageViewBorder: UIImageView!
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var departmentTextField: UITextField!
    @IBOutlet var collegeTextField: UITextField!
    
    let imageGenerator = ImageGenerator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setImageView(image: qrImageViewBorder)
        setImageView(image: userImageViewBorder)
        UIScreen.main.brightness = CGFloat(1.0)
        
        print (passPresenter.requestImage(key: "img"))
        print (passPresenter.requestImage(key: "qr"))
        
        DispatchQueue.global(qos: .userInitiated).async {
            // 소켓 response 대기
            //while
            while true {
                let response = passPresenter.IsResponse()
                
                if response != nil {
                    // response 후 데이터에따라 뷰에 뿌려주기
                    DispatchQueue.main.async {
                        switch response!["seqType"] as! String {
                        case "202" : self.qrImageView.image = response!["qr"] as? UIImage
                        case "204" : self.userImageView.image = response!["img"] as? UIImage
                        default: break
                        }
                    }
                }else {
                    DispatchQueue.main.async {
                        self.showAlert(Message: "서버와의 연결이 불안정합니다.")
                    }
                }
            }
        }
        
        nameTextField.text = passPresenter.getStudentInfo(key: "name")
        idTextField.text = passPresenter.getStudentInfo(key: "studentID")
        departmentTextField.text = passPresenter.getStudentInfo(key: "department")
        collegeTextField.text = passPresenter.getStudentInfo(key: "college")
        
    }
    @IBAction func logoutClick(_ sender: UIButton) {
        UIScreen.main.brightness = CGFloat(UserDefaults.standard.object(forKey: "brightness") as! Float)
        passPresenter.logoutclicked()
        present()
    }
    
    
    func setImageView(image: UIImageView) {
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.borderWidth = 0.5
        image.layer.cornerRadius = 10
    }
    
    func present() {
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "main")
        present(nextView, animated: true, completion: nil)
    }
    
    //알림창 띄우기
    func showAlert(Message: String) {
        let alert = UIAlertController(title: "", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil ))
        self.present(alert, animated: true)
    }
    
}


let passview = PassViewController()
let passPresenter = PassViewPresenter(view: passview)
