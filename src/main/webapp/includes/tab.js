// JavaScript Document



last_tab = 'tab1';
function show(layerName) {
document.getElementById(layerName).style.display = '';
}

function hide(layerName) {
document.getElementById(layerName).style.display = 'none';
}
function show_next(tab_name) {

	document.getElementById(last_tab).className = 'tab';
	var curr = document.getElementById(tab_name);
	curr.className='tab_hover';
	
hide(last_tab+'_data');
show(tab_name+'_data');
last_tab=tab_name;
}