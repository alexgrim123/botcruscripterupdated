/// @description

if async_id != undefined {
	tmp_title_name = "";
	var _id = ds_map_find_value(async_load, "id");
	if (_id == async_id)
	{
		if (ds_map_find_value(async_load, "status"))
		{
			if (ds_map_find_value(async_load, "result") != "")
			{
			    tmp_title_name = ds_map_find_value(async_load, "result");
			}
		}
	}
	if (tmp_title_name != "")
	    script_title = tmp_title_name
}