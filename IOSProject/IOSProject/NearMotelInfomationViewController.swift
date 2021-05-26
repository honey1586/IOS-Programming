//
//  NearMotelInfomationViewController.swift
//  IOSProject
//
//  Created by KPUGAME on 2021/05/26.
//

import UIKit

class NearMotelInfomationViewController: UIViewController {
    @IBOutlet weak var outlet_name: UILabel!
    @IBOutlet weak var outlet_image: UIImageView!
    @IBOutlet weak var outlet_addr: UILabel!
    @IBOutlet weak var outlet_tel: UILabel!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var telView: UIView!
    
    
    var motel_title : String = ""
    var motel_addr : String = ""
    var motel_mapx : String = ""
    var motel_mapy : String = ""
    var motel_image : String = ""
    var motel_tel : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageUrl = URL(string: motel_image) {
            let data = try? Data(contentsOf: imageUrl)
            outlet_image.image = UIImage(data: data!)
        } else {
            // 이미지 없을때
            let tempImage = URL(string: "https://www.thermaxglobal.com/wp-content/uploads/2020/05/image-not-found.jpg")
            let data = try? Data(contentsOf: tempImage!)
            outlet_image.image = UIImage(data: data!)
        }
        
        // Imageview resizing
        let imageRatio: CGFloat = outlet_image.image!.size.height / outlet_image.image!.size.width
        let newHeight: CGFloat = imageRatio * outlet_image.bounds.width
        imageViewHeightConstraint.constant = newHeight
        
        //outlet_image.layer.masksToBounds = true
        //outlet_image.layer.cornerRadius = 30
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        outlet_name.text = motel_title
        outlet_addr.text = motel_addr
        outlet_tel.text = motel_tel
        
        nameView.layer.cornerRadius = 20
        nameView.layer.shadowColor = UIColor.black.cgColor
        nameView.layer.shadowOffset = CGSize(width: 0, height: 0)
        nameView.layer.shadowRadius = 4
        nameView.layer.shadowOpacity = 0.10
        
        imageView.layer.cornerRadius = 20
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        imageView.layer.shadowRadius = 4
        imageView.layer.shadowOpacity = 0.10
        
        addressView.layer.cornerRadius = 20
        addressView.layer.shadowColor = UIColor.black.cgColor
        addressView.layer.shadowOffset = CGSize(width: 0, height: 0)
        addressView.layer.shadowRadius = 4
        addressView.layer.shadowOpacity = 0.10
        
        telView.layer.cornerRadius = 20
        telView.layer.shadowColor = UIColor.black.cgColor
        telView.layer.shadowOffset = CGSize(width: 0, height: 0)
        telView.layer.shadowRadius = 4
        telView.layer.shadowOpacity = 0.10
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToMotelLocation" {
            if let tourInfoLocation = segue.destination as? MotelInfoLocation {
                tourInfoLocation.locationX = motel_mapx as! NSString as String
                tourInfoLocation.locationY = motel_mapy as! NSString as String
                tourInfoLocation.name = motel_title as String
            }
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

}
