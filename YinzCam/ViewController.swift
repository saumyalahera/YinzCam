//
//  ViewController.swift
//  YinzCam
//
//  Created by Saumya Lahera on 8/31/21.

import UIKit
import Alamofire
import AlamofireImage


class ViewController: UIViewController {
    
    /**It uses decodable and JSON Parsing. Check ScheduleData struct for more information*/
    ///This variable holds scheduled games data from the server
    let data = DataHolder()
    
    /**Main tableView that holds all the schedules of all the games.*/
    @IBOutlet weak var scheduleTableView: UITableView!
    
    
//MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //self.scheduleTableView.contentInset = UIEdgeInsets(top: -22, left: 0, bottom: 0, right: 0) //UIEdgeInsetsMake(-44,0,0,0)
        
        /*Register this cell because it will fetch information about the cell identifier.*/
        self.registerNibCells()
        
        /*Register all the cells and section headers*/
        self.setupScheduleTableView()
        
        /*setup Navigation Bar*/
        self.setupNavigationBar(title: "SCHEDULE")
        
        /*Fetch and process data*/
        self.fetchScheduleData(YCScheduleConstants.apiEndPoint)
        
        /*var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        self.scheduleTableView.tableHeaderView = UIView(frame: frame)
        self.scheduleTableView.tableFooterView = UIView(frame: frame)
        self.navigationController?.navigationBar.tintColor = UIColor.white*/
        
        
    }
    
//MARK: - UIBarButton Actions
    @IBAction func toggleMenu(_ sender: Any) {
        print("Toggle Menu")
    }
    
    @IBAction func refreshScheduleTable(_ sender: Any) {
        /*Fetch and process data*/
        self.fetchScheduleData(YCScheduleConstants.apiEndPoint)
    }
    
}

