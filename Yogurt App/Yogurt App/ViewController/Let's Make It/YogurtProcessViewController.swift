//
//  OverviewViewController.swift
//  Yogurt App
//
//  Created by Aditya on 02/05/21.
//

import UIKit
import NYAlertViewController
class YogurtProcessViewController: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var SliderContainerView: RangeSeekSlider!
    @IBOutlet weak var lblOverView: UILabel!
    
    @IBOutlet weak var lblOverviewCount: UILabel!
    @IBOutlet weak var imgOverview: UIImageView!
    @IBOutlet weak var lblMilkType: UILabel!
    
    @IBOutlet weak var btnOverviewBack: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDetailDescription: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnOverviewLetsMakeIt: UIButton!
    @IBOutlet weak var btnContctUs: UIButton!
    @IBOutlet weak var btnStartTimer
        : UIButton!
    
    @IBOutlet weak var stackBackView: UIStackView!
    @IBOutlet weak var stackMakeIt: UIStackView!
 
    
    
    @IBOutlet weak var hieghtStartTimer: NSLayoutConstraint!
    var intBoolSetSliderValue : Int = 0
    
    @IBOutlet weak var blackTransperentView: UIView!
    @IBOutlet weak var imgClose: UIImageView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtRetypeEmail: UITextField!
    @IBOutlet weak var lblEmailTitle: UILabel!
    @IBOutlet weak var btnSend: UIButton!
    
    @IBOutlet var lblTimer: UILabel!
    
    
    public var strSelectMaker :String = ""
    public var strSelectedDescription :String = ""
    public var isBoolClickedFromTimer :Bool = false
    public var strTitle :String = ""
    
    public var isBoolClickedStopTimer :Bool = false
    //@IBOutlet var lblUseExistingOrgLogo: UILabel?
    @IBOutlet var viewExisting: UIView?
    @IBOutlet var imgCheckMark: UIImageView?
    @IBOutlet var btnCheckMark: UIButton?
    
    @IBOutlet weak var viewTimer: UIView!
    @IBOutlet weak var lblTimerTop: UILabel!
    @IBOutlet weak var hieghtTimer: NSLayoutConstraint!
    @IBOutlet weak var btnTimer: UIButton!
    
    public var isBoolProcessRunning :Bool = false
    var hours: Int = 0
    var mins: Int = 0
    var secs: Int = 0
    var scheduleTime : Timer?
    struct MilkProcess {
        
        // MARK: Properties
        
        let title: String
        let imgName: String
        let Detail: String
        let Detail_Process: String
    }
   
    private var milkProcess: [MilkProcess] = [
        MilkProcess(
            title: "Sanitising",
            imgName: "Process_1",
            Detail: "Pour hot water over containers for sanitisation",
            Detail_Process: ""
           
        ),
        MilkProcess(
            title: "Boil the milk",
            imgName: "Process_2",
            Detail: "Boil the milk first",
            Detail_Process: "Just touch the container with milk and if you feel it \("warm") this means that the temperature is ideal."
        ),
        MilkProcess(
            title: "Cool it down",
            imgName: "Process_3",
            Detail: "Cool down the milk to lukewarm in order to start the fermentation.",
            Detail_Process: "Just touch the container with the milk and if you feel it warm this means that the temperature is ideal."
        ),
        MilkProcess(
            title: "Introduce the bacteria",
            imgName: "Process_4",
            Detail: "Introduce the bacteria with the help of starter into the milk and stir gently.",
            Detail_Process: ""
        ),
        MilkProcess(
            title: "Incubate",
            imgName: "Process_5",
            Detail: "Transfer the milk to the yogurt maker. Allow the milk to sit in the warm and protected place, without bothering it during the incubation.",
            Detail_Process: ""
        ),
        MilkProcess(
            title: "Start Timer",
            imgName: "Timer_bg",
            Detail: "The combination you have set usually takes 18 hours and 2 checks. Please carefully check the mix after the first notification and add more time.",
            Detail_Process: "The incubation time depends on the milk used and the temperature of incubation. Please keep an eye on the mix and adjust accordingly if this is needed."
        )
        ,
        MilkProcess(
            title: "Refrigeration",
            imgName: "Process_6",
            Detail: "Cool it down and enjoy",
            Detail_Process: ""
        )
    ]
    
    private let milkProcessVegan: [MilkProcess] = [
        MilkProcess(
            title: "Sanitising",
            imgName: "Process_1",
            Detail: "Pour hot water over containers for sanitisation",
            Detail_Process: ""
           
        ),
        MilkProcess(
            title: "Boil the milk",
            imgName: "Vegan_2",
            Detail: "Slightly Warm the Vegan Milk Always Boil the Dairy Milk and then cool it down to Lukewarm",
            Detail_Process: ""
        ),
        MilkProcess(
            title: "Add Sugar",
            imgName: "Vegan_3",
            Detail: "Add a teaspoon of sugar",
            Detail_Process: ""
        ),
        MilkProcess(
            title: "Introduce the bacteria",
            imgName: "Process_4",
            Detail: "Introduce the bacteria with the help of starter into the milk and stir gently.",
            Detail_Process: ""
        ),
        MilkProcess(
            title: "Incubate",
            imgName: "Process_5",
            Detail: "Transfer the milk to the yogurt maker. Allow the milk to sit in the warm and protected place, without bothering it during the incubation.",
            Detail_Process: ""
        ),
        MilkProcess(
            title: "Start Timer",
            imgName: "Timer_bg",
            Detail: "The combination you have set usually takes 18 hours and 2 checks. Please carefully check the mix after the first notification and add more time.",
            Detail_Process: "The incubation time depends on the milk used and the temperature of incubation. Please keep an eye on the mix and adjust accordingly if this is needed."
        )
        ,
        MilkProcess(
            title: "Refrigeration",
            imgName: "Process_6",
            Detail: "Cool it down and enjoy",
            Detail_Process: ""
        )
    ]
    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupInitialViews()
        self.setUpNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        self.tabBarController?.tabBar.isHidden = false
        
        let timerDate = Constant.userDefault.getTimerDate()
        if(timerDate == ""){
            hieghtTimer.constant = 0
            isBoolProcessRunning = false
        }else{
            if(isBoolClickedFromTimer){
                
            }else{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                let date = dateFormatter.date(from: timerDate)
                if(!(date == nil)){
                    isBoolProcessRunning = true
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
            
            if(isBoolClickedFromTimer){
                scheduleTime?.invalidate()
                if(hieghtTimer.constant > 0){
                    hieghtTimer.constant = 0
                }
                self.lblOverView.text = "Current timer"
                self.btnStartTimer.setTitle("Stop Timer", for: .normal)
                self.stackMakeIt.isHidden = true
                self.stackBackView.isHidden = false
                self.lblTimer.isHidden = false
                switch UIDevice.current.userInterfaceIdiom {
                case .phone:
                    self.timerHieght(height: 50)
                // It's an iPhone
                case .pad:
                    self.timerHieght(height: 80)
                case .unspecified: break
                    
                case .tv: break
                    
                case .carPlay: break
                    
                case .mac: break
                    
                @unknown default: break
                // Uh, oh! What could it be?
                }
               
                SliderContainerView.selectedMaxValue = 6.0
                imgOverview.image = UIImage.init(named: milkProcess[5].imgName)
                intBoolSetSliderValue = 6
               // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
                lblOverView.text = milkProcess[5].title
                lblDescription.text = milkProcess[5].Detail
                lblDetailDescription.text = milkProcess[5].Detail_Process
                let timerDate = Constant.userDefault.getTimerDate()
                if(timerDate == ""){
                    isBoolProcessRunning = false
                }else{
                    isBoolProcessRunning = true
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                    let date = dateFormatter.date(from: timerDate)
                    if(!(date == nil)){
                        let pickedDatetime = date!
                        self.didCreateEvent(name: "", targetDate: pickedDatetime)
                       
                    }
                  
                }
            }else{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                let date = dateFormatter.date(from: timerDate)
                if(!(date == nil)){
                    isBoolProcessRunning = true
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
    }
    // MARK: - NavigationBar Methods
    
    func setUpNavigationBar()
    {
        
    }
    
    //MARK:- Functions
    func setupInitialViews() {
        
        // custom number formatter range slider
        SliderContainerView.delegate = self
        SliderContainerView.minValue = 0.0
        SliderContainerView.maxValue = 7.00
        SliderContainerView.selectedMinValue = 0.0
        SliderContainerView.selectedMaxValue = 1.0
//        SliderContainerView.layer.borderWidth = 1.0
//        SliderContainerView.layer.borderColor = UIColor.black.cgColor
       // SliderContainerView.handleImage = #imageLiteral(resourceName: "custom-handle")
        SliderContainerView.selectedHandleDiameterMultiplier = 1.0
        SliderContainerView.colorBetweenHandles = MySingleton.sharedManager().themeGlobalBlueColor
       // SliderContainerView.sele
        SliderContainerView.lineHeight = 20.0
      
        intBoolSetSliderValue = 1
      //  self.lblOverView.font = MySingleton.sharedManager().themeFontSixteenSizeBold
      //  self.lblOverView.textColor = MySingleton.sharedManager().themeGlobalGreyColor
        
        
        
        //self.lblMilkType.font = MySingleton.sharedManager().themeFontSixteenSizeBold
       // self.lblMilkType.textColor = UIColor.blue
        
      //  self.lblDescription.font = MySingleton.sharedManager().themeFontSixteenSizeBold
      //  self.lblDescription.textColor = MySingleton.sharedManager().themeGlobalGreyColor
        
      //  self.lblDetailDescription.font = MySingleton.sharedManager().themeFontSixteenSizeBold
       // self.lblDetailDescription.textColor = MySingleton.sharedManager().themeGlobalGreyColor
        
        self.btnOverviewBack.setTitle("Back", for: .normal)
        self.btnOverviewBack.setTitleColor(MySingleton.sharedManager().themeGlobalWhiteColor, for: .normal)
       // self.btnOverviewBack.titleLabel?.font = MySingleton.sharedManager().themeFontSixteenSizeBold
        self.btnOverviewBack.titleLabel?.textColor = MySingleton.sharedManager().themeGlobalWhiteColor
        self.btnOverviewBack.setBackgroundColor(MySingleton.sharedManager().themeGlobalBlueColor, for: .normal)
        self.btnOverviewBack?.addTarget(self, action: #selector(self.btnOverviewBackClicked(_:)), for: .touchUpInside)
        self.btnOverviewBack.layer.cornerRadius = self.btnOverviewBack.frame.height / 2
        self.btnOverviewBack.layer.masksToBounds = true
        
        self.btnNext.setTitle("Next", for: .normal)
        self.btnNext.setTitleColor(MySingleton.sharedManager().themeGlobalBlueColor, for: .normal)
       // self.btnNext.titleLabel?.font = MySingleton.sharedManager().themeFontSixteenSizeBold
        self.btnNext.titleLabel?.textColor = MySingleton.sharedManager().themeGlobalBlueColor
        self.btnNext.setBackgroundColor(UIColor.white, for: .normal)
        self.btnNext?.addTarget(self, action: #selector(self.btnOverviewNextClicked(_:)), for: .touchUpInside)
        self.btnNext.layer.cornerRadius = self.btnNext.frame.height / 2
        self.btnNext.layer.masksToBounds = true
        self.btnNext.layer.borderColor = MySingleton.sharedManager().themeGlobalBlueColor?.cgColor
        self.btnNext.layer.borderWidth = 1.0
    
        self.btnBack?.addTarget(self, action: #selector(self.btnBackClicked(_:)), for: .touchUpInside)
        
        self.btnOverviewLetsMakeIt.setTitle("Next", for: .normal)
        self.btnOverviewLetsMakeIt.setTitleColor(MySingleton.sharedManager().themeGlobalBlueColor, for: .normal)
       // self.btnOverviewLetsMakeIt.titleLabel?.font = MySingleton.sharedManager().themeFontSixteenSizeBold
        self.btnOverviewLetsMakeIt.titleLabel?.textColor = MySingleton.sharedManager().themeGlobalBlueColor
        self.btnOverviewLetsMakeIt.setBackgroundColor(UIColor.white, for: .normal)
        self.btnOverviewLetsMakeIt?.addTarget(self, action: #selector(self.btnOverviewNextClicked(_:)), for: .touchUpInside)
        self.btnOverviewLetsMakeIt.layer.cornerRadius = self.btnNext.frame.height / 2
        self.btnOverviewLetsMakeIt.layer.masksToBounds = true
        self.btnOverviewLetsMakeIt.layer.borderColor = MySingleton.sharedManager().themeGlobalBlueColor?.cgColor
        self.btnOverviewLetsMakeIt.layer.borderWidth = 1.0
        
        self.btnStartTimer.setTitle("Start Timer", for: .normal)
        self.btnStartTimer.setTitleColor(MySingleton.sharedManager().themeGlobalBlueColor, for: .normal)
       // self.btnStartTimer.titleLabel?.font = MySingleton.sharedManager().themeFontSixteenSizeBold
        self.btnStartTimer.titleLabel?.textColor = MySingleton.sharedManager().themeGlobalBlueColor
        self.btnStartTimer.setBackgroundColor(UIColor.white, for: .normal)
        self.btnStartTimer?.addTarget(self, action: #selector(self.btnStartTimerClicked(_:)), for: .touchUpInside)
        self.btnStartTimer.layer.cornerRadius = self.btnNext.frame.height / 2
        self.btnStartTimer.layer.masksToBounds = true
        self.btnStartTimer.layer.borderColor = MySingleton.sharedManager().themeGlobalBlueColor?.cgColor
        self.btnStartTimer.layer.borderWidth = 1.0
    
        self.stackMakeIt.isHidden = false
        self.stackBackView.isHidden = true
        self.hieghtStartTimer.constant = 0
        
        imgOverview.image = UIImage.init(named: milkProcess[0].imgName)
       // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
        lblOverView.text = milkProcess[0].title
        lblDescription.text = milkProcess[0].Detail
        lblDetailDescription.text = milkProcess[0].Detail_Process
    
        self.btnSend.setTitle("Continue", for: .normal)
        self.btnSend.setTitleColor(MySingleton.sharedManager().themeGlobalWhiteColor, for: .normal)
    //    self.btnSend.titleLabel?.font = MySingleton.sharedManager().themeFontSixteenSizeBold
       // self.btnSend.titleLabel?.textColor = MySingleton.sharedManager().themeGlobalWhiteColor
      self.btnSend.setBackgroundColor(MySingleton.sharedManager().themeGlobalBlueColor, for: .normal)
        self.btnSend?.addTarget(self, action: #selector(self.btnContinueClicked(_:)), for: .touchUpInside)
        self.btnSend.layer.cornerRadius = self.btnSend.frame.height / 2
        self.btnSend.layer.masksToBounds = true
        
       // self.lblEmailTitle.font = MySingleton.sharedManager().themeFontSixteenSizeBold
      //  self.lblEmailTitle.textColor = MySingleton.sharedManager().themeGlobalBlackColor
        self.lblEmailTitle.text = "Set an email reminder"
        self.blackTransperentView.isHidden = true
        self.viewEmail.isHidden = true
        
       // self.txtEmail.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
      //  self.txtEmail.font = MySingleton.sharedManager().themeFontThirteenSizeMedium
        self.txtEmail.placeholder = "Enter Email Address"
        
      //  self.txtRetypeEmail.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
      //  self.txtRetypeEmail.font = MySingleton.sharedManager().themeFontThirteenSizeMedium
        self.txtRetypeEmail.placeholder = "Re-Enter Email Address"

        self.btnClose?.addTarget(self, action: #selector(self.btnClosedClicked(_:)), for: .touchUpInside)
        self.lblTimer.isHidden = true
        
        btnCheckMark?.addTarget(self, action: #selector(self.btnCheckMarkClicked(_:)), for: .touchUpInside)
        
     //   self.lblTimer.font = MySingleton.sharedManager().themeFontTwentyEightSizeBold
     //   self.lblTimer.textColor = MySingleton.sharedManager().themeGlobalWhiteColor
        
        if(isBoolClickedFromTimer){
            scheduleTime?.invalidate()
            if(hieghtTimer.constant > 0){
                hieghtTimer.constant = 0
            }
            self.lblOverView.text = "Current timer"
            self.btnStartTimer.setTitle("Stop Timer", for: .normal)
            self.stackMakeIt.isHidden = true
            self.stackBackView.isHidden = false
            self.lblTimer.isHidden = false
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                self.timerHieght(height: 50)
            // It's an iPhone
            case .pad:
                self.timerHieght(height: 80)
            case .unspecified: break
                
            case .tv: break
                
            case .carPlay: break
                
            case .mac: break
                
            @unknown default: break
            // Uh, oh! What could it be?
            }
           
            SliderContainerView.selectedMaxValue = 6.0
            imgOverview.image = UIImage.init(named: milkProcess[5].imgName)
            intBoolSetSliderValue = 6
           // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
            lblOverView.text = milkProcess[5].title
            lblDescription.text = milkProcess[5].Detail
            if(strSelectedDescription == "Ready Starter"){
                if(strSelectMaker == "1"){
                    if((intBoolSetSliderValue - 1) == 5){
                        let s = milkProcess[intBoolSetSliderValue - 1].Detail
                        let modified = s.replace(string: "18", replacement:"4")
                        lblDescription.text = modified
                    }else{
                        lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                    }
                }else if(strSelectMaker == "2"){
                    if((intBoolSetSliderValue - 1) == 5){
                        let s = milkProcess[intBoolSetSliderValue - 1].Detail
                        let modified = s.replace(string: "18", replacement:"6")
                        lblDescription.text = modified
                    }else{
                        lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                    }
                }
                else{
                    if((intBoolSetSliderValue - 1) == 5){
                        let s = milkProcess[intBoolSetSliderValue - 1].Detail
                        let modified = s.replace(string: "18", replacement:"8")
                        lblDescription.text = modified
                    }else{
                        lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                    }
                }
            }else{
                if(strSelectMaker == "1"){
                    if((intBoolSetSliderValue - 1) == 5){
                        let s = milkProcess[intBoolSetSliderValue - 1].Detail
                        let modified = s.replace(string: "18", replacement:"12")
                        lblDescription.text = modified
                    }else{
                        lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                    }
                }else if(strSelectMaker == "2"){
                    if((intBoolSetSliderValue - 1) == 5){
                        let s = milkProcess[intBoolSetSliderValue - 1].Detail
                        let modified = s.replace(string: "18", replacement:"16")
                        lblDescription.text = modified
                    }else{
                        lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                    }
                }
                else{
                    if((intBoolSetSliderValue - 1) == 5){
                        let s = milkProcess[intBoolSetSliderValue - 1].Detail
                        let modified = s.replace(string: "18", replacement:"24")
                        lblDescription.text = modified
                    }else{
                        lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                    }
                }
            }
           
            lblDetailDescription.text = milkProcess[5].Detail_Process
            let timerDate = Constant.userDefault.getTimerDate()
            if(timerDate == ""){
                isBoolProcessRunning = false
            }else{
                isBoolProcessRunning = true
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                let date = dateFormatter.date(from: timerDate)
                if(!(date == nil)){
                    let pickedDatetime = date!
                    self.didCreateEvent(name: "", targetDate: pickedDatetime)
                   
                }
              
            }
        }else{
            
        }
        
        if(strTitle == "Whole (full-fat) Daily Milk"){
            
        }else{
            milkProcess = milkProcessVegan
        }
        self.btnTimer?.addTarget(self, action: #selector(self.btnTimerClicked(_:)), for: .touchUpInside)
        imgCheckMark?.image =  UIImage.init(named: "CheckBox")
    }
    func timerHieght(height: Int){
        hieghtStartTimer.constant = CGFloat(height)
        
    }
    @IBAction func btnTimerClicked(_ sender: UIButton)
        {
//        intBoolSetSliderValue = 6
//        
//        self.btnStartTimer.setTitle("Stop Timer", for: .normal)
//        self.stackMakeIt.isHidden = true
//        self.stackBackView.isHidden = false
//        self.lblTimer.isHidden = false
//        switch UIDevice.current.userInterfaceIdiom {
//        case .phone:
//            self.timerHieght(height: 60)
//        // It's an iPhone
//        case .pad:
//            self.timerHieght(height: 80)
//        case .unspecified: break
//            
//        case .tv: break
//            
//        case .carPlay: break
//            
//        case .mac: break
//            
//        @unknown default: break
//        // Uh, oh! What could it be?
//        }
//        //self.hieghtStartTimer.constant = 60
//        SliderContainerView.selectedMaxValue = 5.0
//        imgOverview.image = UIImage.init(named: milkProcess[intBoolSetSliderValue].imgName)
//       // intBoolSetSliderValue = 5
//       // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
//        lblOverView.text = milkProcess[intBoolSetSliderValue].title
//        lblDescription.text = milkProcess[intBoolSetSliderValue].Detail
//        lblDetailDescription.text = milkProcess[intBoolSetSliderValue].Detail_Process
//        let timerDate = Constant.userDefault.getTimerDate()
//        if(timerDate == ""){
//          
//        }else{
//            
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
//            let date = dateFormatter.date(from: timerDate)
//            if(!(date == nil)){
//                let pickedDatetime = date!
//                self.didCreateEvent(name: "", targetDate: pickedDatetime)
//               
//            }
//          
//        }
//         if(intBoolSetSliderValue == 6){
//
//
//
//
//        }
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "YogurtProcessViewController") as? YogurtProcessViewController
//            vc?.strSelectMaker = Constant.userDefault.getSelectMaker()
//            vc?.isBoolClickedFromTimer = true
            
    //        vc?.strTitle = strTitle
    //        vc?.strSelectProcess = strSelectProcess
    //        vc?.strSelectedStarterTitle = milkProcess[indexPath.row].title
    //        vc?.strSelectedDescription = milkProcess[indexPath.row].description
    //        vc?.strSelectedStarterImage = "\(indexPath.item)"
         //   self.navigationController?.pushViewController(vc!, animated: true)
        }
    //MARK:- other Service
    
    @IBAction func btnBackClicked(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func btnCheckMarkClicked(_ sender: UIButton)
    {
       
        if(imgCheckMark?.image == UIImage.init(named: "CheckBox")){
            self.imgCheckMark?.image = UIImage.init(named: "CheckBox_selected")
            self.txtEmail.isUserInteractionEnabled = false
            self.txtRetypeEmail.isUserInteractionEnabled = false
        }else{
            
            self.imgCheckMark?.image = UIImage.init(named: "CheckBox")
            self.txtEmail.isUserInteractionEnabled = true
            self.txtRetypeEmail.isUserInteractionEnabled = true
               
        }
    }
    
    @IBAction func btnOverviewBackClicked(_ sender: UIButton)
    {
        isBoolClickedFromTimer = false
        if(intBoolSetSliderValue < 8){
           
            self.hieghtStartTimer.constant = 0
            
            intBoolSetSliderValue = intBoolSetSliderValue - 1
            self.lblTimer.isHidden = true
            if(intBoolSetSliderValue == 1){
                self.stackMakeIt.isHidden = false
                self.stackBackView.isHidden = true
            }
            else{
                self.stackMakeIt.isHidden = true
                self.stackBackView.isHidden = false
            }
            self.btnNext.setTitle("Next", for: .normal)
            if(intBoolSetSliderValue > 0){
                
                
                if(intBoolSetSliderValue == 6){
                    if(hieghtTimer.constant > 0){
                        hieghtTimer.constant = 0
                    }
                    if(isBoolClickedFromTimer){
                        self.btnStartTimer.setTitle("Stop Timer", for: .normal)
                        self.stackMakeIt.isHidden = true
                        self.stackBackView.isHidden = false
                        self.lblTimer.isHidden = false
                        switch UIDevice.current.userInterfaceIdiom {
                        case .phone:
                            self.timerHieght(height: 50)
                        // It's an iPhone
                        case .pad:
                            self.timerHieght(height: 80)
                        case .unspecified: break
                            
                        case .tv: break
                            
                        case .carPlay: break
                            
                        case .mac: break
                            
                        @unknown default: break
                        // Uh, oh! What could it be?
                        }
                      //  self.hieghtStartTimer.constant = 60
                        SliderContainerView.selectedMaxValue = 6.0
                        imgOverview.image = UIImage.init(named: milkProcess[5].imgName)
                       // intBoolSetSliderValue = 5
                       // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
                        lblOverView.text = milkProcess[5].title
                        lblDescription.text = milkProcess[5].Detail
                        lblDetailDescription.text = milkProcess[5].Detail_Process
                        let timerDate = Constant.userDefault.getTimerDate()
                        if(timerDate == ""){
                          
                        }else{
                            if(isBoolProcessRunning){
                                
                            }else{
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                                let date = dateFormatter.date(from: timerDate)
                                if(!(date == nil)){
                                    let pickedDatetime = date!
                                    self.didCreateEvent(name: "", targetDate: pickedDatetime)
                                   
                                }
                            }
                           
                          
                        }
                    }else{
                        self.stackMakeIt.isHidden = true
                        self.stackBackView.isHidden = false
                        switch UIDevice.current.userInterfaceIdiom {
                        case .phone:
                            self.timerHieght(height: 60)
                        // It's an iPhone
                        case .pad:
                            self.timerHieght(height: 80)
                        case .unspecified: break
                            
                        case .tv: break
                            
                        case .carPlay: break
                            
                        case .mac: break
                            
                        @unknown default: break
                        // Uh, oh! What could it be?
                        }
                       // self.hieghtStartTimer.constant = 60
                        self.btnStartTimer.setTitle("Start Timer", for: .normal)
                        self.btnStartTimer.setBackgroundColor(MySingleton.sharedManager().themeGlobalBlueColor, for: .normal)
                        self.btnStartTimer.setTitleColor(UIColor.white, for: .normal)
                     
                        self.lblTimer.isHidden = false
                        if(strSelectedDescription == "Ready Starter"){
                            if(strSelectMaker == "1"){
                                lblTimer.text = "4:00:00 hrs"
                            }
                            else if(strSelectMaker == "2"){
                                lblTimer.text = "6:00:00 hrs"
                            }
                            else if(strSelectMaker == "3"){
                                lblTimer.text = "8:00:00 hrs"
                            }
                        }else{
                            if(strSelectMaker == "1"){
                                lblTimer.text = "12:00:00 hrs"
                            }
                            else if(strSelectMaker == "2"){
                                lblTimer.text = "16:00:00 hrs"
                            }
                            else if(strSelectMaker == "3"){
                                lblTimer.text = "24:00:00 hrs"
                            }
                        }
                    }
                    
              
                }else{
                    if(isBoolProcessRunning){
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
                    self.hieghtStartTimer.constant = 0
                }
                if(strSelectedDescription == "Ready Starter"){
                    if((intBoolSetSliderValue - 1) == 3){
                        imgOverview.image = UIImage.init(named: "Process4_4")
                        // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
                        lblOverView.text = "Introduce ready yogurt and kefir"
                        lblDescription.text = "Reculture with ready yogurt and kefir as you mix ready yogurt or kefir with milk and incubate."
                        
                        SliderContainerView.selectedMaxValue = CGFloat(intBoolSetSliderValue)
                        SliderContainerView.setNeedsLayout()
                    }else{
                        imgOverview.image = UIImage.init(named: milkProcess[intBoolSetSliderValue - 1].imgName)
                        lblOverView.text = milkProcess[intBoolSetSliderValue - 1].title
                        lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        if(strSelectMaker == "1"){
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"4")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }else if(strSelectMaker == "2"){
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"6")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }
                        else{
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"8")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }
                        lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
                        
                        SliderContainerView.selectedMaxValue = CGFloat(intBoolSetSliderValue)
                        SliderContainerView.setNeedsLayout()
                    }
                } else if(strSelectedDescription == "Vegan Starter"){
                    if((intBoolSetSliderValue - 1) == 3){
                        imgOverview.image = UIImage.init(named: "Process4_4_1")
                        lblOverView.text = milkProcess[intBoolSetSliderValue - 1].title
                        lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        if(strSelectMaker == "1"){
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"12")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }else if(strSelectMaker == "2"){
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"16")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }
                        else{
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"24")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }
                        lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
                        
                        SliderContainerView.selectedMaxValue = CGFloat(intBoolSetSliderValue)
                        SliderContainerView.setNeedsLayout()
                    }else{
                        imgOverview.image = UIImage.init(named: milkProcess[intBoolSetSliderValue - 1].imgName)
                        lblOverView.text = milkProcess[intBoolSetSliderValue - 1].title
                        lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        if(strSelectMaker == "1"){
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"12")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }else if(strSelectMaker == "2"){
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"16")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }
                        else{
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"24")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }
                        lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
                        
                        SliderContainerView.selectedMaxValue = CGFloat(intBoolSetSliderValue)
                        SliderContainerView.setNeedsLayout()
                    }
                }
                else{
                    imgOverview.image = UIImage.init(named: milkProcess[intBoolSetSliderValue - 1].imgName)
                    lblOverView.text = milkProcess[intBoolSetSliderValue - 1].title
                    lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                    if(strSelectMaker == "1"){
                        if((intBoolSetSliderValue - 1) == 5){
                            let s = milkProcess[intBoolSetSliderValue - 1].Detail
                            let modified = s.replace(string: "18", replacement:"12")
                            lblDescription.text = modified
                        }else{
                            lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        }
                    }else if(strSelectMaker == "2"){
                        if((intBoolSetSliderValue - 1) == 5){
                            let s = milkProcess[intBoolSetSliderValue - 1].Detail
                            let modified = s.replace(string: "18", replacement:"16")
                            lblDescription.text = modified
                        }else{
                            lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        }
                    }
                    else{
                        if((intBoolSetSliderValue - 1) == 5){
                            let s = milkProcess[intBoolSetSliderValue - 1].Detail
                            let modified = s.replace(string: "18", replacement:"24")
                            lblDescription.text = modified
                        }else{
                            lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        }
                    }
                    lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
                    
                    SliderContainerView.selectedMaxValue = CGFloat(intBoolSetSliderValue)
                    SliderContainerView.setNeedsLayout()
                }
            }else{
                
                if(strSelectedDescription == "Ready Starter"){
                    if((intBoolSetSliderValue - 1) == 3){
                        imgOverview.image = UIImage.init(named: "Process4_4")
                        // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
                        lblOverView.text = "Introduce ready yogurt and kefir"
                        lblDescription.text = "Reculture with ready yogurt and kefir as you mix ready yogurt or kefir with milk and incubate."
                        
                        intBoolSetSliderValue = 1
                      
                        lblDetailDescription.text = ""
                        
                        SliderContainerView.selectedMaxValue = CGFloat(intBoolSetSliderValue)
                        SliderContainerView.setNeedsLayout()
                    }else{
                        
                        intBoolSetSliderValue = 1
                        imgOverview.image = UIImage.init(named: milkProcess[intBoolSetSliderValue - 1].imgName)
                        lblOverView.text = milkProcess[intBoolSetSliderValue - 1].title
                        lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        if(strSelectMaker == "1"){
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"4")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }else if(strSelectMaker == "2"){
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"6")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }
                        else{
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"8")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }
                        lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
                        
                        SliderContainerView.selectedMaxValue = CGFloat(intBoolSetSliderValue)
                        SliderContainerView.setNeedsLayout()
                    }
                }
                else if(strSelectedDescription == "Vegan Starter"){
                    if((intBoolSetSliderValue - 1) == 3){
                        imgOverview.image = UIImage.init(named: "Process4_4_1")
                        // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
                        lblOverView.text = milkProcess[intBoolSetSliderValue - 1].title
                        lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
                        
                        intBoolSetSliderValue = 1
                      
                        lblDetailDescription.text = ""
                        
                        SliderContainerView.selectedMaxValue = CGFloat(intBoolSetSliderValue)
                        SliderContainerView.setNeedsLayout()
                    }else{
                        
                        intBoolSetSliderValue = 1
                        imgOverview.image = UIImage.init(named: milkProcess[intBoolSetSliderValue - 1].imgName)
                        lblOverView.text = milkProcess[intBoolSetSliderValue - 1].title
                        lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
                        if(strSelectMaker == "1"){
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"12")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }else if(strSelectMaker == "2"){
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"16")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }
                        else{
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"24")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }
                        SliderContainerView.selectedMaxValue = CGFloat(intBoolSetSliderValue)
                        SliderContainerView.setNeedsLayout()
                    }
                }//
                else{
                    intBoolSetSliderValue = 1
                    imgOverview.image = UIImage.init(named: milkProcess[intBoolSetSliderValue - 1].imgName)
                    lblOverView.text = milkProcess[intBoolSetSliderValue - 1].title
                    lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                    lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
                    if(strSelectMaker == "1"){
                        if((intBoolSetSliderValue - 1) == 5){
                            let s = milkProcess[intBoolSetSliderValue - 1].Detail
                            let modified = s.replace(string: "18", replacement:"12")
                            lblDescription.text = modified
                        }else{
                            lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        }
                    }else if(strSelectMaker == "2"){
                        if((intBoolSetSliderValue - 1) == 5){
                            let s = milkProcess[intBoolSetSliderValue - 1].Detail
                            let modified = s.replace(string: "18", replacement:"16")
                            lblDescription.text = modified
                        }else{
                            lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        }
                    }
                    else{
                        if((intBoolSetSliderValue - 1) == 5){
                            let s = milkProcess[intBoolSetSliderValue - 1].Detail
                            let modified = s.replace(string: "18", replacement:"24")
                            lblDescription.text = modified
                        }else{
                            lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        }
                    }
                    SliderContainerView.selectedMaxValue = CGFloat(intBoolSetSliderValue)
                    SliderContainerView.setNeedsLayout()
                }
                
//                self.stackMakeIt.isHidden = false
//                self.stackBackView.isHidden = true
               
            }
        }
       
        
    }
    @IBAction func btnOverviewNextClicked(_ sender: UIButton)
    {
        isBoolClickedFromTimer = false
        if(intBoolSetSliderValue < 7){
            self.hieghtStartTimer.constant = 0
//            self.stackMakeIt.isHidden = true
//            self.stackBackView.isHidden = false
              
            intBoolSetSliderValue = intBoolSetSliderValue + 1
            self.lblTimer.isHidden = true
            if(intBoolSetSliderValue == 1){
                self.stackMakeIt.isHidden = false
                self.stackBackView.isHidden = true
                
                if(isBoolProcessRunning){
                    switch UIDevice.current.userInterfaceIdiom {
                    case .phone:
                        hieghtTimer.constant = 50
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
                
                //self.btnOverviewLetsMakeIt.setTitle("Next", for: .normal)
            }else if(intBoolSetSliderValue == 6){
                
                if(hieghtTimer.constant > 0){
                    hieghtTimer.constant = 0
                }
                if(isBoolClickedFromTimer){
                    self.btnStartTimer.setTitle("Stop Timer", for: .normal)
                    self.stackMakeIt.isHidden = true
                    self.stackBackView.isHidden = false
                    self.lblTimer.isHidden = false
                    switch UIDevice.current.userInterfaceIdiom {
                    case .phone:
                        self.timerHieght(height: 60)
                    // It's an iPhone
                    case .pad:
                        self.timerHieght(height: 80)
                    case .unspecified: break
                        
                    case .tv: break
                        
                    case .carPlay: break
                        
                    case .mac: break
                        
                    @unknown default: break
                    // Uh, oh! What could it be?
                    }
                    //self.hieghtStartTimer.constant = 60
                    SliderContainerView.selectedMaxValue = 6.0
                    imgOverview.image = UIImage.init(named: milkProcess[intBoolSetSliderValue].imgName)
                   // intBoolSetSliderValue = 5
                   // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
                    lblOverView.text = milkProcess[intBoolSetSliderValue].title
                    lblDescription.text = milkProcess[intBoolSetSliderValue].Detail
                    lblDetailDescription.text = milkProcess[intBoolSetSliderValue].Detail_Process
                    let timerDate = Constant.userDefault.getTimerDate()
                    if(timerDate == ""){
                      
                    }else{
                        if(isBoolProcessRunning){
                            
                        }else{
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                            let date = dateFormatter.date(from: timerDate)
                            if(!(date == nil)){
                                let pickedDatetime = date!
                                self.didCreateEvent(name: "", targetDate: pickedDatetime)
                               
                            }
                        }
                    }
                }else{
                    scheduleTime?.invalidate()
                    self.stackMakeIt.isHidden = true
                    self.stackBackView.isHidden = false
                    self.lblTimer.isHidden = false
                    print(strSelectedDescription)
                    if(strSelectedDescription == "Ready Starter"){
                        if(strSelectMaker == "1"){
                            lblTimer.text = "4:00:00 hrs"
                        }
                        else if(strSelectMaker == "2"){
                            lblTimer.text = "6:00:00 hrs"
                        }
                        else if(strSelectMaker == "3"){
                            lblTimer.text = "8:00:00 hrs"
                        }
                    }else{
                        if(strSelectMaker == "1"){
                            lblTimer.text = "12:00:00 hrs"
                        }
                        else if(strSelectMaker == "2"){
                            lblTimer.text = "16:00:00 hrs"
                        }
                        else if(strSelectMaker == "3"){
                            lblTimer.text = "24:00:00 hrs"
                        }
                    }
                  
                    switch UIDevice.current.userInterfaceIdiom {
                    case .phone:
                        self.timerHieght(height: 60)
                    // It's an iPhone
                    case .pad:
                        self.timerHieght(height: 80)
                    case .unspecified: break
                        
                    case .tv: break
                        
                    case .carPlay: break
                        
                    case .mac: break
                        
                    @unknown default: break
                    // Uh, oh! What could it be?
                    }
                    //self.hieghtStartTimer.constant = 60
                    self.btnStartTimer.setTitle("Start Timer", for: .normal)
                    self.btnStartTimer.setBackgroundColor(MySingleton.sharedManager().themeGlobalBlueColor, for: .normal)
                    self.btnStartTimer.setTitleColor(UIColor.white, for: .normal)
                   
                }
               
          
            }
            else if(intBoolSetSliderValue == 7){
              
                if(isBoolProcessRunning){
                    switch UIDevice.current.userInterfaceIdiom {
                    case .phone:
                        hieghtTimer.constant = 50
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
                self.hieghtStartTimer.constant = 0
                self.btnNext.setTitle("Let's Enjoy", for: .normal)
               
            }
            else{
                self.btnNext.setTitle("Next", for: .normal)
                self.stackMakeIt.isHidden = true
                self.stackBackView.isHidden = false
               // self.btnOverviewLetsMakeIt.setTitle("Next", for: .normal)
            }
            
            if(intBoolSetSliderValue > 0){
                if(strSelectedDescription == "Ready Starter"){
                    if((intBoolSetSliderValue - 1) == 3){
                        imgOverview.image = UIImage.init(named: "Process4_4")
                       // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
                        lblOverView.text = "Introduce ready yogurt and kefir"
                        lblDescription.text = "Reculture with ready yogurt and kefir as you mix ready yogurt or kefir with milk and incubate."
                        lblDetailDescription.text = ""
                      
                        SliderContainerView.selectedMaxValue = CGFloat(intBoolSetSliderValue)
                    }else{
                        imgOverview.image = UIImage.init(named: milkProcess[intBoolSetSliderValue - 1].imgName)
                       // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
                        lblOverView.text = milkProcess[intBoolSetSliderValue - 1].title
                        if(intBoolSetSliderValue == 2){
                            //lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
                        }else{
                            lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
                        }
                        //lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        if(strSelectMaker == "1"){
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"4")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }else if(strSelectMaker == "2"){
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"6")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }
                        else{
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"8")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }
                    }
                }else if(strSelectedDescription == "Vegan Starter"){
                    if((intBoolSetSliderValue - 1) == 3){
                        imgOverview.image = UIImage.init(named: "Process4_4_1")
                       
                       // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
                        lblOverView.text = milkProcess[intBoolSetSliderValue - 1].title
                        if(intBoolSetSliderValue == 2){
                            //lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
                        }else{
                            lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
                        }
                        if(strSelectMaker == "1"){
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"12")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }else if(strSelectMaker == "2"){
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"16")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }
                        else{
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"24")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }
                       // lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                    }else{
                        imgOverview.image = UIImage.init(named: milkProcess[intBoolSetSliderValue - 1].imgName)
                       
                       // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
                        lblOverView.text = milkProcess[intBoolSetSliderValue - 1].title
                        lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        if(intBoolSetSliderValue == 2){
                            //lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
                        }else{
                            if(strSelectMaker == "1"){
                                if((intBoolSetSliderValue - 1) == 5){
                                    let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                    let modified = s.replace(string: "18", replacement:"12")
                                    lblDescription.text = modified
                                }else{
                                    lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                                }
                            }else if(strSelectMaker == "2"){
                                if((intBoolSetSliderValue - 1) == 5){
                                    let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                    let modified = s.replace(string: "18", replacement:"16")
                                    lblDescription.text = modified
                                }else{
                                    lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                                }
                            }
                            else{
                                if((intBoolSetSliderValue - 1) == 5){
                                    let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                    let modified = s.replace(string: "24", replacement:"18")
                                    lblDescription.text = modified
                                }else{
                                    lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                                }
                            }
                            lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
                        }
                      //  lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                    }
                }else{
                    imgOverview.image = UIImage.init(named: milkProcess[intBoolSetSliderValue - 1].imgName)
                   // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
                    lblOverView.text = milkProcess[intBoolSetSliderValue - 1].title
                    if(intBoolSetSliderValue == 2){
                        //lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
                    }else{
                        lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
                    }
                    if(strSelectMaker == "1"){
                        if((intBoolSetSliderValue - 1) == 5){
                            let s = milkProcess[intBoolSetSliderValue - 1].Detail
                            let modified = s.replace(string: "18", replacement:"12")
                            lblDescription.text = modified
                        }else{
                            lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        }
                    }else if(strSelectMaker == "2"){
                        if((intBoolSetSliderValue - 1) == 5){
                            let s = milkProcess[intBoolSetSliderValue - 1].Detail
                            let modified = s.replace(string: "18", replacement:"16")
                            lblDescription.text = modified
                        }else{
                            lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        }
                    }
                    else{
                        if((intBoolSetSliderValue - 1) == 5){
                            let s = milkProcess[intBoolSetSliderValue - 1].Detail
                            let modified = s.replace(string: "18", replacement:"24")
                            lblDescription.text = modified
                        }else{
                            lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        }
                    }
                  //  lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                }
                
                SliderContainerView.selectedMaxValue = CGFloat(intBoolSetSliderValue)
                SliderContainerView.setNeedsLayout()
            }else{
//                self.stackMakeIt.isHidden = false
//                self.stackBackView.isHidden = true
                intBoolSetSliderValue = 1
                if(strSelectedDescription == "Ready Starter"){
                    if((intBoolSetSliderValue - 1) == 3){
                        imgOverview.image = UIImage.init(named: "Process4_4")
                       // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
                        lblOverView.text = "Introduce ready yogurt and kefir"
                        lblDescription.text = "Reculture with ready yogurt and kefir as you mix ready yogurt or kefir with milk and incubate."
                        lblDetailDescription.text = ""
                      
                        SliderContainerView.selectedMaxValue = CGFloat(intBoolSetSliderValue)
                    }else{
                        if(strSelectMaker == "1"){
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"4")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }else if(strSelectMaker == "2"){
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"6")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }
                        else{
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"8")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }
                        
                        if((intBoolSetSliderValue - 1) == 2){
                        }
                        else if((intBoolSetSliderValue - 1) == 3){
                        }
                        else{
                            lblOverView.text = milkProcess[intBoolSetSliderValue - 1].title
                         //   lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
                        }
                        imgOverview.image = UIImage.init(named: milkProcess[intBoolSetSliderValue - 1].imgName)
//                        if(strTitle == "Whole (full-fat) Daily Milk"){
//                            imgOverview.image = UIImage.init(named: milkProcess[intBoolSetSliderValue - 1].imgName)
//                           // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
//                            lblOverView.text = milkProcess[intBoolSetSliderValue - 1].title
//                         //   lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
//                            lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
//                        }else{
//                           
//                           // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
//                            
//                        }
                       
                      
                        SliderContainerView.selectedMaxValue = CGFloat(intBoolSetSliderValue)
                    }
                }else if(strSelectedDescription == "Vegan Starter"){
                    if((intBoolSetSliderValue - 1) == 3){
                        imgOverview.image = UIImage.init(named: "Process4_4_1")
                        
                       // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
                        lblOverView.text = milkProcess[intBoolSetSliderValue - 1].title
                        lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
                      
                        SliderContainerView.selectedMaxValue = CGFloat(intBoolSetSliderValue)
                    }else{
                        if(strSelectMaker == "1"){
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"4")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }else if(strSelectMaker == "2"){
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"6")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }
                        else{
                            if((intBoolSetSliderValue - 1) == 5){
                                let s = milkProcess[intBoolSetSliderValue - 1].Detail
                                let modified = s.replace(string: "18", replacement:"8")
                                lblDescription.text = modified
                            }else{
                                lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            }
                        }
                        
                        if(strTitle == "Whole (full-fat) Daily Milk"){
                            imgOverview.image = UIImage.init(named: milkProcess[intBoolSetSliderValue - 1].imgName)
                           // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
                            lblOverView.text = milkProcess[intBoolSetSliderValue - 1].title
                         //   lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                            lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
                        }
                        imgOverview.image = UIImage.init(named: milkProcess[intBoolSetSliderValue - 1].imgName)
                       // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
                        lblOverView.text = milkProcess[intBoolSetSliderValue - 1].title
                        lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
                      
                        SliderContainerView.selectedMaxValue = CGFloat(intBoolSetSliderValue)
                    }
                }else{
                    if(strSelectMaker == "1"){
                        if((intBoolSetSliderValue - 1) == 5){
                            let s = milkProcess[intBoolSetSliderValue - 1].Detail
                            let modified = s.replace(string: "18", replacement:"12")
                            lblDescription.text = modified
                        }else{
                            lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        }
                    }else if(strSelectMaker == "2"){
                        if((intBoolSetSliderValue - 1) == 5){
                            let s = milkProcess[intBoolSetSliderValue - 1].Detail
                            let modified = s.replace(string: "18", replacement:"16")
                            lblDescription.text = modified
                        }else{
                            lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        }
                    }
                    else{
                        if((intBoolSetSliderValue - 1) == 5){
                            let s = milkProcess[intBoolSetSliderValue - 1].Detail
                            let modified = s.replace(string: "18", replacement:"24")
                            lblDescription.text = modified
                        }else{
                            lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                        }
                    }
//
                    imgOverview.image = UIImage.init(named: milkProcess[intBoolSetSliderValue - 1].imgName)
                   // lblMilkType.text =  milkProcess[intBoolSetSliderValue - 1].Detail
                    lblOverView.text = milkProcess[intBoolSetSliderValue - 1].title
                   // lblDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail
                    lblDetailDescription.text = milkProcess[intBoolSetSliderValue - 1].Detail_Process
                  
                    SliderContainerView.selectedMaxValue = CGFloat(intBoolSetSliderValue)
                }
               
                SliderContainerView.setNeedsLayout()
            }
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
            self.navigationController?.pushViewController(vc!, animated: true)
          
        }
       
      
      
     //   SliderContainerView.selectedMaxValue = 5.0
       // self.rangeSeekSlider(SliderContainerView, didChange: 0, maxValue: 5.6000)
        // SliderContainerView.selectedMaxValue = 5
       
    }
    
    
  
    @IBAction func btnOrderStarterClicked(_ sender: UIButton)
    {
        if let url = URL(string: "https://www.npselection.com/") {
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func btnContactUsClicked(_ sender: UIButton)
    {
        if let url = URL(string: "https://www.yogurtathome.com/contact") {
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func btnContinueClicked(_ sender: UIButton)
    {
        if(imgCheckMark?.image == UIImage.init(named: "CheckBox_selected")){
            self.btnStartTimer.setTitle("Stop Timer", for: .normal)
            self.lblTimer.isHidden = false
            let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                let current_date_time = dateFormatter.string(from: date)
                print("before add time-->",current_date_time)

            Constant.userDefault.setSelectMaker(value: strSelectMaker)
                //adding 5 miniuts
            var TimerMiliSecond : String = ""
            if(strSelectedDescription == "Ready Starter"){
                if(strSelectMaker == "1"){
                    let addminutes = date.addingTimeInterval(14400)
                    TimerMiliSecond = "14400"
                   // let addminutes = date.addingTimeInterval(120)
                    dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                    let after_add_time = dateFormatter.string(from: addminutes)
                    print("after add time-->",after_add_time)
                    Constant.userDefault.setTimerDate(value: after_add_time)
                    let pickedDatetime = addminutes
                    self.didCreateEvent(name: "", targetDate: pickedDatetime)
                }
                else if(strSelectMaker == "2"){
                    let addminutes = date.addingTimeInterval(21600)
                    TimerMiliSecond = "21600"
                    dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                    let after_add_time = dateFormatter.string(from: addminutes)
                    Constant.userDefault.setTimerDate(value: after_add_time)
                    print("after add time-->",after_add_time)
                    let pickedDatetime = addminutes
                    self.didCreateEvent(name: "", targetDate: pickedDatetime)
                }
                else if(strSelectMaker == "3"){
                    let addminutes = date.addingTimeInterval(28800)
                    TimerMiliSecond = "28800"
                    dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                    let after_add_time = dateFormatter.string(from: addminutes)
                    Constant.userDefault.setTimerDate(value: after_add_time)
                    print("after add time-->",after_add_time)
                    let pickedDatetime = addminutes
                    self.didCreateEvent(name: "", targetDate: pickedDatetime)
                }
            }else{
                if(strSelectMaker == "1"){
                    let addminutes = date.addingTimeInterval(43200)
                    TimerMiliSecond = "43200"
                   // let addminutes = date.addingTimeInterval(120)
                    dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                    let after_add_time = dateFormatter.string(from: addminutes)
                    print("after add time-->",after_add_time)
                    Constant.userDefault.setTimerDate(value: after_add_time)
                    let pickedDatetime = addminutes
                    self.didCreateEvent(name: "", targetDate: pickedDatetime)
                }
                else if(strSelectMaker == "2"){
                    let addminutes = date.addingTimeInterval(57600)
                    TimerMiliSecond = "57600"
                    dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                    let after_add_time = dateFormatter.string(from: addminutes)
                    Constant.userDefault.setTimerDate(value: after_add_time)
                    print("after add time-->",after_add_time)
                    let pickedDatetime = addminutes
                    self.didCreateEvent(name: "", targetDate: pickedDatetime)
                }
                else if(strSelectMaker == "3"){
                    let addminutes = date.addingTimeInterval(86400)
                    TimerMiliSecond = "86400"
                    dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                    let after_add_time = dateFormatter.string(from: addminutes)
                    Constant.userDefault.setTimerDate(value: after_add_time)
                    print("after add time-->",after_add_time)
                    let pickedDatetime = addminutes
                    self.didCreateEvent(name: "", targetDate: pickedDatetime)
                }
            }
           
         
            let UUID = NSUUID().uuidString
            print("UUID: \(UUID)")
          
            self.blackTransperentView.isHidden = true
            self.viewEmail.isHidden = true
            let strTimerMiliSecond : String = String(TimerMiliSecond)
            let dicParams : Dictionary = [ "id" : "\(Constant.userDefault.getIDData())", "device_token" : "\(Constant.userDefault.getFCMTokenData())","email" : "","time" : strTimerMiliSecond,"milk" : "","starter" : "","maker" : ""]
            
            //Constant.userDefault.setNotificationOpenDateData(value: strDate)
            self.startTimer(dicParams: dicParams.queryString)
            
        }else{
            if(txtEmail.text?.count ?? 0 <= 0 || txtRetypeEmail.text?.count ?? 0 <= 0 || (txtEmail.text?.isValidEmail()) == nil || (txtRetypeEmail.text?.isValidEmail()) == nil || (!(txtEmail.text == txtRetypeEmail.text))){
                
                if(txtEmail.text?.count ?? 0 <= 0){
                    Utils.Toast(message: "Please Enter both email id", controller: self)
                }else  if(txtEmail.text?.count ?? 0 <= 0){
                    Utils.Toast(message: "Please Enter both email id", controller: self)
                }
                else if((txtEmail.text?.isValidEmail()) == nil) {
                    Utils.Toast(message: "Please Enter Valid email id", controller: self)
                }
                else if((txtRetypeEmail.text?.isValidEmail()) == nil) {
                    Utils.Toast(message: "Please Enter Valid email id", controller: self)
                }
                else if(!(txtEmail.text == txtRetypeEmail.text)){
                    Utils.Toast(message: "Both email id should be same", controller: self)
                }
             
            }else{
                self.btnStartTimer.setTitle("Stop Timer", for: .normal)
                self.lblTimer.isHidden = false
                let date = Date()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                    let current_date_time = dateFormatter.string(from: date)
                    print("before add time-->",current_date_time)

                Constant.userDefault.setSelectMaker(value: strSelectMaker)
                    //adding 5 miniuts
                var TimerMiliSecond : String = ""
                if(strSelectedDescription == "Ready Starter"){
                    if(strSelectMaker == "1"){
                        let addminutes = date.addingTimeInterval(14400)
                        TimerMiliSecond = "14400"
                       // let addminutes = date.addingTimeInterval(120)
                        dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                        let after_add_time = dateFormatter.string(from: addminutes)
                        print("after add time-->",after_add_time)
                        Constant.userDefault.setTimerDate(value: after_add_time)
                        let pickedDatetime = addminutes
                        self.didCreateEvent(name: "", targetDate: pickedDatetime)
                    }
                    else if(strSelectMaker == "2"){
                        let addminutes = date.addingTimeInterval(21600)
                        TimerMiliSecond = "21600"
                        dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                        let after_add_time = dateFormatter.string(from: addminutes)
                        Constant.userDefault.setTimerDate(value: after_add_time)
                        print("after add time-->",after_add_time)
                        let pickedDatetime = addminutes
                        self.didCreateEvent(name: "", targetDate: pickedDatetime)
                    }
                    else if(strSelectMaker == "3"){
                        let addminutes = date.addingTimeInterval(28800)
                        TimerMiliSecond = "28800"
                        dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                        let after_add_time = dateFormatter.string(from: addminutes)
                        Constant.userDefault.setTimerDate(value: after_add_time)
                        print("after add time-->",after_add_time)
                        let pickedDatetime = addminutes
                        self.didCreateEvent(name: "", targetDate: pickedDatetime)
                    }
                }else{
                    if(strSelectMaker == "1"){
                        let addminutes = date.addingTimeInterval(43200)
                        TimerMiliSecond = "43200"
                       // let addminutes = date.addingTimeInterval(120)
                        dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                        let after_add_time = dateFormatter.string(from: addminutes)
                        print("after add time-->",after_add_time)
                        Constant.userDefault.setTimerDate(value: after_add_time)
                        let pickedDatetime = addminutes
                        self.didCreateEvent(name: "", targetDate: pickedDatetime)
                    }
                    else if(strSelectMaker == "2"){
                        let addminutes = date.addingTimeInterval(57600)
                        TimerMiliSecond = "57600"
                        dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                        let after_add_time = dateFormatter.string(from: addminutes)
                        Constant.userDefault.setTimerDate(value: after_add_time)
                        print("after add time-->",after_add_time)
                        let pickedDatetime = addminutes
                        self.didCreateEvent(name: "", targetDate: pickedDatetime)
                    }
                    else if(strSelectMaker == "3"){
                        let addminutes = date.addingTimeInterval(86400)
                        TimerMiliSecond = "57600"
                        dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
                        let after_add_time = dateFormatter.string(from: addminutes)
                        Constant.userDefault.setTimerDate(value: after_add_time)
                        print("after add time-->",after_add_time)
                        let pickedDatetime = addminutes
                        self.didCreateEvent(name: "", targetDate: pickedDatetime)
                    }
                }
                
                let UUID = NSUUID().uuidString
                print("UUID: \(UUID)")
              
                self.blackTransperentView.isHidden = true
                self.viewEmail.isHidden = true
                
//                let dicParams : Dictionary = [ "id" : "\(Constant.userDefault.getIDData())", "device_token" : "\(Constant.userDefault.getFCMTokenData())","email" : "\(txtEmail.text ?? "")","time" : "\(TimerMiliSecond)","milk" : "","starter" : "","maker" : ""]
                
                let dicParams : Dictionary = [ "id" : "\(Constant.userDefault.getIDData())", "device_token" : "\(Constant.userDefault.getFCMTokenData())","email" : "\(txtEmail.text ?? "")","time" : "\(TimerMiliSecond)","milk" : "","starter" : "","maker" : ""]
                //Constant.userDefault.setNotificationOpenDateData(value: strDate)
                self.startTimer(dicParams: dicParams.queryString)
                self.blackTransperentView.isHidden = true
                self.viewEmail.isHidden = true
            }
        }
    }
    @IBAction func btnStartTimerClicked(_ sender: UIButton)
    {
        let timerDate = Constant.userDefault.getTimerDate()
        if(timerDate == ""){
            if(btnStartTimer.titleLabel?.text == "Stop Timer"){
                
                let refreshAlert = UIAlertController(title: "Alert", message: "Do you want to cancel current timer ?", preferredStyle: UIAlertController.Style.alert)

                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                    Constant.userDefault.clearUserDefaultsValues()
                    self.isBoolProcessRunning = false
                    let dicParams : Dictionary = [ "id" : "\(Constant.userDefault.getIDData())", "device_token" : "\(Constant.userDefault.getFCMTokenData())","email" : "","time" : "","milk" : "","starter" : "","maker" : ""]
                    self.isBoolClickedStopTimer = true
                    //Constant.userDefault.setNotificationOpenDateData(value: strDate)
                    self.startTimer(dicParams: dicParams.queryString)
                    
                   
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
//                    self.navigationController?.pushViewController(vc!, animated: true)
                      
                }))

                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                      print("Handle Cancel Logic here")
                }))

                present(refreshAlert, animated: true, completion: nil)
          
            }else{
                self.blackTransperentView.isHidden = false
                self.viewEmail.isHidden = false
            }
        }else{
            let refreshAlert = UIAlertController(title: "Alert", message: "Do you want to cancel current timer ?", preferredStyle: UIAlertController.Style.alert)

            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                
                if(self.isBoolProcessRunning){
//                    if(self.isBoolClickedFromTimer){
//
//                    }else{
//                        self.isBoolProcessRunning = true
//                        self.viewEmail.isHidden = false
//                        self.blackTransperentView.isHidden = false
//                    }
                    self.isBoolProcessRunning = false
                    
                    self.blackTransperentView.isHidden = true
                    self.viewEmail.isHidden = true
                    Constant.userDefault.clearUserDefaultsValues()
                    let dicParams : Dictionary = [ "id" : "\(Constant.userDefault.getIDData())", "device_token" : "\(Constant.userDefault.getFCMTokenData())","email" : "","time" : "","milk" : "","starter" : "","maker" : ""]
                    if(self.btnStartTimer.titleLabel?.text == "Stop Timer"){
                        self.isBoolClickedStopTimer = true
                    }else{
                        self.isBoolClickedStopTimer = false
                    }
                    self.startTimer(dicParams: dicParams.queryString)
                }else{
                    self.isBoolProcessRunning = false
                    
                    self.blackTransperentView.isHidden = true
                    self.viewEmail.isHidden = true
                    Constant.userDefault.clearUserDefaultsValues()
                    let dicParams : Dictionary = [ "id" : "\(Constant.userDefault.getIDData())", "device_token" : "\(Constant.userDefault.getFCMTokenData())","email" : "","time" : "","milk" : "","starter" : "","maker" : ""]
                    if(self.btnStartTimer.titleLabel?.text == "Stop Timer"){
                        self.isBoolClickedStopTimer = true
                    }else{
                        self.isBoolClickedStopTimer = false
                    }
                    self.startTimer(dicParams: dicParams.queryString)
                }
               
                
                //Constant.userDefault.setNotificationOpenDateData(value: strDate)
               
                
               
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
//                self.navigationController?.pushViewController(vc!, animated: true)
                  
            }))

            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                  print("Handle Cancel Logic here")
            }))

            present(refreshAlert, animated: true, completion: nil)
        }
       
        
    }
    @IBAction func btnClosedClicked(_ sender: UIButton)
    {
        self.blackTransperentView.isHidden = true
        self.viewEmail.isHidden = true
    }
    
}
// MARK: - RangeSeekSliderDelegate

