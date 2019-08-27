//
//  SubjectGraphicPerformanceCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 20/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import AAInfographics

class SubjectGraphicPerformanceCell: UITableViewCell {
    
    @IBOutlet weak var lineView: UIView!
    private var aaChartView: AAChartView?
    private var aaChartModel: AAChartModel?
    private var subjectArrays: [Any] = []
    private var scoreArray: [Int] = []
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
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setChart(dataPoints: [String], values: [Double]) {
        for obj in ACData.SUBJECTLISTDATA {
            for scoreObject in obj.perfomances {
                scoreArray.append(Int(scoreObject.score)!)
            }
            subjectArrays.append(AASeriesElement().name(obj.subject_name).data(scoreArray).toDic()!)
        }
        aaChartModel = AAChartModel()
            .chartType(.line)//Can be any of the chart types listed under `AAChartType`.
            .animationType(.bounce)
            .title("OVERALL PERFORMANCE")//The chart title
            .subtitle("")//The chart subtitle
            .dataLabelsEnabled(false) //Enable or disable the data labels. Defaults to false
            .tooltipValueSuffix("")//the value suffix of the chart tooltip
            .categories(["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                         "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
            .colorsTheme(["#fe117c","#ffc069","#06caf4","#7dffc0"])
            .series(/*[
                AASeriesElement().name("Biology").data([7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]).toDic()!,
                AASeriesElement().name("Math").data([0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5]).toDic()!,
                AASeriesElement().name("Kimia").data([0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0]).toDic()!,
                 AASeriesElement().name("Fisika").data([3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]).toDic()!,]*/subjectArrays as! [AASeriesElement])

        aaChartView!.aa_drawChartWithChartModel(aaChartModel!)
    }
}
