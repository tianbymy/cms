$(function(){
  $("#new_portlets .portlet input[type=radio]").eq(0).attr("checked","checked")
  type=$(".portlet input[type=radio]:checked").val()
  showform(type)
  $(".portlet input[type=radio]").click(function(){
    type=$(".portlet input[type=radio]:checked").val()
    showform(type)
  })
})
function showform(type){  
    $(".portlet .class_for_form").hide()
    $(".portlet .class_for_"+type).show()
}




$(function(){

$("#portlets_option_channel_id").change(function(){
      channel_id=$(this).val()
      if (channel_id !=""){
          get_programs(channel_id,"");
        }

  })

})

function get_programs(channel_id,programa_id){
            $.getJSON("/infodeploy/programas/get_by_channel?channel_id="+channel_id,function(obj){
            $("#portlets_option_programa_id").empty();
              html=""
              if(obj.length>1){
                html+="<option value=''>---全选---</option>";
                for (i in obj){
                  if (programa_id==obj[i]._id){
                    html+="<option value='"+obj[i]._id+"' selected='selected'>"+obj[i].name+"</option>"
                  }else{
                    html+="<option value='"+obj[i]._id+"'>"+obj[i].name+"</option>"
                  }
                  
                }
              }else{
                  html+="<option value='"+obj[0]._id+"'>"+obj[0].name+"</option>";
                }
            $("#portlets_option_programa_id").append(html);

          })
}