extension YogurtProcessViewController: RangeSeekSliderDelegate {

    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        print("Custom slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
    }

    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
    }

    func didEndTouches(in slider: RangeSeekSlider) {
        print("did end touches")
    }
}
//Timer
extension YogurtProcessViewController{
    
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
//            Constant.userDefault.setTimerDate(value: "")
//            DispatchQueue.main.async {
//                self.hieghtTimer.constant = 0
//               }
//            print("negative interval")
        }
    }

    private func startTimer() {
      
        scheduleTime =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
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
        lblTimerTop.text = "\(hours):\(mins):\(secs)"
    }
}
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
//MARK:- Webservices
extension YogurtProcessViewController{

        func startTimer(dicParams: String) {

            let headers : NSDictionary = [ "" : "" ]

            
            WebServices().CallGlobalAPIForm(url: ServerUrl.SendEmail, headers: headers, parameters: dicParams, httpMethod: "POST", progressView: false, uiView: self.view, networkAlert: true) { (responseJSON, errorMessage) in

                print(responseJSON)

                print(errorMessage)

                guard errorMessage == "" else {
                    Utils.Toast(message: errorMessage , controller: self)
                    return
                }

                do {
                    SVProgressHUD.dismiss()

                    let jsonString = String(data: responseJSON! as! Data, encoding: .utf8)
                    let result = Utils.convertStringToDictionary(text: jsonString ?? "")
                    if let Code = result?["code"] { // The `?` is here because our

                    } else {
                        SVProgressHUD.dismiss()
                        if(self.isBoolClickedStopTimer){
                            self.stackMakeIt.isHidden = true
                            self.stackBackView.isHidden = false
                            self.lblTimer.isHidden = false
                            if(self.strSelectedDescription == "Ready Starter"){
                                if(self.strSelectMaker == "1"){
                                    self.lblTimer.text = "4:00:00 hrs"
                                }
                                else if(self.strSelectMaker == "2"){
                                    self.lblTimer.text = "6:00:00 hrs"
                                }
                                else if(self.strSelectMaker == "3"){
                                    self.lblTimer.text = "24:00:00 hrs"
                                }
                            }else{
                                if(self.strSelectMaker == "1"){
                                    self.lblTimer.text = "12:00:00 hrs"
                                }
                                else if(self.strSelectMaker == "2"){
                                    self.lblTimer.text = "16:00:00 hrs"
                                }
                                else if(self.strSelectMaker == "3"){
                                    self.lblTimer.text = "24:00:00 hrs"
                                }
                            }
                          
                            switch UIDevice.current.userInterfaceIdiom {
                            case .phone:
                                self.timerHieght(height: 0)
                            // It's an iPhone
                            case .pad:
                                self.timerHieght(height: 0)
                            case .unspecified: break
                                
                            case .tv: break
                                
                            case .carPlay: break
                                
                            case .mac: break
                                
                            @unknown default: break
                            // Uh, oh! What could it be?
                            }
                            self.hieghtStartTimer.constant = 50
                            self.btnStartTimer.setTitle("Start Timer", for: .normal)
                            self.btnStartTimer.setBackgroundColor(UIColor.white, for: .normal)
                            self.btnStartTimer.setTitleColor(MySingleton.sharedManager().themeGlobalBlueColor, for: .normal)
                            self.scheduleTime?.invalidate()
                        }else{
                            self.isBoolProcessRunning = true
                        }
                        Utils.Toast(message: result?["message"] as! String, controller: self)
                    }

                } catch {

                    SVProgressHUD.dismiss()

                    do {
                        let dataArray = try JSONDecoder().decode(MessageStruct.self,from: responseJSON as! Data)
                        Utils.Toast(message: dataArray.message ?? "", controller: self)
                    } catch {
                        Utils.Toast(message: error.localizedDescription, controller: self)
                    }
                }

            }

//    Intent intent = new Intent(YogurtMakerChooseActivity.this, StartTimerActivity.class);
//                   intent.putExtra("id",id);
//                   intent.putExtra("device_token",device_token);
//                   intent.putExtra("email",email);
//   //                intent.putExtra("time",Integer.parseInt(realtime));
//   //                intent.putExtra("timer",timeforNextActivity);
//                   intent.putExtra("milk",milk);
//                   intent.putExtra("starter",starter);
//                   intent.putExtra("maker",maker);
//                   intent.putExtra("pos",poss);
//                   intent.putExtra("count", 6);
//                   startActivity(intent);
}
}
