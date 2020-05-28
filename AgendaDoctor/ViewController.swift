//
//  ViewController.swift
//  AgendaDoctor
//
//  Created by TecNM on 03/03/20.
//  Copyright © 2020 TecNM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtContra: UITextField!
    @IBOutlet weak var txttipousr: UITextField!
    @IBOutlet weak var mensajeLabel: UILabel!
    var Usuarios = [Usuario]()
    var Doc = [Doctor]()
    let dataJsonUrlClass = JsonClass()
    
    @IBAction func btnIngresar(_ sender: UIButton) {
         Usuarios.removeAll()
        Doc.removeAll()
        let correo = txtCorreo.text
        let contrasena = txtContra.text
        let tipoUsr = txttipousr.text
        if correo == ""{
            return
        }
        let datos_a_enviar = ["correo": correo!, "contrasena": contrasena!, "tipoUsr": tipoUsr!] as NSMutableDictionary
        dataJsonUrlClass.arrayFromJson(url:"DoctorAgenda/inicio/login.php",datos_enviados:datos_a_enviar){ (array_respuesta) in
            DispatchQueue.main.async {
                let diccionario_datos = array_respuesta?.object(at: 0) as! NSDictionary
                
                let id = diccionario_datos.object(forKey: "idUsuario") as! String?
                let cor = diccionario_datos.object(forKey: "correo") as! String?
                let contra = diccionario_datos.object(forKey: "contrasena") as! String?
                let tipo = diccionario_datos.object(forKey: "tipoUsr") as! String?
                let iddoc = diccionario_datos.object(forKey: "idDoctor") as! String?
                let nomD = diccionario_datos.object(forKey: "nomDoctor") as! String?
                let esp = diccionario_datos.object(forKey: "especialidad") as! String?
                let hora = diccionario_datos.object(forKey: "horario") as! String?
                
                self.Usuarios.append(Usuario(idUsuario: id, correo: cor, contrasena: contra, tipoUsr: tipo) )
                self.Doc.append(Doctor(idDoctor: iddoc, nomDoctor: nomD, especialidad: esp, horario: hora) )
                self.performSegue(withIdentifier: "segue", sender: self)
                if let msg = diccionario_datos.object(forKey: "message") as! String?{
                    self.showAlerta(Titulo: "Bienvenido ", Mensaje: msg)
                    }
              }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mensajeLabel.text = ""
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue"{
            let seguex = segue.destination as! ViewControllerCitas
            seguex.Doc = Doc
        }
        
    }
    
    func showAlerta(Titulo: String, Mensaje: String ){
      let alert = UIAlertController(title: Titulo, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
      alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
     self.present(alert, animated: true, completion: nil)
    }
}

