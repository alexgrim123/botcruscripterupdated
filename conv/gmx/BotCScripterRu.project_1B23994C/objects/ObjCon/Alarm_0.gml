new_file_name = string(save_slot)+"-A.png";
if script_title != ""
    new_file_name = script_title+" - A.png";
surface_save(application_surface,new_file_name);
draw_mode = 2;
alarm[1] = 10;

