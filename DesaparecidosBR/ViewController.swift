
import UIKit

class ViewController: UITableViewController,UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var tblPessoas:UITableView!
    
    //var items = Pessoa[]()
     var items:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        request()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func request() {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(object:  "application/json")
        manager.GET(
            "http://www.desaparecidosbr.org/api/pessoas",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                self.items = responseObject as NSArray
                self.tblPessoas.reloadData()
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                println("Error: " + error.localizedDescription)
            })
    }
    /// tableView Pessoas
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println(self.items.count)
        return self.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "PessoasCell")
        self.configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
//    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
//        return 100
//    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        println(self.items.objectAtIndex(indexPath.row));
        let tempDictionary:NSDictionary = self.items.objectAtIndex(indexPath.row) as NSDictionary;
//        println(indexPath.row)
//        println( self.items.objectAtIndex(indexPath.row));
     //   cell.textLabel.text = tempDictionary.objectForKey("nome")
         cell.textLabel.text = tempDictionary.objectForKey("nome") as NSString
        cell.textLabel.font = UIFont.systemFontOfSize(14.0)
        cell.textLabel.textColor = colorWithHexString("000")
      
    }
    
}

