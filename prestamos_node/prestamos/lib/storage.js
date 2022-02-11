const multer=require('multer');

const path = require('path');

const storage=multer.diskStorage(
   { destination:(req,file,cb)=>{
       cb(null,path.join(__dirname,'../storage/imgs'));/*path.join permite que la ruta que se joinee se use como indicadores de navegacion, 
                                                            no funciona como concatenacion pura de strings  cb(null,__dirname,'../storage/imgs').
                                                        __dirname devuelve la ruta absoluta de este archivo, 
                                                        que esta dentro de /lib y storage esta en la raiz, hay que salir de libs para acceder*/
   },
    filename:(req,file,cb)=>{
        cb(null,Date.now()+'-'+file.originalname);// originalname pone el nombre original y la extension del archivo
    }}
);


const upload=multer({storage});

module.exports=upload;