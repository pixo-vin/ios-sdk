
import UIKit
import OSXScanLib

class ViewController: ScanViewController {

    @IBOutlet weak var vinLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        vinLabel.text = "";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setResult(result: String) {
        vinLabel.text = result;
    }
}
