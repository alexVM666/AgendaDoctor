//
//  ViewControllerCitas.swift
//  AgendaDoctor
//
//  Created by alex on 11/05/20.
//  Copyright © 2020 TecNM. All rights reserved.
//

import UIKit

class ViewControllerCitas: UIViewController {
    var Doc = [Doctor]()
    var Cita = [Citas]()
    
    let dataJsonUrlClass = JsonClass()
    
    
    @IBOutlet weak var txtIdcita: UITextField!
    @IBOutlet weak var txtidpaciente: UITextField!
    @IBOutlet weak var lblUsr: UILabel!
    @IBOutlet weak var txtNomPac: UITextField!
    @IBOutlet weak var txtFech: UITextField!
    @IBOutlet weak var txtAsunto: UITextField!
    @IBOutlet weak var txtPeso: UITextField!
    @IBOutlet weak var txtEstatura: UITextField!
    @IBOutlet weak var txtPresion: UITextField!
    
    @IBOutlet weak var MensajeLabel: UILabel!
    
    @IBAction func btnAgregar(_ sender: UIButton) {
        if txtAsunto.text!.isEmpty || txtFech.text!.isEmpty || txtAsunto.text!.isEmpty{
            showAlerta(Titulo: "Validacion de Entrada", Mensaje: "Error faltan de ingresar datos")
            txtFech.becomeFirstResponder()
            return
        }
        else{
            let fech = txtFech.text
            let est = txtEstatura.text
            let peso = txtPeso.text
            let pres = txtPresion.text
            let asunto = txtAsunto.text
            let idp = txtidpaciente.text
            let idd = lblUsr.text
            
            let datos_a_enviar = ["fecha":fech!,"estatura":est,"peso":peso,"presionArt":pres,
                                  "asunto":asunto,"idPaciente":idp,"idDoctor":idd] as NSMutableDictionary
            dataJsonUrlClass.arrayFromJson(url:"DoctorAgenda/Citas/insertCita.php",datos_enviados:datos_a_enviar){ (array_respuesta) in
                    DispatchQueue.main.async {
                        let diccionario_datos = array_respuesta?.object(at: 0) as! NSDictionary
                        
                        if let msg = diccionario_datos.object(forKey: "message") as! String?{
                            self.showAlerta(Titulo: "Cita Guardada", Mensaje: msg)
                        }
                        self.txtFech.text=""
                        self.txtEstatura.text = "0"
                        self.txtPeso.text = "0"
                        self.txtPresion.text = "0"
                        self.txtAsunto.text = ""
                        self.txtidpaciente.text = "0"
                        self.txtNomPac.text = ""
                    }
                }
        }
    }
    
    @IBAction func btnEliminar(_ sender: UIButton) {
        if txtIdcita.text!.isEmpty {
            showAlerta(Titulo: "Validacion de Entrada", Mensaje: "Error faltan de ingresar datos")
            txtIdcita.becomeFirstResponder()
            return
        }
        else{
            let idCita = txtIdcita.text!
            let datos_a_enviar = ["idCitas":idCita] as NSMutableDictionary
            
                dataJsonUrlClass.arrayFromJson(url:"DoctorAgenda/Citas/deleteCita.php",datos_enviados:datos_a_enviar){ (array_respuesta) in
                    
                    DispatchQueue.main.async {
                        let diccionario_datos = array_respuesta?.object(at: 0) as! NSDictionary
                        if let msg = diccionario_datos.object(forKey: "message") as! String?{
                            self.showAlerta(Titulo: "Cita Eliminada", Mensaje: msg)
                        }
                        self.txtIdcita.text="0"
                        self.txtFech.text=""
                        self.txtEstatura.text = "0"
                        self.txtPeso.text = "0"
                        self.txtPresion.text = "0"
                        self.txtAsunto.text = ""
                        self.txtidpaciente.text = "0"
                        self.txtNomPac.text = ""
                    }
                }
        }
    }
    
    @IBAction func btnActualizar(_ sender: UIButton) {
        if txtIdcita.text!.isEmpty || txtidpaciente.text!.isEmpty || txtAsunto.text!.isEmpty || txtidpaciente.text!.isEmpty{
            showAlerta(Titulo: "Validacion de Entrada", Mensaje: "Error faltan de ingresar datos")
            txtIdcita.becomeFirstResponder()
            return
        }
        else{
                let idcita = txtIdcita.text!
                let fech = txtFech.text!
                let est = txtEstatura.text!
                let peso = txtPeso.text!
                let presion = txtPresion.text!
                let asu = txtAsunto.text!
                let idp = txtidpaciente.text!
                let idd = lblUsr.text!
                let datos_a_enviar = ["idCitas":idcita, "fecha": fech,"estatura":est,"peso":peso,
                                      "presionArt":presion,"asunto":asu,"idPaciente":idp, "idDoctor":idd] as NSMutableDictionary
                
                dataJsonUrlClass.arrayFromJson(url:"DoctorAgenda/Citas/updateCita.php",datos_enviados:datos_a_enviar){ (array_respuesta) in
                    
                    DispatchQueue.main.async {
                        let diccionario_datos = array_respuesta?.object(at: 0) as! NSDictionary
                        if let msg = diccionario_datos.object(forKey: "message") as! String?{
                            self.showAlerta(Titulo: "Guardando", Mensaje: msg)
                        }
                        self.txtIdcita.text="0"
                        self.txtFech.text=""
                        self.txtEstatura.text = "0"
                        self.txtPeso.text = "0"
                        self.txtPresion.text = "0"
                        self.txtAsunto.text = ""
                        self.txtidpaciente.text = "0"
                        self.txtNomPac.text = ""
                    }
                }
        }
    }
    
