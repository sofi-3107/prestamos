const express=require('express');
const res = require('express/lib/response');
const db = require('../models');
const router=express.Router();





/**Rutas CRUD Elemento */

router.get('/',async(req,res) =>{
    try {
        let usuarios=await db.Usuario.findAll();
        res.status(200).json(usuarios);
    } catch (error) {
        res.status(400).send('No se pudieron traer los usuarios, error: '+error.message);
    }
});

router.post('/new',async(req,res)=>{
    if(req.body.nombre!=null){
        try {
            b=req.body;
            nom=b.nombre;
            apel=b.apellido;
            doc=b.dni;
            obs=b.observaciones;
            grado=b.curso;
            phone=b.telefono;
            if(nom=='' || apel=='' || doc=='' || grado==''){
                res.status(500).send('No puedo crear un usuario sin los datos requeridos');
            }

            await db.Usuario.create({
                nombre:nom,
                apellido:apel,
                dni:doc,
                curso:grado,
                telefono:phone,
                observaciones:obs,
            });
            res.status(201).send(`Usuario ${nom} creado correctamente`);
    
        } catch (error) {
            res.status(400).send('Error al crear el usuario: '+error.message);
        }
    }else{
        res.send('No han llegado datos al servidor');
    }

});


router.get('/one/:id',async(req,res)=>{

    console.log(`Método de consulta unitaria id: ${req.params.id}`);
    try {
        let elemento=await db.Usuario.findByPk(req.params.id);
        res.status(200).send(elemento);
    } catch (error) {
        res.status(404).send('No se ha encontrado el elemento: '+error.message);
    }
});

router.delete('/delete/:id',async(req,res)=>{

    await db.Usuario.destroy({where: {id: req.params.id}})
        .then(res.status(200).send(`Usuario borrado correctamente`))
        .catch(error=>res.status(500).send('No se ha podido borrar el Usuario: '+error.message));    
});


router.put('/update/:id',async(req,res)=>{
                b=req.body;
                nom=b.nombre;
                apel=b.apellido;
                doc=b.dni;
                obs=b.observaciones;
                grado=b.curso;
                phone=b.telefono;

                console.log(b.nom+''+b.apel);

    await db.Usuario.update({
                nombre:nom,
                apellido:apel,
                dni:doc,
                curso:grado,
                telefono:phone,
                observaciones:obs,
    },{where: {id:req.params.id}})
        .then(res.status(200).send(`Usuario actualizado correctamente`))
        .catch(error=>res.status(500).send('No se ha podido actualizar el Usuario: '+error.message))
});





module.exports=router;