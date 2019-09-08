//
//  AppDelegate.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 11/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate {

    var isFromHome: Bool = false
    var window: UIWindow?
    var tabBarController = UITabBarController()
    var navArrayMenu = [UINavigationController]()
    var isLogin = UserDefaults.standard.bool(forKey: "isLogin")
    var isFirstInstall = UserDefaults.standard.bool(forKey: "isFirstLogin")
    let notificationDelegate = ACNotificationCenter()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.red], for: .normal)
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        firebaseConfig()
        Messaging.messaging().delegate = notificationDelegate
        application.registerForRemoteNotifications()
        registerForPushNotifications()
        if let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] {
            //TODO: Handle background notification
            print(userInfo)
            UserDefaults.standard.set(true, forKey: "isFromNotif")
            NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: userInfo as? [AnyHashable : Any])
        }
        if !isFirstInstall {
            let loginViewController = OnboardingViewController()
            let navController = UINavigationController(rootViewController: loginViewController)
            window!.rootViewController = navController
        } else {
//            let status = UserDefaults.standard.bool(forKey: "isLogin")
//            if status {
//                goToHome()
//            } else {
//            }
            let loginViewController = ViewController()
            let navController = UINavigationController(rootViewController: loginViewController)
            window!.rootViewController = navController
        }
        window!.makeKeyAndVisible()
        return true
    }
    func firebaseConfig() {
        FirebaseApp.configure()
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("applicationDidBecomeActive")
    }
    func getNotificationSettings() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                guard settings.authorizationStatus == .authorized else { return }
                DispatchQueue.main.async(execute: {
                    UIApplication.shared.registerForRemoteNotifications()
                })
            }
        } else {
            // Fallback on earlier versions
        }
    }
    func registerForPushNotifications() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound, .badge]) {
                (granted, error) in
                guard granted else { return }
                self.getNotificationSettings()
            }
            center.delegate = notificationDelegate
            let openAction = UNNotificationAction(identifier: "OpenNotification", title: NSLocalizedString("Abrir", comment: ""), options: UNNotificationActionOptions.foreground)
            let deafultCategory = UNNotificationCategory(identifier: "CustomSamplePush", actions: [openAction], intentIdentifiers: [], options: [])
            center.setNotificationCategories(Set([deafultCategory]))
        } else {
            let settings = UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                DispatchQueue.global().async {
                    self.sendUpdateFCMToken(token: result.token)
                }
            }
        }
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print(fcmToken)
        let tokenFCM = fcmToken
        if tokenFCM != "" {
            UserDefaults.standard.set(tokenFCM, forKey: "tokenFCM")
        }
        sendUpdateFCMToken(token: fcmToken)
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        if (application.applicationState == UIApplication.State.active) {
            print("dari app delegate dari didreceiveremote: \(userInfo)")
            UserDefaults.standard.set(true, forKey: "isFromNotif")
            NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: userInfo)
        }
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("didReceiveRemoteNotification")
        completionHandler(UIBackgroundFetchResult.newData)
    }
    func sendUpdateFCMToken(token: String){
        print(token)
    }
    func goToHome(){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        window.frame = UIScreen.main.bounds
        window.backgroundColor = .white

        let homeViewController = HomeRoomViewController(nibName: "HomeRoomViewController", bundle: nil)
        let latePaymentViewController = LatePaymentViewController(nibName: "LatePaymentViewController", bundle: nil)
        let detentionViewController = DetentionViewController(nibName: "DetentionViewController", bundle: nil)
        let attendanceViewController = AttendancesViewController(nibName: "AttendancesViewController", bundle: nil)
        let userViewController = UserViewController(nibName: "UserViewController", bundle: nil)
        let classroomViewController = ClassroomViewController(nibName: "ClassroomViewController", bundle: nil)
        let subjectViewController = SubjectViewController(nibName: "SubjectViewController", bundle: nil)
        let permissionViewController = PermissionViewController(nibName: "PermissionViewController", bundle: nil)
        let announcementViewController = AnnouncementViewController(nibName: "AnnouncementViewController", bundle: nil)
        let assignmentViewController = AssignmentViewController(nibName: "AssignmentViewController", bundle: nil)
        let othersViewController = OthersViewController(nibName: "OthersViewController", bundle: nil)
        let subjectListViewController = SubjectListViewController(nibName: "SubjectListViewController", bundle: nil)
        let examViewController = ExamViewController(nibName: "ExamViewController", bundle: nil)
//        let questionViewController = QuestionsViewController(nibName: "QuestionsViewController", bundle: nil)
//        let approvalViewController = ApprovalViewController(nibName: "ApprovalViewController", bundle: nil)
//        let nearbyCourseController = NearbyCourseMoreViewController(nibName: "NearbyCourseMoreViewController", bundle: nil)
//        let newsViewController = NewsViewController(nibName: "NewsViewController", bundle: nil)
//        let agencyViewController = AgencyViewController(nibName: "AgencyViewController", bundle: nil)
//        let calendarViewController = CalendarViewController(nibName: "CalendarViewController", bundle: nil)
//        let scoreViewController = ScoreViewController(nibName: "ScoreViewController", bundle: nil)

        UITabBar.appearance().tintColor = ACColor.OLD_BLUE
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 10)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 10)!], for: .selected)

        let dashboard = UINavigationController(rootViewController: homeViewController)
        let detention = UINavigationController(rootViewController: detentionViewController)
        let latePayment = UINavigationController(rootViewController: latePaymentViewController)
        let attendances = UINavigationController(rootViewController: attendanceViewController)
        let permission = UINavigationController(rootViewController: permissionViewController)
        let assignment = UINavigationController(rootViewController: assignmentViewController)
        let announcement = UINavigationController(rootViewController: announcementViewController)
        let more = UINavigationController(rootViewController: othersViewController)
        let subjectList = UINavigationController(rootViewController: subjectListViewController)
        let examSchedule = UINavigationController(rootViewController: examViewController)
