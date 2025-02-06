draw_set_font(FnDescFont);
draw_set_halign(fa_left);
draw_set_valign(fa_center);

if draw_mode = 0 {
    draw_text_colour(20,30,string_hash_to_newline(reference_title[curr_lang]),c_black,c_black,c_black,c_black,1);
    if (background_enable)
        draw_sprite_ext(SprBack,0,0,0,1,1,0,image_blend,0.25);
    if (highlight_list > -1 || highlight_selection > -1) {
        tmp = max(highlight_list, highlight_selection);
        if list_mode = 0 || highlight_selection > -1 {
            draw_sprite_ext(charIcon[tmp],pic_mode,180,3360, 1.5/(1+pic_scale*pic_mode), 1.5/(1+pic_scale*pic_mode), 0, image_blend, 1);
            draw_text_ext_colour(330,3360,string_hash_to_newline(charTitle[tmp,curr_lang]),60,410,c_black,c_black,c_black,c_black,1);
            draw_text_ext_colour(740,3360,string_hash_to_newline(charDesc[tmp,curr_lang]),60,1700,c_black,c_black,c_black,c_black,1);
        } else if list_mode = 1 {
            draw_sprite_ext(travellerIcon[tmp],pic_mode,180,3360, 1.5/(1+pic_scale*pic_mode), 1.5/(1+pic_scale*pic_mode), 0, image_blend, 1);
            draw_text_ext_colour(330,3360,string_hash_to_newline(travellerTitle[tmp,curr_lang]),60,410,c_black,c_black,c_black,c_black,1);
            draw_text_ext_colour(740,3360,string_hash_to_newline(travellerDesc[tmp,curr_lang]),60,1700,c_black,c_black,c_black,c_black,1);
        } else if list_mode = 2 {
            draw_sprite_ext(fabledIcon[tmp],pic_mode,180,3360, 1.5/(1+pic_scale*pic_mode), 1.5/(1+pic_scale*pic_mode), 0, image_blend, 1);
            draw_text_ext_colour(330,3360,string_hash_to_newline(fabledTitle[tmp,curr_lang]),60,410,c_black,c_black,c_black,c_black,1);
            draw_text_ext_colour(740,3360,string_hash_to_newline(fabledDesc[tmp,curr_lang]),60,1700,c_black,c_black,c_black,c_black,1);
        }
    }
    if (highlight_tag > -1) {
        draw_text_ext_colour(330,3360,string_hash_to_newline(tag_filter_desc[highlight_tag,curr_lang]),60,1700,c_black,c_black,c_black,c_black,1);
    }
    draw_line_width_colour(0,3240,2480,3240,15,c_black,c_black);
    draw_line_width_colour(965,0,965,3240,15,c_black,c_black);
    
    for(i=0; i<=charGroup.demon; i++) {
        if (pick_group_amount[i]) {
            for(j=0; j<pick_group_amount[i]; j++) {
                draw_sprite_ext(charIcon[pick_group_select[i,j]],pic_mode,ui_icon_x+(j%9)*150,ui_icon_y+(j div 9)*150+460*i,1/(1+pic_scale*pic_mode),1/(1+pic_scale*pic_mode),0,image_blend,1);
                tmp_jynx_draw = 0;
                tmp_jynx_draw_icon = SprDjinn;
                for(k=0; k<=charGroup.demon; k++)
                    for(l=0; l<pick_group_amount[k]; l++) {
                        if scr_jynxed(pick_group_select[i, j],pick_group_select[k, l]) {
                            if tmp_jynx_draw = 0 {
                                tmp_jynx_draw = 1;
                                tmp_jynx_draw_icon = charIcon[pick_group_select[k, l]];
                            } else if tmp_jynx_draw = 1 {
                                tmp_jynx_draw = 2;
                                tmp_jynx_draw_icon = SprDjinn;
                            }
                        }
                    }
                if (tmp_jynx_draw)
                    draw_sprite_ext(tmp_jynx_draw_icon,pic_mode,ui_icon_x+(j%9)*150+50,ui_icon_y+(j div 9)*150+460*i+50,0.4/(1+pic_scale*pic_mode),0.4/(1+pic_scale*pic_mode),0,image_blend,1);
            }
        }
    }
    
    for(i=0; i<list_max && i<list_size; i++) {
        switch(list_mode) {
        
            case 0:
                draw_sprite_ext(charIcon[filter_list[i+scroll]],pic_mode,150,200+i*150,1/(1+pic_scale*pic_mode),1/(1+pic_scale*pic_mode),0,image_blend,1);
                draw_text_colour(300,200+i*150,string_hash_to_newline(charTitle[filter_list[i+scroll],curr_lang]),c_black,c_black,c_black,c_black,1)
                if scr_char_picked(filter_list[i+scroll])
                    draw_sprite_ext(SprUiTick,0,850,200+i*150,1,1,0,image_blend,1)
                if i+scroll+1 < list_size && group[filter_list[i+scroll+1]] != group[filter_list[i+scroll]]
                    draw_line_width_colour(100,200+i*150+75,500,200+i*150+75,10,c_black,c_black)
            break;
            
            case 1:
                draw_sprite_ext(travellerIcon[filter_list[i+scroll]],pic_mode,150,200+i*150,1/(1+pic_scale*pic_mode),1/(1+pic_scale*pic_mode),0,image_blend,1);
                draw_text_colour(300,200+i*150,string_hash_to_newline(travellerTitle[filter_list[i+scroll],curr_lang]),c_black,c_black,c_black,c_black,1)
                if traveller_pick[filter_list[i+scroll]]
                    draw_sprite_ext(SprUiTick,0,850,200+i*150,1,1,0,image_blend,1)
            break;
            
            case 2:
                draw_sprite_ext(fabledIcon[filter_list[i+scroll]],pic_mode,150,200+i*150,1/(1+pic_scale*pic_mode),1/(1+pic_scale*pic_mode),0,image_blend,1);
                draw_text_colour(300,200+i*150,string_hash_to_newline(fabledTitle[filter_list[i+scroll],curr_lang]),c_black,c_black,c_black,c_black,1)
                if fabled_pick[filter_list[i+scroll]]
                    draw_sprite_ext(SprUiTick,0,850,200+i*150,1,1,0,image_blend,1)
            break;
        }
    }
    
    for(i=0; i<=setName.experimental; i++) {
        draw_rectangle_colour(ui_x,ui_y + (box_size*1.5)*i,ui_x+box_size,ui_y+box_size + (box_size*1.5)*i,c_black,c_black,c_black,c_black,0);
        draw_rectangle_colour(ui_x+12,ui_y+12 + (box_size*1.5)*i,ui_x+box_size-12,ui_y-12+box_size + (box_size*1.5)*i,c_white,c_white,c_white,c_white,0);
        if filter_set[i]
            draw_sprite_ext(SprUiTick,0,ui_x+box_size/2,ui_y + (box_size*1.5)*i + box_size/3,1,1,0,image_blend,1);
        draw_text_colour(ui_x + box_size + 50, ui_y+box_size*0.5 + (box_size*1.5)*i, string_hash_to_newline(titleSet[i]), c_black, c_black, c_black, c_black, 1);
    }
    
    for(i=0; i<=2; i++) {
        draw_rectangle_colour(ui_x+700,ui_y + (box_size*1.5)*i,ui_x+700+box_size,ui_y+box_size + (box_size*1.5)*i,c_black,c_black,c_black,c_black,0);
        draw_rectangle_colour(ui_x+700+12,ui_y+12 + (box_size*1.5)*i,ui_x+700+box_size-12,ui_y-12+box_size + (box_size*1.5)*i,c_white,c_white,c_white,c_white,0);
        if list_mode = i
            draw_sprite_ext(SprUiTick,0,ui_x+700+box_size/2,ui_y + (box_size*1.5)*i + box_size/3,1,1,0,image_blend,1);
        draw_text_colour(ui_x+700 + box_size + 50, ui_y+box_size*0.5 + (box_size*1.5)*i, string_hash_to_newline(side_char_mode_title[i,curr_lang]), c_black, c_black, c_black, c_black, 1);
    }
    
    
    draw_rectangle_colour(ui_x+700,ui_y + (box_size*1.5)*3,ui_x+700+box_size,ui_y+box_size + (box_size*1.5)*3,c_black,c_black,c_black,c_black,0);
    draw_rectangle_colour(ui_x+700+12,ui_y+12 + (box_size*1.5)*3,ui_x+700+box_size-12,ui_y-12+box_size + (box_size*1.5)*3,c_white,c_white,c_white,c_white,0);
    if amy_order_enable
        draw_sprite_ext(SprUiTick,0,ui_x+700+box_size/2,ui_y + (box_size*1.5)*3 + box_size/3,1,1,0,image_blend,1);
    draw_text_colour(ui_x+700 + box_size + 50, ui_y+box_size*0.5 + (box_size*1.5)*3, string_hash_to_newline(amy_order_title[curr_lang]), c_black, c_black, c_black, c_black, 1);
    
    text = save_text_title[curr_lang]
    if button_lock
        text = wait_text_title[curr_lang]
    
    draw_text_colour(ui_icon_x + 20, ui_icon_y - 130, string_hash_to_newline(picked_characters_title[curr_lang] + string(pick_current) + "/" + string(pick_max)),c_black,c_black,c_black,c_black,1);
    
    draw_text_colour(ui_x + 50, ui_y + box_size*7, string_hash_to_newline(text), c_black, c_black, c_black, c_black, 1);
    
    draw_text_colour(ui_x + 50, ui_y + box_size*9, string_hash_to_newline(erase_button_text[curr_lang]), c_black, c_black, c_black, c_black, 1);
    
    draw_text_colour(ui_x + 570, ui_y + box_size*7, string_hash_to_newline(script_title_title[curr_lang]), c_black, c_black, c_black, c_black, 1);
    draw_text_colour(ui_x + 570, ui_y + box_size*7+60, string_hash_to_newline(script_title), c_black, c_black, c_black, c_black, 1); 
    
    draw_text_colour(ui_x + 770, ui_y + box_size*9, string_hash_to_newline(json_load_button[curr_lang]), c_black, c_black, c_black, c_black, 1);
    
    draw_text_colour(ui_x, ui_y + box_size*11.5, string_hash_to_newline(copypaste_button[curr_lang]), c_black, c_black, c_black, c_black, 0.5)
    
    if help_box_open || filter_box_open {
        draw_rectangle_colour(300,300,__view_get( e__VW.WView, 0 )-300,__view_get( e__VW.HView, 0 )-300,c_black,c_black,c_black,c_black,0);
        draw_rectangle_colour(315,315,__view_get( e__VW.WView, 0 )-315,__view_get( e__VW.HView, 0 )-315,c_ltgray,c_ltgray,c_ltgray,c_ltgray,0);
        box_ui_x = 320;
        box_ui_y = 320;
        sep_x = 900
        if (help_box_open) {
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
            draw_text_ext_colour(box_ui_x+30,box_ui_y+100,string_hash_to_newline(help_full_text[curr_lang]),
             70,1770,c_black,c_black,c_black,c_black,1);
        }
        if (filter_box_open) {
            for(i=0; i<tag_filter_amount; i++) {
                draw_circle_colour(box_ui_x+75+(i%2)*sep_x,box_ui_y+60+(i div 2)*100,25,c_black,c_black,0);
                draw_circle_colour(box_ui_x+75+(i%2)*sep_x,box_ui_y+60+(i div 2)*100,20,c_white,c_white,0);
                if tag_filter_enable[i]
                    draw_sprite_ext(SprUiSmallTick,0,box_ui_x+75+(i%2)*sep_x,box_ui_y+60+(i div 2)*100,1,1,0,image_blend,1);
                if tag_filter_disable[i]
                    draw_sprite_ext(SprUiCross,0,box_ui_x+75+(i%2)*sep_x,box_ui_y+60+(i div 2)*100,1,1,0,image_blend,1);
                draw_text_colour(box_ui_x+150+(i%2)*sep_x,box_ui_y+60+(i div 2)*100,string_hash_to_newline(tag_filter_name[i,curr_lang]),c_black,c_black,c_black,c_black,1);
            }
            tmp_text = tag_filter_mode_title[curr_lang]
            if tag_filter_mode
                tmp_text = tag_filter_mode_title_b[curr_lang]
            draw_text_colour(box_ui_x+150+(50%2)*sep_x,box_ui_y+60+(50 div 2)*100,string_hash_to_newline(tmp_text),c_black,c_black,c_black,c_black,1);
            draw_text_colour(box_ui_x+150+(51%2)*sep_x,box_ui_y+60+(51 div 2)*100,string_hash_to_newline(clear_all_filter_button[curr_lang]),c_black,c_black,c_black,c_black,1);
        }
    }
}

