// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function checkall (){
   $("input[name='news[]']").attr("checked",true);
}

function cancel(){
  $("input[name='news[]']").attr("checked",false);
}