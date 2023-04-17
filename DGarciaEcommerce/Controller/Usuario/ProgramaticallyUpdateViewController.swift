//
//  ProgramaticallyUpdateViewController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 07/03/23.
//

import UIKit

class ProgramaticallyUpdateViewController: UIViewController {
    
    var posicionUsuario : Int? = nil
    
    let userName = UITextField()
    let nombre = UITextField()
    let apellidoPaterno = UITextField()
    let apellidoMaterno = UITextField()
    let datePicker = UIDatePicker()
    let segmentGenre = UISegmentedControl(items: ["Masculino", "Femenino"])
    let telefono = UITextField()
    let celular = UITextField()
    let CURP = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let safeG = view.safeAreaLayoutGuide
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leftAnchor.constraint(equalTo: safeG.leftAnchor, constant: 40.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: safeG.rightAnchor, constant: -40.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: safeG.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeG.bottomAnchor).isActive = true
        
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.widthAnchor.constraint(equalToConstant: )
//        scrollView.widthAnchor.constraint(equalToConstant: view.frame.width - 80).isActive = true
//        scrollView.topAnchor.constraint(equalTo: safeG.topAnchor).isActive = true
//        scrollView.centerXAnchor.constraint(equalTo: safeG.centerXAnchor).isActive = true
//        scrollView.bottomAnchor.constraint(equalTo: safeG.bottomAnchor).isActive = true
//
        
        let imageView = UIView()
        scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        imageView.backgroundColor = .purple
        
        let image = UIImageView()
        imageView.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "person.fill")
        image.contentMode = .scaleAspectFit
        image.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        image.leftAnchor.constraint(equalTo: imageView.leftAnchor).isActive = true
        image.rightAnchor.constraint(equalTo: imageView.rightAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
  
        let button = UIButton()
        imageView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.backgroundColor = .systemGray
        button.tintColor = .white
        button.configuration?.cornerStyle = .capsule
        button.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: imageView.rightAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        let stackView = UIStackView()
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10.0).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        stackView.spacing = 10.0
        
        let userLabel = UILabel()
        stackView.addArrangedSubview(userLabel)
        userLabel.text = "User name:"
        
        
        stackView.addArrangedSubview(userName)
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        userName.placeholder = "User name"
        userName.borderStyle = .roundedRect
        
        
        let nombreLabel = UILabel()
        stackView.addArrangedSubview(nombreLabel)
        nombreLabel.text = "User name:"
        
        stackView.addArrangedSubview(nombre)
        nombre.translatesAutoresizingMaskIntoConstraints = false
        nombre.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        nombre.placeholder = "Nombre"
        nombre.borderStyle = .roundedRect
        
        let apellidoPaternoLabel = UILabel()
        stackView.addArrangedSubview(apellidoPaternoLabel)
        apellidoPaternoLabel.text = "Apellido Paterno:"
        
        stackView.addArrangedSubview(apellidoPaterno)
        apellidoPaterno.translatesAutoresizingMaskIntoConstraints = false
        apellidoPaterno.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        apellidoPaterno.placeholder = "Apellido paterno"
        apellidoPaterno.borderStyle = .roundedRect
        
        let apellidoMaternoLabel = UILabel()
        stackView.addArrangedSubview(apellidoMaternoLabel)
        apellidoMaternoLabel.text = "Apellido Materno:"
        
        stackView.addArrangedSubview(apellidoMaterno)
        apellidoMaterno.translatesAutoresizingMaskIntoConstraints = false
        apellidoMaterno.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        apellidoMaterno.placeholder = "Apellido Materno"
        apellidoMaterno.borderStyle = .roundedRect
        
        let fechaNacimientoLabel = UILabel()
        stackView.addArrangedSubview(fechaNacimientoLabel)
        fechaNacimientoLabel.text = "Fecha nacimiento:"
        
        stackView.addArrangedSubview(datePicker)
        datePicker.heightAnchor.constraint(equalToConstant: 90.0).isActive = true
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.maximumDate = .now
        
        
        let generoLabel = UILabel()
        stackView.addArrangedSubview(generoLabel)
        generoLabel.text = "Genero:"
        
        stackView.addArrangedSubview(segmentGenre)
        segmentGenre.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        segmentGenre.selectedSegmentIndex = 0
        
        
        let telefonoLabel = UILabel()
        stackView.addArrangedSubview(telefonoLabel)
        nombreLabel.text = "Teléfono:"
        
        stackView.addArrangedSubview(telefono)
        telefono.translatesAutoresizingMaskIntoConstraints = false
        telefono.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        telefono.placeholder = "Telefono"
        telefono.borderStyle = .roundedRect
        
        let celularLabel = UILabel()
        stackView.addArrangedSubview(celularLabel)
        celularLabel.text = "Celular:"
        
        stackView.addArrangedSubview(celular)
        celular.translatesAutoresizingMaskIntoConstraints = false
        celular.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        celular.placeholder = "Celular"
        celular.borderStyle = .roundedRect
        
        let CURPLabel = UILabel()
        stackView.addArrangedSubview(CURPLabel)
        CURPLabel.text = "CURP:"
        
        stackView.addArrangedSubview(CURP)
        CURP.translatesAutoresizingMaskIntoConstraints = false
        CURP.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        CURP.placeholder = "CURP"
        CURP.borderStyle = .roundedRect
        
        print(posicionUsuario)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
