  
function LoadMyDailyCall(search) 
{
	var day1 = document.getElementById('day').value;
 	var month1 =document.getElementById('month').value;
 	var year1 =document.getElementById('year').value;
	var me1 =document.getElementById('me').value;
	var status =document.getElementById('typeofcall').value;
	var s ="====day="+day1+"&month="+month1+"&year="+year1+"&me="+me1+"&search="+search;
	//alert(s);
	callAjaxMyDailyCall(day1, month1, year1, me1,status, escape(search)) ;
}  https://marketplace.eclipse.org/marketplace-client-intro?mpc_install=6600208
  

function LoadMyDailyCall() 
{
	var day1 = document.getElementById('day').value;
 	var month1 =document.getElementById('month').value;
 	var year1 =document.getElementById('year').value;
	var search1 =document.getElementById('search').value;
	var me1 =document.getElementById('me').value;
	var status =document.getElementById('typeofcall').value;
	var s ="AAAAAAday="+day1+"&month="+month1+"&year="+year1+"&me="+me1+"&search="+search1;
	//alert(s);
	callAjaxMyDailyCall(day1, month1, year1, me1, status, search1) ;
}  
  
  
  
function callAjaxMyDailyCall(day1, month1, year1, me1, status1, search1) 
{
	 
	
	
	  $.ajax({
                type: "GET",
                url: "../FunnelAjax",  
                data: { actionS:"LoadMyDailyCall", day:day1, month:month1, year:year1, me:me1,status:status1,  search:search1 },
                dataType: "json",  
                success: function(data) { 
                
                	iterateJSONMessage(data) ;
                	   
                     
                },
                error: function(xhr, status, error) {
                    console.error("AJAX error: " + status + error);
                }
            });
}


function iterateJSONMessage(result) 
{
	try
	{
		//GroupTable,totalrec
		var rowLength =  result.length;
		var str="";
		str=str+"<table width='100%'  class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
		str=str+" <thead>";
		str=str+"<tr class='MRow1'>";
		str=str+"<th align='center'><b>ME_NAME</b></th>";
		str=str+"<th align='center'><b>Entry Date</b></th>";
		str=str+"<th align='center'><b>CLIENT_NAME</b></th>";
		str=str+"<th align='center'><b>LOCATION</b></th>";
		str=str+"<th align='center'><b>CONTACT PERSON</b></th>";
		str=str+"<th align='center'><b>DESIGNATION</b></th>";
		str=str+"<th align='center'><b>CONTACT NUMBER</b></th>";
		str=str+"<th align='center'><b>CALL TYPE</b></th>";
		str=str+"<th align='center'><b>DESCRIPTION</b></th>";
		str=str+" </thead>";
		str=str+"</tr>";
		 	
		
		if(rowLength === 0) 
		{
			 str=str+"<tr  class='MRow2'>";
			 str=str+"<td class='bolddeepred' align='center' colspan='17'><center><br>Data not found...</b></center></td>";
			 str=str+"<tr>";
			 str=str+"</table>";
			 
			
		}	 
		else 
		{
			$("#GroupTable").val("");
			
			for (var u = 0;u<rowLength;u++) 
	   		{
				 
				if(u%2==1)
					str=str+"<tr class='MRow1'>";
				else
			    	str=str+"<tr  class='MRow2'>";
			    	
				str=str+"<td class='boldEleven'>";
				str=str+"<input  name='rowid'  id='rowid'   type='checkbox' value='"+result[u].rowid+"' /> "+result[u].mename+"</td>";
				str=str+"<td class='boldEleven'>"+result[u].entrydate +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].clientname +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].location +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].contactperson+"</td>";
				str=str+"<td class='boldEleven'>"+result[u].designation+"</td>";
				str=str+"<td class='boldEleven'>"+result[u].contactnumber +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].typeofcall +"</td>"; 
				str=str+"<td class='boldEleven'>"+result[u].description +"</td>"; 
						
				str=str+"<tr>";
				
				 
			}
			str=str+"</table>";
			 
	   	}
	   	
	   	$("#GroupTable").html(str);
	   	
	   	var totalrecstr = "<center><font class='bolddeepred'>Total no of Records ::"+rowLength+"</font></center>";
	   	$("#totalrec").html(totalrecstr); 
		
	 }
	catch(err)
	{
		alert(err.desc);
	}
	
}
  