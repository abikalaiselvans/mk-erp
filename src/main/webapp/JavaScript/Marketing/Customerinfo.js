var isIE;
var req;
var names;

function initRequest(url) 
{
	if (window.XMLHttpRequest) 
	{
		req = new XMLHttpRequest();
	} 
	else if (window.ActiveXObject) 
	{
		isIE = true;
		req = new ActiveXObject("Microsoft.XMLHTTP");
	}
}


function ClearTable(ctr1) 
{
	var str = "<center><br><br><br><font class='bolddeepred'>Data not found...</font></br></br></br>";
	var tb = document.getElementById(ctr1);
	tb.innerHTML = str
}


function ClearTabler(ctr1) 
{
	var str = "<center><br><font class='bolddeepred'>Total No of Records : 0</font></br>";
	var tb = document.getElementById(ctr1);
	tb.innerHTML = str
}

function LoadCustomerinfo(ctr) 
{
	var verified = document.getElementById('verified').value;
	var account = document.getElementById('account').value;
	var division = document.getElementById('division').value;
	var me = document.getElementById('me').value;
	
	var url = "../marketing?actionS=LoadCustomerinfos&startLetter="
			+ escape(ctr.value) + "&group="
			+ document.getElementById('group').value + "&active="
			+ document.getElementById('status').value + "&verified="+verified +"&account="+account+"&division="+division+"&me="+me;
	initRequest(url);
	req.onreadystatechange = LoadCustomerinfosRequest;
	req.open("GET", url, true);
	req.send(null);
}


function LoadCustomerinfos(startLetter) 
{

	var verified = document.getElementById('verified').value;
	var account = document.getElementById('account').value;
	var division = document.getElementById('division').value;
	var me = document.getElementById('me').value;
	var url = "../marketing?actionS=LoadCustomerinfos&startLetter="
			+ escape(startLetter) + "&group="
			+ document.getElementById('group').value + "&active="
			+ document.getElementById('status').value + "&verified=" + verified+"&account="+account+"&division="+division+"&me="+me;
	initRequest(url);
	req.onreadystatechange = LoadCustomerinfosRequest;
	req.open("GET", url, true);
	req.send(null);
}

function LoadCustomerinfosRequest() {

	ClearTabler('totalrec');
	ClearTable('GroupTable');
	if (req.readyState == 4) {

		if (req.status == 200) {

			LoadCustomerinfosMessages();
		}
	}
}

