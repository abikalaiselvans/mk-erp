function searchItem(componentId,buttonId,tableName,columnName) 
{
	  
	$('#'+componentId).autocomplete(
			{
				source: function( request,response ) {
					$.ajax({
				  	url:"autocompleteUnique",
					type:"GET",
					data:{"searchKey":request.term,"tableName":tableName,"columnName":columnName},
					
					success:function(result)
					{
						bindSearchResult(result,response,buttonId);
					} 
			  });
		  }
		
	});
}	




function bindSearchResult(result,response,buttonId) 
{
	var searchArr = [];
	var response_length = result.length;
	 
	if(response_length != null && response_length > 0) 
	{
		$('#'+buttonId).hide();
		for (var index = 0 ; index < response_length ; index++) 
		{
			searchArr.push(result[index].name);	
		}
	}
	else 
	{
		$('#'+buttonId).show();
		searchArr.push("Record not found");
	}
	
   response(searchArr);

}


 