// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function make_element(value){
  jQuery("#attribute_element").empty()
  if(value != ""){
    if(value=='channel'){
    jQuery.getJSON("/infodeploy/channels/get_all",function(obj){
    if(obj.length > 0){
          var html=""
         html+="<select id ='channels_id' name = 'channels[id]' onchange='get_programas(this.value)'>"
         for(idx=0;idx<obj.length;idx++){
           html+="<option value='"+obj[idx]._id+"'>"+obj[idx].name+"</option>"
         }
         html+="</select>"
         html+="<span id='make_programa'></span>"
        }
        jQuery("#attribute_element").append(html)
        get_programas(jQuery("#channels_id").val())
    })

  }else if(value == 'state'){
    var html="<select name='states[id]' id='states_id'><option value='displaing'>显示中</option><option value='out_of_date'>已过期</option><option value='out_of_stock'>已下架</option></select>"
    jQuery("#attribute_element").append(html)
  }else{
    var html=""
    html="<input type='text' value='' style='width:90px' name='keyword'>"
    jQuery("#attribute_element").append(html)
  }
  }
}

function get_programas(value){
  jQuery("#make_programa").empty()
    if(value != ""){
      jQuery.getJSON("/infodeploy/programas/get_all_by_channel?channel_id="+value,function(obj){
        if(obj.length > 0){
          var html=""
         html+="<select id ='programas_id' name = 'programas[id]'>"
         for(idx=0;idx<obj.length;idx++){
           html+="<option value='"+obj[idx]._id+"'>"+obj[idx].name+"</option>"
         }
         html+="</select>"
        }
        jQuery("#make_programa").append(html)
    })
    }
}

$(function(){
$(".pagenumlist a").click(function(){
    var page=$(this).attr("href").split("=")[1]
    pageNumQuery(page)
    return false;
})
})
function pageNumQuery(page){
    $("#search_list input[name=page]").val(page);
    $("#search_list input[type=submit]").click();
}