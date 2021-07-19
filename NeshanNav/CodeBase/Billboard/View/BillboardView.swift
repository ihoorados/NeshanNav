//
//  BillboardView.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation

class BillboardView: UIViewController {
    
    // MARK: - Dependency Injection
    /*
             - BilboardUseCases
     */
    var retryRequest: (() -> ())?
    weak var delegate: BilboardUseCases?
    init(delegate: BilboardUseCases?) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: app life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        setupUIView()
        setupUILayout()
        setupUIEvent()
    }

    // MARK: UI Element
    var closeBillboardButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        let image = UIImage(systemName: "xmark.square.fill")?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = UIColor.systemRed
        button.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        return button
    }()
    
    var titleLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont(name: "IRANYekanMobile", size: 23)!
        label.text = "نقطه انتخاب شده"
        return label
    }()
    
    var spinner: UIActivityIndicatorView = {
        let spin = UIActivityIndicatorView(style: .medium)
        spin.hidesWhenStopped = true
        return spin
    }()
    
    // MARK: UI Elemet
    lazy var CTAButton: NTCTAButton = {
        let button = NTCTAButton(type: UIButton.ButtonType.custom)
        button.MainLayer.backgroundColor = UIColor.systemBlue.cgColor
        button.BackgroundLayer.backgroundColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1).cgColor
        button.setTitle("مسیریابی", for: .normal)
        button.titleLabel?.font = UIFont(name: "IRANYekanMobile", size: 23)!
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 32)
        return button
    }()
    
    var routeNameIcon:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "streetIcon")
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var routeNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont(name: "IRANYekanMobile", size: 23)!
        return label
    }()
    
    var routeNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis          = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment     = UIStackView.Alignment.center
        stackView.spacing       = 12
        return stackView
    }()
    
    var routeAddressIcon:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "LocationIC")
        return imageView
    }()
    
    var routeaddressLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.font = UIFont(name: "IRANYekanMobile", size: 17)!
        return label
    }()

    var routeAddressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis          = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment     = UIStackView.Alignment.center
        stackView.spacing       = 12
        return stackView
    }()
    
    
    // MARK: Setup UI View
    //       Add UI element to view
    private func setupUIView(){

        view.addSubview(closeBillboardButton)
        view.addSubview(titleLabel)
        
        view.addSubview(routeNameStackView)
        view.addSubview(routeAddressStackView)
        view.addSubview(CTAButton)
        view.addSubview(spinner)
        
        routeNameStackView.addArrangedSubview(routeNameLabel)
        routeNameStackView.addArrangedSubview(routeNameIcon)
        
        routeAddressStackView.addArrangedSubview(routeaddressLabel)
        routeAddressStackView.addArrangedSubview(routeAddressIcon)
        
        print("✅ BillboardView : setup UIViews Completed.")
    }
    
    // MARK: Setup UI Layout
    //       Configure UI Layout Element
    private func setupUILayout(){
                
        closeBillboardButton.anchor(top: view.topAnchor,
                          left: view.leftAnchor,
                          width: 40, height: 40)
        
        spinner.anchor(left: closeBillboardButton.rightAnchor,
                       width: 25, height: 25)
        spinner.centerY(inView: closeBillboardButton)
        
        titleLabel.anchor(left: spinner.rightAnchor,
                          right: view.rightAnchor)
        titleLabel.centerY(inView: closeBillboardButton)
        
        routeNameIcon.anchor(width: 25, height: 25)
        routeAddressIcon.anchor(width: 20, height: 20)

        routeNameStackView.anchor(top: closeBillboardButton.bottomAnchor,
                                  left: view.leftAnchor,
                                  right: view.rightAnchor,
                                  paddingTop: 8.0,
                                  height: 50, cornerRadius: 0)
        routeAddressStackView.anchor(top: routeNameStackView.bottomAnchor,
                                     left: view.leftAnchor,
                                     right: view.rightAnchor,
                                     paddingTop: 4.0,
                                     height: 40, cornerRadius: 0)
        CTAButton.anchor(top: routeAddressStackView.bottomAnchor,
                                left: view.leftAnchor,
                                right: view.rightAnchor,
                                height: 44)
        print("✅ BillboardView : setup UILayouts completed.")
    }
    
    
    // MARK: Setup UI Event ( Target-Action)
    //       Configure UI Event Target Action
    private func setupUIEvent(){
        closeBillboardButton.addTarget(self, action: #selector(closeBillboardTapped), for: .touchUpInside)
        CTAButton.addTarget(self, action: #selector(CTAButtonTapped), for: .touchUpInside)
        print("✅ BillboardView : setup UIEvent completed.")
    }
    
    @objc func closeBillboardTapped(){
        delegate?.closeBillboard()
    }
    
    @objc func CTAButtonTapped(sender: UIButton){
        switch sender.tag {
        case 0:
            delegate?.findDirectionRoutes()
        case 1:
            delegate?.startNavigateOnMap()
        case 2:
            retryRequest?()
        default:
            print("Wrong Selection")
        }
    }
    
    func ConfigButtonToNavigate(){
        CTAButton.alpha = 1
        CTAButton.tag = 1
        CTAButton.setTitle("بزن بریم", for: .normal)
        CTAButton.MainLayer.backgroundColor = UIColor.systemGreen.cgColor
        CTAButton.BackgroundLayer.backgroundColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1).cgColor
    }
    
    func ConfigButtonToRoute(){
        CTAButton.alpha = 1
        CTAButton.tag = 0
        CTAButton.MainLayer.backgroundColor = UIColor.systemBlue.cgColor
        CTAButton.BackgroundLayer.backgroundColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1).cgColor
        CTAButton.setTitle("مسیریابی", for: .normal)
    }
    
    func ConfigButtonToFaild(){
        CTAButton.alpha = 1
        CTAButton.tag = 2
        CTAButton.MainLayer.backgroundColor = UIColor.systemRed.cgColor
        CTAButton.BackgroundLayer.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor
        CTAButton.setTitle("تلاش دوباره", for: .normal)
    }
    
    func HiddenCTAButton(){
        CTAButton.alpha = 0
    }
    
    deinit {
        print("🗑 BillboardView: deinit frome memory.")
    }

}
