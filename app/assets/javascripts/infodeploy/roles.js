function checkallmenuitem(){
	$("input[name='role[menu_items][]']").attr("checked",true);
}

function cancelmenuitem(){
	$("input[name='role[menu_items][]']").attr("checked",false);
}