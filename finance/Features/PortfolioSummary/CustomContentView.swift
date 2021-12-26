//
// Created by Erik Radicheski da Silva on 05/11/21.
//

import UIKit

class CustomContentView: UIView, UIContentView {


    var titleLabel = UILabel()
    var weightLabel = UILabel()
    var priceLabel = UILabel()

    var configuration: UIContentConfiguration {
        didSet {
            self.configure()
        }
    }

    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)

        [self.titleLabel, self.weightLabel, self.priceLabel].forEach( { $0.translatesAutoresizingMaskIntoConstraints = false } )
        [self.titleLabel, self.weightLabel, self.priceLabel].forEach( { self.addSubview($0) } )
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.titleLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 10),
            self.priceLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.priceLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -10),
            self.weightLabel.topAnchor.constraint(equalTo: self.priceLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            self.weightLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -10),
            self.weightLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])


        self.configure()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        if let conf = self.configuration as? CustomContentConfiguration {
            self.titleLabel.text = conf.title
            self.weightLabel.text = "\(conf.weight ?? 0)"
            self.priceLabel.text = "\(conf.price ?? 0)"
        }
    }

}

struct CustomContentConfiguration: UIContentConfiguration {

    var title: String?
    var weight: Decimal?
    var price: Decimal?

    func makeContentView() -> UIView & UIContentView {
        return CustomContentView(self)
    }

    func updated(for state: UIConfigurationState) -> Self {
        return self
    }

}
