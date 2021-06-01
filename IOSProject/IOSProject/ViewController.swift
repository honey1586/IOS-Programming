//
//  ViewController.swift
//  IOSProject
//
//  Created by Jang Jaeyeong on 2021/05/17.
//

import UIKit
import CoreLocation
import Speech

class ViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource , CLLocationManagerDelegate , XMLParserDelegate{
    var result: Result?
    
    var selectSido: String = "서울" // 디폴트
    var selectSigugun: String = "강남구" // 디폴트
    
    // url에 넣기 위한 코드로 변환할 변수
    var sidoCode : String = "1"
    var sigugunCode : String = "1"
        
    var url : String = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?serviceKey=rFxQesfrwsUpDLk8%2Bxq5xlWa92la4nvY8MRzJZ8ogAmu79D5MPF%2FFyBcvJDYAggvw4%2FmDB7ZFlIg6MnWU2VCSA%3D%3D&numOfRows=50&pageNo=1&MobileApp=TourAPI3.0_Guide&MobileOS=ETC&arrange=A&cat1=&contentTypeId=&areaCode="
    
    
    /// 근처 관광지 찾기 변수
    var nearTour_urlTemp : String = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/locationBasedList?serviceKey=rFxQesfrwsUpDLk8%2Bxq5xlWa92la4nvY8MRzJZ8ogAmu79D5MPF%2FFyBcvJDYAggvw4%2FmDB7ZFlIg6MnWU2VCSA%3D%3D&numOfRows=5&pageNo=1&MobileOS=ETC&MobileApp=AppTest&arrange=B&contentTypeId=12&radius=1000&listYN=Y"
    var nearTour_url : String = ""
    
    var myLatitude: Double?
    var myLatitudeF: Float?
    var myLongitude : Double?
    var myLongitudeF: Float?
    var locationManager:CLLocationManager!
    
    var nearTour_parser = XMLParser()
    var nearTour_posts = NSMutableArray()
    var nearTour_elements = NSMutableDictionary()
    var nearTour_element = NSString()
    var nearTour_title1 = NSMutableString()
    var nearTour_image = NSMutableString()
    var nearTour_contentid = NSMutableString()
    var nearTour_selectIndex: Int = 0
    var nearTour_sigunguCode = NSMutableString()
    var nearTour_sidoCode = NSMutableString()
    
    var send_nearTourcontentid : String = ""
    
