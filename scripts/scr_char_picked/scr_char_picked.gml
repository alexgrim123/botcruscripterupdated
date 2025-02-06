function scr_char_picked(argument0) {
	tmp_group = group[argument0];
	for(tmp_itr=0; tmp_itr < pick_group_amount[tmp_group]; tmp_itr++)
	    if pick_group_select[tmp_group, tmp_itr] == argument0
	        return true;
	return false;



}