function LoadCustomerinfosMessages() 
{
	try
	{
		var batchs = req.responseXML.getElementsByTagName("Rowss")[0];
		var str = "";
		str = str + "<table width='100%'  class='boldEleven' border='0'  id='myTable'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
		str = str + "<tr class='MRow1'>";
		str = str + "<td   align='center' class='bold1'>S.No</td>";
		str = str + "<td  align='center' class='bold1'>Company </td>";
		str = str + "<td  align='center' class='bold1'>Contact Person</td>";
		str = str + "<td  align='center' class='bold1'>City </td>";
		str = str + "<td  align='center' class='bold1'>District</td>";
		str = str + "<td  align='center' class='bold1'>Pincode </td>";
		str = str + "<td  align='center' class='bold1'>Group </td>";
		str = str + "<td  align='center' class='bold1'>Handled By</td>";
		str = str + "<td  align='center' class='bold1'>Verification</td>";
		str = str + "<td  align='center' class='bold1'>M.E Change</td>";
		str = str + "</tr>";
		 
		for (loop = 0; loop < batchs.childNodes.length; loop++) 
		{
			var batch = batchs.childNodes[loop];
			 
			 
			var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
			var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
			var CName = batch.getElementsByTagName("CName")[0].childNodes[0].nodeValue;
			var Add1 = batch.getElementsByTagName("Add1")[0].childNodes[0].nodeValue;
			var Add2 = batch.getElementsByTagName("Add2")[0].childNodes[0].nodeValue;
			var Add3 = batch.getElementsByTagName("Add3")[0].childNodes[0].nodeValue;
			var City = batch.getElementsByTagName("City")[0].childNodes[0].nodeValue;
			var District = batch.getElementsByTagName("District")[0].childNodes[0].nodeValue;
			var State = batch.getElementsByTagName("State")[0].childNodes[0].nodeValue;
			var Pin = batch.getElementsByTagName("Pin")[0].childNodes[0].nodeValue;
			var Phone = batch.getElementsByTagName("Phone")[0].childNodes[0].nodeValue;
			var Mobile = batch.getElementsByTagName("Mobile")[0].childNodes[0].nodeValue;
			var Fax = batch.getElementsByTagName("Fax")[0].childNodes[0].nodeValue;
			var Web = batch.getElementsByTagName("Web")[0].childNodes[0].nodeValue;
			var GName = batch.getElementsByTagName("GName")[0].childNodes[0].nodeValue;
			var Active = batch.getElementsByTagName("Active")[0].childNodes[0].nodeValue;
			var Createdby = batch.getElementsByTagName("Createdby")[0].childNodes[0].nodeValue;
			var verified = batch.getElementsByTagName("verified")[0].childNodes[0].nodeValue;
			var usertype = batch.getElementsByTagName("usertype")[0].childNodes[0].nodeValue;
			var Handle = batch.getElementsByTagName("Handle")[0].childNodes[0].nodeValue;
			
			if (loop % 2 == 1)
				str = str + "<tr class='MRow1'>";
			else
				str = str + "<tr  class='MRow2'>";
	
			str = str + "<td  class='boldEleven'><input name='id' id='id' type='checkbox' value='"+ Id + "'/>" + (loop + 1) + "</td>";
			
		 
			str = str + "<td  class='boldEleven'>" + CName + "</td>";
			str = str + "<td  class='boldEleven'>" + Name + "</td>";
			str = str + "<td  class='boldEleven'>" + City + "&nbsp;</td>";
			str = str + "<td  class='boldEleven'>" + District + "&nbsp;</td>";
			str = str + "<td  class='boldEleven'>" + Pin + "&nbsp;</td>";
			str = str + "<td  class='boldEleven'>" + GName + "&nbsp;</td>";
			
		 
			str = str + "<td  class='boldEleven'>" + Handle + "&nbsp;</td>";
			if (verified == "Y")
				str = str + "<td  class='boldEleven'><font color='blue'>Completed</font></td>";
			else if (verified == "R")
				str = str + "<td  class='boldEleven'><font color='red'>Rejected</font></td>";
			else 
			{
				str = str + "<td  class='boldEleven'><font color='red'>Pending</font>&nbsp;&nbsp;";
				if (usertype == "F" || usertype == "B")
					str = str	+ "/&nbsp;&nbsp;<a href='CustomerInfoEdit.jsp?action1=Edit&id="+Id+"'><font class='boldgreen'>Click to verify</font></a> ";
				
					//str = str	+ "/&nbsp;&nbsp;<a href=\"javascript:CustomerVerified('"+ Id+ "')\"> <font class='bolddeepred'>click to verify</font></a>";
	
				str = str + "</td> ";
	
			}
		
		
			
			if ((usertype == "F" || usertype == "B") && verified == "Y") 
				str = str + "<td  class='boldEleven'><a href='CustomerInfoMEChange.jsp?id="+Id+"'><font class='boldgreen'>M.E Change</font></a></td>";
			else
				str = str + "<td  class='boldEleven'>&nbsp;</td>";
		}

		var tb = document.getElementById('GroupTable');
		tb.innerHTML = str;
	
		tb = document.getElementById('totalrec');
		tb.innerHTML = "<center><font class='bolddeepred'>Total no of Records ::"
				+ batchs.childNodes.length + "</font></center>";
	
		str = str + "</table>";
	}
	catch(err)
	{
		alert(err.description);
	}
}

function CustomerVerified(Id) {

	var f = "../SmartLoginAuth?filename=CustomerInfo&actionS=MKTCustomerInfoVerify&rowid="
			+ Id;
	var rs = confirm("Are you sure Customer address verified");
	if (rs == true) {
		location = f;
	}

}