const multer=require('multer');

const path = require('path');
const storage=multer.diskStorage(
   { destination:(req,file,cb)=>{
       cb(null,path.join(__dirname,'../storage/imgs'));
   },
    filename:(req,file,cb)=>{
        cb(null,Date.now()+'-'+file.originalname);
    }}
);


const upload=multer({storage});

module.exports=upload;