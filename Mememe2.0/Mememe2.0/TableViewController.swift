import UIKit
class TableViewController: UIViewController, UITabBarControllerDelegate, UITableViewDelegate {
    
    // MARK: - Properties
    
    var memes = [Meme]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    // MARK: Life Cycle

   @IBOutlet var tableView: UITableView!
   @IBOutlet var sortButton: UIBarButtonItem!
    // MARK: Life Cycle
       override func viewDidLoad() {
           super.viewDidLoad()
           setupTableView()
           setupNavigationBar()
           memes = getMemes()
           tableView.reloadData()
       }

    var pickedMeme: Meme?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        memes = appDelegate.memes
           setupNavigationBar()
           memes = getMemes()
          tableView.reloadData()
       }
    
//    @IBAction func addbutton(_ sender: Any) {
//        self.navigateToEditor(meme: nil)
//        self.navigateToEditor(meme: nil)
//    }
    func sections(in tableview: UITableView) -> Int {
        return 1
    }
    
    func navigateToEditor(meme: Meme?) {
        self.pickedMeme = meme
        self.performSegue(withIdentifier: "goToEditor", sender: self)
    }
    
    func navigateToDetails(meme: Meme?) {
        self.pickedMeme = meme
        self.performSegue(withIdentifier: "goToDetails", sender: self)
    }
    
    
      // Retrive saved memes
      private func getMemes() -> [Meme] {
          let object = UIApplication.shared.delegate
          let appDelegate = object as! AppDelegate
          return appDelegate.memes
      }
      
      // Setup navigation bar
      private func setupNavigationBar() {
          navigationController?.isNavigationBarHidden = false
          self.tabBarController?.tabBar.isHidden = false
          navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createMeme))
      }
      
    // Add the setup for the table view
      private func setupTableView() {
          tableView.delegate = self
          tableView.delegate = self
      }
      
     // Call the create meme view controller
      @objc func createMeme() {
          let ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EditorViewController") as! ViewController
          
          self.navigationController?.pushViewController(ViewController, animated: true)
      }
  }
      
      //MARK: Table View Setup
      
 
extension TableViewController: UICollectionViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        
        cell.memeTitle.text = meme.name
        cell.memeImage?.image = UIImage(named: meme.imageName)
        tableView.separatorColor = UIColor.black

        
        return cell
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return self.memes.count
      
             
      
      // Delegate
      
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let detailController = self.storyboard!.instantiateViewController(withIdentifier: "ViewController") as! ViewController
          let meme = memes[(indexPath as NSIndexPath).row]
       
          //Present the view controller using navigation
          self.navigationController!.pushViewController(detailController, animated: true)
          
      }
    func editMemeViewController(segue: UIStoryboardSegue) -> ViewController {
              let navigationController = segue.destination as! UINavigationController
              let viewController = navigationController.viewControllers[0] as! ViewController
              return viewController
          }
          
         
        func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            return .delete
        }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == .delete {
                memes.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                appDelegate.memes.remove(at: indexPath.row)
            }
            
        }
      }
   
    
    @IBAction func sortButtonTapped(_ sender: Any) {
        
        tableView.isEditing = !tableView.isEditing
        
    }
 func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
 func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let selectedItem = memes[sourceIndexPath.row]
        memes.remove(at: sourceIndexPath.row)
        memes.insert(selectedItem, at: destinationIndexPath.row)
        
        // so that re-order changes are reflected also in collection, apply shared model object memes
        appDelegate.memes.remove(at: sourceIndexPath.row)
        appDelegate.memes.insert(selectedItem, at: destinationIndexPath.row)
        
    }
  }
