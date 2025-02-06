new_file_name = string(save_slot)+"-B.png";
if script_title != ""
    new_file_name = script_title+" - B.png";

surface_save(application_surface,new_file_name);
draw_mode = 0;
button_lock = 0;

new_file_name = string(save_slot)+".json";
if script_title != ""
    new_file_name = script_title+".json";
if file_exists(new_file_name)
    file_delete(new_file_name);
file = file_text_open_write(new_file_name);

formed_string = "["
for(i=0; i<4; i++)
    for(j=0; j<pick_group_amount[i]; j++) {
        if (formed_string != "[")
            formed_string+=","
        formed_string+="{\"id\":\""+string(charCode[pick_group_select[i,j]])+"\"}";
    }
for(i=1; i<travellerName.lastChar; i++) {
    if (traveller_pick[i]) {
        if (formed_string != "[")
            formed_string+=","
        formed_string+="{\"id\":\""+string(travellerCode[i])+"\"}"
    }
}
for(i=0; i<fabledName.lastChar; i++) {
    if (fabled_pick[i]) {
        if (formed_string != "[")
            formed_string+=","
        formed_string+="{\"id\":\""+string(fabledCode[i])+"\"}"
    }
}
formed_string+="]"
file_text_write_string(file, formed_string);
file_text_close(file);

save_slot++;
ini_open("data.ini");
ini_write_real("data","save",save_slot);
ini_close();