draw_set_font(FnMainFont);
draw_set_halign(fa_left);
draw_set_valign(fa_center);

if draw_mode = 1 {

    pointer_y = 60;
    for(i=0; i<=charGroup.demon; i++) {
        if (pick_group_amount[i]) {
            draw_sprite_ext(titleCardSprite[i],curr_lang,0,pointer_y,1,1,0,image_blend,1);
            if pointer_y = 60 && script_title != "" {
                draw_set_font(FnTitleFont);
                draw_rectangle_colour(180,pointer_y-40,220+string_width(string_hash_to_newline(script_title)),pointer_y+40,c_white,c_white,c_white,c_white,0);
                draw_text_colour(200,pointer_y,string_hash_to_newline(script_title),c_black,c_black,c_black,c_black,1);
                draw_set_font(FnMainFont);
            }
            pointer_y+=100;
            for(j=0; j<pick_group_amount[i]; j++) {
                draw_sprite_ext(charIcon[pick_group_select[i, j]], pic_mode,130,pointer_y,1/(1+pic_scale*pic_mode),1/(1+pic_scale*pic_mode),0,image_blend,1);
                if (string_length(charTitle[pick_group_select[i, j],curr_lang]) >= 18) {
                    draw_set_font(FnMainFontSmaller);
                }
                draw_text_ext_colour(250,pointer_y,string_hash_to_newline(charTitle[pick_group_select[i, j],curr_lang]),60,2480,c_black,c_black,c_black,c_black,1);
                draw_set_font(FnMainFont);
                draw_text_ext_colour(620,pointer_y,string_hash_to_newline(charDesc[pick_group_select[i, j],curr_lang]),50,1820,c_black,c_black,c_black,c_black,1);
                pointer_x = 0;
                for(k=0; k<=charGroup.demon; k++)
                    for(l=0; l<pick_group_amount[k]; l++)
                        if pick_group_select[i, j] < pick_group_select[k, l] && scr_jynxed(pick_group_select[i, j],pick_group_select[k, l]) {
                            draw_sprite_ext(charIcon[pick_group_select[k, l]],pic_mode,300+pointer_x,pointer_y+50,0.4/(1+pic_scale*pic_mode),0.4/(1+pic_scale*pic_mode),0,image_blend,1);
                            pointer_x += 50;
                        }
                if j = pick_group_amount[i]-1
                    pointer_y+=100;
                else
                    pointer_y+=120;
            }
        }
    }

    draw_sprite_ext(SprC,0,100,3470,1,1,0,image_blend,1);
    draw_text_colour(1800,3470,string_hash_to_newline(asterisk_title[curr_lang]),c_black,c_black,c_black,c_black,1);
}

