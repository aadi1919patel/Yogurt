//
//  MenuViewController.swift
//  Yogurt App
//
//  Created by Aditya on 01/05/21.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var imgClose: UIImageView!
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var lblShop: UILabel!
    @IBOutlet weak var imgShop: UIImageView!
    @IBOutlet weak var btnShop: UIButton!
    
    @IBOutlet weak var lblFindProduct: UILabel!
    @IBOutlet weak var imgFindProduct: UIImageView!
    @IBOutlet weak var btnFindProduct: UIButton!
    
    @IBOutlet weak var viewLetsConnect: UIView!
    @IBOutlet weak var lblLetsConnect: UILabel!
    @IBOutlet weak var imgLetsConnect: UIImageView!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var btnLetsConnect: UIButton!
    
    @IBOutlet weak var lblYoutube: UILabel!
    @IBOutlet weak var imgYoutube: UIImageView!
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
    
    @IBOutlet weak var lblShareApp: UILabel!
    @IBOutlet weak var imgShareApp: UIImageView!
    @IBOutlet weak var btnShareApp: UIButton!
    
    @IBOutlet weak var lblBlog: UILabel!
    @IBOutlet weak var imgBlog: UIImageView!
    @IBOutlet weak var btnBlog: UIButton!
    
    @IBOutlet weak var lblForum: UILabel!
    @IBOutlet weak var imgForum: UIImageView!
    @IBOutlet weak var btnForum: UIButton!
    
    @IBOutlet weak var lblContactUs: UILabel!
    @IBOutlet weak var imgContactUs: UIImageView!
    @IBOutlet weak var btnContactUs: UIButton!
    
    @IBOutlet weak var lblAboutUs: UILabel!
    @IBOutlet weak var imgAboutUs: UIImageView!
    @IBOutlet weak var btnAboutUs: UIButton!
    
    @IBOutlet weak var heightLetsConnect: NSLayoutConstraint!

    
    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupInitialViews()
        self.setUpNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    // MARK: - NavigationBar Methods
    
    func setUpNavigationBar()
    {
       
    }
    
    //MARK:- Functions
    func setupInitialViews() {
        
//        self.lblShop.font = MySingleton.sharedManager().themeFontEighteenSizeBold
//        self.lblShop.textColor = MySingleton.sharedManager().themeGlobalGreyColor
//        
//        self.lblFindProduct.font = MySingleton.sharedManager().themeFontEighteenSizeBold
//        self.lblFindProduct.textColor = MySingleton.sharedManager().themeGlobalGreyColor
//        
//        self.lblLetsConnect.font = MySingleton.sharedManager().themeFontEighteenSizeBold
//        self.lblLetsConnect.textColor = MySingleton.sharedManager().themeGlobalGreyColor
//        
//        self.lblShareApp.font = MySingleton.sharedManager().themeFontEighteenSizeBold
//        self.lblShareApp.textColor = MySingleton.sharedManager().themeGlobalGreyColor
//        
//        self.lblBlog.font = MySingleton.sharedManager().themeFontEighteenSizeBold
//        self.lblBlog.textColor = MySingleton.sharedManager().themeGlobalGreyColor
//        
//        self.lblForum.font = MySingleton.sharedManager().themeFontEighteenSizeBold
//        self.lblForum.textColor = MySingleton.sharedManager().themeGlobalGreyColor
//        
//        self.lblContactUs.font = MySingleton.sharedManager().themeFontEighteenSizeBold
//        self.lblContactUs.textColor = MySingleton.sharedManager().themeGlobalGreyColor
//        self.lblAboutUs.font = MySingleton.sharedManager().themeFontEighteenSizeBold
//        self.lblAboutUs.textColor = MySingleton.sharedManager().themeGlobalGreyColor
//       
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
//        
        
        
//        self.lblDescription.font = MySingleton.sharedManager().themeFontEighteenSizeBold
//        self.lblDescription.textColor = MySingleton.sharedManager().themeGlobalDarkBlackColor
//
//        scrollview.delegate = self
//        self.btnLetsMakeIt.setTitle("Let's Make It", for: .normal)
//       // self.btnLetsMakeIt.setTitleColor(MySingleton.sharedManager().themeGlobalWhiteColor, for: .normal)
//        self.btnLetsMakeIt.titleLabel?.font = MySingleton.sharedManager().themeFontSixteenSizeBold
//        self.btnLetsMakeIt.titleLabel?.textColor = MySingleton.sharedManager().themeGlobalWhiteColor
//        self.btnLetsMakeIt.setBackgroundColor(UIColor.blue, for: .normal)
//        self.btnLetsMakeIt?.addTarget(self, action: #selector(self.btnLetsMakeItClicked(_:)), for: .touchUpInside)
//        self.btnLetsMakeIt.layer.cornerRadius = self.btnLetsMakeIt.frame.height / 2
//        self.btnLetsMakeIt.layer.masksToBounds = true
//
//
//        self.btnSeeOverview.layer.cornerRadius = self.btnLetsMakeIt.frame.height / 2
//        self.btnSeeOverview.layer.masksToBounds = true
//        self.btnSeeOverview.layer.borderColor = UIColor.blue.cgColor
//        self.btnSeeOverview.layer.borderWidth = 1.0
//        self.btnSeeOverview.setTitle("See Overview", for: .normal)
//        self.btnSeeOverview.setTitleColor(UIColor.blue, for: .normal)
//        self.btnSeeOverview.titleLabel?.font = MySingleton.sharedManager().themeFontSixteenSizeBold
//        self.btnSeeOverview.setBackgroundColor(UIColor.white, for: .normal)
//        self.btnSeeOverview?.addTarget(self, action: #selector(self.btnSeeOverviewClicked(_:)), for: .touchUpInside)
//
//        self.btnLetsConnect?.addTarget(self, action: #selector(self.btnLetsConnectClicked(_:)), for: .touchUpInside)
//        self.heightLetsConnect.constant = 0
//        self.viewLetsConnect.isHidden = true
//        self.imgArrow.image = #imageLiteral(resourceName: "Down")
        self.btnClose?.addTarget(self, action: #selector(self.btnClosedClicked(_:)), for: .touchUpInside)

        
        self.btnShop?.addTarget(self, action: #selector(self.btnShopClicked(_:)), for: .touchUpInside)
        self.btnFindProduct?.addTarget(self, action: #selector(self.btnFindProductClicked(_:)), for: .touchUpInside)
        self.btnLetsConnect?.addTarget(self, action: #selector(self.btnLetsConnectClicked(_:)), for: .touchUpInside)
        self.btnShareApp?.addTarget(self, action: #selector(self.btnShareAppClicked(_:)), for: .touchUpInside)
        self.btnBlog?.addTarget(self, action: #selector(self.btnBlogClicked(_:)), for: .touchUpInside)
        self.btnForum?.addTarget(self, action: #selector(self.btnForumClicked(_:)), for: .touchUpInside)
        self.btnContactUs?.addTarget(self, action: #selector(self.btnContactUsClicked(_:)), for: .touchUpInside)
        self.btnAboutUs?.addTarget(self, action: #selector(self.btnAboutUsClicked(_:)), for: .touchUpInside)
        
        self.btnYoutube?.addTarget(self, action: #selector(self.btnYoutubeClicked(_:)), for: .touchUpInside)
        self.btnFacebook?.addTarget(self, action: #selector(self.btnFacebookClicked(_:)), for: .touchUpInside)
        self.btnInstagram?.addTarget(self, action: #selector(self.btnInstagramClicked(_:)), for: .touchUpInside)
        self.btnTwitter?.addTarget(self, action: #selector(self.btnTwitterClicked(_:)), for: .touchUpInside)
        self.btnPintrest?.addTarget(self, action: #selector(self.btnPinterestClicked(_:)), for: .touchUpInside)
        
        self.heightLetsConnect.constant = 0
        self.viewLetsConnect.isHidden = true
    }
    //MARK:- other Service

    @IBAction func btnClosedClicked(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnShopClicked(_ sender: UIButton)
    {
        if let url = URL(string: "https://www.npselection.com/") {
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func btnFindProductClicked(_ sender: UIButton)
    {
        if let url = URL(string: "https://www.yogurtathome.com/single-post/NPSection-Products") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func btnForumClicked(_ sender: UIButton)
    {
        if let url = URL(string: "https://forum.yogurtathome.com/") {
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func btnBlogClicked(_ sender: UIButton)
    {
        if let url = URL(string: "https://www.yogurtathome.com/blog") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func btnShareAppClicked(_ sender: UIButton)
    {
       // share(message: "NPSelection", link: "\nLet me recommend you this application.\n\nhtttp://google.com")
        let activityVC = UIActivityViewController(activityItems: ["Let me recommend you this application.\n\nhtttp://google.com"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = sender
        present(activityVC, animated: true, completion: nil)
        activityVC.completionWithItemsHandler = { (activityType, completed:Bool, returnedItems:[Any]?, error: Error?) in
            
            if completed  {
                self.dismiss(animated: true, completion: nil)
            }
        }
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
//                let rightOffset: CGPoint = CGPoint(x: 0, y: 0)
//                self.scrollview.setContentOffset(rightOffset, animated: true)
                } else {
                    self.imgArrow.image = #imageLiteral(resourceName: "Up")
                    button.isSelected = true
                    self.heightLetsConnect.constant = 370
                    self.viewLetsConnect.isHidden = false
                   // let rightOffset: CGPoint = CGPoint(x: 0, y: self.mainContainerView.frame.width - self.mainContainerView.bounds.size.width + self.mainContainerView.frame.height / 2)
                   // self.scrollview.setContentOffset(rightOffset, animated: true)
                   
                }
            }
        
    }
    @IBAction func btnContactUsClicked(_ sender: UIButton)
    {
        if let url = URL(string: "https://www.yogurtathome.com/contact") {
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func btnAboutUsClicked(_ sender: UIButton)
    {
        if let url = URL(string: "https://www.yogurtathome.com/") {
            UIApplication.shared.open(url)
        }
    }
    
}
//Let's Connect
extension MenuViewController {

    @IBAction func btnYoutubeClicked(_ sender: UIButton)
    {
        if let url = URL(string: "https://www.youtube.com/channel/UC6zTN7MU57uspzOXa18s7Ew/videos") {
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
        if let url = URL(string: "https://twitter.com/NPSelection/") {
            UIApplication.shared.open(url)
        }
    
    }
    @IBAction func btnPinterestClicked(_ sender: UIButton)
    {
        if let url = URL(string: "https://www.pinterest.co.uk/npselection/") {
            UIApplication.shared.open(url)
        }
    }
}
