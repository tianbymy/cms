// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function getPrograma(value,type){
  jQuery(".programa").empty()
  jQuery(".article_type").empty()
    if(value != ""){
      jQuery.getJSON("/infodeploy/programas/get_by_channel?channel_id="+value,function(obj){
        if(obj.length > 0){
          var html=""
         html+="<select id ='article_programa_id' name = 'article[programa_id]' onchange='get_programa_kinds(this.value,\""+type+"\");'>"
         for(idx=0;idx<obj.length;idx++){
           html+="<option value='"+obj[idx]._id+"'>"+obj[idx].name+"</option>"
         }
         html+="</select>"
        }
        jQuery(".programa").append(html)
        get_programa_kinds(jQuery("#article_programa_id").val(),type)
    })
    }
}

function get_programa_kinds(programa,type){
  jQuery(".article_type").empty()
    if(programa != ""){
      jQuery.getJSON("/infodeploy/programas/get_by_kinds?programa_id="+programa,function(obj){
        if(obj.length > 0){
          var html=""
          html +="<div class='item'>"
          html +="<label>文章类型</label>"
          html += "<span class='require'>*</span>"
         for(idx=0;idx<obj.length;idx++){
           if(type == obj[idx][1]){
            html+="<input type='radio' value='"+obj[idx][1]+"' name='article[type]' id='article_type_text' checked='checked'>"
           }else{
            if(idx == 0){
              html+="<input type='radio' value='"+obj[idx][1]+"' name='article[type]' id='article_type_text' checked='checked'>"
            }else{
              html+="<input type='radio' value='"+obj[idx][1]+"' name='article[type]' id='article_type_text'>"
            }
           }
           html+="<label class='lable_for_radio'>"+obj[idx][0]+"</label>"
         }
         html +="</div>"
        }
        jQuery(".article_type").append(html)
    })
  }
}

function add_slide(){
  var html=""
  html+="<p>"
  html+="<label>-</label>"
  html+="<span class='require'>&nbsp;</span>"
  html+="<input type='file' name='slide[image][][name]'>"
  html+="<span>&nbsp;图片描述&nbsp;</span>"
  html+="<input type='text' name='slide[image][][describe]'>"
  html+="<a onclick='destroy_slide($(this));return false;' href='#'>删除</a>"
  html+="</p>"
  jQuery(".slides").append(html)
}

function destroy_slide(element){
  element.parent("p").remove();
  return false;
}


function make_deploy_date(start_date,end_date){
  jQuery(".deploy_date").empty()
  var html=""
  html+="<div class ='item' style = 'padding-left:20px'>"
  html+="<label class = 'label_w4'>开始时间</label>"
  html+='<input name="wordage[deploy_start]" id="wordage_deploy_start" value="'+start_date+'" class="Wdate begin_date left" onclick="WdatePicker({maxDate:\'#F{$dp.$D(\\\'wordage_deploy_end\\\',{d:-1})}\',dateFmt:\'yyyy-MM-dd HH:00:00\'})">';
  html+='<label class = \'label_w4\'>结束时间</label>';
  html+='<input name="wordage[deploy_end]" id="wordage_deploy_end" value="'+end_date+'" class="Wdate begin_date left" onclick="WdatePicker({minDate:\'#F{$dp.$D(\\\'wordage_deploy_start\\\',{d:1})}\',dateFmt:\'yyyy-MM-dd HH:00:00\'})" >';
  html+="</div>"
  jQuery(".deploy_date").append(html)
}

function cancel_deploy_date(){
  jQuery(".deploy_date").empty()
}

function checkall (){
   $("input[name='news[]']").attr("checked",true);
}

function cancel(){
  $("input[name='news[]']").attr("checked",false);
}

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

function destroy_image(slide,element){
  if(slide != ""){
      jQuery.getJSON("/infodeploy/slides/destroy_image?slide_id="+slide,function(obj){
        
        if(obj == true){
          element.parent("div").remove();
          return false;
        }
    })
    }
}