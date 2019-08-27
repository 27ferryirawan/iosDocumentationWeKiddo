//
//  SubjectDetailPerformanceCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 11/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import AAInfographics

class SubjectDetailPerformanceCell: UITableViewCell {

    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var passingGradeLabel: UILabel!
    @IBOutlet weak var radiantScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            self.bgView.layer.cornerRadius = 7
            self.bgView.layer.borderWidth = 1.0
            self.bgView.layer.borderColor = UIColor.lightGray.cgColor
            self.bgView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var radianScoreRounded: UIView! {
        didSet {
            radianScoreRounded.layer.cornerRadius = radianScoreRounded.frame.size.width/2
            radianScoreRounded.clipsToBounds = true
        }
    }
    @IBOutlet weak var passingScoreRounded: UIView! {
        didSet {
            passingScoreRounded.layer.cornerRadius = passingScoreRounded.frame.size.width/2
            passingScoreRounded.clipsToBounds = true
        }
    }
    @IBOutlet weak var scoreRounded: UIView! {
        didSet {
            scoreRounded.layer.cornerRadius = scoreRounded.frame.size.width/2
            scoreRounded.clipsToBounds = true
        }
    }
    var value = 0
    var scoreArray: [Int] = []
    private var aaChartView: AAChartView?
    private var aaChartModel: AAChartModel?
    var dataObj: SubjectDetailModel? {
        didSet {
            setChart()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        aaChartView = AAChartView()
        let chartViewWidth = chartView.frame.size.width
        let chartViewHeight = chartView.frame.size.height
        aaChartView!.frame = CGRect(x: 0,
                                    y: 0,
                                    width: chartViewWidth,
                                    height: chartViewHeight)
        aaChartView!.contentHeight = chartViewHeight
        chartView.addSubview(aaChartView!)
        aaChartView!.scrollEnabled = false
        aaChartView!.isClearBackgroundColor = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setChart() {
        guard let obj = dataObj else {
            return
        }
        for scoreObject in obj.score_perfomances {
            scoreArray.append(Int(scoreObject.score)!)
        }
        aaChartModel = AAChartModel()
            .chartType(.line)
            .animationType(.bounce)
            .title("Performance")
            .subtitle("")
            .dataLabelsEnabled(false)
            .tooltipValueSuffix("")
            .categories(["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                         "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
            .colorsTheme(["#fe117c","#ffc069","#06caf4","#7dffc0"])
            .series([
                AASeriesElement()
                    .name(obj.teacher_info_subject_name)
                    .data(scoreArray)])
        aaChartView!.aa_drawChartWithChartModel(aaChartModel!)
    }
}
