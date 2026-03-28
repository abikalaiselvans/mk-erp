  
function LoadMyFunnelinfo(search) 
{
	var day1 = document.getElementById('day').value;
 	var month1 =document.getElementById('month').value;
 	var year1 =document.getElementById('year').value;
	var me1 =document.getElementById('me').value;
	var s ="====day="+day1+"&month="+month1+"&year="+year1+"&me="+me1+"&search="+search;
	//alert(s);
	callAjaxFunnelinfo(day1, month1, year1, me1, escape(search)) ;
}  
  

function LoadMyFunnelsearchinfo() 
{
	var day1 = document.getElementById('day').value;
 	var month1 =document.getElementById('month').value;
 	var year1 =document.getElementById('year').value;
	var search1 =document.getElementById('search').value;
	var me1 =document.getElementById('me').value;
	var s ="AAAAAAday="+day1+"&month="+month1+"&year="+year1+"&me="+me1+"&search="+search1;
	//alert(s);
	callAjaxFunnelinfo(day1, month1, year1, me1, search1) ;
}  
  
  
  
function callAjaxFunnelinfo(day1, month1, year1, me1, search1) 
{
	 
	
	
	  $.ajax({
                type: "POST",
                url: "../FunnelAjax",  
                data: { actionS:"Loadfunnelinfos", day:day1, month:month1, year:year1, me:me1, search:search1 },
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
		str=str+"<th align='center'><b>CLIENT_NAME</b></th>";
		str=str+"<th align='center'><b>LOCATION</b></th>";
		str=str+"<th align='center'><b>PRODUCT</b></th>";
		str=str+"<th align='center'><b>LOB</b></th>";
		str=str+"<th align='center'><b>OEM</b></th>";
		str=str+"<th align='center'><b>QTY</b></th>";
		str=str+"<th align='center'><b>UNIT</b></th>";
		str=str+"<th align='center'><b>VALUE</b></th>";
		str=str+"<th align='center'><b>TOTAL</b></th>";
		str=str+"<th align='center'><b>BOTTOMLINE</b></th>";
		str=str+"<th align='center'><b>CATEGORY</b></th>";
		str=str+"<th align='center'><b>STAGE</b></th>";
		str=str+"<th align='center'><b>APPROX</b></th>";
		str=str+"<th align='center'><b>PROBABILITY</b></th>";
		str=str+"<th align='center'><b>PROPOSAL</b></th>";
		str=str+"<th align='center'><b>REMARKS</b></th>";
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
				str=str+"<input required  name='branchid'  id='branchid'   type='checkbox' value='"+result[u].ROWID+"' /> "+result[u].ME_NAME+"</td>";
				str=str+"<td class='boldEleven'>"+result[u].ME_NAME +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].CLIENT_NAME +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].LOCATION +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].PRODUCT+"</td>";
				str=str+"<td class='boldEleven'>"+result[u].LOB +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].OEM +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].QTY +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].UNIT +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].VALUE +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].TOTAL +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].BOTTOMLINE +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].CATEGORY +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].STAGE +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].APPROX +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].PROBABILITY +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].PROPOSAL +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].REMARKS +"</td>";
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
  