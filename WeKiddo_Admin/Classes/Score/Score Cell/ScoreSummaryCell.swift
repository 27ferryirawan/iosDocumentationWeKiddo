//
//  ScoreSummaryCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 23/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import AAInfographics

protocol ScoreSummaryDelegate: class {
    func displayScoreView()
}

class ScoreSummaryCell: UITableViewCell {
    var value = 0
    var scoreArray: [Int] = []
    @IBOutlet weak var scoreButton: UIButton!
    @IBOutlet weak var lineView: UIView!
    private var aaChartView: AAChartView?
    private var aaChartModel: AAChartModel?
    @IBOutlet weak var summaryScoreList: UIView! {
        didSet {
            self.summaryScoreList.layer.cornerRadius = 7
            self.summaryScoreList.layer.borderWidth = 1.0
            self.summaryScoreList.layer.borderColor = UIColor.lightGray.cgColor
            self.summaryScoreList.layer.masksToBounds = true
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
    var dataObj: ScoreSummaryModel? {
        didSet {
            setChart()
        }
    }
    weak var delegate: ScoreSummaryDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        aaChartView = AAChartView()
        let chartViewWidth = lineView.frame.size.width
        let chartViewHeight = lineView.frame.size.height
        aaChartView!.frame = CGRect(x: 0,
                                    y: 0,
                                    width: chartViewWidth,
                                    height: chartViewHeight)
        aaChartView!.contentHeight = chartViewHeight
        lineView.addSubview(aaChartView!)
        aaChartView!.scrollEnabled = false
        aaChartView!.isClearBackgroundColor = true
        scoreButton.addTarget(self, action: #selector(displayScoreDetail), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func displayScoreDetail() {
        self.delegate?.displayScoreView()
    }
    func setChart() {
        guard let obj = dataObj else {
            return
        }
        print(obj.perfomances)
        for scoreObject in obj.perfomances {
            scoreArray.append(Int(scoreObject.score)!)
        }
        print(scoreArray)
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
                AASeriesElement().name(obj.subject_name).data(scoreArray)
                /*
                AASeriesElement()
                    .name(obj.subject_name)
                    .data(/*[7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]*/scoreArray)
                    .toDic()!,
                AASeriesElement()
                    .name("New York")
                    .data([0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5])
                    .toDic()!,
                AASeriesElement()
                    .name("Berlin")
                    .data([0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0])
                    .toDic()!,
                AASeriesElement()
                    .name("London")
                    .data([3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8])
                    .toDic()!,*/])
        aaChartView!.aa_drawChartWithChartModel(aaChartModel!)
    }
}
