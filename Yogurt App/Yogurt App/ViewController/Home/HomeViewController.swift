//
//  ViewController.swift
//  Yogurt App
//
//  Created by Aditya on 01/05/21.
//

import UIKit

class HomeViewController: UIViewController,UIScrollViewDelegate {
    
    //MARK:- Outlets
    
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var btnMenu: UIButton!
    
    @IBOutlet weak var btnLetsMakeIt: UIButton!
    @IBOutlet weak var btnSeeOverview: UIButton!
    
    @IBOutlet weak var lblLetsConnect: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    
    @IBOutlet weak var viewLetsConnect: UIView!
    @IBOutlet weak var lblYoutube: UILabel!
    @IBOutlet weak var imgYoutube: UIImageView!
    @IBOutlet weak var viewSeperator: UIView!
    @IBOutlet weak var btnYoutube: UIButton!
    
    @IBOutlet weak var lblFacebook: UILabel!
    @IBOutlet weak var imgFacebook: UIImageView!
    @IBOutlet weak var btnFacebook: UIButton!
    
    @IBOutlet weak var lblInstagram: UILabel!
    @IBOutlet weak var imgInstagram: UIImageView!
    @IBOutlet weak var btnInstagram: UIButton!
    
    @IBOutlet weak var lblTwitter: UILabel!
    @IBOutlet weak var imgTwitter: UIImageView!
    @IBOutlet weak var btnTwitter: UIButton!
    
    @IBOutlet weak var lblPintrest: UILabel!
    @IBOutlet weak var imgPintrest: UIImageView!
    @IBOutlet weak var btnPintrest: UIButton!
    
    @IBOutlet weak var heightLetsConnect: NSLayoutConstraint!
    @IBOutlet weak var btnLetsConnect: UIButton!
    
    var hours: Int = 0
    var mins: Int = 0
    var secs: Int = 0
    
    @IBOutlet weak var viewTimer: UIView!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var hieghtTimer: NSLayoutConstraint!
    @IBOutlet weak var btnTimer: UIButton!
    
    var scheduleTime : Timer?
    //MARK:- Methods
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupInitialViews()
        self.setUpNavigationBar()
        let isFirstLaunch: Bool = UserDefaults.isFirstLaunch()
        if(isFirstLaunch){
            let lower : UInt32 = 10
            let upper : UInt32 = 50000
            let randomNumber = arc4random_uniform(upper - lower) + lower
            Constant.userDefault.setIDData(value: randomNumber)
            print(Constant.userDefault.getIDData())
        }
        hieghtTimer.constant = 0
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
    // MARK: - NavigationBar Methods
    
