	//
//  YogurtSelectedProcessViewController.swift
//  Yogurt App
//
//  Created by Aditya on 06/05/21.
//

import UIKit

class YogurtSelectedProcessViewController: UIViewController {

    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var imgClose: UIImageView!
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblSelect: UILabel!
    
    @IBOutlet weak var viewMilk: UIView!
    @IBOutlet weak var imgMilk: UIImageView!
    @IBOutlet weak var lblMilkTitle: UILabel!
    @IBOutlet weak var lblMilkDescription: UILabel!
    
    @IBOutlet weak var viewStarter: UIView!
    @IBOutlet weak var imgStarter: UIImageView!
    @IBOutlet weak var lblStarterTitle: UILabel!
    @IBOutlet weak var lblStarterDescription: UILabel!
    
    @IBOutlet weak var viewMaker: UIView!
    @IBOutlet weak var imgMaker: UIImageView!
    @IBOutlet weak var lblMakerTitle: UILabel!
    @IBOutlet weak var lblMakerDescription: UILabel!
    
    @IBOutlet weak var btnStartProcess: UIButton!
    @IBOutlet weak var btnProcess: UIButton!
    
    @IBOutlet weak var viewTimer: UIView!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var btnTimer: UIButton!
    @IBOutlet weak var hieghtTimer: NSLayoutConstraint!
    public var strTitle :String = ""
    public var strSelectProcess :String = ""
    
    public var strSelectMaker :String = ""
    
    public var strSelectedStarterTitle :String = ""
    public var strSelectedStarterImage :String = ""
    public var strSelectedDescription :String = ""

    public var strSelectedSMakerTitle :String = ""
    public var strSelectedMakerImage :String = ""
    
    var hours: Int = 0
    var mins: Int = 0
    var secs: Int = 0
    var scheduleTime : Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialViews()
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

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
       
    }
    

    // MARK: - NavigationBar Methods
    
    func setUpNavigationBar()
    {
       
    }
    
    //MARK:- Functions
    func setupInitialViews() {
        
       // self.lblTitle.font = MySingleton.sharedManager().themeFontSixteenSizeBold
       // self.lblTitle.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        self.lblTitle.text = strTitle
      //  self.lblSelect.font = MySingleton.sharedManager().themeFontSixteenSizeBold
     //   self.lblSelect.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        
        
     //   self.lblMilkTitle.font = MySingleton.sharedManager().themeFontFourteenSizeBold
     //   self.lblMilkTitle.textColor = MySingleton.sharedManager().themeGlobalGreyColor
        self.lblMilkTitle.text = "Milk"
      //  self.lblMilkDescription.font = MySingleton.sharedManager().themeFontFourteenSizeBold
       // self.lblMilkDescription.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        print(strTitle)
        if(strTitle == "Whole (full-fat) Daily Milk"){
            self.lblMilkDescription.text = "Dairy Milk"
        }else if(strTitle == "Soy/Cashew Milk"){
            self.lblMilkDescription.text = "Vegan Milk"
        }else{
            self.lblMilkDescription.text = "Other Milk"
        }
       
        
       // self.lblStarterTitle.font = MySingleton.sharedManager().themeFontFourteenSizeBold
      //  self.lblStarterTitle.textColor = MySingleton.sharedManager().themeGlobalGreyColor
        self.lblStarterTitle.text = "Youart/Kefir Starter"
        
       // self.lblStarterDescription.font = MySingleton.sharedManager().themeFontFourteenSizeBold
       // self.lblStarterDescription.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        self.lblStarterDescription.text = strSelectedDescription
        
        self.imgStarter.image = UIImage.init(named: strSelectedStarterImage)
        
        //self.lblMakerTitle.font = MySingleton.sharedManager().themeFontFourteenSizeBold
       // self.lblMakerTitle.textColor = MySingleton.sharedManager().themeGlobalGreyColor
        self.lblMakerTitle.text = "Youart/Kefir Starter"
        
        //self.lblMakerDescription.font = MySingleton.sharedManager().themeFontFourteenSizeBold
        //self.lblMakerDescription.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        self.lblMakerDescription.text = strSelectedSMakerTitle
        
        self.imgMaker.image = UIImage.init(named: strSelectedMakerImage)
        
        self.btnClose?.addTarget(self, action: #selector(self.btnClosedClicked(_:)), for: .touchUpInside)
        self.btnProcess.layer.cornerRadius = self.btnProcess.frame.height / 2
        self.btnProcess.layer.masksToBounds = true
        //self.btnProcess.titleLabel?.text = "Start Process"
        self.btnProcess.setTitle("Start Process", for: .normal)
       // self.btnProcess.titleLabel?.font = MySingleton.sharedManager().themeFontSixteenSizeBold
       // self.btnProcess.titleLabel?.textColor = MySingleton.sharedManager().themeGlobalWhiteColor
        
        
        self.btnStartProcess.layer.cornerRadius = self.btnStartProcess.frame.height / 2
        self.btnStartProcess.layer.masksToBounds = true
        //self.btnStartProcess.setTitle("Start Process", for: .normal)
       // self.btnStartProcess.titleLabel?.text = "Start Process"
        
        //self.btnStartProcess.titleLabel?.font = MySingleton.sharedManager().themeFontTwelveSizeBold
       // self.btnStartProcess.titleLabel?.textColor = MySingleton.sharedManager().themeGlobalWhiteColor
        
        self.btnProcess?.addTarget(self, action: #selector(self.btnStartProcessClicked(_:)), for: .touchUpInside)
        
        self.btnStartProcess?.addTarget(self, action: #selector(self.btnStartProcessClicked(_:)), for: .touchUpInside)
        self.btnTimer?.addTarget(self, action: #selector(self.btnTimerClicked(_:)), for: .touchUpInside)
        
        
    }
     
    //MARK:- other Service
    
  
    @IBAction func btnClosedClicked(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func btnStartProcessClicked(_ sender: UIButton)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "YogurtProcessViewController") as? YogurtProcessViewController
        vc?.strSelectMaker = strSelectMaker
        vc?.strSelectedDescription = strSelectedDescription
        vc?.strTitle = strTitle
       
//        vc?.strTitle = strTitle
//        vc?.strSelectProcess = strSelectProcess
//        vc?.strSelectedStarterTitle = milkProcess[indexPath.row].title
//        vc?.strSelectedDescription = milkProcess[indexPath.row].description
//        vc?.strSelectedStarterImage = "\(indexPath.item)"
        self.navigationController?.pushViewController(vc!, animated: true)
        
        //self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnTimerClicked(_ sender: UIButton)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "YogurtProcessViewController") as? YogurtProcessViewController
        vc?.strSelectMaker = strSelectMaker
        vc?.strSelectedDescription = strSelectedDescription
        vc?.isBoolClickedFromTimer = true
        
//        vc?.strTitle = strTitle
//        vc?.strSelectProcess = strSelectProcess
//        vc?.strSelectedStarterTitle = milkProcess[indexPath.row].title
//        vc?.strSelectedDescription = milkProcess[indexPath.row].description
//        vc?.strSelectedStarterImage = "\(indexPath.item)"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
//Timer
extension YogurtSelectedProcessViewController{
    
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
            print("negative interval")
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