//        let nearbyCourse = UINavigationController(rootViewController: nearbyCourseController)
//        let user = UINavigationController(rootViewController: userViewController)
//        let subject = UINavigationController(rootViewController: subjectViewController)
//        let classroom = UINavigationController(rootViewController: classroomViewController)
//        let question = UINavigationController(rootViewController: questionViewController)
//        let approval = UINavigationController(rootViewController: approvalViewController)
//        let news = UINavigationController(rootViewController: newsViewController)
//        let agency = UINavigationController(rootViewController: agencyViewController)
//        let calendar = UINavigationController(rootViewController: calendarViewController)
//        let score = UINavigationController(rootViewController: scoreViewController)

        let menuDictionary: [String: UINavigationController] =
            [
                "69": announcement,
                "36": attendances,
                "37": permission,
                "38": detention,
                "42": latePayment,
                "68": assignment,
                "47": subjectList, //subjectTopic
                "71": dashboard,
                "70": examSchedule, // -> DEVELOPMEMNT PHASE 1
                //                "26": schoolProfile,
                //                "27": user,
                //                "28": subject,
                //                "29": classRoom,
                //                "31": classSchedule,
                //                "33": joinClass,
                //                "39": notification,
                //                "40": news,
                //                "44": food,
                //                "45": fosterParent,
                //                "46": teacherAttendance,
                //                "48": assignmentChat,
                //                "49": calendar,
                //                "50": teacherOnDuty, // -> DEVELOPMEMNT PHASE 1
            ]
        
        var menuName : [String: String] = [:]
        navArrayMenu.removeAll()
        for menuItem in ACData.LOGINDATA.dashboardMenu {
            let menu = menuItem.menu_id
            guard let menuNav = menuDictionary["\(menu)"] else {
                return
            }
            menuName["\(menuItem.menu_id)"] = menuItem.menu_name
            navArrayMenu.append(menuNav)
        }
        navArrayMenu.append(more)
        // USER
        let userRoomTab = UITabBarItem(
            title: menuName["27"],
            image: UIImage(named:"tabbar_profile"),
            selectedImage: UIImage(named:"tabbar_profile")
        )
        userRoomTab.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        userViewController.tabBarItem = userRoomTab
        // SUBJECT
        let subjectRoomTab = UITabBarItem(
            title: menuName["28"],
            image: UIImage(named:"icon_home"),
            selectedImage: UIImage(named:"icon_home")
        )
        subjectRoomTab.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        subjectViewController.tabBarItem = subjectRoomTab
        // CLASSROOM
        let classRoomTab = UITabBarItem(
            title: menuName["29"],
            image: UIImage(named:"icon_home"),
            selectedImage: UIImage(named:"icon_home")
        )
        classRoomTab.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        classroomViewController.tabBarItem = classRoomTab
        // ATTENDANCE
        let attendanceRoomTab = UITabBarItem(
            title: menuName["36"],
            image: UIImage(named:"tabbar_attendance"),
            selectedImage: UIImage(named:"tabbar_attendance")
        )
        attendanceRoomTab.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        attendanceViewController.tabBarItem = attendanceRoomTab
        // PERMISSION
        let permissionTab = UITabBarItem(
            title: menuName["37"],
            image: UIImage(named:"tabbar_permission"),
            selectedImage: UIImage(named:"tabbar_permission")
        )
        permissionTab.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        permissionViewController.tabBarItem = permissionTab
        // LATE PAYMENT
        let latePaymentTab = UITabBarItem(
            title: menuName["42"],
            image: UIImage(named:"tabbar_permission"),
            selectedImage: UIImage(named:"tabbar_permission")
        )
        latePaymentTab.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        latePaymentViewController.tabBarItem = latePaymentTab
        // DETENTION
        let detentionTab = UITabBarItem(
            title: menuName["38"],
            image: UIImage(named:"tabbar_detention"),
            selectedImage: UIImage(named:"tabbar_detention")
        )
        detentionTab.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        detentionViewController.tabBarItem = detentionTab
        // ASSIGNMENT
        let assignmentTab = UITabBarItem(
            title: menuName["68"],
            image: UIImage(named:"tabbar_assigment"),
            selectedImage: UIImage(named:"tabbar_assigment")
        )
        assignmentTab.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        assignmentViewController.tabBarItem = assignmentTab
        // ANNOUNCEMENT
        let announcementTab = UITabBarItem(
            title: menuName["69"],
            image: UIImage(named:"tabbar_assigment"),
            selectedImage: UIImage(named:"tabbar_assigment")
        )
        announcementTab.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        announcementViewController.tabBarItem = announcementTab
        // HOMEROOM ADMIN
        let homeAdminTab = UITabBarItem(
            title: menuName["71"],
            image: UIImage(named:"tabbar_home"),
            selectedImage: UIImage(named:"tabbar_home")
        )
        homeAdminTab.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        homeViewController.tabBarItem = homeAdminTab
        // Exam Schedule
        let examScheduleTab = UITabBarItem(
            title: menuName["70"],
            image: UIImage(named:"ic_exam_nb"),
            selectedImage: UIImage(named:"ic_exam_nb")
        )
        examScheduleTab.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        examViewController.tabBarItem = examScheduleTab
        // OTHERS
        let othersTab = UITabBarItem(
            title: "More",
            image: UIImage(named:"icon_more"),
            selectedImage: UIImage(named:"icon_more")
        )
        othersTab.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        othersViewController.tabBarItem = othersTab
//        tabBarController.viewControllers = [dashboard, dashboardTeacher, dashboardHomeRoom, more]
        tabBarController.viewControllers = navArrayMenu
        tabBarController.selectedIndex = 0
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    func showLoginView() {
        let topViewController: UIViewController? = window?.rootViewController
        let modalViewController: UIViewController? = topViewController?.presentedViewController
        if !(modalViewController is ViewController) {
            let loginViewController = ViewController(nibName: "ViewController", bundle: nil)
            let loginNavController = UINavigationController(rootViewController: loginViewController)
            topViewController?.present(loginNavController, animated: false) {() -> Void in }
        } else {
            
        }
    }
}
