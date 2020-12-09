//
//  PostTableViewController.swift
//  Lab06
//
//  Created by Ker on 24.11.2020.
//  Copyright © 2020 Ker. All rights reserved.
//

import UIKit

let notify = Notification.Name("123")
let commentsSaved = Notification.Name("321")
 let toNextScreenIdentifier = "toNextScreen"
var val = 5


class PostTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var text : UITextField!
   
    var posts: Array<Post> = []
    var savedPosts: Array<Post> = []
    var filteredPosts: Array<Post> = []
    var comments = [String?]()
    var filter: UIButton = UIButton()
  
    override func viewDidLoad() {
        UseCase().request()
        super.viewDidLoad()
        self.text.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        text.delegate = self
        self.title = "/r/\(subreddit)"
        //    self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.text)
        self.filter.setImage(UIImage(systemName: "bookmark"), for: .normal)
        self.filter.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        self.filter.addTarget(self, action: #selector(self.showsub), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.filter)
        self.filter.tintColor = UIColor.systemGreen
       NotificationCenter.default.addObserver(self, selector: #selector(loadPosts), name: notify, object: nil)

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            filter(text+string)
        }
        return true
    }
    
    func filter(_ query : String){
        filteredPosts.removeAll()
        for data in savedPosts{
                if data.title.lowercased().starts(with: query.lowercased()){
            filteredPosts.append(data)
            }
        }

            tableView.reloadData()
    }
    
    
    @objc
    func showsub(){
        filter.isSelected = !filter.isSelected
      
        text.isHidden = false
        loadSaved()
        
       DispatchQueue.main.async {
             self.tableView.reloadData()
         
     }
        
    }
  
    func loadSaved(){
        if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Info.json"){
            if  let data = try? Data(contentsOf: path, options: .alwaysMapped){
                        do{
                            savedPosts = try JSONDecoder().decode([Post].self, from: data)
                            print(savedPosts)
                                    tableView.reloadData()
                            
                        } catch {
                            print(error)
            }
                
            
        }
            }


    }
        
        
    
    
    @objc
    func loadPosts(){
        let post = UseCase().getData()
        var i = 0
        while i < val {
            posts.append(post[i])
            i+=1
        }
        DispatchQueue.main.async {
           
            self.tableView.reloadData()
        
    }
    }
    
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if filter.isSelected{
             if !filteredPosts.isEmpty{
                           return filteredPosts.count
                          
             } else{
            
            return savedPosts.count
            }
        }
           
        else{
            text.isHidden = true
        return posts.count
            
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as! PostTableViewCell
       
        if filter.isSelected{
            cell.configure(for: savedPosts[indexPath.row])
             if !filteredPosts.isEmpty{
                cell.configure(for: filteredPosts[indexPath.row])
                   }
            
        } else{
        cell.configure(for: posts[indexPath.row] )
        }
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: toNextScreenIdentifier, sender: indexPath)
    }
 
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == posts.count - 1 {
              let post = UseCase().getData()
            if posts.count < limit {
                var i = posts.count
                val+=5
                      while i < val {
                          posts.append(post[i])
                          i+=1
                      }
                self.perform(#selector(loadTable),with: nil,afterDelay: 1.0)
            }
        }
    }
    
    @objc func loadTable(){
        self.tableView.reloadData()
    }
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
      switch segue.identifier{
      case toNextScreenIdentifier:
        if let indexPath = (sender as? IndexPath)?.row{
                let info = segue.destination as! ViewController
            if (filter.isSelected){
                info.normalize(data: savedPosts[indexPath])
                if (!filteredPosts.isEmpty){
                    info.normalize(data: filteredPosts[indexPath])
                }
            } else{
            info.normalize(data: posts[indexPath])
            }
           // }
      
        }
      default:()
    }
    
    }
}

