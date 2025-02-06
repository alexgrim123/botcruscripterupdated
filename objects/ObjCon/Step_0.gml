highlight_selection = -1;
highlight_list = -1;
if (!filter_box_open && !help_box_open) {
    for(i=0; i<=charGroup.demon; i++) {
        if (pick_group_amount[i]) {
            for(j=0; j<pick_group_amount[i]; j++) {
                if mouse_area(ui_icon_x+(j%9)*150 - 70,ui_icon_y+(j div 9)*150+460*i - 70, ui_icon_x+(j%9)*150 + 70,ui_icon_y+(j div 9)*150+460*i + 70) {
                    highlight_selection = pick_group_select[i,j];
                }
            }
        }
    }
    
    if !button_lock && mouse_check_button_pressed(mb_left) && mouse_area(ui_x, ui_y + box_size*11.5 - 100, ui_x + 1200, ui_y + box_size*11.5 + 100)
        clipboard_set_text("%appdata%\\BotCScripterRu");
    
    if !button_lock && mouse_check_button_pressed(mb_left) && mouse_area(ui_x + 650, ui_y + box_size*7 - 100, ui_x + 1200, ui_y + box_size*7 + 100) {
        tmp_title = get_string(get_string_title[curr_lang],script_title);
        if (tmp_title != "")
            script_title = tmp_title
    }
    
    if !button_lock && mouse_check_button_pressed(mb_left) && mouse_area(ui_x + 650, ui_y + box_size*9 - 100, ui_x + 1200, ui_y + box_size*9 + 100) {
        filename = get_open_filename("json file|*.json", "");
        if (filename != "") {
            scr_remove_all();
            file = file_text_open_read(filename);
            finding_name = filename;
            while(true) {
                tmp_slash_pos = string_pos("\\",finding_name);
                finding_name = string_copy(finding_name,tmp_slash_pos+1,string_length(finding_name));
                if string_pos("\\",finding_name) == 0
                    break;
            }
            tmp_ext_pos = string_pos(".json",finding_name);
            script_title = string_copy(finding_name,1,tmp_ext_pos-1);
            json_file_string = file_text_read_string(file);
            for(i=0; i<string_length(json_file_string); i++) {
                if string_char_at(json_file_string,i) == ":" {
                    tmp_json_char = string_char_at(json_file_string,i+2);
                    for(j=i+3; j<string_length(json_file_string); j++) {
                        if string_char_at(json_file_string,j) == "\""
                            break;
                        tmp_json_char += string_char_at(json_file_string,j)
                    }
                    for(j=1; j<travellerName.lastChar; j++)
                        if tmp_json_char == travellerCode[j] {
                            traveller_pick[j] = 1;
                            break;
                        }
                    for(j=0; j<fabledName.lastChar; j++)
                        if tmp_json_char == fabledCode[j] {
                            fabled_pick[j] = 1;
                            break;
                        }
                    for(j=0; j<charName.lastChar; j++)
                        if tmp_json_char == charCode[j] {
                            scr_pick_char(j);
                            break;
                        }
                }
            }
            file_text_close(file);
        }
    }
    
    if mouse_check_button_pressed(mb_left) && mouse_area(ui_x + 20, ui_y + box_size*9 - 100, ui_x + 620, ui_y + box_size*9 + 100)
        if !button_lock {
            scr_remove_all();
        }
    
    if mouse_check_button_pressed(mb_left) && mouse_area(ui_x + 20, ui_y + box_size*7 - 100, ui_x + 620, ui_y + box_size*7 + 100)
        if !button_lock {
            amy_sort();
            alarm[0] = 10;
            draw_mode = 1;
            button_lock = 1;
        }
    
    for(i=0; i<=setName.experimental; i++)
        if !button_lock && mouse_area(ui_x, ui_y + (box_size*1.5)*i, ui_x + 600, ui_y + box_size + (box_size*1.5)*i) {
            if mouse_check_button_pressed(mb_left) {
                filter_set[i] = !filter_set[i];
                scr_refresh();
                break;
            }
            if mouse_check_button_pressed(mb_right) && i != setName.experimental {
                scr_remove_all();
                script_title = titleSet[i];
                for(j=0; j<charName.lastChar; j++) {
                    if charSet[j] = i
                        scr_pick_char(j);
                }
            } else if mouse_check_button_pressed(mb_right) {
                // randomize
                scr_remove_all();
                script_title = random_title[curr_lang];
                for(j=0; j<4; j++) {
                    for(k=0; k<base_random_amount[j]; k++) {
                        scr_pick_random_char(j);
                    }
                }
            }
        }
    
    for(i=0; i<=2; i++)
        if !button_lock && mouse_area(ui_x+700, ui_y + (box_size*1.5)*i, ui_x+700 + 600, ui_y + box_size + (box_size*1.5)*i) {
            if mouse_check_button_pressed(mb_left) {
                list_mode = i;
                scr_refresh();
                break;
            }
            if mouse_check_button_pressed(mb_right) {
                if (i == 1) {
                    alarm[2] = 10;
                    draw_mode = 3;
                    button_lock = 1;
                }
                if (i == 2) {
                    alarm[3] = 10;
                    draw_mode = 4;
                    button_lock = 1;
                }
            }
        }
    
    if mouse_area(ui_x+700, ui_y + (box_size*1.5)*3, ui_x+700 + 600, ui_y + box_size + (box_size*1.5)*3) {
            if !button_lock && mouse_check_button_pressed(mb_left) {
                amy_order_enable = !amy_order_enable;
            }
        }
    
    for(i=0; i<list_max && i<list_size; i++)
        if mouse_area(0,130+i*150,965,270+i*150)
            highlight_list = filter_list[i+scroll];
    
    if !button_lock && mouse_check_button_pressed(mb_left) && highlight_selection > -1 {
        scr_remove_char(highlight_selection)
    }
    if !button_lock && mouse_check_button_pressed(mb_left) && highlight_list > -1 {
        switch(list_mode) {
        
            case 0:
                if scr_char_picked(highlight_list)
                    scr_remove_char(highlight_list)
                else
                    scr_pick_char(highlight_list)
            break;
    
            case 1:
                if !traveller_pick[highlight_list] && !scr_max_travellers() {
                    traveller_pick[highlight_list] = 1;
                } else {
                    traveller_pick[highlight_list] = 0;
                }
            break;
            
            case 2:
                if !fabled_pick[highlight_list] && !scr_max_fabled() {
                    fabled_pick[highlight_list] = 1;
                } else {
                    fabled_pick[highlight_list] = 0;
                }
            break;
    
        }
    }
    
    sp_scroll = max(scroll_max div 15, 1)
    
    if !button_lock && (mouse_wheel_down() || (!arrow_button_cd && (keyboard_check(vk_down) || keyboard_check(vk_right)))) {
        if scroll < scroll_max
            scroll = min(scroll_max, scroll+sp_scroll);
            arrow_button_cd = 4;
    }
    
    if !button_lock && (mouse_wheel_up() || (!arrow_button_cd && (keyboard_check(vk_up) || keyboard_check(vk_left)))) {
        if scroll > 0 {
            scroll = max(scroll-sp_scroll, 0);
            arrow_button_cd = 4;
        }
    }
}