    @IBAction func btnCita(_ sender: UIButton) {
        txtFech.text=""
        txtEstatura.text = "0"
        txtPeso.text = "0"
        txtPresion.text = "0"
        txtAsunto.text = ""
        txtidpaciente.text = "0"
        let idcita = txtIdcita.text
        if idcita == ""{
            return
        }
        let datos_a_enviar = ["idCitas": idcita!] as NSMutableDictionary
        dataJsonUrlClass.arrayFromJson(url:"DoctorAgenda/Citas/getCita.php",datos_enviados:datos_a_enviar){ (array_respuesta) in
            DispatchQueue.main.async {
                let diccionario_datos = array_respuesta?.object(at: 0) as! NSDictionary
                
                if let msg = diccionario_datos.object(forKey: "message") as! String?{
                    self.MensajeLabel.text = msg
                }
                
                if let fech = diccionario_datos.object(forKey: "fecha") as! String?{
                    self.txtFech.text = fech
                }
                
                if let est = diccionario_datos.object(forKey: "estatura") as! String?{
                    self.txtEstatura.text = est
                }
                
                if let peso = diccionario_datos.object(forKey: "peso") as! String?{
                    self.txtPeso.text = peso
                }
                if let presion = diccionario_datos.object(forKey: "presionArt") as! String?{
                    self.txtPresion.text = presion
                }
                if let asu = diccionario_datos.object(forKey: "asunto") as! String?{
                    self.txtAsunto.text = asu
                }
                if let idp = diccionario_datos.object(forKey: "idPaciente") as! String?{
                    self.txtidpaciente.text = idp
                }
                if let nomP = diccionario_datos.object(forKey: "nomPaciente") as! String?{
                    self.txtNomPac.text = nomP
                }
            }
        }
    }
    
    @IBAction func btnAllCitas(_ sender: UIButton) {
        Cita.removeAll()
        let idd = lblUsr.text!
        if idd == ""{
            return
        }
        let datos_a_enviar = ["idDoctor": idd] as NSMutableDictionary
        dataJsonUrlClass.arrayFromJson(url:"DoctorAgenda/Citas/getCitas.php",datos_enviados:datos_a_enviar){ (array_respuesta) in

            DispatchQueue.main.async {
                let cuenta = array_respuesta?.count
                
                for indice in stride(from: 0, to: cuenta!, by: 1){
                    let citas = array_respuesta?.object(at: indice) as! NSDictionary
                    let idcita = citas.object(forKey: "idCitas") as! String?
                    let fechas = citas.object(forKey: "fecha") as! String?
                    let estatura = citas.object(forKey: "estatura") as! String?
                    let peso = citas.object(forKey: "peso") as! String?
                    let presion = citas.object(forKey: "presionArt") as! String?
                    let asunto = citas.object(forKey: "asunto") as! String?
                    let idp = citas.object(forKey: "idPaciente") as! String?
                    let idd = citas.object(forKey: "idDoctor") as! String?
                    let nom = citas.object(forKey: "nomPaciente") as! String?
                    self.Cita.append(Citas(idCitas: idcita, fecha: fechas, estatura: estatura, peso: peso,
                                           presionArt: presion, asunto: asunto, idPaciente: idp,idDoctor: idd,nomPaciente: nom) )
                }
                self.performSegue(withIdentifier: "segueCitas", sender: self)
            }
          }
      }
    
    @IBAction func btnPacientes(_ sender: UIButton) {
        self.performSegue(withIdentifier: "seguePacientes", sender: self)
    }
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
         let doc : Doctor
        doc = Doc[0]
        MensajeLabel.text = ""
        lblUsr.text = String(doc.self.idoctor!)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueCitas"{
            let seguex = segue.destination as! TableViewController
            seguex.Cita = Cita
        }
        if segue.identifier == "seguePacientes"{
            let segueP = segue.destination as! ViewControllerPacientes
            segueP.doctor = Doc
        }
    }
    
    func showAlerta(Titulo: String, Mensaje: String ){
      let alert = UIAlertController(title: Titulo, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
      alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
     self.present(alert, animated: true, completion: nil)
    }
}
