// JavaScript Document

	var theMonths=new Array();

	theMonths[0]="January";

	theMonths[1]="February";

	theMonths[2]="March";

	theMonths[3]="April";

	theMonths[4]="May";

	theMonths[5]="June";

	theMonths[6]="July";

	theMonths[7]="August";

	theMonths[8]="September";

	theMonths[9]="October";

	theMonths[10]="November";

	theMonths[11]="December";

	var theDate=new Date();

	var snDateString=theMonths[theDate.getMonth()]+"     "+theDate.getDate()+" ,  "+theDate.getFullYear();

	document.write(snDateString);

