//
//  TourInfosViewController.swift
//  IOSProject
//
//  Created by KPUGAME on 2021/05/23.
//

import UIKit

class TourInfosViewController: UIViewController , XMLParserDelegate {
    @IBOutlet weak var outlet_showInformation: UIButton!
    @IBOutlet weak var outlet_showLocation: UIButton!
    @IBOutlet weak var outlet_showWeather: UIButton!
    @IBOutlet weak var outlet_nearMotel: UIButton!
    
    
    var weather_sido_temp2: String = ""
    var weather_sigugun_temp2: String = ""
    
    var motel_sidocode_temp2 : String = ""
    var motel_siguguncode_temp2: String = ""
    
    var keyword_sidocode_temp : String = ""
    var keyword_sigungucode_temp : String = ""
    
    var contentid : String = ""
    var detailurl : String = ""
    
    var parser = XMLParser()
    var posts = NSMutableArray()
    
    //title과 date 같은 feed 데이터를 저장하는 mutable dictionary
    var elements = NSMutableDictionary()
    var element = NSString()
    
    //저장 문자열 변수
    var name = NSMutableString()
    var addr1 = NSMutableString()
    //설명
    var overview = NSMutableString()
    
    //위도 경도 좌표 변수
    var mapx = NSMutableString()
    var mapy = NSMutableString()
    
    //image url
    var firstimage = NSMutableString()
    
    //homepage url
    var homepage = NSMutableString()
    
    //전화번호
    var tel = NSMutableString()
    
    
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf: (URL(string:detailurl)!))!
        parser.delegate = self
        parser.parse()
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String? , qualifiedName qName: String? , attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if(elementName as NSString).isEqual(to: "item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            name = NSMutableString()
            name = ""
            addr1 = NSMutableString()
            addr1 = ""
            overview = NSMutableString()
            overview = ""
            mapx = NSMutableString()
            mapx = ""
            mapy = NSMutableString()
            mapy = ""
            firstimage = NSMutableString()
            firstimage = ""
            homepage = NSMutableString()
            homepage = ""
            tel = NSMutableString()
            tel = ""
            
        }
    }
    
    func parser(_ parser: XMLParser , foundCharacters string: String)
    {
        if element.isEqual(to: "title"){
            name.append(string)
        } else if element.isEqual(to: "addr1"){
            addr1.append(string)
        } else if element.isEqual(to: "overview"){
            overview.append(string)
        } else if element.isEqual(to: "mapx"){
            mapx.append(string)
        } else if element.isEqual(to: "mapy"){
            mapy.append(string)
        } else if element.isEqual(to: "firstimage"){
            firstimage.append(string)
        } else if element.isEqual(to: "homepage"){
            homepage.append(string)
        } else if element.isEqual(to: "tel"){
            tel.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String? , qualifiedName qName: String?)
    {
        if(elementName as NSString).isEqual(to: "item"){
            if !name.isEqual(nil){
                elements.setObject(name, forKey: "title" as NSCopying)
            }
            if !addr1.isEqual(nil)
            {
                elements.setObject(addr1, forKey: "addr1" as NSCopying)
            }
            if !overview.isEqual(nil){
                elements.setObject(overview, forKey: "overview" as NSCopying)
            }
            if !mapx.isEqual(nil)
            {
                elements.setObject(mapx, forKey: "mapx" as NSCopying)
            }
            if !mapy.isEqual(nil){
                elements.setObject(mapy, forKey: "mapy" as NSCopying)
            }
            if !firstimage.isEqual(nil)
            {
                elements.setObject(firstimage, forKey: "firstimage" as NSCopying)
            }
            if !homepage.isEqual(nil){
                elements.setObject(homepage, forKey: "homepage" as NSCopying)
            }
            if !tel.isEqual(nil)
            {
                elements.setObject(tel, forKey: "tel" as NSCopying)
            }
            
            posts.add(elements)
        }
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToInformation"{
            if let tourinformationViewController = segue.destination as? TourInformationViewController{
                tourinformationViewController.name = name as String
                tourinformationViewController.firstImage = firstimage as String
                tourinformationViewController.address = addr1 as String
                tourinformationViewController.telephone = tel as String
                tourinformationViewController.overview = overview as String
            }
        }
        if segue.identifier == "segueToLocation" {
            if let tourInfoLocation = segue.destination as? TourInfoLocation {
                tourInfoLocation.locationX = mapx as! NSString as String
                tourInfoLocation.locationY = mapy as! NSString as String
                tourInfoLocation.name = name as String
            }
        }
        if segue.identifier == "segueToWeather" {
            if let tourweather = segue.destination as? TourWeatherViewController {
                if keyword_sidocode_temp == "" {
                    tourweather.weather_sido = weather_sido_temp2
                    tourweather.weather_sigugun = weather_sigugun_temp2
                } else {
                    tourweather.weather_sido = keyword_sidocode_temp
                    tourweather.weather_sigugun = keyword_sigungucode_temp
                }
                
            }
        }
        if segue.identifier == "segueToMotel" {
            if let nearMotel = segue.destination as? NearMotelTableViewController {
                if keyword_sidocode_temp == "" {
                    nearMotel.motel_sido_code = motel_sidocode_temp2
                    nearMotel.motel_sigugun_code = motel_siguguncode_temp2
                } else {
                    nearMotel.motel_sido_code = keyword_sidocode_temp
                    nearMotel.motel_sigugun_code = keyword_sigungucode_temp
                }

            }
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        // Do any additional setup after loading the view.
        
        //print("detailurl : " + detailurl)
        //print("contentid : " + contentid!)
        
        // Button custom
        customButton(button: outlet_showInformation)
        customButton(button: outlet_showLocation)
        customButton(button: outlet_showWeather)
        customButton(button: outlet_nearMotel)
    }
    
    
    func customButton(button: UIButton) {
        button.setTitleColor(.white, for: .normal)
        button.titleLabel!.font = UIFont(name: "IBMPlexSansKR-Light.otf", size: 20.0)
        button.tintColor = .white
        button.layer.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0).cgColor
        button.layer.cornerRadius = button.bounds.height / 2.0
        
    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     
    */
    

    @IBAction func action_ShowInformation(_ sender: Any) {
        performSegue(withIdentifier: "segueToInformation", sender: nil)
    }
    @IBAction func action_showLocation(_ sender: Any) {
        performSegue(withIdentifier: "segueToLocation", sender: nil)
    }
    @IBAction func action_showWeather(_ sender: Any) {
        performSegue(withIdentifier: "segueToWeather", sender: nil)
    }
    @IBAction func action_nearMotel(_ sender: Any) {
        performSegue(withIdentifier: "segueToMotel", sender: nil)
    }
    
    
}