    /// 키워드 관광지 찾기 변수
    var keywordTour_url : String = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchKeyword?serviceKey=rFxQesfrwsUpDLk8%2Bxq5xlWa92la4nvY8MRzJZ8ogAmu79D5MPF%2FFyBcvJDYAggvw4%2FmDB7ZFlIg6MnWU2VCSA%3D%3D&MobileApp=AppTest&MobileOS=ETC&pageNo=1&numOfRows=10&listYN=Y&arrange=B&contentTypeId=12&keyword="
    var keyword : String = ""
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))!
    private var speechRecognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var speechRecognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    @IBOutlet weak var transcribeButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var myTextView: UITextView!
    
    
    func authorizeSR() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.transcribeButton.isEnabled = true
                    
                case .denied:
                    self.transcribeButton.isEnabled = true
                    self.transcribeButton.setTitle("Speech recognition access denied by user", for: .disabled)
                    
                case .restricted:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition restricted on device", for: .disabled)
                    
                case .notDetermined:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition not authorized", for: .disabled)
                }
            }
        }
    }
    
    func startSession() throws {
        if let recognitionTask = speechRecognitionTask {
            recognitionTask.cancel()
            self.speechRecognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSession.Category.record)
        
        speechRecognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = speechRecognitionRequest else {
            fatalError("SFSpeechAudioBufferRecognitionRequest object creation failed")
        }
        
        let inputNode = audioEngine.inputNode
        
        recognitionRequest.shouldReportPartialResults = true
        
        speechRecognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) {
            result, error in
            var finished = false
            
            if let result = result {
                self.myTextView.text = result.bestTranscription.formattedString
                finished = result.isFinal
            }
            if error != nil || finished {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.speechRecognitionRequest = nil
                self.speechRecognitionTask = nil
                self.transcribeButton.isEnabled = true
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in self.speechRecognitionRequest?.append(buffer) }
        
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    
    @IBAction func startTranscribing(_ sender: Any) {
        transcribeButton.isEnabled = false
        transcribeButton.backgroundColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
        stopButton.isEnabled = true
        stopButton.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        try! startSession()
    }
    @IBAction func stopTranscribing(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            speechRecognitionRequest?.endAudio()
            transcribeButton.isEnabled = true
            transcribeButton.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
            stopButton.isEnabled = false
            stopButton.backgroundColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
        }
        
        // 여기서 keyword로 url 제조
        keyword = myTextView.text
        
    }
    @IBAction func keywordSearch(_ sender: Any) {
        performSegue(withIdentifier: "segueToKeyword", sender: nil)
    }
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var outlet_seartchView: UIView!
    @IBOutlet weak var outlet_searchButton: UIButton!
    
    @IBOutlet weak var outlet_nearButton1: UIButton!
    @IBOutlet weak var outlet_nearButton2: UIButton!
    @IBOutlet weak var outlet_nearButton3: UIButton!
    @IBOutlet weak var outlet_nearButton4: UIButton!
    @IBOutlet weak var outlet_nearButton5: UIButton!
    
    
    @IBOutlet weak var nearView: UIView!
    @IBOutlet weak var nearStackView: UIStackView!
    @IBOutlet weak var keywordView: UIView!
    @IBOutlet weak var outlet_keywordSearchButton: UIButton!
    
    
    var randomsido : [String] = []
    
    
    
    // MARK: Parser
    
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
            nearTour_image = NSMutableString()
            nearTour_image = ""
            nearTour_contentid = NSMutableString()
            nearTour_contentid = ""
            nearTour_sidoCode = NSMutableString()
            nearTour_sidoCode = ""
            nearTour_sigunguCode = NSMutableString()
            nearTour_sigunguCode = ""
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
        } else if nearTour_element.isEqual(to: "areacode") {
            nearTour_sidoCode.append(string)
        } else if nearTour_element.isEqual(to: "sigungucode") {
            nearTour_sigunguCode.append(string)
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
            if !nearTour_sidoCode.isEqual(nil){
                nearTour_elements.setObject(nearTour_sidoCode, forKey: "areacode" as NSCopying)
            }
            if !nearTour_sigunguCode.isEqual(nil){
                nearTour_elements.setObject(nearTour_sigunguCode, forKey: "sigungucode" as NSCopying)
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
        //myLatitude = coor?.latitude
        //myLatitudeF = Float(myLatitude!)
        //myLongitude = coor?.longitude
        //myLongitudeF = Float(myLongitude!)
        myLatitude = 37.339569091796875
        myLongitude = 126.7351482203925
    }
    
    
    
    
    // MARK: Pickerview
    
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
        
        label.textColor = .black
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
        if segue.identifier == "segueToNearTour" {
            if let tourInfosViewController = segue.destination as? TourInfosViewController {
                let contentId = (nearTour_posts.object(at: nearTour_selectIndex) as AnyObject).value(forKey: "contentid") as! NSString as String
                tourInfosViewController.contentid = contentId
                tourInfosViewController.detailurl = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?serviceKey=rFxQesfrwsUpDLk8%2Bxq5xlWa92la4nvY8MRzJZ8ogAmu79D5MPF%2FFyBcvJDYAggvw4%2FmDB7ZFlIg6MnWU2VCSA%3D%3D&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&contentId=" + contentId + "&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y"
                let nearTour_sidoCodeTemp = (nearTour_posts.object(at: nearTour_selectIndex) as AnyObject).value(forKey: "areacode") as! NSString as String
                let nearTour_sigunguCodeTemp = (nearTour_posts.object(at: nearTour_selectIndex) as AnyObject).value(forKey: "sigungucode") as! NSString as String
                print(nearTour_sidoCodeTemp)
                print(nearTour_sigunguCodeTemp)
                tourInfosViewController.weather_sido_temp2 = nearTour_sidoCodeTemp
                tourInfosViewController.weather_sigugun_temp2 = nearTour_sigunguCodeTemp
                
                tourInfosViewController.motel_sidocode_temp2 = nearTour_sidoCodeTemp
                tourInfosViewController.motel_siguguncode_temp2 = nearTour_sigunguCodeTemp
                
           
            }
        }
        
        if segue.identifier == "segueToKeyword" {
            if let tourlistTableViewController = segue.destination as? TourlistTableViewController {
                var keywordurltemp = keywordTour_url + keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                tourlistTableViewController.url = keywordurltemp
            }
        }
        
//        if segue.identifier == "segueToNearTourInfo" {
//            if let tinfos = segue.destination as? TourInfosViewController {
//                //sendcontentid = (posts.object(at:indexPath.row) as AnyObject).value(forKey:"contentid") as! NSString as String
//                //print("sendContentId : " + sendcontentid)
//                tinfos.contentid = send_nearTourcontentid
//                tinfos.detailurl = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?serviceKey=rFxQesfrwsUpDLk8%2Bxq5xlWa92la4nvY8MRzJZ8ogAmu79D5MPF%2FFyBcvJDYAggvw4%2FmDB7ZFlIg6MnWU2VCSA%3D%3D&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&contentId=" + send_nearTourcontentid + "&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y"
//                print(send_nearTourcontentid)
////                tinfos.weather_sido_temp2 =
////                tinfos.weather_sigugun_temp2 = weather_sigugun_temp
////                tinfos.motel_sidocode_temp2 = motel_sidocode_temp
////                tinfos.motel_siguguncode_temp2 = motel_siguguncode_temp
//            }
//        }
    }
    
    
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJson()
        getMyLocation()
        
        //nearTour_url = nearTour_urlTemp + "&mapX=" + String(myLongitude!) + "&mapY=" + String(myLatitude!) + ""
        nearTour_url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/locationBasedList?serviceKey=rFxQesfrwsUpDLk8%2Bxq5xlWa92la4nvY8MRzJZ8ogAmu79D5MPF%2FFyBcvJDYAggvw4%2FmDB7ZFlIg6MnWU2VCSA%3D%3D&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&arrange=A&contentTypeId=12&radius=10000&listYN=Y&mapX=" + String(myLongitude!) + "&mapY=" + String(myLatitude!)
        
        
        beginParsing()
        authorizeSR()
        
        transcribeButton.isEnabled = true
        transcribeButton.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        stopButton.isEnabled = false
        stopButton.backgroundColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
        
        addView(button: outlet_nearButton1,
                imageURL: (nearTour_posts.object(at: 0) as AnyObject).value(forKey: "firstimage") as! NSString as String,
                title: (nearTour_posts.object(at: 0) as AnyObject).value(forKey: "title") as! NSString as String)
        addView(button: outlet_nearButton2,
                imageURL: (nearTour_posts.object(at: 1) as AnyObject).value(forKey: "firstimage") as! NSString as String,
                title: (nearTour_posts.object(at: 1) as AnyObject).value(forKey: "title") as! NSString as String)
        addView(button: outlet_nearButton3,
                imageURL: (nearTour_posts.object(at: 2) as AnyObject).value(forKey: "firstimage") as! NSString as String,
                title: (nearTour_posts.object(at: 2) as AnyObject).value(forKey: "title") as! NSString as String)
        addView(button: outlet_nearButton4,
                imageURL: (nearTour_posts.object(at: 3) as AnyObject).value(forKey: "firstimage") as! NSString as String,
                title: (nearTour_posts.object(at: 3) as AnyObject).value(forKey: "title") as! NSString as String)
        addView(button: outlet_nearButton5,
                imageURL: (nearTour_posts.object(at: 4) as AnyObject).value(forKey: "firstimage") as! NSString as String,
                title: (nearTour_posts.object(at: 4) as AnyObject).value(forKey: "title") as! NSString as String)
        
        myTextView.backgroundColor = .white
        myTextView.layer.cornerRadius = myTextView.bounds.height / 2.0
        myTextView.font = UIFont(name: "IBMPlexSansKR-SemiBold", size: 20)
        myTextView.textColor = .black
   
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        outlet_searchButton.layer.cornerRadius = outlet_searchButton.bounds.height / 2.0
        transcribeButton.layer.cornerRadius = transcribeButton.bounds.height / 2.0
        stopButton.layer.cornerRadius = stopButton.bounds.height / 2.0
        outlet_keywordSearchButton.layer.cornerRadius = outlet_keywordSearchButton.bounds.height / 2.0
        
        outlet_seartchView.layer.cornerRadius = 25
