 <!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>:: Dash Board ::</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="shortcut icon" href="favicon_16.ico"/>
    <link rel="bookmark" href="favicon_16.ico"/>
    <!-- site css -->
    <link rel="stylesheet" href="../dist/css/site.min.css">
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,800,700,400italic,600italic,700italic,800italic,300italic" rel="stylesheet" type="text/css">
    
	
<link href="../resources/DataTables/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../resources/DataTables/js/jquery-3.3.1.js"></script>

<style>
#QuaTable > #tbody>tr:nth-child(odd) 
{
   	background-color : #bdf4f4;
   	color:#000000;
	 
}

#QuaTable > #tbody>tr:nth-child(even) 
{
  	background-color : #f7f7f7;
   	color:#000000;
	 
}
</style>
<script type="text/javascript" src="../dist/js/site.min.js"></script>
  </head>
  <body >
    <!--nav-->
    <nav role="navigation" class="navbar navbar-custom">
        <div class="container-fluid">
          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
           
            <img src='../images/top_banner.png'/>
          </div>

          <!-- Collect the nav links, forms, and other content for toggling -->
         <div id="bs-content-row-navbar-collapse-5" class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
              <li class="active"><a href="getting-started.html">Getting Started</a></li>
              <li class="active"><a href="index.html">Documentation</a></li>
              <!-- <li class="disabled"><a href="#">Link</a></li> -->
              <li class="dropdown">
                <a data-toggle="dropdown" class="dropdown-toggle" href="#">Silverbux <b class="caret"></b></a>
                <ul role="menu" class="dropdown-menu">
                  <li><a href="#">Action</a></li>
                  <li class="divider"></li>
                  <li class="active"><a href="#">Separated link</a></li>
                  <li class="divider"></li>
                  <li class="disabled"><a href="#">Signout</a></li>
                </ul>
              </li>
            </ul>

          </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
      </nav>
	  
	  
    <!--header-->
    <div class="container-fluid">
    <!--documents-->
	
	
         <!--<div class="row row-offcanvas row-offcanvas-left">-->
          <!--<div class="col-xs-6 col-sm-3 sidebar-offcanvas" role="navigation"></div> -->
	 	  
          <div class="col-xs-12 col-sm-12 content">
            <div class="panel panel-default">
              <div class="panel-heading">Sample Heading</div>
              <div class="panel-body">
                  <div class="content-row col-md-12">

<table cellpadding="0" cellspacing="0" border="0"
id="tableId">
<thead>
<tr>
<th width="10%">First Name</th>
<th width="10%">Last Name</th> 
</tr>
</thead>
</table>				  <div id='content'></div>
				  
				  </div>
             </div><!-- panel body -->
            </div>
        </div><!-- content -->
      <!--leftpanel  </div> -->
    </div>
	
    <!--footer-->
    <div class="site-footer">
      <div class="container"></div>
    </div>
	
  </body>
</html>



<script language="javascript" src="../resources/DataTables/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" charset="utf-8">
$(document).ready(function() {
	var oTable = $('#tableId').dataTable( {
	"processing": true,
	"ajax": {
	"url": "../SmartCommonAjax?actionS=DatatableLoadQualification",
	"dataSrc": "demo",
	"type": "GET"
	}
	} );
} );
</script>


<script>

$(document).ready(function()
		{ 
		 
		
		
	$.ajax({
        url: "../SmartCommonAjax?actionS=DatatableLoadQualification",
        type: 'GET',
        dataType: 'json', 
 		success: function (result) {
			try { 
				//console.log(result);
				
				var rowLength =  result.length;
				var content="";
				content +=  "<table id='example' class='display' style='width:100%'> ";
					content +=  "<thead> ";
						content +=  "<tr> ";
							content +=  "<th>S.No</th> ";
							content +=  "<th>Qualification</th> ";
						content +=  "</tr> ";
					content +=  "</thead> ";
					content +=  "<tbody> ";
					content +=  "</tbody> ";
			
				var id,name;
				if(rowLength === 0) 
				{
					content +=  "<tr><td colspan='2' class = 'star'><center><b>Data not found...</b></center></td></tr>";
				}
				else 
				{
					for (var index = 0;index<rowLength;index++) 
					{
						var value = result[index];
						id = value[0];
						name = value[1];
						content += "<tr>";
						content += "<td>"+(index+1)+". <input type='checkbox'  name='quaId' class ='checkList' value= '"+id+"'></td>";
						content += "<td>"+name+"</td>";
						content += "</tr>";
					}
				}
				content +=  "</table> "; 
			
				//$('#content').html(content);
			}
			catch(err)
			{
				alert(err.desc);
			}			
       },
        error: function(err) {
			console.log(err +'<p>An error has occurred</p>');
		}
    });
 	 
 });
</script>    	 	

 
 