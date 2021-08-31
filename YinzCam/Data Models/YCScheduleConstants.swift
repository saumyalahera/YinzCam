//
//  YCScheduleConstants.swift
//  YinzCam
//
//  Created by Saumya Lahera on 8/31/21.
//

import Foundation
import UIKit

/*This class holds all constants required throughout the application.*/
class YCScheduleConstants:NSObject {
    
    //MARK: - Create a shared device object
    static let shared = YCScheduleConstants()
    
    //MARK: - XIB Constants
    ///It holds bye schedule cell identifier string
    public static var scheduleByeTableViewCellXibString = "YCScheduleByeTableViewCell"
    
    ///It holds regular schedule cell identifier string
    public static var  scheduleRegularTableViewCellXibString = "YCScheduleRegularTableViewCell"
    
    ///It holds Final schedule cell identifier string
    public static var  scheduleFinalTableViewCellXibString = "YCScheduleFinalTableViewCell"
    
    ///It holds regular Original schedule cell identifier string
    public static var  scheduleOGRegularTableViewCellXibString = "YCScheduleOGRegularTableViewCell"
    
    ///It holds Final Original schedule cell identifier string
    public static var  scheduleOGFinalTableViewCellXibString = "YCScheduleOGFinalTableViewCell"
    
    
    //MARK: - TableView Cell Identifier Constants
    ///It holds final identifier string
    public static var  finalCellIdentifier = "finalCell"
    
    ///It holds bye cell identifier
    public static var  byeCellIdentifier = "byeCell"
    
    ///It holds regular cell identifier
    public static var  regularCellIdentifier = "regularCell"
    
    ///It holds final identifier string
    public static var  finalOGCellIdentifier = "finalOGCell"
    
    ///It holds regular cell identifier
    public static var  regularOGCellIdentifier = "regularOGCell"

    ///It holds section header celll identifier
    public static var  sectionHeaderIdentifier = "YCScheduleSectionHeaderViewCell"
    
    //MARK: - API Constants
    ///It holds JSON data link
    public static var  apiEndPoint = "http://files.yinzcam.com.s3.amazonaws.com/iOS/interviews/ScheduleExercise/schedule.json"
                     //http://files.yinzcam.com.s3.amazonaws.com/iOS/interviews/ScheduleExercise/schedule.json
    
    ///Images DB link
    public static var  imageAPIEndPoint = "https://s3.amazonaws.com/yc-app-resources/nfl/logos/"
    
    //MARK: - NavigationBar Constants
    ///Navigation Title Font
    public static var  navigationBarTitleFontName = "LeagueGothic-Regular"
    
    ///Navigation bar color
    public static var  navigationBarColor = UIColor(red: 46/255, green: 76/255, blue: 86/255, alpha: 1)
    
    public static var  originalCells = false
    
}



