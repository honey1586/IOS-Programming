//
//  ViewController.swift
//  IOSProject
//
//  Created by Jang Jaeyeong on 2021/05/17.
//

import UIKit
import CoreLocation

class ViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource , CLLocationManagerDelegate , XMLParserDelegate{
    var result: Result?
    
    var selectSido: String = "서울" // 디폴트
    var selectSigugun: String = "강남구" // 디폴트
    
    // url에 넣기 위한 코드로 변환할 변수
    var sidoCode : String = "1"
    var sigugunCode : String = "1"
        
    var url : String = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?serviceKey=rFxQesfrwsUpDLk8%2Bxq5xlWa92la4nvY8MRzJZ8ogAmu79D5MPF%2FFyBcvJDYAggvw4%2FmDB7ZFlIg6MnWU2VCSA%3D%3D&numOfRows=50&pageNo=1&MobileApp=TourAPI3.0_Guide&MobileOS=ETC&arrange=A&cat1=&contentTypeId=&areaCode="
    
    
    /// 근처 관광지 찾기 변수
    var nearTour_url : String = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/locationBasedList?serviceKey=rFxQesfrwsUpDLk8%2Bxq5xlWa92la4nvY8MRzJZ8ogAmu79D5MPF%2FFyBcvJDYAggvw4%2FmDB7ZFlIg6MnWU2VCSA%3D%3D&numOfRows=5&pageNo=1&MobileOS=ETC&MobileApp=AppTest&arrange=B&contentTypeId=12&radius=1000&listYN=Y&mapX=126.981611&mapY=37.568477"
    var myLatitude: Double?
    var myLongitude : Double?
    var locationManager:CLLocationManager!
    
    var nearTour_parser = XMLParser()
    var nearTour_posts = NSMutableArray()
    
    var nearTour_elements = NSMutableDictionary()
    var nearTour_element = NSString()
    
    var nearTour_title1 = NSMutableString()
    var nearTour_image = NSMutableString()
    
    var nearTour_contentid = NSMutableString()
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var outlet_seartchView: UIView!
    @IBOutlet weak var outlet_searchButton: UIButton!
    
    @IBOutlet weak var nearView: UIView!
    @IBOutlet weak var nearStackView: UIStackView!
    @IBOutlet weak var recommendView: UIView!
    @IBOutlet weak var recommendStackView: UIStackView!
    
    var randomsido : [String] = []
    
    private func beginParsing()
    {
        nearTour_posts = []
        nearTour_parser = XMLParser(contentsOf: (URL(string:nearTour_url))!)!
        nearTour_parser.delegate = self
        nearTour_parser.parse()
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String? , qualifiedName qName: String? , attributes attributeDict: [String : String])
    {
        nearTour_element = elementName as NSString
        if(elementName as NSString).isEqual(to: "item")
        {
            nearTour_elements = NSMutableDictionary()
            nearTour_elements = [:]
            nearTour_title1 = NSMutableString()
            nearTour_title1 = ""
            nearTour_contentid = NSMutableString()
            nearTour_contentid = ""
        }
    }
    func parser(_ parser: XMLParser , foundCharacters string: String)
    {
        if nearTour_element.isEqual(to: "title"){
            nearTour_title1.append(string)
        } else if nearTour_element.isEqual(to: "firstimage"){
            nearTour_image.append(string)
        } else if nearTour_element.isEqual(to: "contentid") {
            nearTour_contentid.append(string)
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String? , qualifiedName qName: String?)
    {
        if(elementName as NSString).isEqual(to: "item"){
            if !nearTour_title1.isEqual(nil){
                nearTour_elements.setObject(nearTour_title1, forKey: "title" as NSCopying)
            }
            if !nearTour_image.isEqual(nil){
                nearTour_elements.setObject(nearTour_image, forKey: "firstimage" as NSCopying)
            }
            if !nearTour_contentid.isEqual(nil){
                nearTour_elements.setObject(nearTour_contentid, forKey: "contentid" as NSCopying)
            }
            
            nearTour_posts.add(nearTour_elements)
        }
    }
    
    var motel_urlString = " http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchStay?serviceKey=rFxQesfrwsUpDLk8%2Bxq5xlWa92la4nvY8MRzJZ8ogAmu79D5MPF%2FFyBcvJDYAggvw4%2FmDB7ZFlIg6MnWU2VCSA%3D%3D&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&arrange=A&listYN=Y"
    
    func getMyLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.startUpdatingLocation()
        
        let coor = locationManager.location?.coordinate
        myLatitude = coor?.latitude
        myLongitude = coor?.longitude
    }
    