//        outlet_seartchView.layer.shadowColor = UIColor.black.cgColor
//        outlet_seartchView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        outlet_seartchView.layer.shadowRadius = 4
//        outlet_seartchView.layer.shadowOpacity = 0.2
        
        nearView.layer.cornerRadius = 25
//        nearView.layer.shadowColor = UIColor.black.cgColor
//        nearView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        nearView.layer.shadowRadius = 4
//        nearView.layer.shadowOpacity = 0.2

        keywordView.layer.cornerRadius = 25
//        keywordView.layer.shadowColor = UIColor.black.cgColor
//        keywordView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        keywordView.layer.shadowRadius = 4
//        keywordView.layer.shadowOpacity = 0.2
        
        
    }
    
    
    
    
    func addView(button: UIButton, imageURL: String, title: String) {
        let label = UILabel()
        
        button.layer.cornerRadius = 20
        button.setTitle("", for: .normal)
        print(imageURL)
        if let imageUrl = URL(string: imageURL) {
            let data = try? Data(contentsOf: imageUrl)
            //button.setImage(UIImage(data: data!), for: .normal)
            button.setBackgroundImage(UIImage(data: data!), for: .normal)
        } else {
            // 이미지 없을때
            let tempImage = URL(string: "https://www.thermaxglobal.com/wp-content/uploads/2020/05/image-not-found.jpg")
            let data = try? Data(contentsOf: tempImage!)
            button.setBackgroundImage(UIImage(data: data!), for: .normal)
        }
        button.clipsToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.2
        
        button.addSubview(label)
        label.text = title
        label.textAlignment = .left
        label.font = UIFont(name: "IBMPlexSansKR-SemiBold", size: 18)
        label.textColor = .white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowRadius = 5
        label.layer.shadowOpacity = 1.0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: 0).isActive = true
        label.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -20).isActive = true
        
    }
    
    
    
    
    
    
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
    
    
    
    
    @IBAction func action_nearButton1(_ sender: Any) {
        nearTour_selectIndex = 0
        performSegue(withIdentifier: "segueToNearTour", sender: nil)
    }
    @IBAction func action_nearButton2(_ sender: Any) {
        nearTour_selectIndex = 1
        performSegue(withIdentifier: "segueToNearTour", sender: nil)
    }
    @IBAction func action_nearButton3(_ sender: Any) {
        nearTour_selectIndex = 2
        performSegue(withIdentifier: "segueToNearTour", sender: nil)
    }
    @IBAction func action_nearButton4(_ sender: Any) {
        nearTour_selectIndex = 3
        performSegue(withIdentifier: "segueToNearTour", sender: nil)
    }
    @IBAction func action_nearButton5(_ sender: Any) {
        nearTour_selectIndex = 4
        performSegue(withIdentifier: "segueToNearTour", sender: nil)
    }
}





