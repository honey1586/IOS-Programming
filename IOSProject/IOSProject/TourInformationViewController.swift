//
//  TourInformationViewController.swift
//  IOSProject
//
//  Created by KPUGAME on 2021/05/23.
//

import UIKit

class TourInformationViewController: ViewController {
    @IBOutlet weak var outlet_name: UILabel!
    @IBOutlet weak var outlet_image: UIImageView!
    @IBOutlet weak var outlet_address: UILabel!
    @IBOutlet weak var outlet_tel: UILabel!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    var name : String = ""
    var firstImage: String = ""
    var address: String = ""
    var telephone: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageUrl = URL(string: firstImage) {
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
        
        outlet_name.text = name
        outlet_address.text = address
        outlet_tel.text = telephone
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
