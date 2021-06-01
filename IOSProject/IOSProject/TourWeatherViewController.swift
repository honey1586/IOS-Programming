//
//  TourWeatherViewController.swift
//  IOSProject
//
//  Created by KPUGAME on 2021/05/23.
//

import UIKit
import HTMLKit
import WebKit
// Location

class TourWeatherViewController: UIViewController, WKNavigationDelegate {
    var weather_sido : String = ""
    var weather_sigugun: String = ""
    var weather_code : String = ""
    
    private let webView: WKWebView = {
        let prefs = WKPreferences()
        prefs.javaScriptEnabled = true
        let config = WKWebViewConfiguration()
        config.preferences = prefs
        let webView = WKWebView(frame: .zero , configuration: config)
        return webView
    }()
    
    var weather_urlString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.frame = view.bounds
        webView.navigationDelegate = self
        guard let weather_url = URL(string: weatherAreaToCode(sido: weather_sido, sigugun: weather_sigugun)) else {
            return
        }
        webView.load(URLRequest(url:weather_url))
        // Do any additional setup after loading the view.

    }
    
    func weatherAreaToCode(sido:String,sigugun:String) ->String {
        if sido == "서울" || sido == "1" {
            if sigugun == "강남구" || sigugun == "1"{
                weather_code = "09680590"
            }
            else if sigugun == "강동구" || sigugun == "2"{
                weather_code = "09740640"
            }
            else if sigugun == "강북구" || sigugun == "3"{
                weather_code = "09305635"
            }
            else if sigugun == "강서구" || sigugun == "4"{
                weather_code = "09500591"
            }
            else if sigugun == "관악구" || sigugun == "5"{
                weather_code = "09620595"
            }
            else if sigugun == "광진구" || sigugun == "6"{
                weather_code = "09215820"
            }
            else if sigugun == "구로구" || sigugun == "7"{
                weather_code = "09530530"
            }
            else if sigugun == "금천구" || sigugun == "8"{
                weather_code = "09545670"
            }
            else if sigugun == "노원구" || sigugun == "9"{
                weather_code = "09350695"
            }
            else if sigugun == "도봉구" || sigugun == "10"{
                weather_code = "09320690"
            }
            else if sigugun == "동대문구" || sigugun == "11"{
                weather_code = "09230536"
            }
            else if sigugun == "동작구" || sigugun == "12"{
                weather_code = "09590520"
            }
            else if sigugun == "마포구" || sigugun == "13"{
                weather_code = "09440730"
            }
            else if sigugun == "서대문구" || sigugun == "14"{
                weather_code = "09410117"
            }
            else if sigugun == "서초구" || sigugun == "15"{
                weather_code = "09650520"
            }
            else if sigugun == "성동구" || sigugun == "16"{
                weather_code = "09200560"
            }
            else if sigugun == "성북구" || sigugun == "17"{
                weather_code = "09290555"
            }
            else if sigugun == "송파구" || sigugun == "18"{
                weather_code = "09710710"
            }
            else if sigugun == "양천구" || sigugun == "19"{
                weather_code = "09470670"
            }
            else if sigugun == "영등포구" || sigugun == "20"{
                weather_code = "09560550"
            }
            else if sigugun == "용산구" || sigugun == "21"{
                weather_code = "09170650"
            }
            else if sigugun == "은평구" || sigugun == "22"{
                weather_code = "09380102"
            }
            else if sigugun == "종로구" || sigugun == "23"{
                weather_code = "09110615"
            }
            else if sigugun == "중구" || sigugun == "24"{
                weather_code = "09140590"
            }
            else if sigugun == "중랑구" || sigugun == "25"{
                weather_code = "09260690"
            }
        }
        if sido == "인천" || sido == "2"{
            if sigugun == "강화군" || sigugun == "1"{
                weather_code = "11710250"
            }
            else if sigugun == "계양구" || sigugun == "2"{
                weather_code = "11245614"
            }
            else if sigugun == "미추홀구" || sigugun == "3"{
                weather_code = "11177510"
            }
            else if sigugun == "남동구" || sigugun == "4"{
                weather_code = "11200583"
            }
            else if sigugun == "동구" || sigugun == "5"{
                weather_code = "11140590"
            }
            else if sigugun == "부평구" || sigugun == "6"{
                weather_code = "11237540"
            }
            else if sigugun == "서구" || sigugun == "7"{
                weather_code = "11260107"
            }
            else if sigugun == "연수구" || sigugun == "8"{
                weather_code = "11185795"
            }
            else if sigugun == "옹진군" || sigugun == "9"{
                weather_code = "11720360"
            }
            else if sigugun == "중구" || sigugun == "10"{
                weather_code = "11110109"
            }
        }
        if sido == "대전" || sido == "3" {
            if sigugun == "대덕구" || sigugun == "1"{
                weather_code = "07230101"
            }
            else if sigugun == "동구" || sigugun == "2"{
                weather_code = "07110105"
            }
            else if sigugun == "서구" || sigugun == "3"{
                weather_code = "07170640"
            }
            else if sigugun == "유성구" || sigugun == "4"{
                weather_code = "07200540"
            }
            else if sigugun == "중구" || sigugun == "5"{
                weather_code = "07140105"
            }
        }
        if sido == "대구" || sido == "4"{
            if sigugun == "남구" || sigugun == "1"{
                weather_code = "06200530"
            }
            else if sigugun == "달서구" || sigugun == "2"{
                weather_code = "06290602"
            }
            else if sigugun == "달성군" || sigugun == "3"{
                weather_code = "06710253"
            }
            else if sigugun == "동구" || sigugun == "4"{
                weather_code = "06140540"
            }
            else if sigugun == "북구" || sigugun == "5"{
                weather_code = "06230570"
            }
            else if sigugun == "서구" || sigugun == "6"{
                weather_code = "06170640"
            }
            else if sigugun == "수성구" || sigugun == "7"{
                weather_code = "06260510"
            }
            else if sigugun == "중구" || sigugun == "8"{
                weather_code = "06110517"
            }
        }
        if sido == "광주" || sido == "5"{
            if sigugun == "광산구" || sigugun == "1"{
                weather_code = "05200525"
            }
            else if sigugun == "남구" || sigugun == "2"{
                weather_code = "05155690"
            }
            else if sigugun == "동구" || sigugun == "3"{
                weather_code = "05110655"
            }
            else if sigugun == "북구" || sigugun == "4"{
                weather_code = "05170107"
            }
            else if sigugun == "서구" || sigugun == "5"{
                weather_code = "05140650"
            }
        }
        if sido == "부산" || sido == "6"{
            if sigugun == "강서구" || sigugun == "1"{
                weather_code = "08440101"
            }
            else if sigugun == "금정구" || sigugun == "2"{
                weather_code = "08410590"
            }
            else if sigugun == "기장군" || sigugun == "3"{
                weather_code = "08710250"
            }
            else if sigugun == "남구" || sigugun == "4"{
                weather_code = "08290560"
            }
            else if sigugun == "동구" || sigugun == "5"{
                weather_code = "08170570"
            }
            else if sigugun == "동래구" || sigugun == "6"{
                weather_code = "08260520"
            }
            else if sigugun == "부산진구" || sigugun == "7"{
                weather_code = "08230640"
            }
            else if sigugun == "북구" || sigugun == "8"{
                weather_code = "08320520"
            }
            else if sigugun == "사상구" || sigugun == "9"{
                weather_code = "08530105"
            }
            else if sigugun == "사하구" || sigugun == "10"{
                weather_code = "08380102"
            }
            else if sigugun == "서구" || sigugun == "11"{
                weather_code = "08140640"
            }
            else if sigugun == "수영구" || sigugun == "12"{
                weather_code = "08500670"
            }
            else if sigugun == "연제구" || sigugun == "13"{
                weather_code = "08470660"
            }
            else if sigugun == "영도구" || sigugun == "14"{
                weather_code = "08200640"
            }
            else if sigugun == "중구" || sigugun == "15"{
                weather_code = "08110530"
            }
            else if sigugun == "해운대구" || sigugun == "16"{
                weather_code = "08350530"
            }
        }
        if sido == "울산" || sido == "7"{
            if sigugun == "중구" || sigugun == "1"{
                weather_code = "10110550"
            }
            else if sigugun == "남구" || sigugun == "2"{
                weather_code = "10140105"
            }
            else if sigugun == "동구" || sigugun == "3"{
                weather_code = "10170540"
            }
            else if sigugun == "북구" || sigugun == "4"{
                weather_code = "10200122"
            }
            else if sigugun == "울주군" || sigugun == "5"{
                weather_code = "10710400"
            }
        }
        if sido == "세종특별자치시" || sido == "8"{
            if sigugun == "세종특별자치시" || sigugun == "1"{
                weather_code = "17110250"
            }
        }
        if sido == "경기도" || sido == "31"{
            if sigugun == "가평군" || sigugun == "1"{
                weather_code = "02820250"
            }
            else if sigugun == "고양시" || sigugun == "2"{
                weather_code = "02285560"
            }
            else if sigugun == "과천시" || sigugun == "3"{
                weather_code = "02290107"
            }
            else if sigugun == "광명시" || sigugun == "4"{
                weather_code = "02210610"
            }
            else if sigugun == "광주시" || sigugun == "5"{
                weather_code = "02610103"
            }
            else if sigugun == "구리시" || sigugun == "6"{
                weather_code = "02310541"
            }
            else if sigugun == "군포시" || sigugun == "7"{
                weather_code = "02410570"
            }
            else if sigugun == "김포시" || sigugun == "8"{
                weather_code = "02570106"
            }
            else if sigugun == "남양주시" || sigugun == "9"{
                weather_code = "02360103"
            }
            else if sigugun == "동두천시" || sigugun == "10"{
                weather_code = "02250510"
            }
            else if sigugun == "부천시" || sigugun == "11"{
                weather_code = "02190108"
            }
            else if sigugun == "성남시" || sigugun == "12"{
                weather_code = "02133101"
            }
            else if sigugun == "수원시" || sigugun == "13"{
                weather_code = "02111598"
            }
            else if sigugun == "시흥시" || sigugun == "14"{
                weather_code = "02390630"
            }
            else if sigugun == "안산시" || sigugun == "15"{
                weather_code = "02273107"
            }
            else if sigugun == "안성시" || sigugun == "16"{
                weather_code = "02550510"
            }
            else if sigugun == "안양시" || sigugun == "17"{
                weather_code = "02171101"
            }
            else if sigugun == "양주시" || sigugun == "18"{
                weather_code = "02630510"
            }
            else if sigugun == "양평군" || sigugun == "19"{
                weather_code = "02830250"
            }
            else if sigugun == "여주시" || sigugun == "20"{
                weather_code = "02670510"
            }
            else if sigugun == "연천군" || sigugun == "21"{
                weather_code = "02800250"
            }
            else if sigugun == "오산시" || sigugun == "22"{
                weather_code = "02370510"
            }
            else if sigugun == "용인시" || sigugun == "23"{
                weather_code = "02463102"
            }
            else if sigugun == "의왕시" || sigugun == "24"{
                weather_code = "02430101"
            }
            else if sigugun == "의정부시" || sigugun == "25"{
                weather_code = "02150520"
            }
            else if sigugun == "이천시" || sigugun == "26"{
                weather_code = "02500103"
            }
            else if sigugun == "파주시" || sigugun == "27"{
                weather_code = "02480510"
            }
            else if sigugun == "평택시" || sigugun == "28"{
                weather_code = "02220630"
            }
            else if sigugun == "포천시" || sigugun == "29"{
                weather_code = "02650510"
            }
            else if sigugun == "하남시" || sigugun == "30"{
                weather_code = "02450530"
            }
            else if sigugun == "화성시" || sigugun == "31"{
                weather_code = "02590262"
            }
        }
        if sido == "강원도" || sido == "32"{
            if sigugun == "강릉시" || sigugun == "1"{
                weather_code = "01150101"
            }
            else if sigugun == "고성군" || sigugun == "2"{
                weather_code = "01820250"
            }
            else if sigugun == "동해시" || sigugun == "3"{
                weather_code = "01170101"
            }
            else if sigugun == "삼척시" || sigugun == "4"{
                weather_code = "01230106"
            }
            else if sigugun == "속초시" || sigugun == "5"{
                weather_code = "01210103"
            }
            else if sigugun == "양구군" || sigugun == "6"{
                weather_code = "01800250"
            }
            else if sigugun == "양양군" || sigugun == "7"{
                weather_code = "01830250"
            }
            else if sigugun == "영월군" || sigugun == "8"{
                weather_code = "01750250"
            }
            else if sigugun == "원주시" || sigugun == "9"{
                weather_code = "01130115"
            }
            else if sigugun == "인제군" || sigugun == "10"{
                weather_code = "01810250"
            }
            else if sigugun == "정선군" || sigugun == "11"{
                weather_code = "01770250"
            }
            else if sigugun == "철원군" || sigugun == "12"{
                weather_code = "01780256"
            }
            else if sigugun == "춘천시" || sigugun == "13"{
                weather_code = "01110580"
            }
            else if sigugun == "태백시" || sigugun == "14"{
                weather_code = "01190540"
            }
            else if sigugun == "평창군" || sigugun == "15"{
                weather_code = "01760250"
            }
            else if sigugun == "홍천군" || sigugun == "16"{
                weather_code = "01720250"
            }
            else if sigugun == "화천군" || sigugun == "17"{
                weather_code = "01790250"
            }
            else if sigugun == "횡성군" || sigugun == "18"{
                weather_code = "01730250"
            }
        }
        if sido == "충청북도" || sido == "33"{
            if sigugun == "괴산군" || sigugun == "1"{
                weather_code = "16760250"
            }
            else if sigugun == "단양군" || sigugun == "2"{
                weather_code = "16800250"
            }
            else if sigugun == "보은군" || sigugun == "3"{
                weather_code = "16720250"
            }
            else if sigugun == "영동군" || sigugun == "4"{
                weather_code = "16740250"
            }
            else if sigugun == "옥천군" || sigugun == "5"{
                weather_code = "16730250"
            }
            else if sigugun == "음성군" || sigugun == "6"{
                weather_code = "16770250"
            }
            else if sigugun == "제천시" || sigugun == "7"{
                weather_code = "16150547"
            }
            else if sigugun == "진천군" || sigugun == "8"{
                weather_code = "16750250"
            }
            else if sigugun == "청원군" || sigugun == "9"{
                weather_code = "16114101"
            }
            else if sigugun == "청주시" || sigugun == "10"{
                weather_code = "16114101"
            }
            else if sigugun == "충주시" || sigugun == "11"{
                weather_code = "16130625"
            }
            else if sigugun == "증평군" || sigugun == "12"{
                weather_code = "16745250"
            }
        }
        if sido == "충청남도" || sido == "34"{
            if sigugun == "공주시" || sigugun == "1"{
                weather_code = "15150102"
            }
            else if sigugun == "금산군" || sigugun == "2"{
                weather_code = "15710250"
            }
            else if sigugun == "논산시" || sigugun == "3"{
                weather_code = "15230109"
            }
            else if sigugun == "당진시" || sigugun == "4"{
                weather_code = "15270510"
            }
            else if sigugun == "보령시" || sigugun == "5"{
                weather_code = "15180545"
            }
            else if sigugun == "부여군" || sigugun == "6"{
                weather_code = "15760250"
            }
            else if sigugun == "서산시" || sigugun == "7"{
                weather_code = "15210510"
            }
            else if sigugun == "서천군" || sigugun == "8"{
                weather_code = "15770253"
            }
            else if sigugun == "아산시" || sigugun == "9"{
                weather_code = "15200600"
            }
            else if sigugun == "예산군" || sigugun == "10"{
                weather_code = "15810250"
            }
            else if sigugun == "천안시" || sigugun == "11"{
                weather_code = "15133253"
            }
            else if sigugun == "청양군" || sigugun == "12"{
                weather_code = "15790250"
            }
            else if sigugun == "태안군" || sigugun == "13"{
                weather_code = "15825250"
            }
            else if sigugun == "홍성군" || sigugun == "14"{
                weather_code = "15800250"
            }
            else if sigugun == "계룡시" || sigugun == "15"{
                weather_code = "15250101"
            }
        }
        if sido == "경상북도" || sido == "35"{
            if sigugun == "경산시" || sigugun == "1"{
                weather_code = "04290520"
            }
            else if sigugun == "경주시" || sigugun == "2"{
                weather_code = "04130126"
            }
            else if sigugun == "고령군" || sigugun == "3"{
                weather_code = "04830253"
            }
            else if sigugun == "구미시" || sigugun == "4"{
                weather_code = "04190110"
            }
            else if sigugun == "군위군" || sigugun == "5"{
                weather_code = "04720250"
            }
            else if sigugun == "김천시" || sigugun == "6"{
                weather_code = "04150575"
            }
            else if sigugun == "문경시" || sigugun == "7"{
                weather_code = "04280610"
            }
            else if sigugun == "봉화군" || sigugun == "8"{
                weather_code = "04920250"
            }
            else if sigugun == "상주시" || sigugun == "9"{
                weather_code = "04250520"
            }
            else if sigugun == "성주군" || sigugun == "10"{
                weather_code = "04840250"
            }
            else if sigugun == "안동시" || sigugun == "11"{
                weather_code = "04170104"
            }
            else if sigugun == "영덕군" || sigugun == "12"{
                weather_code = "04770250"
            }
            else if sigugun == "영양군" || sigugun == "13"{
                weather_code = "04760250"
            }
            else if sigugun == "영주시" || sigugun == "14"{
                weather_code = "04210600"
            }
            else if sigugun == "영천시" || sigugun == "15"{
                weather_code = "04230520"
            }
            else if sigugun == "예천군" || sigugun == "16"{
                weather_code = "04900250"
            }
            else if sigugun == "울릉군" || sigugun == "17"{
                weather_code = "04940250"
            }
            else if sigugun == "울진군" || sigugun == "18"{
                weather_code = "04930250"
            }
            else if sigugun == "의성군" || sigugun == "19"{
                weather_code = "04730250"
            }
            else if sigugun == "청도군" || sigugun == "20"{
                weather_code = "04820250"
            }
            else if sigugun == "청송군" || sigugun == "21"{
                weather_code = "04750250"
            }
            else if sigugun == "칠곡군" || sigugun == "22"{
                weather_code = "04850250"
            }
            else if sigugun == "포항시" || sigugun == "23"{
                weather_code = "04113107"
            }
        }
        if sido == "경상남도" || sido == "36" {
            if sigugun == "거제시" || sigugun == "1"{
                weather_code = "03310109"
            }
            else if sigugun == "거창군" || sigugun == "1"{
                weather_code = "03880250"
            }
            else if sigugun == "고성군" || sigugun == "2"{
                weather_code = "03820250"
            }
            else if sigugun == "김해시" || sigugun == "3"{
                weather_code = "03250103"
            }
            else if sigugun == "남해군" || sigugun == "4"{
                weather_code = "03840250"
            }
            else if sigugun == "마산시" || sigugun == "5"{
                weather_code = "03127570"
            }
            else if sigugun == "밀양시" || sigugun == "6"{
                weather_code = "03270103"
            }
            else if sigugun == "사천시" || sigugun == "7"{
                weather_code = "03240330"
            }
            else if sigugun == "산청군" || sigugun == "8"{
                weather_code = "03860250"
            }
            else if sigugun == "양산시" || sigugun == "9"{
                weather_code = "03330510"
            }
            else if sigugun == "의령군" || sigugun == "10"{
                weather_code = "03720250"
            }
            else if sigugun == "진주시" || sigugun == "11"{
                weather_code = "03170119"
            }
            else if sigugun == "진해시" || sigugun == "12"{
                weather_code = "03129144"
            }
            else if sigugun == "창녕군" || sigugun == "13"{
                weather_code = "03740250"
            }
            else if sigugun == "창원시" || sigugun == "14"{
                weather_code = "03129144"
            }
            else if sigugun == "통영시" || sigugun == "15"{
                weather_code = "03220111"
            }
            else if sigugun == "하동군" || sigugun == "16"{
                weather_code = "03850250"
            }
            else if sigugun == "함안군" || sigugun == "17"{
                weather_code = "03730250"
            }
            else if sigugun == "함양군" || sigugun == "18"{
                weather_code = "03870250"
            }
            else if sigugun == "합천군" || sigugun == "19"{
                weather_code = "03890250"
            }
        }
        if sido == "전라북도" || sido == "37"{
            if sigugun == "고창군" || sigugun == "1"{
                weather_code = "13790250"
            }
            else if sigugun == "군산시" || sigugun == "2"{
                weather_code = "13130134"
            }
            else if sigugun == "김제시" || sigugun == "3"{
                weather_code = "13210107"
            }
            else if sigugun == "남원시" || sigugun == "4"{
                weather_code = "13190116"
            }
            else if sigugun == "무주군" || sigugun == "5"{
                weather_code = "13730250"
            }
            else if sigugun == "부안군" || sigugun == "6"{
                weather_code = "13800250"
            }
            else if sigugun == "순창군" || sigugun == "7"{
                weather_code = "13770250"
            }
            else if sigugun == "완주군" || sigugun == "8"{
                weather_code = "13710360"
            }
            else if sigugun == "익산시" || sigugun == "9"{
                weather_code = "13140113"
            }
            else if sigugun == "임실군" || sigugun == "10"{
                weather_code = "13750250"
            }
            else if sigugun == "장수군" || sigugun == "11"{
                weather_code = "13740250"
            }
            else if sigugun == "전주시" || sigugun == "12"{
                weather_code = "13113102"
            }
            else if sigugun == "정읍시" || sigugun == "13"{
                weather_code = "13180101"
            }
            else if sigugun == "진안군" || sigugun == "14"{
                weather_code = "13720250"
            }
        }
        if sido == "전라남도" || sido == "38"{
            if sigugun == "강진군" || sigugun == "1"{
                weather_code = "12810250"
            }
            else if sigugun == "고흥군" || sigugun == "2"{
                weather_code = "12770250"
            }
            else if sigugun == "곡성군" || sigugun == "3"{
                weather_code = "12720250"
            }
            else if sigugun == "광양시" || sigugun == "4"{
                weather_code = "12230530"
            }
            else if sigugun == "구례군" || sigugun == "5"{
                weather_code = "12730250"
            }
            else if sigugun == "나주시" || sigugun == "6"{
                weather_code = "12170102"
            }
            else if sigugun == "담양군" || sigugun == "7" {
                weather_code = "12710250"
            }
            else if sigugun == "목포시" || sigugun == "8"{
                weather_code = "12110510"
            }
            else if sigugun == "무안군" || sigugun == "9"{
                weather_code = "12840250"
            }
            else if sigugun == "보성군" || sigugun == "10"{
                weather_code = "12780250"
            }
            else if sigugun == "순천시" || sigugun == "11"{
                weather_code = "12150119"
            }
            else if sigugun == "신안군" || sigugun == "12"{
                weather_code = "12910253"
            }
            else if sigugun == "여수시" || sigugun == "13"{
                weather_code = "12130780"
            }
            else if sigugun == "영광군" || sigugun == "14"{
                weather_code = "12870250"
            }
            else if sigugun == "영암군" || sigugun == "15"{
                weather_code = "12830250"
            }
            else if sigugun == "완도군" || sigugun == "16"{
                weather_code = "12890250"
            }
            else if sigugun == "장성군" || sigugun == "17"{
                weather_code = "12880250"
            }
            else if sigugun == "장흥군" || sigugun == "18"{
                weather_code = "12800250"
            }
            else if sigugun == "진도군" || sigugun == "19"{
                weather_code = "12900250"
            }
            else if sigugun == "함평군" || sigugun == "20"{
                weather_code = "12860250"
            }
            else if sigugun == "해남군" || sigugun == "21"{
                weather_code = "12820250"
            }
            else if sigugun == "화순군" || sigugun == "22"{
                weather_code = "12790250"
            }
        }
        if sido == "제주도" || sido == "39"{
            if sigugun == "남제주군" || sigugun == "1" {
                weather_code = "14110104"
            }
            else if sigugun == "북제주군" || sigugun == "2" {
                weather_code = "14110104"
            }
            else if sigugun == "서귀포시" || sigugun == "3"{
                weather_code = "14130590"
            }
            else if sigugun == "제주시" || sigugun == "4"{
                weather_code = "14110104"
            }
        }
        
        weather_urlString = "https://weather.naver.com/today/" + weather_code
        return weather_urlString
    }

}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //parsing
    }
}
