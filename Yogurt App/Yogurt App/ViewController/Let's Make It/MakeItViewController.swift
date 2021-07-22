//
//  ViewController.swift
//  Yogurt App
//
//  Created by Aditya on 05/05/21.
//

import UIKit

class MakeItViewController: UIViewController {

    //MARK:- Outlets
    
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var imgClose: UIImageView!
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var FirstContainerView: UIView!
    @IBOutlet weak var lblFirstContain: UILabel!
   

    @IBOutlet weak var btnFirstContain: UIButton!
    @IBOutlet weak var SecondContainerView: UIView!
    @IBOutlet weak var lblSecondContain: UILabel!
    @IBOutlet weak var btnSecondContain: UIButton!
    @IBOutlet weak var ThirdContainerView: UIView!
    @IBOutlet weak var lblThirdContain: UILabel!
    @IBOutlet weak var btnThirdContain: UIButton!
    
    var hours: Int = 0
       var mins: Int = 0
       var secs: Int = 0

    @IBOutlet weak var viewTimer: UIView!
       @IBOutlet weak var lblTimer: UILabel!
       @IBOutlet weak var hieghtTimer: NSLayoutConstraint!
    @IBOutlet weak var btnTimer: UIButton!
    
    var scheduleTime : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupInitialViews()
        self.setUpNavigationBar()
       
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        self.tabBarController?.tabBar.isHidden = false
      
        let timerDate = Constant.userDefault.getTimerDate()
                if(timerDate == ""){
                    hieghtTimer.constant = 0
                }else{
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                    let date = dateFormatter.date(from: timerDate)
                    if(!(date == nil)){
                        let pickedDatetime = date!
                        self.didCreateEvent(name: "", targetDate: pickedDatetime)
                        switch UIDevice.current.userInterfaceIdiom {
                        case .phone:
                            hieghtTimer.constant = 40
                        // It's an iPhone
                        case .pad:
                            hieghtTimer.constant = 60
                        case .unspecified: break
                            
                        case .tv: break
                            
                        case .carPlay: break
                            
                        case .mac: break
                            
                        @unknown default: break
                        // Uh, oh! What could it be?
                        }
                    }
                  
                }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
                
                NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
        scheduleTime?.invalidate()
        
    }
    @objc private func applicationWillResignActive() {
        print("Resign")
    }
    
    @objc private func applicationDidBecomeActive() {
        print("Active")
        scheduleTime?.invalidate()
        let timerDate = Constant.userDefault.getTimerDate()
        if(timerDate == ""){
            hieghtTimer.constant = 0
        }else{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
            let date = dateFormatter.date(from: timerDate)
            if(!(date == nil)){
                let pickedDatetime = date!
                self.didCreateEvent(name: "", targetDate: pickedDatetime)
                switch UIDevice.current.userInterfaceIdiom {
                case .phone:
                    hieghtTimer.constant = 40
                // It's an iPhone
                case .pad:
                    hieghtTimer.constant = 60
                case .unspecified: break
                    
                case .tv: break
                    
                case .carPlay: break
                    
                case .mac: break
                    
                @unknown default: break
                // Uh, oh! What could it be?
                }
            }
            
        }
    }
    // MARK: - NavigationBar Methods
    
    func setUpNavigationBar()
    {
       
    }
    
    //MARK:- Functions
    func setupInitialViews() {
        
       // self.lblTitle.font = MySingleton.sharedManager().themeFontEighteenSizeBold
       // self.lblTitle.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        
       // self.lblQuestion.font = MySingleton.sharedManager().themeFontEighteenSizeBold
       // self.lblQuestion.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        
       // self.lblDescription.font = MySingleton.sharedManager().themeFontFourteenSizeMedium
       // self.lblDescription.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        
      //  self.lblDescription.text = "The lactic acid bacteria work best with whole dairy milk with no preservatives.Preservatives kill all bacteria no matter \("good") or \("bad")."
        FirstContainerView.roundCorners([.bottomLeft, .topRight], radius: 50)
        
      //  self.lblFirstContain.font = MySingleton.sharedManager().themeFontEighteenSizeBold
      //  self.lblFirstContain.textColor = MySingleton.sharedManager().themeGlobalWhiteColor
        self.btnFirstContain?.addTarget(self, action: #selector(self.btnFirstContainClicked(_:)), for: .touchUpInside)
        
        SecondContainerView.roundCorners([.bottomLeft, .topRight], radius: 50)
        
       // self.lblSecondContain.font = MySingleton.sharedManager().themeFontEighteenSizeBold
       // self.lblSecondContain.textColor = MySingleton.sharedManager().themeGlobalWhiteColor
        self.btnSecondContain?.addTarget(self, action: #selector(self.btnSecondContainClicked(_:)), for: .touchUpInside)
        
        ThirdContainerView.roundCorners([.bottomLeft, .topRight], radius: 50)
        
     //   self.lblThirdContain.font = MySingleton.sharedManager().themeFontEighteenSizeBold
      //  self.lblThirdContain.textColor = MySingleton.sharedManager().themeGlobalWhiteColor
        self.btnThirdContain?.addTarget(self, action: #selector(self.btnThirdContainClicked(_:)), for: .touchUpInside)
        
        self.btnClose?.addTarget(self, action: #selector(self.btnClosedClicked(_:)), for: .touchUpInside)
        self.btnTimer?.addTarget(self, action: #selector(self.btnTimerClicked(_:)), for: .touchUpInside)
        
       
    }
    //MARK:- other Service

    @IBAction func btnClosedClicked(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnFirstContainClicked(_ sender: UIButton)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.strTitle = self.lblFirstContain.text ?? ""
        vc?.strSelectProcess = "1"
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    @IBAction func btnSecondContainClicked(_ sender: UIButton)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.strTitle = self.lblSecondContain.text ?? ""
        vc?.strSelectProcess = "2"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnThirdContainClicked(_ sender: UIButton)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.strTitle = self.lblThirdContain.text ?? ""
        vc?.strSelectProcess = "3"
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    @IBAction func btnBlogClicked(_ sender: UIButton)
    {
        if let url = URL(string: "https://www.yogurtathome.com/blog") {
            UIApplication.shared.open(url)
        }
        
        
    }
    @IBAction func btnShareAppClicked(_ sender: UIButton)
    {
      
        
    }
    
    @IBAction func btnLetsConnectClicked(_ sender: UIButton)
    {
        
    }
    @IBAction func btnContactUsClicked(_ sender: UIButton)
    {
    }
    @IBAction func btnAboutUsClicked(_ sender: UIButton)
    {
        
    }
    
    
    @IBAction func btnTimerClicked(_ sender: UIButton)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "YogurtProcessViewController") as? YogurtProcessViewController
        vc?.strSelectMaker = Constant.userDefault.getSelectMaker()
        vc?.isBoolClickedFromTimer = true
        
//        vc?.strTitle = strTitle
//        vc?.strSelectProcess = strSelectProcess
//        vc?.strSelectedStarterTitle = milkProcess[indexPath.row].title
//        vc?.strSelectedDescription = milkProcess[indexPath.row].description
//        vc?.strSelectedStarterImage = "\(indexPath.item)"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
//Timer
extension MakeItViewController{
    
    private func didCreateEvent(name: String, targetDate: Date) {
        self.title = name
        let difference = floor(targetDate.timeIntervalSince(Date()))
        if difference > 0.0 {
            let computedHours: Int = Int(difference) / 3600
            let remainder: Int = Int(difference) - (computedHours * 3600)
            let minutes: Int = remainder / 60
            let seconds: Int = Int(difference) - (computedHours * 3600) - (minutes * 60)

            print("\(computedHours) \(minutes) \(seconds)")
            hours = computedHours
            mins = minutes
            secs = seconds

            updateLabel()

            startTimer()
        }
        else {
            Constant.userDefault.setTimerDate(value: "")
            DispatchQueue.main.async {
                self.hieghtTimer.constant = 0
               }
        }
    }

    private func startTimer() {
        scheduleTime = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            if self.secs > 0 {
                self.secs = self.secs - 1
            }
            else if self.mins > 0 && self.secs == 0 {
                self.mins = self.mins - 1
                self.secs = 59
            }
            else if self.hours > 0 && self.mins == 0 && self.secs == 0 {
                self.hours = self.hours - 1
                self.mins = 59
                self.secs = 59
            }

            self.updateLabel()
        })
    }

    private func updateLabel() {
        lblTimer.text = "\(hours):\(mins):\(secs)"
    }
}
