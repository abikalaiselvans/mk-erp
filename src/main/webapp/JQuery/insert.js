$(document).ready(function() {
$('#form').submit(function(){
var content= $('#content').val(); 
$.ajax({type:"post",url:"demo.jsp",data:"content="+content,success:function(msg){$('#result').hide(); 
$("#result").html("<h3>" + msg + "</h3>").fadeIn("slow"); } });
return false;
});
});