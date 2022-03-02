//
//  DetailsDataCell.swift
//  iOS-Weather-App
//
//  Created by pavels.garklavs on 24/02/2022.
//

import UIKit

class DetailsDataCell: UITableViewCell {

    static let reuseIdentifier = "DetailsDataCell"

    let dateLabel = UILabel()
    let temperatureLabel = UILabel()
    let maxTemperatureLabel = UILabel()
    let minTemperatureLabel = UILabel()
    let minMaxSeparator = UILabel()
    let windLabel = UILabel()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDateLabel()
        setupTemperatureLabel()
        setupMinTemperatureLabel()
        setupMinMaxSeparator()
        setupMaxTemperatureLabel()
        setupWindLabel()
    }

}

private extension DetailsDataCell {
    func setupDateLabel() {
        contentView.addSubview(dateLabel)
        dateLabel.font = .systemFont(ofSize: 16)
        dateLabel.text = " "

        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(5)
        }
    }

    func setupTemperatureLabel() {
        contentView.addSubview(temperatureLabel)
        temperatureLabel.font = Constants.cellTempFont
        temperatureLabel.text = " "

        temperatureLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(5)
        }
    }

    func setupMaxTemperatureLabel() {
        contentView.addSubview(maxTemperatureLabel)
        maxTemperatureLabel.font = Constants.cellMinMaxFont
        maxTemperatureLabel.text = " "
        maxTemperatureLabel.textColor = .red

        maxTemperatureLabel.snp.makeConstraints { make in
            make.trailing.equalTo(minMaxSeparator.snp.leading)
            make.centerY.equalToSuperview()
        }
    }

    func setupMinTemperatureLabel() {
        contentView.addSubview(minTemperatureLabel)
        minTemperatureLabel.font = Constants.cellMinMaxFont
        minTemperatureLabel.text = " "
        minTemperatureLabel.textColor = .blue

        minTemperatureLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
    }

    func setupMinMaxSeparator() {
        contentView.addSubview(minMaxSeparator)
        minMaxSeparator.font = Constants.cellMinMaxFont
        minMaxSeparator.text = "/"

        minMaxSeparator.snp.makeConstraints { make in
            make.trailing.equalTo(minTemperatureLabel.snp.leading)
            make.centerY.equalToSuperview()
        }
    }

    func setupWindLabel() {
        contentView.addSubview(windLabel)

        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "wind")
        let fullString = NSMutableAttributedString(string: " ")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        fullString.append(NSAttributedString(string: " "))
        windLabel.attributedText = fullString

        windLabel.font = windLabel.font.withSize(18)

        windLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }

}
