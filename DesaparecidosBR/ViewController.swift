
import UIKit

class ViewController: UITableViewController,UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var tblPessoas:UITableView!
    
    var items = Pessoa[]()
    // var items:NSMutableArray = []
    
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
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "detalhesPessoa") {
            var indexPath = self.tblPessoas.indexPathForSelectedRow;
         //   var object:NSManagedObject  = self.fetchedResultsController.objectAtIndexPath(indexPath);
            
           // NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            var detailViewController  = segue.destinationViewController as DetalhesPessoaViewController
          //  var object  = self.items.objectAtIndex(indexPath)
            //println(indexPath);
      //      println(self.items.objectAtIndex(indexPath)
            // detailViewController.pessoa = self.tblPessoas.objectAtIndex(indexPath.row);
           // detailViewController.setPessoa(object);
           
        }
    }
    func request() {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(object:  "application/json")
        manager.GET(
            "http://www.desaparecidosbr.org/api/pessoas",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                var a:NSArray = responseObject as NSArray
                for var i = 0; i < a.count; i++
                {
                    
                    var dic:NSDictionary =  a.objectAtIndex(i) as NSDictionary
                    var p:Pessoa = Pessoa()
                    p.nome = dic.objectForKey("nome").uppercaseString as NSString
                    p.cidade = dic.objectForKey("cidade").uppercaseString as NSString
                    self.items.append(p)
                }
           
                self.tblPessoas.reloadData()
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                println("Error: " + error.localizedDescription)
            })
    }
    /// tableView Pessoas
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       // let cell:UITableViewCell? = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "PessoasCell")
        var cell:UITableViewCell? =
        tableView.dequeueReusableCellWithIdentifier("PessoasCell") as? UITableViewCell
       
        
        if !cell
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle,
                reuseIdentifier: "PessoasCell")
        }
        self.configureCell(cell!, atIndexPath: indexPath)
        
        return cell!
    }
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
       // var tappedItem:Pessoa = self.items.objectAtIndex(indexPath.row) as Pessoa
         var tappedItem:Pessoa = self.items[indexPath.row]
         println(tappedItem.nome);
    }
//    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
//        return 100
//    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
    //    println(self.items[indexPath.row]);
        var pessoa:Pessoa = self.items[indexPath.row] as Pessoa
        //println(pessoa)
      //  let tempDictionary:NSDictionary = self.items.objectAtIndex(indexPath.row) as NSDictionary;
        // cell.textLabel.text = tempDictionary.objectForKey("nome") as NSString
        cell.textLabel.text = pessoa.nome
        cell.textLabel.font = UIFont.systemFontOfSize(14.0)
        
        cell.detailTextLabel.text = pessoa.cidade
        cell.detailTextLabel.textColor = colorWithHexString("000")
      
    }
    
}

