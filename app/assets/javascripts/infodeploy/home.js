function getHomePrograma(value){
  jQuery(".programa").empty()
    if(value != ""){
      jQuery.getJSON("/infodeploy/programas/get_by_channel?channel_id="+value,function(obj){
        if(obj.length > 0){
          var html=""
         html+="<select id ='home_management_programa_id' name = 'home_management[programa_id]'>"
         for(idx=0;idx<obj.length;idx++){
           html+="<option value='"+obj[idx]._id+"'>"+obj[idx].name+"</option>"
         }
         html+="</select>"
        }
        jQuery(".programa").append(html)
    })
    }
}

function checkall (){
   $("input[name='news[]']").attr("checked",true);
}

function cancel(){
  $("input[name='news[]']").attr("checked",false);
}