if draw_mode = 2 {
    draw_sprite_ext(SprFirstNight, curr_lang, 1240, 500, 1, 1, 0, image_blend, 1);
    if invert_other_night
        spr = SprOtherNight;
    else
        spr = SprOtherNightInverted
    draw_sprite_ext(spr, curr_lang, 1240, 3000, 1, 1, 0, image_blend, 1);
    
    pointer_y = 80;
    for(i=1; i<first_night_order_array_length; i++) {
        found = 0;
        remove_scale = 1;
        if (i = f_night_minion_info) {
            found = 1;
            spr = SprMinion;
            text = minion_info_text[curr_lang]
            remove_scale = 0;
        } else if (i = f_night_demon_info) {
            found = 1;
            spr = SprDemon;
            text = demon_info_text[curr_lang]
            remove_scale = 0;
        } else if (i = f_night_dawn_order) {
            found = 1;
            spr = SprDawn;
            text = dawn_title[curr_lang]
            remove_scale = 0;
        } else {
            for(j=0; j<4; j++)
                for(k=0; k<pick_group_amount[j]; k++) {
                    if f_night[pick_group_select[j,k]] = i {
                        spr = charIcon[pick_group_select[j,k]];
                        text = charTitle[pick_group_select[j,k],curr_lang];
                        found = 1;
                    }
                }
            for(j=1; j<travellerName.lastChar; j++)
                if traveller_pick[j] && (traveller_f_night[j] = i) {
                        spr = travellerIcon[j];
                        text = travellerTitle[j,curr_lang];
                        found = 1;
                }
        }
        if found {
            draw_sprite_ext(spr, pic_mode, 160, pointer_y, 1/(1+pic_scale*pic_mode*remove_scale), 1/(1+pic_scale*pic_mode*remove_scale), 0, image_blend, 1);
            draw_text_colour(280, pointer_y, string_hash_to_newline(text), c_black, c_black, c_black, c_black, 1);
            pointer_y+=120;
        }
    }
    
    pointer_y = 3427;
    for(i=other_night_order_array_length-1; i>=0; i--) {
        found = 0;
        remove_scale = 1;
        if (i = 0) {
            found = 1;
            spr = SprDusk;
            text = dusk_title[curr_lang]
            remove_scale = 0;
        } else if (i = o_night_dawn_order) {
            found = 1;
            spr = SprDawn;
            text = dawn_title[curr_lang]
            remove_scale = 0;
        } else {
            for(j=0; j<4; j++)
                for(k=0; k<pick_group_amount[j]; k++) {
                    if o_night[pick_group_select[j,k]] = i {
                        spr = charIcon[pick_group_select[j,k]];
                        text = charTitle[pick_group_select[j,k],curr_lang];
                        found = 1;
                    }
                }
            for(j=1; j<travellerName.lastChar; j++)
                if traveller_pick[j] && (traveller_o_night[j] = i) {
                        spr = travellerIcon[j];
                        text = travellerTitle[j,curr_lang];
                        found = 1;
                }
        }
        if found {
            draw_sprite_ext(spr, pic_mode, 1900, pointer_y, 1/(1+pic_scale*pic_mode*remove_scale), 1/(1+pic_scale*pic_mode*remove_scale), 0, image_blend, 1);
            draw_text_colour(2020, pointer_y, string_hash_to_newline(text), c_black, c_black, c_black, c_black, 1);
            pointer_y-=120;
        }
    }
    
    pointer_y = 850;
    jynx_count = 0;
    jynx_max = jynx_init_max;
    
    if scr_has_travellers() {
        jynx_max-=2;
        draw_text_ext_colour(850,pointer_y,string_hash_to_newline(recommended_travellers_title[curr_lang]),50,750,c_black, c_black, c_black, c_black, 1);
        pointer_y += 100;
        pointer_x = 850;
        for(i=1;i<travellerName.lastChar;i++)
            if traveller_pick[i] {
                draw_sprite_ext(travellerIcon[i],pic_mode,pointer_x,pointer_y,0.7/(1+pic_scale*pic_mode),0.7/(1+pic_scale*pic_mode),0,image_blend,1)
                pointer_x+=110;
            }
        pointer_y += 200;
    }
    if scr_has_fabled() {
        jynx_max-=2;
        draw_text_ext_colour(850,pointer_y,string_hash_to_newline(recommended_fabled_title[curr_lang]),50,750,c_black, c_black, c_black, c_black, 1);
        pointer_y += 100;
        pointer_x = 850;
        for(i=0;i<fabledName.lastChar;i++)
            if fabled_pick[i] {
                draw_sprite_ext(fabledIcon[i],pic_mode,pointer_x,pointer_y,0.7/(1+pic_scale*pic_mode),0.7/(1+pic_scale*pic_mode),0,image_blend,1)
                pointer_x+=110;
            }
        pointer_y += 200;
    }
    
    for(i=0; i<4; i++)
        for(j=0; j<pick_group_amount[i]; j++)
            for(k=0; k<4; k++)
                for(l=0; l<pick_group_amount[k]; l++) {
                    if pick_group_select[i,j] < pick_group_select[k,l] && scr_jynxed(pick_group_select[i,j],pick_group_select[k,l]) {
                        if jynx_count < jynx_max {
                            draw_sprite_ext(charIcon[pick_group_select[i,j]],pic_mode,800,pointer_y,1/(1+pic_scale*pic_mode),1/(1+pic_scale*pic_mode),0,image_blend,1)
                            draw_sprite_ext(charIcon[pick_group_select[k,l]],pic_mode,920,pointer_y,1/(1+pic_scale*pic_mode),1/(1+pic_scale*pic_mode),0,image_blend,1)
                            draw_text_ext_colour(1020,pointer_y,string_hash_to_newline(scr_jynxed_desc(pick_group_select[i,j],pick_group_select[k,l])),50,750,c_black, c_black, c_black, c_black, 1);
                            pointer_y += 150;
                        }
                        jynx_count++;
                    }
                }
    if jynx_count >= jynx_max+1 {
        draw_text_ext_colour(920,pointer_y,string_hash_to_newline(not_included_jynx_title[curr_lang]+string(jynx_count-13)),50,900,c_black, c_black, c_black, c_black, 1);
    }
    
    draw_sprite_ext(SprC,0,100,3470,1,1,0,image_blend,1);
}

