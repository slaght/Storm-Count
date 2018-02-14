import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var stormImage: UIImageView!
    @IBOutlet weak var mountainImage: UIImageView!
    @IBOutlet weak var islandImage: UIImageView!
    
    @IBOutlet weak var stormPlus: UIView!
    @IBOutlet weak var stormMinus: UIView!
    @IBOutlet weak var mountainPlus: UIView!
    @IBOutlet weak var mountainMinus: UIView!
    @IBOutlet weak var islandPlus: UIView!
    @IBOutlet weak var islandMinus: UIView!
    
    @IBOutlet weak var stormCount: UILabel!
    @IBOutlet weak var mountainCount: UILabel!
    @IBOutlet weak var islandCount: UILabel!
    
    @IBAction func stormPlusGesture(_ sender: UILongPressGestureRecognizer) {
        handle(target: stormPlus, count: stormCount, up: true, gesture: sender)
    }
    @IBAction func stormMinusGesture(_ sender: UILongPressGestureRecognizer) {
        handle(target: stormMinus, count: stormCount, up: false, gesture: sender)
    }
    @IBAction func mountainPlusGesture(_ sender: UILongPressGestureRecognizer) {
        handle(target: mountainPlus, count: mountainCount, up: true, gesture: sender)
    }
    @IBAction func mountainMinusGesture(_ sender: UILongPressGestureRecognizer) {
        handle(target: mountainMinus, count: mountainCount, up: false, gesture: sender)
    }
    @IBAction func islandPlusGesture(_ sender: UILongPressGestureRecognizer) {
        handle(target: islandPlus, count: islandCount, up: true, gesture: sender)
    }
    @IBAction func islandMinusGesture(_ sender: UILongPressGestureRecognizer) {
        handle(target: islandMinus, count: islandCount, up: false, gesture: sender)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var canBecomeFirstResponder: Bool {
        //get {
            return true
        //}
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        stormImage.layer.cornerRadius = 10
        mountainImage.layer.cornerRadius = 10
        islandImage.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake && (self.stormCount.text != "0" || self.mountainCount.text != "0" || self.islandCount.text != "0"){
            let alert = UIAlertController(title: "Clear Count", message: "Are you sure you want to clear the counters?", preferredStyle: .alert)
            let clearAction = UIAlertAction(title: "Clear", style: .destructive) { (alert: UIAlertAction!) -> Void in
                self.stormCount.text = "0"
                self.mountainCount.text = "0"
                self.islandCount.text = "0"
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) {(alert: UIAlertAction!) -> Void in}
            alert.addAction(clearAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion:nil)
        }
    }
    
    func handle(target: UIView, count: UILabel, up: Bool, gesture: UILongPressGestureRecognizer) {
        if (gesture.state == .ended) {
            brighten(target: target)
            if (up) {
                increment(target: count)
            } else {
                decrement(target: count)
            }
        } else if (gesture.state == .began) {
            dim(target: target)
        }
    }
    
    func brighten(target: UIView) {
        target.backgroundColor = .clear
    }
    
    func dim(target: UIView) {
        target.backgroundColor = .black
    }
    
    func increment(target: UILabel) {
        target.text = String((target.text! as NSString).integerValue + 1)
    }
    
    func decrement(target: UILabel) {
        if(target.text != "0") {
            target.text = String((target.text! as NSString).integerValue - 1)
        }
    }
}
