//
//  PostTableViewController.swift
//  Lab06
//
//  Created by Ker on 24.11.2020.
//  Copyright © 2020 Ker. All rights reserved.
//

import UIKit

let notify = Notification.Name("123")
private let toNextScreenIdentifier = "toNextScreen"

class PostTableViewController: UITableViewController {
    let use: UseCase = UseCase()
    var posts: Array<Post> = []
    var savedPosts: Array<Post> = []

    var filter : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    
    override func viewDidLoad() {
            super.viewDidLoad()
        self.title = "/r/\(subreddit)"
    //    self.navigationController?.navigationBar.prefersLargeTitles = true
        self.filter.setImage(UIImage(systemName: "bookmark"), for: .normal)
        self.filter.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        self.filter.tintColor = UIColor.green
        self.filter.addTarget(self, action: #selector(self.showsub), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.filter)
        NotificationCenter.default.addObserver(self, selector: #selector(update), name: notify, object: nil)
       
        if posts.count == 0 {
            use.request()
           
           
        }
       
    }
    
    
      @objc
    func updatePostNotification(){
    update()
      }
    
    @objc
    func showsub(){
        filter.isSelected = !filter.isSelected
        updateSaved()
    }
    
    func updateSaved(){
    
        let saved = use.getSavedData()
     
        savedPosts = saved
       
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    @objc
    func update(){
        let post = use.getData()
        posts = post
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
            return self.savedPosts.count
        }
        else{
        return self.posts.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as! PostTableViewCell
        if filter.isSelected{
            cell.configure(for: self.savedPosts[indexPath.row])
        } else{
        cell.configure(for: self.posts[indexPath.row] )
        }
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: toNextScreenIdentifier, sender: indexPath)
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
                let a = segue.destination as! ViewController
                a.normalize(data: posts[indexPath], position: indexPath)
            }
        default:()
        }
    }
    

}
