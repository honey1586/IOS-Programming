//
//  NearMotelTableViewController.swift
//  IOSProject
//
//  Created by KPUGAME on 2021/05/26.
//

import UIKit

class NearMotelTableViewController: UITableViewController ,XMLParserDelegate{
    //
    //  NearMotelViewController.swift
    //  IOSProject
    //
    //  Created by KPUGAME on 2021/05/26.

    var motel_sido_code : String = ""
    var motel_sigugun_code : String = ""
   
    @IBOutlet var moteltbData: UITableView!
    
    
    var motel_parser = XMLParser()
    var motel_posts = NSMutableArray()
    
    var motel_elements = NSMutableDictionary()
    var motel_element = NSString()
    
    var motel_title = NSMutableString()
    var motel_addr1 = NSMutableString()
    var motel_image = NSMutableString()
    var motel_mapx = NSMutableString()
    var motel_mapy = NSMutableString()
    
    
    private func beginParsing()
    {
        motel_posts = []
        motel_parser = XMLParser(contentsOf: (URL(string:"http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchStay?serviceKey=rFxQesfrwsUpDLk8%2Bxq5xlWa92la4nvY8MRzJZ8ogAmu79D5MPF%2FFyBcvJDYAggvw4%2FmDB7ZFlIg6MnWU2VCSA%3D%3D&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&arrange=A&listYN=Y&areaCode=\(motel_sido_code)&sigunguCode=\(motel_sigugun_code)")!))!
        motel_parser.delegate = self
        motel_parser.parse()
        moteltbData.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String? , qualifiedName qName: String? , attributes attributeDict: [String : String])
    {
        motel_element = elementName as NSString
        if(elementName as NSString).isEqual(to: "item")
        {
            motel_elements = NSMutableDictionary()
            motel_elements = [:]
            motel_title = NSMutableString()
            motel_title = ""
            motel_addr1 = NSMutableString()
            motel_addr1 = ""
            motel_image = NSMutableString()
            motel_image = ""
            motel_mapx = NSMutableString()
            motel_mapx = ""
            motel_mapy = NSMutableString()
            motel_mapy = ""
        }
    }
    
    func parser(_ parser: XMLParser , foundCharacters string: String)
    {
        if motel_element.isEqual(to: "title"){
            motel_title.append(string)
        } else if motel_element.isEqual(to: "addr1"){
            motel_addr1.append(string)
        } else if motel_element.isEqual(to: "firstimage") {
            motel_image.append(string)
        } else if motel_element.isEqual(to: "mapx") {
            motel_mapx.append(string)
        } else if motel_element.isEqual(to: "mapy") {
            motel_mapy.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String? , qualifiedName qName: String?)
    {
        if(elementName as NSString).isEqual(to: "item"){
            if !motel_title.isEqual(nil){
                motel_elements.setObject(motel_title, forKey: "title" as NSCopying)
            }
            if !motel_addr1.isEqual(nil){
                motel_elements.setObject(motel_addr1, forKey: "addr1" as NSCopying)
            }
            if !motel_image.isEqual(nil){
                motel_elements.setObject(motel_image, forKey: "firstimage" as NSCopying)
            }
            if !motel_mapx.isEqual(nil){
                motel_elements.setObject(motel_mapx, forKey: "mapx" as NSCopying)
            }
            if !motel_mapy.isEqual(nil){
                motel_elements.setObject(motel_mapy, forKey: "mapy" as NSCopying)
            }
            
            
            motel_posts.add(motel_elements)
        }
    }
    
    override func viewDidLoad() {
        beginParsing()
        super.viewDidLoad()
       
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return motel_posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = (motel_posts.object(at: indexPath.row) as AnyObject).value(forKey: "title") as! NSString as String
        cell.detailTextLabel?.text = (motel_posts.object(at: indexPath.row) as AnyObject).value(forKey: "addr1") as! NSString as String

        // Configure the cell...

        return cell
    }

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
