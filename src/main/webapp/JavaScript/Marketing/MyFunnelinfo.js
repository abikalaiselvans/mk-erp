  
function LoadMyFunnelinfo(search) 
{
	var day1 = document.getElementById('day').value;
 	var month1 =document.getElementById('month').value;
 	var year1 =document.getElementById('year').value;
	var me1 =document.getElementById('me').value;
	var s ="====day="+day1+"&month="+month1+"&year="+year1+"&me="+me1+"&search="+search;
	//alert(s);
	callAjaxFunnelinfo(day1, month1, year1, me1, escape(search)) ;
}  https://marketplace.eclipse.org/marketplace-client-intro?mpc_install=6600208
  

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
                type: "GET",
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
		str=str+"<th align='center'><b>UNIT VALUE</b></th>"; 
		str=str+"<th align='center'><b>TOTAL</b></th>";
		str=str+"<th align='center'><b>BOTTOMLINE</b></th>";
		str=str+"<th align='center'><b>CATEGORY</b></th>";
		str=str+"<th align='center'><b>STAGE</b></th>";
		str=str+"<th align='center'><b>APPROX CLOSURE</b></th>";
		str=str+"<th align='center'><b>STATUS</b></th>";
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
				str=str+"<input  name='rowid'  id='rowid'   type='checkbox' value='"+result[u].rowid+"' /> "+result[u].mename+"</td>";
				str=str+"<td class='boldEleven'>"+result[u].clientname +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].location +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].product+"</td>";
				str=str+"<td class='boldEleven'>"+result[u].lob +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].oem +"</td>";
				str=str+"<td class='boldEleven' align='right'>"+result[u].qty  +"</td>";
				str=str+"<td class='boldEleven' align='right'>"+result[u].unitvalue +"</td>"; 
				str=str+"<td class='boldEleven' align='right'>"+result[u].totalvalue +"</td>";
				str=str+"<td class='boldEleven' align='right'>"+result[u].bottomlinevalue +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].category +"</td>";
				str=str+"<td class='boldEleven'>Stage "+result[u].stage +"%</td>";
				str=str+"<td class='boldEleven'>"+result[u].approxclosure +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].status +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].probabilitywinning +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].proposal +"</td>";
				str=str+"<td class='boldEleven'>"+result[u].remarks +"</td>";
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
  