//
//  ViewController.swift
//  IOSProject
//
//  Created by Jang Jaeyeong on 2021/05/17.
//

import UIKit

class ViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource{
    var result: Result?
    
    var selectSido: String = "서울" // 디폴트
    var selectSigugun: String = "강남구" // 디폴트
    
    // url에 넣기 위한 코드로 변환할 변수
    var sidoCode : String = ""
    var sigugunCode : String = ""
        
    var url : String = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?serviceKey=rFxQesfrwsUpDLk8%2Bxq5xlWa92la4nvY8MRzJZ8ogAmu79D5MPF%2FFyBcvJDYAggvw4%2FmDB7ZFlIg6MnWU2VCSA%3D%3D&numOfRows=50&pageNo=1&MobileApp=TourAPI3.0_Guide&MobileOS=ETC&arrange=A&cat1=&contentTypeId=&areaCode="
    
    @IBOutlet weak var pickerView: UIPickerView!
        
    @IBAction func doneToPickerViewController(segue:UIStoryboardSegue){
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
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
        }
        
        sigugunCode = String(pickerView.selectedRow(inComponent: 1) + 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToTableView"{
            if let navController = segue.destination as? UINavigationController{
                if let tourlistTableViewController = navController.topViewController as? TourlistTableViewController{
                    changeNameToCode(sidoName: selectSido)
                    tourlistTableViewController.url = url + sidoCode + "&sigunguCode=" + sigugunCode + "&cat2=&cat3=&listYN=Y&modifiedtime=&"
                    tourlistTableViewController.result = result
                    tourlistTableViewController.weather_sido_temp = selectSido
                    tourlistTableViewController.weather_sigugun_temp = selectSigugun
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJson()
        
        
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
}



