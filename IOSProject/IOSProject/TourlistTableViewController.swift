//
//  TourlistTableViewController.swift
//  IOSProject
//
//  Created by KPUGAME on 2021/05/22.
//

import UIKit

class TourlistTableViewController: UITableViewController,XMLParserDelegate{
    
    @IBOutlet var tbData: UITableView!
    var weather_sido_temp : String = ""
    var weather_sigugun_temp : String = ""
    
    var motel_sidocode_temp : String = ""
    var motel_siguguncode_temp : String = ""
    
    var result : Result?
    var url : String?
    
    var parser = XMLParser()
    var posts = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var title1 = NSMutableString()
    var addr1 = NSMutableString()
    var contentid = NSMutableString()
    var sendcontentid : String = ""
    var sendurl = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?serviceKey=rFxQesfrwsUpDLk8%2Bxq5xlWa92la4nvY8MRzJZ8ogAmu79D5MPF%2FFyBcvJDYAggvw4%2FmDB7ZFlIg6MnWU2VCSA%3D%3D&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&contentId="
    
    var keyword_sidoCode = NSMutableString()
    var keyword_sigunguCode = NSMutableString()
    
    var send_keyword_sidocode : String = ""
    var send_keyword_sigungucode : String = ""
   
    
    private func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf: (URL(string:url!))!)!
        parser.delegate = self
        parser.parse()
        tbData.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String? , qualifiedName qName: String? , attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if(elementName as NSString).isEqual(to: "item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            addr1 = NSMutableString()
            addr1 = ""
            contentid = NSMutableString()
            contentid = ""
            keyword_sidoCode = NSMutableString()
            keyword_sidoCode = ""
            keyword_sigunguCode = NSMutableString()
            keyword_sigunguCode = ""
        }
    }
    
    func parser(_ parser: XMLParser , foundCharacters string: String)
    {
        if element.isEqual(to: "title"){
            title1.append(string)
        } else if element.isEqual(to: "addr1"){
            addr1.append(string)
        } else if element.isEqual(to: "contentid") {
            contentid.append(string)
        } else if element.isEqual(to: "areacode") {
            keyword_sidoCode.append(string)
        } else if element.isEqual(to: "sigungucode") {
            keyword_sigunguCode.append(string)
        }
        
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String? , qualifiedName qName: String?)
    {
        if(elementName as NSString).isEqual(to: "item"){
            if !title1.isEqual(nil){
                elements.setObject(title1, forKey: "title" as NSCopying)
            }
            if !addr1.isEqual(nil){
                elements.setObject(addr1, forKey: "addr1" as NSCopying)
            }
            if !contentid.isEqual(nil){
                elements.setObject(contentid, forKey: "contentid" as NSCopying)
            }
            if !keyword_sidoCode.isEqual(nil){
                elements.setObject(keyword_sidoCode, forKey: "areacode" as NSCopying)
            }
            if !keyword_sigunguCode.isEqual(nil){
                elements.setObject(keyword_sigunguCode, forKey: "sigungucode" as NSCopying)
            }
            
            posts.add(elements)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "segueToInfoView"{
//            if let tourinfosViewController = segue.destination as? TourInfosViewController{
//                tourinfosViewController.weather_sido_temp2 = weather_sido_temp
//                tourinfosViewController.weather_sigugun_temp2 = weather_sigugun_temp
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        
        //print(url)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TourlistTableViewCell
        
        cell.nameLabel.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "title") as! NSString as String
        cell.addressLabel.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "addr1") as! NSString as String
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendcontentid = (posts.object(at:indexPath.row) as AnyObject).value(forKey:"contentid") as! NSString as String
        send_keyword_sidocode = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "areacode") as! NSString as String
        send_keyword_sigungucode = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "sigungucode") as!
            NSString as String
        self.performSegue(withIdentifier: "segueToInfoView", sender: nil)
        
        //print(sendcontentid)
//        var tinfos = TourInfosViewController()
//        tinfos.contentid = sendcontentid
//        tinfos.detailurl = sendurl + sendcontentid + "&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y"
        
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToInfoView" {
            if let tinfos = segue.destination as? TourInfosViewController {
                //sendcontentid = (posts.object(at:indexPath.row) as AnyObject).value(forKey:"contentid") as! NSString as String
                //print("sendContentId : " + sendcontentid)
                tinfos.contentid = sendcontentid
                tinfos.detailurl = sendurl + sendcontentid + "&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y"
                tinfos.weather_sido_temp2 = weather_sido_temp
                tinfos.weather_sigugun_temp2 = weather_sigugun_temp
                tinfos.motel_sidocode_temp2 = motel_sidocode_temp
                tinfos.motel_siguguncode_temp2 = motel_siguguncode_temp
                tinfos.keyword_sidocode_temp = send_keyword_sidocode
                tinfos.keyword_sigungucode_temp = send_keyword_sigungucode
                print(send_keyword_sidocode)
                print(send_keyword_sigungucode)
            }
        }
    }

}