    @IBAction func doneToPickerViewController(segue:UIStoryboardSegue){
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view {
            label = v as! UILabel
        }
        label.font = UIFont(name: "IBMPlexSansKR-Light", size: 20)
        if component == 0 {
            label.text = result!.data[row].title
            randomsido.append(result!.data[row].title)
            
        }
        else {
            let selectedSido = pickerView.selectedRow(inComponent: 0)
            label.text = result!.data[selectedSido].items[row]
        }
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return result!.data.count
        }
        else {
            let selectedSido = pickerView.selectedRow(inComponent: 0)
            return result!.data[selectedSido].items.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return result!.data[row].title
        }
        else {
            let selectedSido = pickerView.selectedRow(inComponent: 0)
            return result!.data[selectedSido].items[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            let selectedSido = pickerView.selectedRow(inComponent: 0)
            let sido = result!.data[selectedSido].title
            selectSido = sido
            selectSigugun = result!.data[selectedSido].items[0]
            
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)
        }
        else {
            let selectedSido = pickerView.selectedRow(inComponent: 0)
            let selectedSigugun = pickerView.selectedRow(inComponent: 1)
            let sigugun = result!.data[selectedSido].items[selectedSigugun]
            selectSigugun = sigugun
            sigugunCode = String(pickerView.selectedRow(inComponent: 1) + 1)
        }
        
        
    }
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToTableView"{
            if let tourlistTableViewController = segue.destination as? TourlistTableViewController{
                    changeNameToCode(sidoName: selectSido)
                    tourlistTableViewController.url = url + sidoCode + "&sigunguCode=" + sigugunCode + "&cat2=&cat3=&listYN=Y&modifiedtime=&"
                    tourlistTableViewController.result = result
                    tourlistTableViewController.weather_sido_temp = selectSido
                    tourlistTableViewController.weather_sigugun_temp = selectSigugun
                    tourlistTableViewController.motel_sidocode_temp = sidoCode
                    tourlistTableViewController.motel_siguguncode_temp = sigugunCode
            }
        }
    }
    
    
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJson()
        getMyLocation()
        beginParsing()
   
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        if let searchButton = outlet_searchButton {
            searchButton.layer.cornerRadius = searchButton.bounds.height / 2.0
        }
        if let searchView = outlet_seartchView {
            searchView.layer.cornerRadius = 25
            searchView.layer.shadowColor = UIColor.black.cgColor
            searchView.layer.shadowOffset = CGSize(width: 0, height: 0)
            searchView.layer.shadowRadius = 4
            searchView.layer.shadowOpacity = 0.2
        }
        if let tempNearView = nearView {
            tempNearView.layer.cornerRadius = 25
            tempNearView.layer.shadowColor = UIColor.black.cgColor
            tempNearView.layer.shadowOffset = CGSize(width: 0, height: 0)
            tempNearView.layer.shadowRadius = 4
            tempNearView.layer.shadowOpacity = 0.2
        }
        if let tempRecommendView = recommendView {
            tempRecommendView.layer.cornerRadius = 25
            tempRecommendView.layer.shadowColor = UIColor.black.cgColor
            tempRecommendView.layer.shadowOffset = CGSize(width: 0, height: 0)
            tempRecommendView.layer.shadowRadius = 4
            tempRecommendView.layer.shadowOpacity = 0.2
        }
    }
    
    
    
    
    //func addView(scrollView: UIScrollView, )
    
    
    
    
    
    
    private func parseJson() {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            let jsonData = try Data(contentsOf: url)
            result = try JSONDecoder().decode(Result.self, from: jsonData)
        }
        catch {
            print("Error: \(error)")
        }
    }
    
    func changeNameToCode(sidoName:String) {
        if sidoName == "서울" {
            sidoCode = "1"
        }
        if sidoName == "인천" {
            sidoCode = "2"
        }
        if sidoName == "대전" {
            sidoCode = "3"
        }
        if sidoName == "대구" {
            sidoCode = "4"
        }
        if sidoName == "광주" {
            sidoCode = "5"
        }
        if sidoName == "부산" {
            sidoCode = "6"
        }
        if sidoName == "울산" {
            sidoCode = "7"
        }
        if sidoName == "세종특별자치시" {
            sidoCode = "8"
        }
        if sidoName == "경기도" {
            sidoCode = "31"
        }
        if sidoName == "강원도" {
            sidoCode = "32"
        }
        if sidoName == "충청북도" {
            sidoCode = "33"
        }
        if sidoName == "충청남도" {
            sidoCode = "34"
        }
        if sidoName == "경상북도" {
            sidoCode = "35"
        }
        if sidoName == "경상남도" {
            sidoCode = "36"
        }
        if sidoName == "전라북도" {
            sidoCode = "37"
        }
        if sidoName == "전라남도" {
            sidoCode = "38"
        }
        if sidoName == "제주도" {
            sidoCode = "39"
        }
    }
}