    func setUpNavigationBar()
    {
       
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
    //MARK:- Functions
    func setupInitialViews() {
        
      //  self.lblDescription.font = MySingleton.sharedManager().themeFontFourtySizeMedium
       // self.lblDescription.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        
        scrollview.delegate = self
        self.btnLetsMakeIt.setTitle("Let's Make It", for: .normal)
       // self.btnLetsMakeIt.setTitleColor(MySingleton.sharedManager().themeGlobalWhiteColor, for: .normal)
      //  self.btnLetsMakeIt.titleLabel?.font = MySingleton.sharedManager().themeFontEighteenSizeMedium
      //  self.btnLetsMakeIt.titleLabel?.textColor = MySingleton.sharedManager().themeGlobalWhiteColor
       // self.btnLetsMakeIt.setBackgroundColor(UIColor.blue, for: .normal)
        self.btnLetsMakeIt?.addTarget(self, action: #selector(self.btnLetsMakeItClicked(_:)), for: .touchUpInside)
        self.btnLetsMakeIt.layer.cornerRadius = self.btnLetsMakeIt.frame.height / 2
        self.btnLetsMakeIt.layer.masksToBounds = true
        
            
        self.btnSeeOverview.layer.cornerRadius = self.btnSeeOverview.frame.height / 2
        self.btnSeeOverview.layer.masksToBounds = true
        self.btnSeeOverview.layer.borderColor = MySingleton.sharedManager().themeGlobalBlueColor?.cgColor
        self.btnSeeOverview.layer.borderWidth = 2.0
        self.btnSeeOverview.setTitle("See Overview", for: .normal)
       // self.btnSeeOverview.setTitleColor(UIColor.blue, for: .normal)
       // self.btnSeeOverview.titleLabel?.font = MySingleton.sharedManager().themeFontSixteenSizeBold
      //  self.btnSeeOverview.setBackgroundColor(UIColor.white, for: .normal)
        self.btnSeeOverview?.addTarget(self, action: #selector(self.btnSeeOverviewClicked(_:)), for: .touchUpInside)
        
        self.btnLetsConnect?.addTarget(self, action: #selector(self.btnLetsConnectClicked(_:)), for: .touchUpInside)
        self.heightLetsConnect.constant = 0
        self.viewLetsConnect.isHidden = true
        self.imgArrow.image = #imageLiteral(resourceName: "Down")
        self.btnMenu?.addTarget(self, action: #selector(self.btnMenuClicked(_:)), for: .touchUpInside)
        
//        self.lblYoutube.font = MySingleton.sharedManager().themeFontEighteenSizeBold
//        self.lblYoutube.textColor = MySingleton.sharedManager().themeGlobalGreyColor
//        
//        self.lblFacebook.font = MySingleton.sharedManager().themeFontEighteenSizeBold
//        self.lblFacebook.textColor = MySingleton.sharedManager().themeGlobalGreyColor
//        
//        self.lblInstagram.font = MySingleton.sharedManager().themeFontEighteenSizeBold
//        self.lblInstagram.textColor = MySingleton.sharedManager().themeGlobalGreyColor
//        
//        self.lblPintrest.font = MySingleton.sharedManager().themeFontEighteenSizeBold
//        self.lblPintrest.textColor = MySingleton.sharedManager().themeGlobalGreyColor
//        
//        self.lblTwitter.font = MySingleton.sharedManager().themeFontEighteenSizeBold
//        self.lblTwitter.textColor = MySingleton.sharedManager().themeGlobalGreyColor
        
//        self.lblDescription.font = MySingleton.sharedManager().themeFontEighteenSizeBold
//        self.lblDescription.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
        self.btnYoutube?.addTarget(self, action: #selector(self.btnYoutubeClicked(_:)), for: .touchUpInside)
        self.btnFacebook?.addTarget(self, action: #selector(self.btnFacebookClicked(_:)), for: .touchUpInside)
        self.btnInstagram?.addTarget(self, action: #selector(self.btnInstagramClicked(_:)), for: .touchUpInside)
        self.btnTwitter?.addTarget(self, action: #selector(self.btnTwitterClicked(_:)), for: .touchUpInside)
        self.btnPintrest?.addTarget(self, action: #selector(self.btnPinterestClicked(_:)), for: .touchUpInside)
        
        self.btnTimer?.addTarget(self, action: #selector(self.btnTimerClicked(_:)), for: .touchUpInside)

    }
    //MARK:- other Service

    @IBAction func btnMenuClicked(_ sender: UIButton)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func btnLetsMakeItClicked(_ sender: UIButton)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MakeItViewController") as? MakeItViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    @IBAction func btnSeeOverviewClicked(_ sender: UIButton)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OverviewViewController") as? OverviewViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func btnLetsConnectClicked(_ sender: UIButton)
    {
        if let button = sender as? UIButton {
            if button.isSelected {
                    // set deselected
                    button.isSelected = false
                self.heightLetsConnect.constant = 0
                self.viewLetsConnect.isHidden = true
                self.imgArrow.image = #imageLiteral(resourceName: "Down")
                let rightOffset: CGPoint = CGPoint(x: 0, y: 0)
                self.scrollview.setContentOffset(rightOffset, animated: true)
                } else {
                    self.imgArrow.image = #imageLiteral(resourceName: "Up")
                    button.isSelected = true
                    self.heightLetsConnect.constant = 370
                    self.viewLetsConnect.isHidden = false
                    let rightOffset: CGPoint = CGPoint(x: 0, y: self.mainContainerView.frame.width - self.mainContainerView.bounds.size.width + self.mainContainerView.frame.height / 2)
                    self.scrollview.setContentOffset(rightOffset, animated: true)
                   
                }
            }
        
    }
    
    
}
//Let's Connect
extension HomeViewController {

    @IBAction func btnYoutubeClicked(_ sender: UIButton)
    {
        if let url = URL(string: "https://www.youtube.com/channel/UC6zTN7MU57uspzOXa18s7Ew") {
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func btnFacebookClicked(_ sender: UIButton)
    {
        if let url = URL(string: "https://www.facebook.com/NPSelection/") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func btnInstagramClicked(_ sender: UIButton)
    {
        if let url = URL(string: "https://www.instagram.com/npselection/") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func btnTwitterClicked(_ sender: UIButton)
    {
        if let url = URL(string: "https://twitter.com/NPSelection") {
            UIApplication.shared.open(url)
        }
    
    }
    @IBAction func btnPinterestClicked(_ sender: UIButton)
    {
        if let url = URL(string: "https://www.pinterest.co.uk/npselection/") {
            UIApplication.shared.open(url)
        }
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
extension HomeViewController{
    
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
           
            print("negative interval")
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

 
