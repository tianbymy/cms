function ajax_find_data(url,channel,programas){  
  $.post(url,{
    "attributes[name]":"channel",
     "channels[id]":channel,
     "programas[id]":programas
   },function(data){
     
   }
 )
}

