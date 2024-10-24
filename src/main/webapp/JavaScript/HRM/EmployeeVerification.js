var isIE;
var req;
var names;
var target1;
var ctrl;

function getElementY(element) {
	var target1Top = 0;
	if (element.offsetParent) {
		while (element.offsetParent) {
			target1Top += element.offsetTop;
			element = element.offsetParent;
		}
	} else if (element.y) {
		target1Top += element.y;
	}
	return target1Top;
}

function initRequest(url) {
	if (window.XMLHttpRequest) {
		req = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		isIE = true;
		req = new ActiveXObject("Microsoft.XMLHTTP");
	}
}

function ClearTable(ctr1) {
	var str = "<center><br><br><br><font class='bolddeepred'>Data not found...</font></br></br></br>";
	var tb = document.getElementById(ctr1);
	tb.innerHTML = str
}

function ClearTabler(ctr1) {
	var str = "<center><br><br><br><font class='bolddeepred'>Total No of Records : 0</font></br></br></br>";
	var tb = document.getElementById(ctr1);
	tb.innerHTML = str
}

function loadEmployeeVerification(startLetter) {
	var mon = document.getElementById('month').value;
	var yr = document.getElementById('year').value;
	var url = "../SmartHRM?actionS=loadEmployeeVerification&mon=" + escape(mon)
			+ "&yr=" + escape(yr) + "&startLetter=" + escape(startLetter);
	initRequest(url);
	req.onreadystatechange = loadEmployeeVerificationRequest;
	req.open("GET", url, true);
	req.send(null);
}

function loadEmployeeVerificationRequest() {
	if (req.readyState == 4) {
		ClearTable('GroupTable');
		ClearTabler('totalRec');
		if (req.status == 200) {

			loadEmployeeVerificationDetails();

		}
	}
}

function loadEmployeeVerificationDetails() {

	var batchs = req.responseXML.getElementsByTagName("Rows")[0];

	var str = "";
	str = str
			+ " <table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";

	str = str + " <tr class='MRow1'> ";
	str = str
			+ " <td><div align='center'><strong class='bold1'>S.No</strong></div></td> ";
	str = str
			+ " <td><div align='center'><strong class='bold1'>Name</strong></div></td> ";
	str = str
			+ " <td><div align='center'><strong class='bold1'>CName</strong></div></td>   ";
	str = str
			+ " <td><div align='center'><strong class='bold1'>Address</strong></div></td>  ";
	str = str
			+ " <td><div align='center'><strong class='bold1'>Email</strong></div></td> ";
	str = str
			+ " <td><div align='center'><strong class='bold1'>Mobile</strong></div></td>  ";
	str = str
			+ " <td><div align='center'><strong class='bold1'>Phone</strong></div></td>  ";
	str = str
			+ " <td><div align='center'><strong class='bold1'>RequestDate</strong></div></td>   ";
	str = str
			+ " <td><div align='center'><strong class='bold1'>VerificationId</strong></div></td>  ";
	str = str
			+ " <td><div align='center'><strong class='bold1'>EmpName</strong></div></td>  ";
	str = str
			+ " <td><div align='center'><strong class='bold1'>Status</strong></div></td>   ";
	str = str
			+ " <td><div align='center'><strong class='bold1'>ResponseDate</strong></div></td>   ";
	str = str
			+ " <td><div align='center'><strong class='bold1'>ResponsedBy</strong></div></td> ";
	str = str + " </tr>";

	for (loop = 0; loop < batchs.childNodes.length; loop++) {
		var batch = batchs.childNodes[loop];
		var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
		var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
		var CName = batch.getElementsByTagName("CName")[0].childNodes[0].nodeValue;
		var Address = batch.getElementsByTagName("Address")[0].childNodes[0].nodeValue;
		var Email = batch.getElementsByTagName("Email")[0].childNodes[0].nodeValue;
		var Mobile = batch.getElementsByTagName("Mobile")[0].childNodes[0].nodeValue;
		var Phone = batch.getElementsByTagName("Phone")[0].childNodes[0].nodeValue;

		var RequestDate = batch.getElementsByTagName("RequestDate")[0].childNodes[0].nodeValue;
		var VerificationId = batch.getElementsByTagName("VerificationId")[0].childNodes[0].nodeValue;
		var EmpName = batch.getElementsByTagName("EmpName")[0].childNodes[0].nodeValue;
		var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
		var ResponseDate = batch.getElementsByTagName("ResponseDate")[0].childNodes[0].nodeValue;
		var ResponsedBy = batch.getElementsByTagName("ResponsedBy")[0].childNodes[0].nodeValue;

		if (loop % 2 == 1)
			str = str + "<tr class='MRow1'>";
		else
			str = str + "<tr class='MRow2'>";
		str = str + "<td  class='boldEleven'>" + (loop + 1);
		str = str + "<td  class='boldEleven'>" + Name;
		str = str + "<td  class='boldEleven'>" + CName;
		str = str + "<td  class='boldEleven'>" + Address;
		str = str + "<td  class='boldEleven'>" + Email;
		str = str + "<td  class='boldEleven'>" + Mobile;
		str = str + "<td  class='boldEleven'>" + Phone;
		str = str + "<td  class='boldEleven'>" + RequestDate;
		str = str + "<td  class='boldEleven'>" + VerificationId;
		str = str + "<td  class='boldEleven'>" + EmpName;
		if (Status == "Y") {
			str = str
					+ "<td  class='boldEleven'><font color='#178507'>Responsed</font>";
			str = str + " / <a href='EmployeeVerificationResponse.jsp?rowid="
					+ Id + "&empid=" + VerificationId + "&email=" + Email
					+ "' style=\" text-decoration:none\">Re-Response</a>";
			str = str + "<td  class='boldEleven'>" + ResponseDate;
			str = str + "<td  class='boldEleven'>" + ResponsedBy;

		} else {
			str = str
					+ "<td  class='boldEleven'><font color='red'>Pending</font>";
			str = str + " / <a href='EmployeeVerificationResponse.jsp?rowid="
					+ Id + "&empid=" + VerificationId + "&email=" + Email
					+ "' style=\" text-decoration:none\">Send a Response</a>";
			str = str + "<td  class='boldEleven'>&nbsp;";
			str = str + "<td  class='boldEleven'>&nbsp;";
		}

	}
	str = str + "</table>";

	var tb = document.getElementById('GroupTable');
	tb.innerHTML = str

	if (batchs.childNodes.length > 0) {
		var tb = document.getElementById('totalRec');
		tb.innerHTML = "<center> <font  class='bolddeepred'>Total No of Records : "
				+ batchs.childNodes.length + "</font></center>";
	} else {
		str = str
				+ "<tr class='MRow1'><td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td></tr>";
	}
}
