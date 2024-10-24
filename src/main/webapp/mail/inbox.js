function checkall(ch)
{
	if(ch==1)
	{
		document.forminbox.msgno.checked=true;
	}
	else
	{
		for(var i = 0; i < ch ; i++)
		{
			document.forminbox.msgno[i].checked = true;
		}
	}
}
function clearall(cl)
{
	if(cl==1)
	{
		
		document.forminbox.msgno.checked=false;
	}
	else{
			for(var i = 0; i < cl ; i++)
			{
				document.forminbox.msgno[i].checked = false;
			}
		}
}
function check(count)
{
	var j=0;
	if(count==1)
	{
		if(document.forminbox.msgno.checked==true)
		{
			j++;
		}
	}
	else
	{
		for(var i = 0; i < count; i++)
		{
			if(document.forminbox.msgno[i].checked == true)
			{
				j++;
			}
		}
	}
	if(j==0)
	{
		alert("Please select any message!!!");
		return false;
	}
	else
	{return true;
	}

	
	
}
function cca(CB)
{
	
	if (CB.checked)
	{		
		hL(CB);
	}
	else
		dL(CB);
}
function hL(E)
{
	
	E=E.parentElement;
	E=E.parentElement;
	E.className = "H";
}
function dL(E)
{
	E=E.parentElement;
	E=E.parentElement;
	E.className = "";
}
function deleteMessages(count)
{
	if(check(count))
	{
		document.forminbox.action="delmessages.jsp"
		document.forminbox.submit();
	}

}
function deleteTrash(count)
{
	if(check(count))
	{
		document.forminbox.action="delfromtrash.jsp"
		document.forminbox.submit();
	}

}
function unread(count)
{
	alert("TotalCount"+count);
if(check(count))
	{
		document.forminbox.action="MarkUnread.jsp"
		document.forminbox.submit();
	}
}
function moveToFolder(count)
{
//alert("The count is: "+count);	
if(check(count))
{
if(document.forminbox.foldertomove.options[document.forminbox.foldertomove.selectedIndex].value!="empty")
	{
 // alert("The count of first is:"+count);
 // alert("First folder is:"+document.forminbox.foldertomove.options[document.forminbox.foldertomove.selectedIndex].value);
document.forminbox.action="movemessages.jsp";
document.forminbox.submit();
	}
else
	{
	if(document.forminbox.foldertomove1.options[document.forminbox.foldertomove1.selectedIndex].value!="empty")
		{
		//alert("The count of second is:"+count);
		//alert("Second folder is:"+document.forminbox.foldertomove1.options[document.forminbox.foldertomove1.selectedIndex].value);
		document.forminbox.action="movemessages.jsp";
		document.forminbox.submit();

		}
		else{alert("Please Select Any Folder to Move Messages");}

	}
}
}
function SwitchFolder(name)
	{
	document.forminbox.currentfolder.value=name;
	document.forminbox.action="read_mail.jsp";
	document.forminbox.submit();
	}
	
function ShowLetter(count)
{
	document.forminbox.id.value=count;
	document.forminbox.action="showLetter.jsp";
	document.forminbox.submit();
}
function AddFolder()
    {
	var nn = window.prompt("Please enter a name for your folder.","");
	if (nn != null && nn != "null" && nn != "") 
		{

		    var str = "new_folder.jsp?foldername="+nn;
            window.open(str, "_top");
	   
		}
	    
    }

//-->