if draw_mode = 3 {

    draw_set_font(FnMainFont);
    pointer_y = 60;
    draw_sprite_ext(SprTravellers,1,0,pointer_y,1,1,0,image_blend,1);
    pointer_y+=100;
    for(i=1; i<travellerName.lastChar; i++) {
        draw_sprite_ext(travellerIcon[i], pic_mode, 130,pointer_y,1/(1+pic_scale*pic_mode),1/(1+pic_scale*pic_mode),0,image_blend,1);
        draw_text_ext_colour(250,pointer_y,string_hash_to_newline(travellerTitle[i,curr_lang]),60,2480,c_black,c_black,c_black,c_black,1);
        draw_text_ext_colour(620,pointer_y,string_hash_to_newline(travellerDesc[i,curr_lang]),50,1820,c_black,c_black,c_black,c_black,1);
        pointer_y+=120;
    }

    draw_sprite_ext(SprC,0,100,3470,1,1,0,image_blend,1);
    draw_text_colour(1800,3470,string_hash_to_newline(asterisk_title[curr_lang]),c_black,c_black,c_black,c_black,1);
}

if draw_mode = 4 {

    draw_set_font(FnMainFont);
    pointer_y = 60;
    draw_sprite_ext(SprFabled,1,0,pointer_y,1,1,0,image_blend,1);
    pointer_y+=100;
    for(i=0; i<fabledName.lastChar; i++) {
        draw_sprite_ext(fabledIcon[i], pic_mode, 130,pointer_y,1/(1+pic_scale*pic_mode),1/(1+pic_scale*pic_mode),0,image_blend,1);
        draw_text_ext_colour(250,pointer_y,string_hash_to_newline(fabledTitle[i,curr_lang]),60,2480,c_black,c_black,c_black,c_black,1);
        draw_text_ext_colour(620,pointer_y,string_hash_to_newline(fabledDesc[i,curr_lang]),50,1820,c_black,c_black,c_black,c_black,1);
        pointer_y+=120;
    }

    draw_sprite_ext(SprC,0,100,3470,1,1,0,image_blend,1);
    draw_text_colour(1800,3470,string_hash_to_newline(asterisk_title[curr_lang]),c_black,c_black,c_black,c_black,1);
}