//MARK: - TableView Methods
extension ViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.sections[section].games.list.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data.sections[section].heading
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    /*func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }*/
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed(YCScheduleConstants.sectionHeaderIdentifier, owner: self, options: nil)?.first as! YCScheduleSectionHeaderViewCell
        headerView.sectionTitle.text = data.sections[section].heading?.uppercased() ?? "-"
        
        
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*Get current game object*/
        let currentGame = data.sections[indexPath.section].games.list[indexPath.row]
       
        /*Check what type of section it is. “Type” attribute are S (scheduled), F (final), and B (bye)*/
        if(currentGame.type == "F") {
            
            //If you are using bigger iphones (As per in the document)
            /*let cell = tableView.dequeueReusableCell(withIdentifier: constants.finalOGCellIdentifier, for: indexPath) as! ScheduleOGFinalTableViewCell*/
            
            //If you are using a smaller iphone
            let cell = tableView.dequeueReusableCell(withIdentifier: YCScheduleConstants.finalCellIdentifier, for: indexPath) as! YCScheduleFinalTableViewCell
            
            /*Set some properties*/
            cell.homeTeamName.text = data.team.name ?? "-"
            cell.homeTeamScore.text = currentGame.homeScore ?? "-"
            cell.awayTeamName.text = currentGame.opponent?.name ?? "-"
            cell.awayTeamScore.text = currentGame.awayScore ?? "-"
            cell.gameDate.text = (currentGame.date?.text ?? "-").uppercased()
            cell.gameWeek.text = (currentGame.week ?? "-").uppercased()
            cell.gameType.text = (currentGame.gameState ?? "-").uppercased()
            
            /*Dynamic font size*/
            cell.gameDate.adjustsFontSizeToFitWidth = true
            cell.gameDate.minimumScaleFactor = 0.5
            
            cell.gameWeek.adjustsFontSizeToFitWidth = true
            cell.gameWeek.minimumScaleFactor = 0.5
            
            cell.gameType.adjustsFontSizeToFitWidth = true
            cell.gameType.minimumScaleFactor = 0.5
            
            
           /*Set home logos*/
            var url = URL(string: "\(YCScheduleConstants.imageAPIEndPoint)nfl_\((data.team.triCode ?? "-").lowercased())_light.png")!
            cell.homeTeamTriCode.af.setImage(withURL: url)
            
            /*Set Away team LOGO*/
            url = URL(string: "\(YCScheduleConstants.imageAPIEndPoint)nfl_\((currentGame.opponent?.triCode ?? "-").lowercased())_light.png")!
            cell.awayTeamTriCode.af.setImage(withURL: url)
            
        }else if(currentGame.type == "B") {
            
            /*This is when the cell is of type BYE*/
            let cell = tableView.dequeueReusableCell(withIdentifier: YCScheduleConstants.byeCellIdentifier, for: indexPath) as! YCScheduleByeTableViewCell
            cell.week.text = currentGame.week
            
            /*Dynamic font size*/
            cell.week.adjustsFontSizeToFitWidth = true
            cell.week.minimumScaleFactor = 0.5
            
            return cell
            
        }else {
            
            //If you are using bigger iphones (As per the experiment document)
            /*This is when the cell is of type Regular - Game that is to be played*/
            /*let cell = tableView.dequeueReusableCell(withIdentifier: constants.regularOGCellIdentifier, for: indexPath) as! ScheduleOGRegularTableViewCell*/
            
            //If you are using a smaller iphone
            let cell = tableView.dequeueReusableCell(withIdentifier: YCScheduleConstants.regularCellIdentifier, for: indexPath) as! YCScheduleRegularTableViewCell
            
            /*Set Home and Away teams properties*/
            cell.homeTeamName.text = data.team.name ?? "-"
            cell.homeTeamRecord.text = data.team.record ?? "-"
            cell.awayTeamName.text = currentGame.opponent?.name ?? "-"
            cell.awayTeamRecord.text = currentGame.awayScore ?? "-"
            cell.gameDate.text = (currentGame.date?.text ?? "-").uppercased()
            cell.gameWeek.text = (currentGame.week ?? "-").uppercased()
            cell.gameTime.text = (currentGame.gameState ?? "-").uppercased()
            
            /*Dynamic font size*/
            cell.gameDate.adjustsFontSizeToFitWidth = true
            cell.gameDate.minimumScaleFactor = 0.5
            
            cell.gameWeek.adjustsFontSizeToFitWidth = true
            cell.gameWeek.minimumScaleFactor = 0.5
            
            cell.gameTime.adjustsFontSizeToFitWidth = true
            cell.gameTime.minimumScaleFactor = 0.5
            
            /*Set teams logos*/
            var url = URL(string: "\(YCScheduleConstants.imageAPIEndPoint)nfl_\((data.team.triCode ?? "-").lowercased())_light.png")!
            cell.homeTeamTriCode.af.setImage(withURL: url)
            
            url = URL(string: "\(YCScheduleConstants.imageAPIEndPoint)nfl_\((currentGame.opponent?.triCode ?? "-").lowercased())_light.png")!
            cell.awayTeamTriCode.af.setImage(withURL: url)
            
            return cell
        }
        let cell = UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//MARK: - Personal TableView Methods
    /**This function registers schedule table cells with XIB*/
    func registerNibCells() {
        self.scheduleTableView.register(UINib(nibName: YCScheduleConstants.scheduleRegularTableViewCellXibString, bundle: nil), forCellReuseIdentifier: YCScheduleConstants.regularCellIdentifier)
        self.scheduleTableView.register(UINib(nibName: YCScheduleConstants.scheduleFinalTableViewCellXibString, bundle: nil), forCellReuseIdentifier: YCScheduleConstants.finalCellIdentifier)
        self.scheduleTableView.register(UINib(nibName: YCScheduleConstants.scheduleByeTableViewCellXibString, bundle: nil), forCellReuseIdentifier: YCScheduleConstants.byeCellIdentifier)
        self.scheduleTableView.register(UINib(nibName: YCScheduleConstants.scheduleOGRegularTableViewCellXibString, bundle: nil), forCellReuseIdentifier: YCScheduleConstants.regularOGCellIdentifier)
        self.scheduleTableView.register(UINib(nibName: YCScheduleConstants.scheduleOGFinalTableViewCellXibString, bundle: nil), forCellReuseIdentifier: YCScheduleConstants.finalOGCellIdentifier)
       
    }
    
    /**This function sets up table view properties to allow cell selection and section header height
     - Parameter title: Navigation Title String
     - Parameter fontName: Navigation font name. Its default value is set in ScheduleConstant Class*/
    func setupScheduleTableView(sectionHeaderHeight: CGFloat = 60, allowCellSelection: Bool = false) {
        self.scheduleTableView.sectionHeaderHeight = sectionHeaderHeight
        self.scheduleTableView.allowsSelection = allowCellSelection
    }
    
    /**This function sets up navigation bar with background color, custom fonts and also sets title.
     - Parameter title: Navigation Title String
     - Parameter fontName: Navigation font name. Its default value is set in ScheduleConstant Class
     - Parameter fontSize: Navigation font size*/
    func setupNavigationBar(title: String, fontName: String = YCScheduleConstants.navigationBarTitleFontName, fontSize: CGFloat = 25) {
        self.navigationController?.navigationBar.barTintColor = YCScheduleConstants.navigationBarColor
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.white,
         NSAttributedString.Key.font: UIFont(name: fontName, size: fontSize)!]
        self.title = title
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = YCScheduleConstants.navigationBarColor
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                              NSAttributedString.Key.font: UIFont(name: fontName, size: fontSize)!]
            //appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor,NSAttributedString.Key.font: UIFont(resource: R.font.robotoMedium, size: fontSize)!]

            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        
    }
}

//MARK: - Alamofire Methods
extension ViewController {
    
   
    /**This function calls the API - url and process the fetched Data. It is processed for a very specific type of data. It uses Decodable for get the data from JSON.
     - Parameter url: API endpoint*/
    func fetchScheduleData(_ url: String) {
        
        let alert = UIAlertController(title: nil, message: "Fetching data...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .large //UIActivityIndicatorView.Style.
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        let request = AF.request(url)
        request.responseJSON { (response) in
            switch response.result {
            case .success(_):
                do {
                    
                    let filteredData = try JSONDecoder().decode(GameList.self, from: response.data!)
                    //print(filteredData.gameSections)
                    
                    self.data.sections = filteredData.gameSections
                    self.data.team = filteredData.team
                    
                    /*Reload data*/
                    self.scheduleTableView.reloadData()
                    
                } catch {
                    print(error)
                }
            case .failure(_):
                /*Display error on the screen*/
                print("failure")
            }
            
            /*Dismiss alert view*/
            alert.dismiss(animated: true, completion: nil)
        }
    }
}






