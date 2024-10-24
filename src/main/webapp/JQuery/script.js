$(document).ready(function() {
$('#form').submit(function(){
var number = $('#number').val(); 
$.ajax({type:"post",url:"calculate.jsp",data:"number=" +number,success:function(msg){$('#result').hide(); 
$("#result").html("<h3>" + msg + "</h3>").fadeIn("slow"); } });
return false;
});
});