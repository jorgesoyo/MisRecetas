//
//  ViewController.swift
//  RecetasCompleto
//
//  Created by Jorge MR on 18/06/17.
//  Copyright © 2017 Jorge MR. All rights reserved.
//

import UIKit


//Ojo esta clase hereda de UITableViewController y no de UIViewController
class ViewController: UITableViewController {

    @IBOutlet var tableview: UITableView!
    var recetas : [Receta] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hace que despues de la ultima celda en la tableview, no salgan celdas vacias
        tableview.tableFooterView = UIView(frame: CGRect.zero)
        //Color de la rayita que separa las celdas
        tableview.separatorColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0.241887941)
        
        //Para cambiar el texto del boton por una imagen
        //navigationItem.backBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "hamburguesa"), style: .plain, target: nil, action: nil)
        
        //Para cambiar el texto del boton por otro texto
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
        var receta = Receta(nombre : "Pozole rojo",
                            imagen : #imageLiteral(resourceName: "pozole"),
                            tiempo: 120,
                            ingredientes: ["Carne", "Lechuga", "maiz"],
                            pasos: ["Lorem ipsum dolor sit amet", "consectetur adipisicing elit",
                                    "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                                    "Ut enim ad minim veniam", "quis nostrud exercitation ullamco asfadf af afw efwefaasfe wf wef adsfqe 2ff sadfwefwad af df wef wf a afadsfqef wfe wef we wef wef wef x2"])
        recetas.append(receta)
        receta = Receta(nombre: "Pizza con pimiento",
                        imagen : #imageLiteral(resourceName: "pizza"),
                        tiempo: 30,
                        ingredientes: ["Masa", "Pimiento", "Queso", "Arina"],
                        pasos: ["Lorem ipsum dolor sit amet", "consectetur adipisicing elit",
                                "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                                "Ut enim ad minim veniam", "quis nostrud exercitation ullamco"])
        recetas.append(receta)
        
        receta = Receta(nombre: "Enchiladas verdes",
                        imagen : #imageLiteral(resourceName: "enchiladas"),
                        tiempo: 50,
                        ingredientes: ["Tortillas", "Salsa verde", "Chiles verdes", "Crema", "Queso", "Pollo"],
                        pasos: ["Lorem ipsum dolor sit amet", "consectetur adipisicing elit",
                                "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                                "Ut enim ad minim veniam", "quis nostrud exercitation ullamco",
                                "reprehenderit in voluptate velit es","se cillum dolore eu fugiat nulla pariatur."])
        recetas.append(receta)
        
        receta = Receta(nombre: "Hamburguesa con papas",
                        imagen : #imageLiteral(resourceName: "hamburguesa"),
                        tiempo: 16,
                        ingredientes: ["Pan","Carne","Papas","Pepinillos"],
                        pasos: ["Lorem ipsum dolor sit amet", "consectetur adipisicing elit",
                                "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"])
        recetas.append(receta)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Ocultar la barra de navegacion al hacer swipe hacia abajo
        navigationController?.hidesBarsOnSwipe = true
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // OCULTAR LA BARRA DE ARRIBA (carrier, hora, pila)
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    //MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recetas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //indexpad.row indica en que celda te encuentras
        let receta = recetas[indexPath.row]
        let celdaID = "CeldaReceta"
        let celda = tableView.dequeueReusableCell(withIdentifier: celdaID, for: indexPath) as! CeldaReceta
        celda.miniatura.image = receta.imagen
        celda.miniatura.layer.cornerRadius = 36.75
        celda.miniatura.clipsToBounds = true
        celda.titulo.text = receta.nombre
        celda.tiempo.text = "minutos: \(receta.tiempo!)"
        celda.numIngredientes.text = "Ingredientes: \(receta.ingredientes.count)"
        
        if receta.isFavorite {
            celda.accessoryType = .checkmark
        }else{
            celda.accessoryType = .none
        }
        
        return celda
        
    }
    /* //YA NO ES NECESARIA PORQUE LAS ACCIONES LAS IMPLEMENTO EN EditActionsForRowAt indexPath
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.recetas.remove(at: indexPath.row)
            //self.tableView.reloadData() //No es muy eficiente porque recarga toda la tabla
            self.tableView.deleteRows(at: [indexPath], with: .fade) //En cambio este solo lo borra de la vista
        }
    }
    */
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //Accion de Compartir
        let accionCompartir = UITableViewRowAction(style: .default, title: "Compartir") { (accion, indexPath) in
            let textoPorDefecto  = "Estoy aprendiendo a cocinar \(self.recetas[indexPath.row].nombre!)"
            let actividadController = UIActivityViewController(activityItems: [textoPorDefecto,self.recetas[indexPath.row].imagen!], applicationActivities: nil)
            self.present(actividadController, animated: true, completion: nil)
        }
        accionCompartir.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        //Accion de Borrar
        let accionBorrar = UITableViewRowAction(style: .destructive, title: "Borrar") { (accion, indexPath) in
            self.recetas.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return [accionBorrar, accionCompartir]
    }
    
    //MARK: - UITableViewDelegate
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let recetaSeleccionada = self.recetas[indexPath.row]
                let destinationViewController = segue.destination as! DetailViewController
                destinationViewController.receta = recetaSeleccionada
                
            }
        }
    }
}