highlight_tag = -1;
if !button_lock {
    if keyboard_check_pressed(vk_f2) {
        curr_lang++;
        if curr_lang >= language.lastIndex
            curr_lang = 0;
        if file_exists("data.ini") {
            ini_open("data.ini")
            ini_write_real("options","language",curr_lang);
            ini_close();
        }        
        scr_refresh();
    }
    if keyboard_check_pressed(vk_f5) {
        background_enable = !background_enable;
        if file_exists("data.ini") {
            ini_open("data.ini")
            ini_write_real("options","background",background_enable);
            ini_close();
        }
    }

    if help_box_open {
        if keyboard_check_pressed(vk_anykey)
            help_box_open = 0;
    } else if keyboard_check_pressed(vk_f1) {
        if !filter_box_open
            help_box_open = 1;
    }
    
    if filter_box_open {
        if keyboard_check_pressed(vk_space)
            filter_box_open = 0;
        box_ui_x = 320;
        box_ui_y = 320;
        sep_x = 900
        for(i=0;i<tag_filter_amount;i++) {
            tmp_x_cen = box_ui_x+75+(i%2)*sep_x;
            tmp_y_cen = box_ui_y+60+(i div 2)*100
            if mouse_area(tmp_x_cen-50,tmp_y_cen-50,tmp_x_cen+800,tmp_y_cen+50) {
                highlight_tag = i;
                if mouse_check_button_pressed(mb_left) {
                    tag_filter_disable[i] = 0;
                    tag_filter_enable[i] = !tag_filter_enable[i]
                    scr_refresh();
                    break;
                }
                if mouse_check_button_pressed(mb_right) {
                    tag_filter_enable[i] = 0;
                    tag_filter_disable[i] = !tag_filter_disable[i]
                    scr_refresh();
                    break;
                }
            }
        }

        tmp_x_cen = box_ui_x+75+(50%2)*sep_x;
        tmp_y_cen = box_ui_y+60+(50 div 2)*100
        if mouse_area(tmp_x_cen-50,tmp_y_cen-50,tmp_x_cen+800,tmp_y_cen+50) {
            if mouse_check_button_pressed(mb_left) {
                tag_filter_mode = !tag_filter_mode
                scr_refresh();
            }
        }

        tmp_x_cen = box_ui_x+75+(51%2)*sep_x;
        tmp_y_cen = box_ui_y+60+(51 div 2)*100
        if mouse_area(tmp_x_cen-50,tmp_y_cen-50,tmp_x_cen+800,tmp_y_cen+50) {
            if mouse_check_button_pressed(mb_left) {
                for(i=0;i<tag_filter_amount;i++) {
                    tag_filter_enable[i] = 0;
                    tag_filter_disable[i] = 0;
                }
                scr_refresh();
            }
        }
    } else if keyboard_check_pressed(vk_space) {
        filter_box_open = 1;
    }
}

if arrow_button_cd > 0
    arrow_button_cd--;

