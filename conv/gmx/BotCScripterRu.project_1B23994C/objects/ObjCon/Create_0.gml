/// @description  Core creation code

// load ini

script_title = "";
curr_lang = 0;
background_enable = 1;
pic_mode = 1; // 0 - old pics, 1 - new pics

save_slot = 0;
if file_exists("data.ini") {
    ini_open("data.ini")
    save_slot = ini_read_real("data","save",save_slot);
    curr_lang = ini_read_real("options","language",curr_lang);
    background_enable = ini_read_real("options","background",background_enable);
} else {
    ini_open("data.ini")
    ini_write_real("data","save",save_slot);
    ini_write_real("options","language",curr_lang);
    ini_write_real("options","background",background_enable);
}
ini_close();

// all fonts
draw_set_font(FnMainFont);
draw_set_halign(fa_left);
draw_set_valign(fa_center);

// general vars
draw_mode = 0; // 0 - choosing, 1 - first page, 2 - second page
amy_order_enable = 1; // 0 - off, 1 - on
button_lock = 0;
filter_box_open = 0; // tag filters
help_box_open = 0; // help
invert_other_night = 0; // 0 - not inverted, 1 - invert for print
fable_offset = -500;
arrow_button_cd = 0;
pic_scale = 1.8;
base_random_amount[0] = 13;
base_random_amount[1] = 4;
base_random_amount[2] = 4;
base_random_amount[3] = 4;

// filter list and selection
highlight_list = -1;
highlight_selection = -1;
filter_list[0] = 0;
list_pick[0] = 0;
list_size = 0;
list_max = 20;
list_mode = 0; // 0 - chars, 1 - travellers, 2 - fabled
scroll = 0;
scroll_max = 0;
side_chars_max = 8;

ui_icon_x = 1100;
ui_icon_y = 1550;

ui_x = 1100;
ui_y = 100;
box_size = 100;

// picks
jynx_init_max = 13;
pick_max = 25;
pick_current = 0;
for(i=0; i<4; i++) {
    pick_group_amount[i] = 0;
    for(j=0; j<pick_max; j++)
        pick_group_select[i,j] = 0;
}

group_title_card[charGroup.townsfolk] = SprTownsfolk;
group_title_card[charGroup.outsider] = SprOutsiders;
group_title_card[charGroup.minion] = SprMinions;
group_title_card[charGroup.demon] = SprDemons;

/// Enum


enum charName {
    baron,
    butler,
    chef,
    drunk,
    empath,
    fortuneteller,
    imp,
    investigator,
    librarian,
    mayor,
    monk,
    poisoner,
    ravenkeeper,
    recluse,
    saint,
    scarletwoman,
    slayer,
    soldier,
    spy,
    undertaker,
    virgin,
    washerwoman,
    assassin,
    chambermaid,
    courtier,
    devilsadvocate,
    exorcist,
    fool,
    gambler,
    godfather,
    goon,
    gossip,
    grandmother,
    innkeeper,
    lunatic,
    mastermind,
    minstrel,
    moonchild,
    pacifist,
    po,
    professor,
    pukka,
    sailor,
    shabaloth,
    tealady,
    tinker,
    zombuul,
    artist,
    barber,
    cerenovus,
    clockmaker,
    dreamer,
    eviltwin,
    fanggu,
    flowergirl,
    juggler,
    klutz,
    mathematician,
    mutant,
    nodashii,
    oracle,
    philosopher,
    pithag,
    sage,
    savant,
    seamstress,
    snakecharmer,
    sweetheart,
    towncrier,
    vigormortis,
    vortox,
    witch,
    acrobat,
    alchemist,
    alhadikhia,
    amnesiac,
    atheist,
    balloonist,
    boomdandy,
    bountyhunter,
    cannibal,
    choirboy,
    cultleader,
    damsel,
    engineer,
    farmer,
    fearmonger,
    fisherman,
    general,
    goblin,
    golem,
    heretic,
    huntsman,
    king,
    legion,
    leviathan,
    lilmonsta,
    lleech,
    lycanthrope,
    magician,
    marionette,
    mezepheles,
    nightwatchman,
    noble,
    organgrinder,
    pixie,
    politician,
    poppygrower,
    preacher,
    psychopath,
    puzzlemaster,
    riot,
    snitch,
    vizier,
    knight,
    steward,
    highPriestess,
    harpy,
    plagueDoctor,
    shugenja,
    ojo,
    hatter,
    kazali,
    village_idiot,
    yaggababble,
    widow,
    banshee,
    ogre,
    summoner,
    lastChar
};

enum language {
    russian,
    english,
    lastIndex
};

enum fabledName {
    angel,
    buddhist,
    djinn,
    doomsayer,
    duchess,
    fibbin,
    fiddler,
    hellslibrarian,
    revolutionary,
    sentinel,
    spiritofivory,
    stormcatcher,
    toymaker,
    gardener,
    ferryman,
    bootlegger,
    lastChar
}

enum travellerName {
    blank,
    apprentice,
    barista,
    beggar,
    bishop,
    bonecollector,
    bureaucrat,
    butcher,
    deviant,
    gangster,
    gunslinger,
    harlot,
    judge,
    matron,
    scapegoat,
    thief,
    voudon,
    lastChar
}

for(i = 0; i <= charName.lastChar; i++) {
    for(j = i+1; j <= charName.lastChar; j++) {
        jynx_marker[i,j] = 0;
        jynx_eng_desc[i,j] = "";
        jynx_ru_desc[i,j] = "";
    }
}

enum setName {
    troubleBrewing,
    badMoonRising,
    sectsAndViolets,
    experimental
};

enum charGroup {
    townsfolk,
    outsider,
    minion,
    demon
};

enum amyOrder {
    firstNight,
    firstAndEveryNight,
    everyNight,
    everyNightAsterisk,
    dayActions,
    dayOncePerGame,
    oncePerGame,
    triggerOncePerGame,
    passive
};

titleCardSprite[charGroup.townsfolk] = SprTownsfolk;
titleCardSprite[charGroup.outsider] = SprOutsiders;
titleCardSprite[charGroup.minion] = SprMinions;
titleCardSprite[charGroup.demon] = SprDemons;

titleSet[setName.troubleBrewing] = "Trouble Brewing";
titleSet[setName.badMoonRising] = "Bad Moon Rising";
titleSet[setName.sectsAndViolets] = "Sects & Violets";
titleSet[setName.experimental] = "Experimental";

/// System texts

side_char_mode_title[0,language.russian] = "Стандартные";
side_char_mode_title[1,language.russian] = "Путники";
side_char_mode_title[2,language.russian] = "Сказки";

side_char_mode_title[0,language.english] = "Standard";
side_char_mode_title[1,language.english] = "Travellers";
side_char_mode_title[2,language.english] = "Fabled";

get_string_title[language.russian] = "Назовите свой сценарий";
get_string_title[language.english] = "Name your script";

reference_title[language.russian] = "F1 - СПРАВКА";
reference_title[language.english] = "F1 - REFERENCE GUIDE";

amy_order_title[language.russian] = "Порядок Эми";
amy_order_title[language.english] = "Amy Order";

save_text_title[language.russian] = "СОХРАНИТЬ"
save_text_title[language.english] = "SAVE"
wait_text_title[language.russian] = "ПОДОЖДИТЕ..."
wait_text_title[language.english] = "WAIT..."

picked_characters_title[language.russian] = "Выбранные персонажи   ";
picked_characters_title[language.english] = "Characters picked     ";

erase_button_text[language.russian] = "ОЧИСТИТЬ";
erase_button_text[language.english] = "CLEAR";

script_title_title[language.russian] = "НАЗВАНИЕ СЦЕНАРИЯ:";
script_title_title[language.english] = "SCRIPT NAME:";

clear_all_filter_button[language.russian] = "Сбросить фильтры";
clear_all_filter_button[language.english] = "Clear filters"

json_load_button[language.russian] = "ЗАГРУЗИТЬ JSON";
json_load_button[language.english] = "LOAD JSON";

copypaste_button[language.russian] = "%appdata%\\BotCScripterRu  <= сохраняется сюда#кликните, чтобы скопировать путь";
copypaste_button[language.english] = "%appdata%\\BotCScripterRu  <= saved here#click to copy directory";

help_full_text[language.russian] = "Открыть дополнительные фильтры: Пробел##На дополнительные фильтры можно нажимать ПКМ - это означает не включать в поиск##Чтобы получить распечатку способностей Сказок и Путников - ПКМ по ним в основных фильтрах##Чтобы собрать основные сценарии - ПКМ по их названиям в фильтрах##Если у иконки персонажа в основной области маленькая иконка в углу - у вас в сценарии будут правила Джина##Если выбирать Сказки и Путников - они будут добавлены как рекоммендованные в ночной порядок##ПКМ по экспериментальной категории - абсолютно случайный сценарий##Убрать задник: F5##ПОМЕНЯТЬ ЯЗЫК: F2";
help_full_text[language.english] = "Open tag filter: SPACE##Tag filters may be clicked with RMB to exclude them from searching##You can make Travellers and Fabled Sheets by clicking RMB on their filters##To make basic scripts, click RMB on basic script name filter##If there are small icons besides character icons on the main assembly screen, then these characters will have Djinn jynx##Picking Travellers and Fabled adds them to the sheet as recommended (Travellers will be added to night order too)##RMB click on experimental category to generate random script##Remove background: F5##LANGUAGE CHANGE: F2";

tag_filter_mode_title[language.russian] = "Режим: хотя бы один";
tag_filter_mode_title[language.english] = "Mode: at least one tag";
tag_filter_mode_title_b[language.russian] = "Режим: одновременно";
tag_filter_mode_title_b[language.english] = "Mode: has all tags";

asterisk_title[language.russian] = "*каждая ночь, кроме первой";
asterisk_title[language.english] = "*not the first night";

minion_info_text[language.russian] = "Информация для приспешников";
minion_info_text[language.english] = "Minion info";
demon_info_text[language.russian] = "Информация для демона";
demon_info_text[language.english] = "Demon info";

dawn_title[language.english] = "Dawn";
dawn_title[language.russian] = "Рассвет";
dusk_title[language.english] = "Dusk";
dusk_title[language.russian] = "Закат";

random_title[language.english] = "Embrace the Chaos";
random_title[language.russian] = "Восславим Хаос";

recommended_travellers_title[language.russian] = "Рекомендуемые Путники:";
recommended_travellers_title[language.english] = "Recommended Travellers:";
recommended_fabled_title[language.russian] = "Рекомендуемые Сказки:";
recommended_fabled_title[language.english] = "Recommended Fabled:";

not_included_jynx_title[language.russian] = "Не перечисленных сглазов: ";
not_included_jynx_title[language.english] = "Not listed jynxes: ";

/// Trouble Brewing

charCode[charName.baron] = "baron"
charIcon[charName.baron] = SprBaron
charTitle[charName.baron,language.russian]= "Барон";
charDesc[charName.baron,language.russian] = "В игре дополнительные Посторонние. [+2 Посторонних]"
charTitle[charName.baron,language.english] = "Baron"
charDesc[charName.baron,language.english] = "There are extra Outsiders in play. [+2 Outsiders]"
charSet[charName.baron] = setName.troubleBrewing;
group[charName.baron] = charGroup.minion;
f_night[charName.baron] = 0;
o_night[charName.baron] = 0;
amy_order[charName.baron] = amyOrder.passive

charCode[charName.butler] = "butler"
charIcon[charName.butler] = SprButler
charTitle[charName.butler,language.russian] = "Дворецкий"
charDesc[charName.butler,language.russian] = "Каждую ночь вы выбираете игрока (не себя). Следующим днём можете голосовать только если выбранный игрок голосует."
charTitle[charName.butler,language.english] = "Butler"
charDesc[charName.butler,language.english] = "Each night, choose a player (not yourself): tomorrow, you may only vote if they are voting too."
charSet[charName.butler] = setName.troubleBrewing;
group[charName.butler] = charGroup.outsider;
f_night[charName.butler] = 38;
o_night[charName.butler] = 66;
amy_order[charName.butler] = amyOrder.everyNight

charCode[charName.chef] = "chef"
charIcon[charName.chef] = SprChef
charTitle[charName.chef,language.russian] = "Шеф"
charDesc[charName.chef,language.russian] = "В начале вы знаете, сколько пар Злодеев в игре."
charTitle[charName.chef,language.english] = "Chef";
charDesc[charName.chef,language.english] = "You start knowing how many pairs of evil players there are.";
charSet[charName.chef] = setName.troubleBrewing;
group[charName.chef] = charGroup.townsfolk;
f_night[charName.chef] = 35;
o_night[charName.chef] = 0;
amy_order[charName.chef] = amyOrder.firstNight

charCode[charName.drunk] = "drunk"
charIcon[charName.drunk] = SprDrunk
charTitle[charName.drunk,language.russian] = "Пьяница"
charDesc[charName.drunk,language.russian] = "Вы не знаете, что вы пьяница. Вы думаете, что вы конкретный горожанин, но это не так."
charTitle[charName.drunk,language.english] = "Drunk";
charDesc[charName.drunk,language.english] = "You do not know you are the Drunk. You think you are a Townsfolk character, but you are not.";
charSet[charName.drunk] = setName.troubleBrewing;
group[charName.drunk] = charGroup.outsider;
f_night[charName.drunk] = 0;
o_night[charName.drunk] = 0;
amy_order[charName.drunk] = amyOrder.passive

charCode[charName.empath] = "empath"
charIcon[charName.empath] = SprEmpath
charTitle[charName.empath,language.russian] = "Эмпат"
charDesc[charName.empath,language.russian] = "Каждую ночь вы узнаёте, сколько Злодеев среди ваших двух живых соседей."
charTitle[charName.empath,language.english] = "Empath";
charDesc[charName.empath,language.english] = "Each night, you learn how many of your 2 alive neighbours are evil.";
charSet[charName.empath] = setName.troubleBrewing;
group[charName.empath] = charGroup.townsfolk;
f_night[charName.empath] = 36;
o_night[charName.empath] = 52;
amy_order[charName.empath] = amyOrder.everyNight

charCode[charName.fortuneteller] = "fortune_teller"
charIcon[charName.fortuneteller] = SprFortuneTeller
charTitle[charName.fortuneteller,language.russian] = "Предсказатель"
charDesc[charName.fortuneteller,language.russian] = "Каждую ночь вы выбираете двоих игроков и узнаёте, есть ли среди них Демон. Есть один Добрый игрок, которого вы также видите как Демона."
charTitle[charName.fortuneteller,language.english] = "Fortune Teller";
charDesc[charName.fortuneteller,language.english] = "Each night, choose 2 players: you learn if either is a Demon. There is a good player that registers as a Demon to you.";
charSet[charName.fortuneteller] = setName.troubleBrewing;
group[charName.fortuneteller] = charGroup.townsfolk;
f_night[charName.fortuneteller] = 37;
o_night[charName.fortuneteller] = 53;
amy_order[charName.fortuneteller] = amyOrder.everyNight

charCode[charName.imp] = "imp"
charIcon[charName.imp] = SprImp
charTitle[charName.imp,language.russian] = "Чёрт"
charDesc[charName.imp,language.russian] = "Каждую ночь* вы выбираете игрока. Этот игрок умирает. Если вы убиваете таким образом себя, приспешник становится Чёртом."
charTitle[charName.imp,language.english] = "Imp";
charDesc[charName.imp,language.english] = "Each night*, choose a player: they die. If you kill yourself this way, a Minion becomes the Imp.";
charSet[charName.imp] = setName.troubleBrewing;
group[charName.imp] = charGroup.demon;
f_night[charName.imp] = 0;
o_night[charName.imp] = 23;
amy_order[charName.imp] = amyOrder.everyNightAsterisk

charCode[charName.investigator] = "investigator"
charIcon[charName.investigator] = SprInvestigator
charTitle[charName.investigator,language.russian] = "Следователь"
charDesc[charName.investigator,language.russian] = "В начале вы знаете, что один из двух игроков - конкретный Приспешник."
charTitle[charName.investigator,language.english] = "Investigator";
charDesc[charName.investigator,language.english] = "You start knowing that 1 of 2 players is a particular Minion.";
charSet[charName.investigator] = setName.troubleBrewing;
group[charName.investigator] = charGroup.townsfolk;
f_night[charName.investigator] = 34;
o_night[charName.investigator] = 0;
amy_order[charName.investigator] = amyOrder.firstNight

charCode[charName.librarian] = "librarian"
charIcon[charName.librarian] = SprLibrarian
charTitle[charName.librarian,language.russian] = "Библиотекарь"
charDesc[charName.librarian,language.russian] = "В начале вы знаете, что один из двух игроков - конкретный Посторонний. (Или что их нет)"
charTitle[charName.librarian,language.english] = "Librarian";
charDesc[charName.librarian,language.english] = "You start knowing that 1 of 2 players is a particular Outsider. (Or that zero are in play.)";
charSet[charName.librarian] = setName.troubleBrewing;
group[charName.librarian] = charGroup.townsfolk;
f_night[charName.librarian] = 33;
o_night[charName.librarian] = 0;
amy_order[charName.librarian] = amyOrder.firstNight

charCode[charName.mayor] = "mayor"
charIcon[charName.mayor] = SprMayor
charTitle[charName.mayor,language.russian] = "Мэр"
charDesc[charName.mayor,language.russian] = "Если не произошла казнь и в конце дня только 3 игрока живы, вы и ваша команда побеждаете. Если вы умираете ночью, вместо вас может умереть кто-то другой."
charTitle[charName.mayor,language.english] = "Mayor";
charDesc[charName.mayor,language.english] = "If only 3 players live & no execution occurs, your team wins. If you die at night, another player might die instead.";
charSet[charName.mayor] = setName.troubleBrewing;
group[charName.mayor] = charGroup.townsfolk;
f_night[charName.mayor] = 0;
o_night[charName.mayor] = 0;
amy_order[charName.mayor] = amyOrder.passive

charCode[charName.monk] = "monk"
charIcon[charName.monk] = SprMonk
charTitle[charName.monk,language.russian] = "Монах"
charDesc[charName.monk,language.russian] = "Каждую ночь* вы выбираете игрока (не себя), этому игроку не может навредить Демон."
charTitle[charName.monk,language.english] = "Monk";
charDesc[charName.monk,language.english] = "Each night*, choose a player (not yourself): they are safe from the Demon tonight.";
charSet[charName.monk] = setName.troubleBrewing;
group[charName.monk] = charGroup.townsfolk;
f_night[charName.monk] = 0;
o_night[charName.monk] = 11;
amy_order[charName.monk] = amyOrder.everyNightAsterisk

charCode[charName.poisoner] = "poisoner"
charIcon[charName.poisoner] = SprPoisoner
charTitle[charName.poisoner,language.russian] = "Отравитель"
charDesc[charName.poisoner,language.russian] = "Каждую ночь выбираете игрока. Он отравлен ночью и до конца дня."
charTitle[charName.poisoner,language.english] = "Poisoner";
charDesc[charName.poisoner,language.english] = "Each night, choose a player: they are poisoned tonight and tomorrow day.";
charSet[charName.poisoner] = setName.troubleBrewing;
group[charName.poisoner] = charGroup.minion;
f_night[charName.poisoner] = 16;
o_night[charName.poisoner] = 6;
amy_order[charName.poisoner] = amyOrder.everyNight

charCode[charName.ravenkeeper] = "ravenkeeper"
charIcon[charName.ravenkeeper] = SprRavenkeeper
charTitle[charName.ravenkeeper,language.russian] = "Хозяин ворона"
charDesc[charName.ravenkeeper,language.russian] = "Если вы умираете ночью, вы просыпаетесь и выбираете игрока. Узнайте, какой у него персонаж."
charTitle[charName.ravenkeeper,language.english] = "Ravenkeeper";
charDesc[charName.ravenkeeper,language.english] = "If you die at night, you are woken to choose a player: you learn their character.";
charSet[charName.ravenkeeper] = setName.troubleBrewing;
group[charName.ravenkeeper] = charGroup.townsfolk;
f_night[charName.ravenkeeper] = 0;
o_night[charName.ravenkeeper] = 51;
amy_order[charName.ravenkeeper] = amyOrder.triggerOncePerGame

charCode[charName.recluse] = "recluse"
charIcon[charName.recluse] = SprRecluse
charTitle[charName.recluse,language.russian] = "Отшельник"
charDesc[charName.recluse,language.russian] = "Вас можно посчитать Злодеем, Приспешником или Демоном, даже если вы мертвы."
charTitle[charName.recluse,language.english] = "Recluse";
charDesc[charName.recluse,language.english] = "You might register as evil & as a Minion or Demon, even if dead.";
charSet[charName.recluse] = setName.troubleBrewing;
group[charName.recluse] = charGroup.outsider;
f_night[charName.recluse] = 0;
o_night[charName.recluse] = 0;
amy_order[charName.recluse] = amyOrder.passive

charCode[charName.saint] = "saint"
charIcon[charName.saint] = SprSaint
charTitle[charName.saint,language.russian] = "Святой"
charDesc[charName.saint,language.russian] = "Если вас казнят, ваша команда проигрывает."
charTitle[charName.saint,language.english] = "Saint";
charDesc[charName.saint,language.english] = "If you die by execution, your team loses.";
charSet[charName.saint] = setName.troubleBrewing;
group[charName.saint] = charGroup.outsider;
f_night[charName.saint] = 0;
o_night[charName.saint] = 0;
amy_order[charName.saint] = amyOrder.passive

charCode[charName.scarletwoman] = "scarlet_woman"
charIcon[charName.scarletwoman] = SprScarletWoman
charTitle[charName.scarletwoman,language.russian] = "Алая дама"
charDesc[charName.scarletwoman,language.russian] = "Если в игре 5+ игроков живы и Демон умер, вы становитесь Демоном. (Путники не считаются)"
charTitle[charName.scarletwoman,language.english] = "Scarlet Woman";
charDesc[charName.scarletwoman,language.english] = "If there are 5 or more players alive & the Demon dies, you become the Demon. (Travellers don't count)";
charSet[charName.scarletwoman] = setName.troubleBrewing;
group[charName.scarletwoman] = charGroup.minion;
f_night[charName.scarletwoman] = 0;
o_night[charName.scarletwoman] = 16;
amy_order[charName.scarletwoman] = amyOrder.passive

charCode[charName.slayer] = "slayer"
charIcon[charName.slayer] = SprSlayer
charTitle[charName.slayer,language.russian] = "Убийца демонов"
charDesc[charName.slayer,language.russian] = "Один раз за игру, днём, публично можете выбрать игрока. Если это Демон - он умирает."
charTitle[charName.slayer,language.english] = "Slayer";
charDesc[charName.slayer,language.english] = "Once per game, during the day, publicly choose a player: if they are the Demon, they die.";
charSet[charName.slayer] = setName.troubleBrewing;
group[charName.slayer] = charGroup.townsfolk;
f_night[charName.slayer] = 0;
o_night[charName.slayer] = 0;
amy_order[charName.slayer] = amyOrder.dayOncePerGame

charCode[charName.soldier] = "soldier"
charIcon[charName.soldier] = SprSoldier
charTitle[charName.soldier,language.russian] = "Солдат"
charDesc[charName.soldier,language.russian] = "Демон не может навредить вам."
charTitle[charName.soldier,language.english] = "Soldier";
charDesc[charName.soldier,language.english] = "You are safe from the Demon.";
charSet[charName.soldier] = setName.troubleBrewing;
group[charName.soldier] = charGroup.townsfolk;
f_night[charName.soldier] = 0;
o_night[charName.soldier] = 0;
amy_order[charName.soldier] = amyOrder.passive

charCode[charName.spy] = "spy"
charIcon[charName.spy] = SprSpy
charTitle[charName.spy,language.russian] = "Шпион"
charDesc[charName.spy,language.russian] = "Вас можно посчитать Добрым, Горожанином или Посторонним, даже если мертвы. Каждую ночь вы смотрите Гримуар."
charTitle[charName.spy,language.english] = "Spy";
charDesc[charName.spy,language.english] = "Each night, you see the Grimoire. You might register as good & as a Townsfolk or Outsider, even if dead.";
charSet[charName.spy] = setName.troubleBrewing;
group[charName.spy] = charGroup.minion;
f_night[charName.spy] = 50;
o_night[charName.spy] = 67;
amy_order[charName.spy] = amyOrder.everyNight

charCode[charName.undertaker] = "undertaker"
charIcon[charName.undertaker] = SprUndertaker
charTitle[charName.undertaker,language.russian] = "Гробовщик"
charDesc[charName.undertaker,language.russian] = "Каждую ночь* вы узнаёте какой персонаж днём умер от казни."
charTitle[charName.undertaker,language.english] = "Undertaker";
charDesc[charName.undertaker,language.english] = "Each night*, you learn which character died by execution today.";
charSet[charName.undertaker] = setName.troubleBrewing;
group[charName.undertaker] = charGroup.townsfolk;
f_night[charName.undertaker] = 0;
o_night[charName.undertaker] = 54;
amy_order[charName.undertaker] = amyOrder.everyNightAsterisk

charCode[charName.virgin] = "virgin"
charIcon[charName.virgin] = SprVirgin
charTitle[charName.virgin,language.russian] = "Дева"
charDesc[charName.virgin,language.russian] = "Когда вас номинируют в первый раз, если это сделал Горожанин, он сразу же будет казнён."
charTitle[charName.virgin,language.english] = "Virgin";
charDesc[charName.virgin,language.english] = "The 1st time you are nominated, if the nominator is a Townsfolk, they are executed immediately.";
charSet[charName.virgin] = setName.troubleBrewing;
group[charName.virgin] = charGroup.townsfolk;
f_night[charName.virgin] = 0;
o_night[charName.virgin] = 0;
amy_order[charName.virgin] = amyOrder.dayOncePerGame

charCode[charName.washerwoman] = "washerwoman"
charIcon[charName.washerwoman] = SprWasherwoman
charTitle[charName.washerwoman,language.russian] = "Прачка"
charDesc[charName.washerwoman,language.russian] = "В начале вы знаете, что один из двух игроков - конкретный Горожанин."
charTitle[charName.washerwoman,language.english] = "Washerwoman";
charDesc[charName.washerwoman,language.english] = "You start knowing that 1 of 2 players is a particular Townsfolk.";
charSet[charName.washerwoman] = setName.troubleBrewing;
group[charName.washerwoman] = charGroup.townsfolk;
f_night[charName.washerwoman] = 32;
o_night[charName.washerwoman] = 0;
amy_order[charName.washerwoman] = amyOrder.firstNight


/// Bad Moon Rising

charCode[charName.assassin] = "assassin"
charIcon[charName.assassin] = SprAssassin
charTitle[charName.assassin,language.russian] = "Ассасин"
charDesc[charName.assassin,language.russian] = "Раз в игру, ночью*, выберите игрока. Этот игрок умирает, даже если по какой-то причине не мог."
charTitle[charName.assassin,language.english] = "Assassin";
charDesc[charName.assassin,language.english] = "Once per game, at night*, choose a player: they die, even if for some reason they could not.";
charSet[charName.assassin] = setName.badMoonRising;
group[charName.assassin] = charGroup.minion;
f_night[charName.assassin] = 0;
o_night[charName.assassin] = 35;
amy_order[charName.assassin] = amyOrder.oncePerGame

charCode[charName.chambermaid] = "chambermaid"
charIcon[charName.chambermaid] = SprChambermaid
charTitle[charName.chambermaid,language.russian] = "Служанка"
charDesc[charName.chambermaid,language.russian] = "Каждую ночь вы выбираете 2 живых игроков (не себя). Вы узнаёте, сколько из них проснулось ночью из-за своей способности."
charTitle[charName.chambermaid,language.english] = "Chambermaid";
charDesc[charName.chambermaid,language.english] = "Each night, choose 2 alive players (not yourself): you learn how many woke tonight due to their ability.";
charSet[charName.chambermaid] = setName.badMoonRising;
group[charName.chambermaid] = charGroup.townsfolk;
f_night[charName.chambermaid] = 52;
o_night[charName.chambermaid] = 69;
amy_order[charName.chambermaid] = amyOrder.everyNight

charCode[charName.courtier] = "courtier"
charIcon[charName.courtier] = SprCourtier
charTitle[charName.courtier,language.russian] = "Придворный"
charDesc[charName.courtier,language.russian] = "Раз в игру, ночью, выберите персонажа. Этот персонаж пьян 3 ночи и 3 дня."
charTitle[charName.courtier,language.english] = "Courtier";
charDesc[charName.courtier,language.english] = "Once per game, at night, choose a character: they are drunk for 3 nights & 3 days.";
charSet[charName.courtier] = setName.badMoonRising;
group[charName.courtier] = charGroup.townsfolk;
f_night[charName.courtier] = 18;
o_night[charName.courtier] = 7;
amy_order[charName.courtier] = amyOrder.oncePerGame

charCode[charName.devilsadvocate] = "devils_advocate"
charIcon[charName.devilsadvocate] = SprDevilsAdvocate
charTitle[charName.devilsadvocate,language.russian] = "Адвокат дьявола"
charDesc[charName.devilsadvocate,language.russian] = "Каждую ночь вы выбираете живого игрока (не того же, что и в прошлую ночь). Если его казнят на следующий день, он не умирает."
charTitle[charName.devilsadvocate,language.english] = "Devil's Advocate";
charDesc[charName.devilsadvocate,language.english] = "Each night, choose a living player (different to last night): if executed tomorrow, they don't die.";
charSet[charName.devilsadvocate] = setName.badMoonRising;
group[charName.devilsadvocate] = charGroup.minion;
f_night[charName.devilsadvocate] = 21;
o_night[charName.devilsadvocate] = 12;
amy_order[charName.devilsadvocate] = amyOrder.everyNight

charCode[charName.exorcist] = "exorcist"
charIcon[charName.exorcist] = SprExorcist
charTitle[charName.exorcist,language.russian] = "Экзорцист"
charDesc[charName.exorcist,language.russian] = "Каждую ночь* вы выбираете игрока (не того же, что и в прошлую ночь). Если выбран Демон, то он узнаёт, что вы Экзорцист, и не просыпается ночью."
charTitle[charName.exorcist,language.english] = "Exorcist";
charDesc[charName.exorcist,language.english] = "Each night*, choose a player (different to last night): the Demon, if chosen, learns who you are then doesn't wake tonight.";
charSet[charName.exorcist] = setName.badMoonRising;
group[charName.exorcist] = charGroup.townsfolk;
f_night[charName.exorcist] = 0;
o_night[charName.exorcist] = 20;
amy_order[charName.exorcist] = amyOrder.everyNightAsterisk

charCode[charName.fool] = "fool"
charIcon[charName.fool] = SprFool
charTitle[charName.fool,language.russian] = "Шут"
charDesc[charName.fool,language.russian] = "В первый раз, когда вы умираете, вы не умираете."
charTitle[charName.fool,language.english] = "Fool";
charDesc[charName.fool,language.english] = "The first time you die, you don't.";
charSet[charName.fool] = setName.badMoonRising;
group[charName.fool] = charGroup.townsfolk;
f_night[charName.fool] = 0;
o_night[charName.fool] = 0;
amy_order[charName.fool] = amyOrder.passive

charCode[charName.gambler] = "gambler"
charIcon[charName.gambler] = SprGambler
charTitle[charName.gambler,language.russian] = "Картёжник"
charDesc[charName.gambler,language.russian] = "Каждую ночь* вы выбираете игрока и угадываете его персонажа. Если вы не угадали, вы умираете."
charTitle[charName.gambler,language.english] = "Gambler";
charDesc[charName.gambler,language.english] = "Each night*, choose a player & guess their character: if you guess wrong, you die.";
charSet[charName.gambler] = setName.badMoonRising;
group[charName.gambler] = charGroup.townsfolk;
f_night[charName.gambler] = 0;
o_night[charName.gambler] = 9;
amy_order[charName.gambler] = amyOrder.everyNightAsterisk

charCode[charName.godfather] = "godfather"
charIcon[charName.godfather] = SprGodfather
charTitle[charName.godfather,language.russian] = "Крёстный отец"
charDesc[charName.godfather,language.russian] = "Вы знаете, какие Посторонние в игре. Каждую ночь, если днём Посторонний умер, выберите игрока, этот игрок умирает. [-1/+1 Посторонний]"
charTitle[charName.godfather,language.english] = "Godfather";
charDesc[charName.godfather,language.english] = "You start knowing which Outsiders are in play. If 1 died today, choose a player tonight: they die. [-1 or +1 Outsider]";
charSet[charName.godfather] = setName.badMoonRising;
group[charName.godfather] = charGroup.minion;
f_night[charName.godfather] = 20;
o_night[charName.godfather] = 36;
amy_order[charName.godfather] = amyOrder.everyNight

charCode[charName.goon] = "goon"
charIcon[charName.goon] = SprGoon
charTitle[charName.goon,language.russian] = "Наёмник"
charDesc[charName.goon,language.russian] = "Каждую ночь первый игрок, который выбирает вас целью своей способности, пьянеет до заката. Вы переходите на его сторону."
charTitle[charName.goon,language.english] = "Goon";
charDesc[charName.goon,language.english] = "Each night, the 1st player to choose you with their ability is drunk until dusk. You become their alignment.";
charSet[charName.goon] = setName.badMoonRising;
group[charName.goon] = charGroup.outsider;
f_night[charName.goon] = 0;
o_night[charName.goon] = 0;
amy_order[charName.goon] = amyOrder.passive

charCode[charName.gossip] = "gossip"
charIcon[charName.gossip] = SprGossip
charTitle[charName.gossip,language.russian] = "Сплетник"
charDesc[charName.gossip,language.russian] = "Каждый день, можете публично сделать заявление. Если это была правда, ночью умрёт игрок."
charTitle[charName.gossip,language.english] = "Gossip";
charDesc[charName.gossip,language.english] = "Each day, you may make a public statement. Tonight, if it was true, a player dies.";
charSet[charName.gossip] = setName.badMoonRising;
group[charName.gossip] = charGroup.townsfolk;
f_night[charName.gossip] = 0;
o_night[charName.gossip] = 37;
amy_order[charName.gossip] = amyOrder.dayActions

charCode[charName.grandmother] = "grandmother"
charIcon[charName.grandmother] = SprGrandmother
charTitle[charName.grandmother,language.russian] = "Бабушка"
charDesc[charName.grandmother,language.russian] = "В начале вы узнаёте одного Доброго игрока и его персонажа. Если его убьёт Демон, вы тоже умираете."
charTitle[charName.grandmother,language.english] = "Grandmother";
charDesc[charName.grandmother,language.english] = "You start knowing a good player & their character. If the Demon kills them, you die too.";
charSet[charName.grandmother] = setName.badMoonRising;
group[charName.grandmother] = charGroup.townsfolk;
f_night[charName.grandmother] = 39;
o_night[charName.grandmother] = 50;
amy_order[charName.grandmother] = amyOrder.firstNight

charCode[charName.innkeeper] = "innkeeper"
charIcon[charName.innkeeper] = SprInnkeeper
charTitle[charName.innkeeper,language.russian] = "Трактирщик"
charDesc[charName.innkeeper,language.russian] = "Каждую ночь* вы выбираете 2 игроков. Они не могут умереть этой ночью, но 1 из них пьян до заката."
charTitle[charName.innkeeper,language.english] = "Innkeeper";
charDesc[charName.innkeeper,language.english] = "Each night*, choose 2 players: they can't die tonight, but 1 is drunk until dusk.";
charSet[charName.innkeeper] = setName.badMoonRising;
group[charName.innkeeper] = charGroup.townsfolk;
f_night[charName.innkeeper] = 0;
o_night[charName.innkeeper] = 8;
amy_order[charName.innkeeper] = amyOrder.everyNightAsterisk

charCode[charName.lunatic] = "lunatic"
charIcon[charName.lunatic] = SprLunatic
charTitle[charName.lunatic,language.russian] = "Лунатик"
charDesc[charName.lunatic,language.russian] = "Вы думаете, что вы Демон, но это не так. Демон знает, что вы Лунатик, и знает, кого вы выбираете ночью."
charTitle[charName.lunatic,language.english] = "Lunatic";
charDesc[charName.lunatic,language.english] = "You think you are a Demon, but you are not. The Demon knows who you are & who you choose at night.";
charSet[charName.lunatic] = setName.badMoonRising;
group[charName.lunatic] = charGroup.outsider;
f_night[charName.lunatic] = 7;
o_night[charName.lunatic] = 19;
amy_order[charName.lunatic] = amyOrder.passive

charCode[charName.mastermind] = "mastermind"
charIcon[charName.mastermind] = SprMastermind
charTitle[charName.mastermind,language.russian] = "Руководитель"
charDesc[charName.mastermind,language.russian] = "Если Демон умер из-за казни, игра продолжается ещё один день. Если за этот день кого-то казнят, его команда проигрывают."
charTitle[charName.mastermind,language.english] = "Mastermind";
charDesc[charName.mastermind,language.english] = "If the Demon dies by execution (ending the game), play for 1 more day. If a player is then executed, their team loses.";
charSet[charName.mastermind] = setName.badMoonRising;
group[charName.mastermind] = charGroup.minion;
f_night[charName.mastermind] = 0;
o_night[charName.mastermind] = 0;
amy_order[charName.mastermind] = amyOrder.triggerOncePerGame

charCode[charName.minstrel] = "minstrel"
charIcon[charName.minstrel] = SprMinstrel
charTitle[charName.minstrel,language.russian] = "Менестрель"
charDesc[charName.minstrel,language.russian] = "Если от казни умер Приспешник, все другие игроки (кроме Путников) пьяны до завтрашнего заката."
charTitle[charName.minstrel,language.english] = "Minstrel";
charDesc[charName.minstrel,language.english] = "When a Minion dies by execution, all other players (except Travellers) are drunk until dusk tomorrow.";
charSet[charName.minstrel] = setName.badMoonRising;
group[charName.minstrel] = charGroup.townsfolk;
f_night[charName.minstrel] = 0;
o_night[charName.minstrel] = 0;
amy_order[charName.minstrel] = amyOrder.passive

charCode[charName.moonchild] = "moonchild"
charIcon[charName.moonchild] = SprMoonchild
charTitle[charName.moonchild,language.russian] = "Дитя луны"
charDesc[charName.moonchild,language.russian] = "Когда вы узнаёте, что умерли, публично выберите одного живого игрока. Если он Добрый, он умирает ночью."
charTitle[charName.moonchild,language.english] = "Moonchild";
charDesc[charName.moonchild,language.english] = "When you learn that you died, publicly choose 1 alive player. Tonight, if it was a good player, they die.";
charSet[charName.moonchild] = setName.badMoonRising;
group[charName.moonchild] = charGroup.outsider;
f_night[charName.moonchild] = 0;
o_night[charName.moonchild] = 49;
amy_order[charName.moonchild] = amyOrder.triggerOncePerGame

charCode[charName.pacifist] = "pacifist"
charIcon[charName.pacifist] = SprPacifist
charTitle[charName.pacifist,language.russian] = "Пацифист"
charDesc[charName.pacifist,language.russian] = "Казнённые Добрые игроки могут не умереть."
charTitle[charName.pacifist,language.english] = "Pacifist";
charDesc[charName.pacifist,language.english] = "Executed good players might not die.";
charSet[charName.pacifist] = setName.badMoonRising;
group[charName.pacifist] = charGroup.townsfolk;
f_night[charName.pacifist] = 0;
o_night[charName.pacifist] = 0;
amy_order[charName.pacifist] = amyOrder.passive

charCode[charName.po] = "po"
charIcon[charName.po] = SprPo
charTitle[charName.po,language.russian] = "По"
charDesc[charName.po,language.russian] = "Каждую ночь* вы выбираете игрока. Этот игрок умирает. Если в последний раз вы никого не выбирали, выберите 3 игроков."
charTitle[charName.po,language.english] = "Po";
charDesc[charName.po,language.english] = "Each night*, you may choose a player: they die. If your last choice was no-one, choose 3 players tonight.";
charSet[charName.po] = setName.badMoonRising;
group[charName.po] = charGroup.demon;
f_night[charName.po] = 0;
o_night[charName.po] = 27;
amy_order[charName.po] = amyOrder.everyNightAsterisk

charCode[charName.professor] = "professor"
charIcon[charName.professor] = SprProfessor
charTitle[charName.professor,language.russian] = "Профессор"
charDesc[charName.professor,language.russian] = "Раз в игру, ночью*, выберите мёртвого игрока. Если это Горожанин, он воскрешается."
charTitle[charName.professor,language.english] = "Professor";
charDesc[charName.professor,language.english] = "Once per game, at night*, choose a dead player: if they are a Townsfolk, they are resurrected.";
charSet[charName.professor] = setName.badMoonRising;
group[charName.professor] = charGroup.townsfolk;
f_night[charName.professor] = 0;
o_night[charName.professor] = 42;
amy_order[charName.professor] = amyOrder.oncePerGame

charCode[charName.pukka] = "pukka"
charIcon[charName.pukka] = SprPukka
charTitle[charName.pukka,language.russian] = "Пукка"
charDesc[charName.pukka,language.russian] = "Каждую ночь вы выбираете игрока. Этот игрок отравлен. Предыдущий отравленный игрок умирает, затем перестаёт быть отравленным."
charTitle[charName.pukka,language.english] = "Pukka";
charDesc[charName.pukka,language.english] = "Each night, choose a player: they are poisoned. The previously poisoned player dies then becomes healthy.";
charSet[charName.pukka] = setName.badMoonRising;
group[charName.pukka] = charGroup.demon;
f_night[charName.pukka] = 27;
o_night[charName.pukka] = 24;
amy_order[charName.pukka] = amyOrder.everyNightAsterisk

charCode[charName.sailor] = "sailor"
charIcon[charName.sailor] = SprSailor
charTitle[charName.sailor,language.russian] = "Моряк"
charDesc[charName.sailor,language.russian] = "Каждую ночь вы выбираете живого игрока, либо он, либо вы пьяны до следующего заката. Вы не можете умереть."
charTitle[charName.sailor,language.english] = "Sailor";
charDesc[charName.sailor,language.english] = "Each night, choose an alive player: either you or they are drunk until dusk. You can't die.";
charSet[charName.sailor] = setName.badMoonRising;
group[charName.sailor] = charGroup.townsfolk;
f_night[charName.sailor] = 10;
o_night[charName.sailor] = 2;
amy_order[charName.sailor] = amyOrder.everyNight

charCode[charName.shabaloth] = "shabaloth"
charIcon[charName.shabaloth] = SprShabaloth
charTitle[charName.shabaloth,language.russian] = "Шабалот"
charDesc[charName.shabaloth,language.russian] = "Каждую ночь* вы выбираете 2 игроков. Они умирают. Мёртвый игрок, которого вы выбирали прошлой ночью может быть извергнут."
charTitle[charName.shabaloth,language.english] = "Shabaloth";
charDesc[charName.shabaloth,language.english] = "Each night*, choose 2 players: they die. A dead player you chose last night might be regurgitated.";
charSet[charName.shabaloth] = setName.badMoonRising;
group[charName.shabaloth] = charGroup.demon;
f_night[charName.shabaloth] = 0;
o_night[charName.shabaloth] = 26;
amy_order[charName.shabaloth] = amyOrder.everyNightAsterisk

charCode[charName.tealady] = "tea_lady"
charIcon[charName.tealady] = SprTeaLady
charTitle[charName.tealady,language.russian] = "Чайная леди"
charDesc[charName.tealady,language.russian] = "Если оба ваших живых соседа Добрые, они не могут умереть."
charTitle[charName.tealady,language.english] = "Tea Lady";
charDesc[charName.tealady,language.english] = "If both your alive neighbors are good, they can't die.";
charSet[charName.tealady] = setName.badMoonRising;
group[charName.tealady] = charGroup.townsfolk;
f_night[charName.tealady] = 0;
o_night[charName.tealady] = 0;
amy_order[charName.tealady] = amyOrder.passive

charCode[charName.tinker] = "tinker"
charIcon[charName.tinker] = SprTinker
charTitle[charName.tinker,language.russian] = "Умелец"
charDesc[charName.tinker,language.russian] = "Вы можете умереть в любой момент."
charTitle[charName.tinker,language.english] = "Tinker";
charDesc[charName.tinker,language.english] = "You might die at any time.";
charSet[charName.tinker] = setName.badMoonRising;
group[charName.tinker] = charGroup.outsider;
f_night[charName.tinker] = 0;
o_night[charName.tinker] = 48;
amy_order[charName.tinker] = amyOrder.passive

charCode[charName.zombuul] = "zombuul"
charIcon[charName.zombuul] = SprZombuul
charTitle[charName.zombuul,language.russian] = "Зомбуул"
charDesc[charName.zombuul,language.russian] = "Каждую ночь* если днём никто не умер, выберите игрока. Этот игрок умирает. Первый раз, когда вы умираете, вы остаётесь в живых, но считается, что вы умерли."
charTitle[charName.zombuul,language.english] = "Zombuul";
charDesc[charName.zombuul,language.english] = "Each night*, if no-one died today, choose a player: they die. The 1st time you die, you live but register as dead.";
charSet[charName.zombuul] = setName.badMoonRising;
group[charName.zombuul] = charGroup.demon;
f_night[charName.zombuul] = 0;
o_night[charName.zombuul] = 25;
amy_order[charName.zombuul] = amyOrder.everyNightAsterisk


/// Sects & Violets

charCode[charName.artist] = "artist"
charIcon[charName.artist] = SprArtist
charTitle[charName.artist,language.russian] = "Художник"
charDesc[charName.artist,language.russian] = "Раз в игру, днём, вы можете посетить Рассказчика и спросить любой вопрос, на который можно ответить Да/Нет."
charTitle[charName.artist,language.english] = "Artist";
charDesc[charName.artist,language.english] = "Once per game, during the day, privately ask the Storyteller any yes/no question.";
charSet[charName.artist] = setName.sectsAndViolets;
group[charName.artist] = charGroup.townsfolk;
f_night[charName.artist] = 0;
o_night[charName.artist] = 0;
amy_order[charName.artist] = amyOrder.dayOncePerGame;

charCode[charName.barber] = "barber"
charIcon[charName.barber] = SprBarber
charTitle[charName.barber,language.russian] = "Парикмахер"
charDesc[charName.barber,language.russian] = "Если вы умираете, в эту ночь Демон может выбрать 2 игроков (не другого Демона), эти игроки меняются персонажами."
charTitle[charName.barber,language.english] = "Barber";
charDesc[charName.barber,language.english] = "If you died today or tonight, the Demon may choose 2 players (not another Demon) to swap characters.";
charSet[charName.barber] = setName.sectsAndViolets;
group[charName.barber] = charGroup.outsider;
f_night[charName.barber] = 0;
o_night[charName.barber] = 39;
amy_order[charName.barber] = amyOrder.triggerOncePerGame;

charCode[charName.cerenovus] = "cerenovus"
charIcon[charName.cerenovus] = SprCerenovus
charTitle[charName.cerenovus,language.russian] = "Манипулятор"
charDesc[charName.cerenovus,language.russian] = "Каждую ночь вы выбираете игрока и Доброго персонажа. Выбранный игрок должен спятить, что он - выбранный персонаж, иначе может быть казнён."
charTitle[charName.cerenovus,language.english] = "Cerenovus";
charDesc[charName.cerenovus,language.english] = "Each night, choose a player & a good character: they are \"mad\" they are this character tomorrow, or might be executed.";
charSet[charName.cerenovus] = setName.sectsAndViolets;
group[charName.cerenovus] = charGroup.minion;
f_night[charName.cerenovus] = 24;
o_night[charName.cerenovus] = 14;
amy_order[charName.cerenovus] = amyOrder.everyNight;

charCode[charName.clockmaker] = "clockmaker"
charIcon[charName.clockmaker] = SprClockmaker
charTitle[charName.clockmaker,language.russian] = "Часовщик"
charDesc[charName.clockmaker,language.russian] = "В начале вы узнаёте, сколько шагов отделяет Демона от его ближайшего Приспешника."
charTitle[charName.clockmaker,language.english] = "Clockmaker";
charDesc[charName.clockmaker,language.english] = "You start knowing how many steps from the Demon to its nearest Minion.";
charSet[charName.clockmaker] = setName.sectsAndViolets;
group[charName.clockmaker] = charGroup.townsfolk;
f_night[charName.clockmaker] = 40;
o_night[charName.clockmaker] = 0;
amy_order[charName.clockmaker] = amyOrder.firstNight;

charCode[charName.dreamer] = "dreamer"
charIcon[charName.dreamer] = SprDreamer
charTitle[charName.dreamer,language.russian] = "Мечтатель"
charDesc[charName.dreamer,language.russian] = "Каждую ночь вы выбираете игрока (не себя). Вы узнаёте 1 Доброго и 1 Злого персонажей. Этот игрок является одним из них."
charTitle[charName.dreamer,language.english] = "Dreamer";
charDesc[charName.dreamer,language.english] = "Each night, choose a player (not yourself or Travellers): you learn 1 good & 1 evil character, 1 of which is correct.";
charSet[charName.dreamer] = setName.sectsAndViolets;
group[charName.dreamer] = charGroup.townsfolk;
f_night[charName.dreamer] = 41;
o_night[charName.dreamer] = 55;
amy_order[charName.dreamer] = amyOrder.everyNight;

charCode[charName.eviltwin] = "evil_twin"
charIcon[charName.eviltwin] = SprEvilTwin
charTitle[charName.eviltwin,language.russian] = "Злой близнец"
charDesc[charName.eviltwin,language.russian] = "Вы и игрок другой команды знаете друг друга. Если Доброго игрока из вас казнят, Зло побеждает. Пока оба живы, Добро не может победить."
charTitle[charName.eviltwin,language.english] = "Evil Twin";
charDesc[charName.eviltwin,language.english] = "You & an opposing player know each other. If the good player is executed, evil wins. Good can't win if you both live.";
charSet[charName.eviltwin] = setName.sectsAndViolets;
group[charName.eviltwin] = charGroup.minion;
f_night[charName.eviltwin] = 22;
o_night[charName.eviltwin] = 0;
amy_order[charName.eviltwin] = amyOrder.passive;

charCode[charName.fanggu] = "fang_gu"
charIcon[charName.fanggu] = SprFangGu
charTitle[charName.fanggu,language.russian] = "Фэнг Гу"
charDesc[charName.fanggu,language.russian] = "Каждую ночь* выбираете игрока. Этот игрок умирает. Если так 1-ый раз выбрали Постороннего он становится Злым Фэнг Гу и вместо него умираете вы. [+1 Посторонний]"
charTitle[charName.fanggu,language.english] = "Fang Gu";
charDesc[charName.fanggu,language.english] = "Each night*, choose a player: they die. The 1st Outsider this kills becomes an evil Fang Gu & you die instead. [+1 Outsider]";
charSet[charName.fanggu] = setName.sectsAndViolets;
group[charName.fanggu] = charGroup.demon;
f_night[charName.fanggu] = 0;
o_night[charName.fanggu] = 28;
amy_order[charName.fanggu] = amyOrder.everyNightAsterisk;

charCode[charName.flowergirl] = "flowergirl"
charIcon[charName.flowergirl] = SprFlowerGirl
charTitle[charName.flowergirl,language.russian] = "Цветочница"
charDesc[charName.flowergirl,language.russian] = "Каждую ночь* вы узнаёте, голосовал ли сегодня Демон."
charTitle[charName.flowergirl,language.english] = "Flowergirl";
charDesc[charName.flowergirl,language.english] = "Each night*, you learn if a Demon voted today.";
charSet[charName.flowergirl] = setName.sectsAndViolets;
group[charName.flowergirl] = charGroup.townsfolk;
f_night[charName.flowergirl] = 0;
o_night[charName.flowergirl] = 56;
amy_order[charName.flowergirl] = amyOrder.everyNightAsterisk;

charCode[charName.juggler] = "juggler"
charIcon[charName.juggler] = SprJuggler
charTitle[charName.juggler,language.russian] = "Жонглёр"
charDesc[charName.juggler,language.russian] = "В первый свой день, публично угадайте до 5 персонажей у игроков. Ночью вы узнаете, сколько угадали."
charTitle[charName.juggler,language.english] = "Juggler";
charDesc[charName.juggler,language.english] = "On your 1st day, publicly guess up to 5 players' characters. That night, you learn how many you got correct.";
charSet[charName.juggler] = setName.sectsAndViolets;
group[charName.juggler] = charGroup.townsfolk;
f_night[charName.juggler] = 0;
o_night[charName.juggler] = 60;
amy_order[charName.juggler] = amyOrder.dayOncePerGame;

charCode[charName.klutz] = "klutz"
charIcon[charName.klutz] = SprKlutz
charTitle[charName.klutz,language.russian] = "Недотёпа"
charDesc[charName.klutz,language.russian] = "Когда вы узнаёте, что вы умерли, публично выберите живого игрока. Если вы выбрали Злодея, ваша команда проигрывает."
charTitle[charName.klutz,language.english] = "Klutz";
charDesc[charName.klutz,language.english] = "When you learn that you died, publicly choose 1 alive player: if they are evil, your team loses.";
charSet[charName.klutz] = setName.sectsAndViolets;
group[charName.klutz] = charGroup.outsider;
f_night[charName.klutz] = 0;
o_night[charName.klutz] = 0;
amy_order[charName.klutz] = amyOrder.triggerOncePerGame;

charCode[charName.mathematician] = "mathematician"
charIcon[charName.mathematician] = SprMathematician
charTitle[charName.mathematician,language.russian] = "Математик"
charDesc[charName.mathematician,language.russian] = "Каждую ночь вы узнаёте, сколько способностей других игроков сработали ненормально (начиная с рассвета) из-за способностей других персонажей."
charTitle[charName.mathematician,language.english] = "Mathematician";
charDesc[charName.mathematician,language.english] = "Each night, you learn how many players' abilities worked abnormally (since dawn) due to another character's ability.";
charSet[charName.mathematician] = setName.sectsAndViolets;
group[charName.mathematician] = charGroup.townsfolk;
f_night[charName.mathematician] = 53;
o_night[charName.mathematician] = 70;
amy_order[charName.mathematician] = amyOrder.everyNight;

charCode[charName.mutant] = "mutant"
charIcon[charName.mutant] = SprMutant
charTitle[charName.mutant,language.russian] = "Мутант"
charDesc[charName.mutant,language.russian] = "Если вы спятили по поводу того, что вы Посторонний, вас могут казнить."
charTitle[charName.mutant,language.english] = "Mutant";
charDesc[charName.mutant,language.english] = "If you are \"mad\" about being an Outsider, you might be executed.";
charSet[charName.mutant] = setName.sectsAndViolets;
group[charName.mutant] = charGroup.outsider;
f_night[charName.mutant] = 0;
o_night[charName.mutant] = 0;
amy_order[charName.mutant] = amyOrder.passive;

charCode[charName.nodashii] = "no_dashii"
charIcon[charName.nodashii] = SprNoDashii
charTitle[charName.nodashii,language.russian] = "Но Дашии"
charDesc[charName.nodashii,language.russian] = "Каждую ночь* вы выбираете игрока. Этот игрок умирает. Ваши 2 соседа Горожанина отравлены."
charTitle[charName.nodashii,language.english] = "No Dashii";
charDesc[charName.nodashii,language.english] = "Each night*, choose a player: they die. Your 2 Townsfolk neighbors are poisoned.";
charSet[charName.nodashii] = setName.sectsAndViolets;
group[charName.nodashii] = charGroup.demon;
f_night[charName.nodashii] = 0;
o_night[charName.nodashii] = 29;
amy_order[charName.nodashii] = amyOrder.everyNightAsterisk;

charCode[charName.oracle] = "oracle"
charIcon[charName.oracle] = SprOracle
charTitle[charName.oracle,language.russian] = "Оракул"
charDesc[charName.oracle,language.russian] = "Каждую ночь* вы узнаёте, сколько мёртвых игроков Злодеи."
charTitle[charName.oracle,language.english] = "Oracle";
charDesc[charName.oracle,language.english] = "Each night*, you learn how many dead players are evil.";
charSet[charName.oracle] = setName.sectsAndViolets;
group[charName.oracle] = charGroup.townsfolk;
f_night[charName.oracle] = 0;
o_night[charName.oracle] = 58;
amy_order[charName.oracle] = amyOrder.everyNightAsterisk;

charCode[charName.philosopher] = "philosopher"
charIcon[charName.philosopher] = SprPhilosopher
charTitle[charName.philosopher,language.russian] = "Философ"
charDesc[charName.philosopher,language.russian] = "Раз в игру, ночью, выберите Доброго персонажа. Вы получаете его способность. Если в игре есть такой персонаж, он становятся пьяными."
charTitle[charName.philosopher,language.english] = "Philosopher";
charDesc[charName.philosopher,language.english] = "Once per game, at night, choose a good character: gain that ability. If this character is in play, they are drunk.";
charSet[charName.philosopher] = setName.sectsAndViolets;
group[charName.philosopher] = charGroup.townsfolk;
f_night[charName.philosopher] = 1;
o_night[charName.philosopher] = 1;
amy_order[charName.philosopher] = amyOrder.oncePerGame;

charCode[charName.pithag] = "pit-hag"
charIcon[charName.pithag] = SprPitHag
charTitle[charName.pithag,language.russian] = "Колдунья"
charDesc[charName.pithag,language.russian] = "Каждую ночь* вы выбираете игрока и персонажа, в котрого он превращается (если такого персонажа нет в игре). Если сделан Демон, смерти этой ночью выбирает Рассказчик."
charTitle[charName.pithag,language.english] = "Pit-Hag";
charDesc[charName.pithag,language.english] = "Each night*, choose a player & a character they become (if not in play). If a Demon is made, deaths tonight are arbitrary.";
charSet[charName.pithag] = setName.sectsAndViolets;
group[charName.pithag] = charGroup.minion;
f_night[charName.pithag] = 0;
o_night[charName.pithag] = 15;
amy_order[charName.pithag] = amyOrder.everyNightAsterisk;

charCode[charName.sage] = "sage"
charIcon[charName.sage] = SprSage
charTitle[charName.sage,language.russian] = "Мудрец"
charDesc[charName.sage,language.russian] = "Если Демон убьёт вас, вы узнаете, что это 1 из 2 игроков."
charTitle[charName.sage,language.english] = "Sage";
charDesc[charName.sage,language.english] = "If the Demon kills you, you learn that it is 1 of 2 players.";
charSet[charName.sage] = setName.sectsAndViolets;
group[charName.sage] = charGroup.townsfolk;
f_night[charName.sage] = 0;
o_night[charName.sage] = 41;
amy_order[charName.sage] = amyOrder.triggerOncePerGame;

charCode[charName.savant] = "savant"
charIcon[charName.savant] = SprSavant
charTitle[charName.savant,language.russian] = "Учёный"
charDesc[charName.savant,language.russian] = "Каждый день вы можете посетить Рассказчика, чтобы узнать 2 факта. Один правдивый, другой ложный."
charTitle[charName.savant,language.english] = "Savant";
charDesc[charName.savant,language.english] = "Each day, you may visit the Storyteller to learn 2 things in private: 1 is true & 1 is false.";
charSet[charName.savant] = setName.sectsAndViolets;
group[charName.savant] = charGroup.townsfolk;
f_night[charName.savant] = 0;
o_night[charName.savant] = 0;
amy_order[charName.savant] = amyOrder.dayActions;

charCode[charName.seamstress] = "seamstress"
charIcon[charName.seamstress] = SprSeamstress
charTitle[charName.seamstress,language.russian] = "Швея"
charDesc[charName.seamstress,language.russian] = "Раз в игру, ночью, выберите 2 игроков (не себя). Вы узнаёте, на одной ли они стороне."
charTitle[charName.seamstress,language.english] = "Seamstress";
charDesc[charName.seamstress,language.english] = "Once per game, at night, choose 2 players (not yourself): you learn if they are the same alignment.";
charSet[charName.seamstress] = setName.sectsAndViolets;
group[charName.seamstress] = charGroup.townsfolk;
f_night[charName.seamstress] = 42;
o_night[charName.seamstress] = 59;
amy_order[charName.seamstress] = amyOrder.oncePerGame;

charCode[charName.snakecharmer] = "snake_charmer"
charIcon[charName.snakecharmer] = SprSnakeCharmer
charTitle[charName.snakecharmer,language.russian] = "Заклинатель змей"
charDesc[charName.snakecharmer,language.russian] = "Каждую ночь вы выбираете живого игрока. Если этот игрок Демон, он меняется с вами сторонами, персонажами и становится отравлен."
charTitle[charName.snakecharmer,language.english] = "Snake Charmer";
charDesc[charName.snakecharmer,language.english] = "Each night, choose an alive player: a chosen Demon swaps characters & alignments with you & is then poisoned.";
charSet[charName.snakecharmer] = setName.sectsAndViolets;
group[charName.snakecharmer] = charGroup.townsfolk;
f_night[charName.snakecharmer] = 19;
o_night[charName.snakecharmer] = 10;
amy_order[charName.snakecharmer] = amyOrder.everyNight;

charCode[charName.sweetheart] = "sweetheart"
charIcon[charName.sweetheart] = SprSweetheart
charTitle[charName.sweetheart,language.russian] = "Возлюбленная"
charDesc[charName.sweetheart,language.russian] = "Когда вы умираете, один из игроков пьянеет."
charTitle[charName.sweetheart,language.english] = "Sweetheart";
charDesc[charName.sweetheart,language.english] = "When you die, 1 player is drunk from now on.";
charSet[charName.sweetheart] = setName.sectsAndViolets;
group[charName.sweetheart] = charGroup.outsider;
f_night[charName.sweetheart] = 0;
o_night[charName.sweetheart] = 40;
amy_order[charName.sweetheart] = amyOrder.triggerOncePerGame;

charCode[charName.towncrier] = "town_crier"
charIcon[charName.towncrier] = SprTownCrier
charTitle[charName.towncrier,language.russian] = "Глашатай"
charDesc[charName.towncrier,language.russian] = "Каждую ночь* вы узнаёте, номинировал ли кого-то Приспешник."
charTitle[charName.towncrier,language.english] = "Town Crier";
charDesc[charName.towncrier,language.english] = "Each night*, you learn if a Minion nominated today.";
charSet[charName.towncrier] = setName.sectsAndViolets;
group[charName.towncrier] = charGroup.townsfolk;
f_night[charName.towncrier] = 0;
o_night[charName.towncrier] = 57;
amy_order[charName.towncrier] = amyOrder.everyNightAsterisk;

charCode[charName.vigormortis] = "vigormortis"
charIcon[charName.vigormortis] = SprVigormortis
charTitle[charName.vigormortis,language.russian] = "Вигормортис"
charDesc[charName.vigormortis,language.russian] = "Каждую ночь* вы выбираете игрока. Этот игрок умирает. Убитые вами Приспешники оставляют свою способность и отравляют 1 соседа Горожанина. [-1 Посторонний]"
charTitle[charName.vigormortis,language.english] = "Vigormortis";
charDesc[charName.vigormortis,language.english] = "Each night*, choose a player: they die. Minions you kill keep their ability & poison 1 Townsfolk neighbor. [-1 Outsider]";
charSet[charName.vigormortis] = setName.sectsAndViolets;
group[charName.vigormortis] = charGroup.demon;
f_night[charName.vigormortis] = 0;
o_night[charName.vigormortis] = 31;
amy_order[charName.vigormortis] = amyOrder.everyNightAsterisk;

charCode[charName.vortox] = "vortox"
charIcon[charName.vortox] = SprVortox
charTitle[charName.vortox,language.russian] = "Вортокс"
charDesc[charName.vortox,language.russian] = "Каждую ночь* вы выбираете игрока. Этот игрок умирает. Вся получаемая способностями Горожан информация будет ложной. Если днём никого не казнили, Зло побеждает."
charTitle[charName.vortox,language.english] = "Vortox";
charDesc[charName.vortox,language.english] = "Each night*, choose a player; they die. Townsfolk abilities yield false info. Each day, if no-one is executed, evil wins.";
charSet[charName.vortox] = setName.sectsAndViolets;
group[charName.vortox] = charGroup.demon;
f_night[charName.vortox] = 0;
o_night[charName.vortox] = 30;
amy_order[charName.vortox] = amyOrder.everyNightAsterisk;

charCode[charName.witch] = "witch"
charIcon[charName.witch] = SprWitch
charTitle[charName.witch,language.russian] = "Ведьма"
charDesc[charName.witch,language.russian] = "Каждую ночь вы выбираете игрока. Если он номинирует на следующий день, он умирает. Если в живых только 3 игрока, вы теряете эту способность."
charTitle[charName.witch,language.english] = "Witch";
charDesc[charName.witch,language.english] = "Each night, choose a player: if they nominate tomorrow, they die. If just 3 players live, you lose this ability.";
charSet[charName.witch] = setName.sectsAndViolets;
group[charName.witch] = charGroup.minion;
f_night[charName.witch] = 23;
o_night[charName.witch] = 13;
amy_order[charName.witch] = amyOrder.everyNight;

/// Experimental

charCode[charName.acrobat] = "acrobat"
charIcon[charName.acrobat] = SprAcrobat
charTitle[charName.acrobat,language.russian] = "Акробат"
charDesc[charName.acrobat,language.russian] = "Каждую ночь* если один из ваших живых соседей отравлен или пьян, вы умираете."
charTitle[charName.acrobat,language.english] = "Acrobat";
charDesc[charName.acrobat,language.english] = "Each night*, if either good living neighbour is drunk or poisoned, you die.";
charSet[charName.acrobat] = setName.experimental;
group[charName.acrobat] = charGroup.outsider;
f_night[charName.acrobat] = 0;
o_night[charName.acrobat] = 38;
amy_order[charName.acrobat] = amyOrder.everyNightAsterisk;

charCode[charName.alchemist] = "alchemist"
charIcon[charName.alchemist] = SprAlchemist
charTitle[charName.alchemist,language.russian] = "Алхимик"
charDesc[charName.alchemist,language.russian] = "У вас способность Приспешника, которого нет в игре."
charTitle[charName.alchemist,language.english] = "Alchemist";
charDesc[charName.alchemist,language.english] = "You have a not-in-play Minion ability.";
charSet[charName.alchemist] = setName.experimental;
group[charName.alchemist] = charGroup.townsfolk;
f_night[charName.alchemist] = 2;
o_night[charName.alchemist] = 0;
amy_order[charName.alchemist] = amyOrder.passive;

charCode[charName.alhadikhia] = "al-hadikhia"
charIcon[charName.alhadikhia] = SprAlHadikhia
charTitle[charName.alhadikhia,language.russian] = "Аль-Хадика"
charDesc[charName.alhadikhia,language.russian] = "Каждую ночь* выберите 3 игроков (все узнают кого). Каждый в тайне выбирает жить или умереть. Если все выбрали жить, все умирают."
charTitle[charName.alhadikhia,language.english] = "Al-Hadikhia";
charDesc[charName.alhadikhia,language.english] = "Each night*, choose 3 players (all players learn who): each silently chooses to live or die, but if all live, all die.";
charSet[charName.alhadikhia] = setName.experimental;
group[charName.alhadikhia] = charGroup.demon;
f_night[charName.alhadikhia] = 0;
o_night[charName.alhadikhia] = 32;
amy_order[charName.alhadikhia] = amyOrder.everyNightAsterisk;

charCode[charName.amnesiac] = "amnesiac"
charIcon[charName.amnesiac] = SprAmnesiac
charTitle[charName.amnesiac,language.russian] = "Амнезиак"
charDesc[charName.amnesiac,language.russian] = "Вы не знаете свою способность. Каждый день можете посетить рассказчика и угадать какая у вас способность: вы узнаете насколько это точно."
charTitle[charName.amnesiac,language.english] = "Amnesiac";
charDesc[charName.amnesiac,language.english] = "You do not know what your ability is. Each day, privately guess what it is: you learn how accurate you are.";
charSet[charName.amnesiac] = setName.experimental;
group[charName.amnesiac] = charGroup.townsfolk;
f_night[charName.amnesiac] = 31;
o_night[charName.amnesiac] = 46;
amy_order[charName.amnesiac] = amyOrder.dayActions;

charCode[charName.atheist] = "atheist"
charIcon[charName.atheist] = SprAtheist
charTitle[charName.atheist,language.russian] = "Атеист"
charDesc[charName.atheist,language.russian] = "Рассказчик может нарушать правила игры. Если его казнить, Добро побеждает. Работает даже если вы мертвы. [Злодеи не добавляются]"
charTitle[charName.atheist,language.english] = "Atheist";
charDesc[charName.atheist,language.english] = "The Storyteller can break the game rules, and if executed, good wins, even if you are dead. [No evil characters]";
charSet[charName.atheist] = setName.experimental;
group[charName.atheist] = charGroup.townsfolk;
f_night[charName.atheist] = 0;
o_night[charName.atheist] = 0;
amy_order[charName.atheist] = amyOrder.passive;

charCode[charName.balloonist] = "balloonist"
charIcon[charName.balloonist] = SprBalloonist
charTitle[charName.balloonist,language.russian] = "Аэронавт"
charDesc[charName.balloonist,language.russian] = "Каждую ночь вы узнаёте по 1 игроку каждой группы персонажей в игре, пока они не закончатся. [+1 посторонний]"
charTitle[charName.balloonist,language.english] = "Balloonist";
charDesc[charName.balloonist,language.english] = "Each night, you learn 1 player of each character type, until there are no more types to learn. [+1 Outsider]";
charSet[charName.balloonist] = setName.experimental;
group[charName.balloonist] = charGroup.townsfolk;
f_night[charName.balloonist] = 46;
o_night[charName.balloonist] = 61;
amy_order[charName.balloonist] = amyOrder.everyNight;

charCode[charName.boomdandy] = "boomdandy"
charIcon[charName.boomdandy] = SprBoomdandy
charTitle[charName.boomdandy,language.russian] = "Подрывник"
charDesc[charName.boomdandy,language.russian] = "Если вас казнят, все кроме 3 игроков умирают. Через 1 минуту, игрок на которого показывают больше всего игроков умирает."
charTitle[charName.boomdandy,language.english] = "Boomdandy";
charDesc[charName.boomdandy,language.english] = "If you are executed, all but 3 players die. 1 minute later, the player with the most players pointing at them, dies.";
charSet[charName.boomdandy] = setName.experimental;
group[charName.boomdandy] = charGroup.minion;
f_night[charName.boomdandy] = 0;
o_night[charName.boomdandy] = 0;
amy_order[charName.boomdandy] = amyOrder.triggerOncePerGame;

charCode[charName.bountyhunter] = "bounty_hunter"
charIcon[charName.bountyhunter] = SprBountyHunter
charTitle[charName.bountyhunter,language.russian] = "Охотник за головами"
charDesc[charName.bountyhunter,language.russian] = "В начале вы знаете 1 игрока Злодея. Если этот игрок умирает, вы узнаёте другого игрока Злодея этой ночью. [1 Горожанин Злой]"
charTitle[charName.bountyhunter,language.english] = "Bounty Hunter";
charDesc[charName.bountyhunter,language.english] = "You start knowing 1 evil player. If the player you know dies, you learn another evil player tonight. [1 Townsfolk is evil]";
charSet[charName.bountyhunter] = setName.experimental;
group[charName.bountyhunter] = charGroup.townsfolk;
f_night[charName.bountyhunter] = 47;
o_night[charName.bountyhunter] = 63;
amy_order[charName.bountyhunter] = amyOrder.firstAndEveryNight

charCode[charName.cannibal] = "cannibal"
charIcon[charName.cannibal] = SprCannibal
charTitle[charName.cannibal,language.russian] = "Каннибал"
charDesc[charName.cannibal,language.russian] = "У вас есть способность последнего убитого через казнь. Если этот игрок Злодей, вы отравлены, пока Добрый игрок не умрёт от казни."
charTitle[charName.cannibal,language.english] = "Cannibal";
charDesc[charName.cannibal,language.english] = "You have the ability of the recently killed executee. If they are evil, you are poisoned until a good player dies by execution.";
charSet[charName.cannibal] = setName.experimental;
group[charName.cannibal] = charGroup.townsfolk;
f_night[charName.cannibal] = 0;
o_night[charName.cannibal] = 0;
amy_order[charName.cannibal] = amyOrder.passive

charCode[charName.choirboy] = "choirboy"
charIcon[charName.choirboy] = SprChoirBoy
charTitle[charName.choirboy,language.russian] = "Мальчик хорист"
charDesc[charName.choirboy,language.russian] = "Если Демон убивает Короля, вы узнаёте, кто из игроков Демон. [+Король]"
charTitle[charName.choirboy,language.english] = "Choirboy";
charDesc[charName.choirboy,language.english] = "If the Demon kills the King, you learn which player is the Demon. [+the King]";
charSet[charName.choirboy] = setName.experimental;
group[charName.choirboy] = charGroup.townsfolk;
f_night[charName.choirboy] = 0;
o_night[charName.choirboy] = 43;
amy_order[charName.choirboy] = amyOrder.triggerOncePerGame

charCode[charName.cultleader] = "cult_leader"
charIcon[charName.cultleader] = SprCultLeader
charTitle[charName.cultleader,language.russian] = "Лидер культа"
charDesc[charName.cultleader,language.russian] = "Каждую ночь вы переходите на сторону одного из живых соседей. Если все Добрые игроки выберут вступить в ваш культ, ваша команда побеждает."
charTitle[charName.cultleader,language.english] = "Cult Leader";
charDesc[charName.cultleader,language.english] = "Each night, you become the alignment of an alive neighbour. If all good players choose to join your cult, your team wins.";
charSet[charName.cultleader] = setName.experimental;
group[charName.cultleader] = charGroup.townsfolk;
f_night[charName.cultleader] = 49;
o_night[charName.cultleader] = 65;
amy_order[charName.cultleader] = amyOrder.dayActions

charCode[charName.damsel] = "damsel"
charIcon[charName.damsel] = SprDamsel
charTitle[charName.damsel,language.russian] = "Мадам"
charDesc[charName.damsel,language.russian] = "Все приспешники знают, что вы есть в игре. Если приспешник публично угадает вас (один раз за игру), ваша команда проигрывает."
charTitle[charName.damsel,language.english] = "Damsel";
charDesc[charName.damsel,language.english] = "All Minions know you are in play. If a Minion publicly guesses you (once), your team loses.";
charSet[charName.damsel] = setName.experimental;
group[charName.damsel] = charGroup.outsider;
f_night[charName.damsel] = 30;
o_night[charName.damsel] = 45;
amy_order[charName.damsel] = amyOrder.passive

charCode[charName.engineer] = "engineer"
charIcon[charName.engineer] = SprEngineer
charTitle[charName.engineer,language.russian] = "Инженер"
charDesc[charName.engineer,language.russian] = "Раз в игру, ночью, выберите какой Демон или какие Приспешники в игре."
charTitle[charName.engineer,language.english] = "Engineer";
charDesc[charName.engineer,language.english] = "Once per game, at night, choose which Minions or which Demon is in play.";
charSet[charName.engineer] = setName.experimental;
group[charName.engineer] = charGroup.townsfolk;
f_night[charName.engineer] = 12;
o_night[charName.engineer] = 4;
amy_order[charName.engineer] = amyOrder.oncePerGame

charCode[charName.farmer] = "farmer"
charIcon[charName.farmer] = SprFarmer
charTitle[charName.farmer,language.russian] = "Фермер"
charDesc[charName.farmer,language.russian] = "Если вы умираете ночью, живой Добрый игрок становится Фермером."
charTitle[charName.farmer,language.english] = "Farmer";
charDesc[charName.farmer,language.english] = "If you die at night, an alive good player becomes a Farmer.";
charSet[charName.farmer] = setName.experimental;
group[charName.farmer] = charGroup.townsfolk;
f_night[charName.farmer] = 0;
o_night[charName.farmer] = 47;
amy_order[charName.farmer] = amyOrder.passive

charCode[charName.fearmonger] = "fearmonger"
charIcon[charName.fearmonger] = SprFearmonger
charTitle[charName.fearmonger,language.russian] = "Страшила"
charDesc[charName.fearmonger,language.russian] = "Каждую ночь вы выбираете игрока: если вы номинировали его и его казнили, его команда проигрывает. Все игроки знают, если вы выбираете нового игрока."
charTitle[charName.fearmonger,language.english] = "Fearmonger";
charDesc[charName.fearmonger,language.english] = "Each night, choose a player: if you nominate & execute them, their team loses. All players know if you choose a new player.";
charSet[charName.fearmonger] = setName.experimental;
group[charName.fearmonger] = charGroup.minion;
f_night[charName.fearmonger] = 25;
o_night[charName.fearmonger] = 17;
amy_order[charName.fearmonger] = amyOrder.everyNight

charCode[charName.fisherman] = "fisherman"
charIcon[charName.fisherman] = SprFisherman
charTitle[charName.fisherman,language.russian] = "Рыбак"
charDesc[charName.fisherman,language.russian] = "Раз в игру, днём, посетите рассказчика, чтобы получить совет по тому, как вашей команде победить."
charTitle[charName.fisherman,language.english] = "Fisherman";
charDesc[charName.fisherman,language.english] = "Once per game, during the day, visit the Storyteller for some advice to help your team win.";
charSet[charName.fisherman] = setName.experimental;
group[charName.fisherman] = charGroup.townsfolk;
f_night[charName.fisherman] = 0;
o_night[charName.fisherman] = 0;
amy_order[charName.fisherman] = amyOrder.dayOncePerGame

charCode[charName.general] = "general"
charIcon[charName.general] = SprGeneral
charTitle[charName.general,language.russian] = "Генерал"
charDesc[charName.general,language.russian] = "Каждую ночь вы узнаёте, какая сторона по мнению рассказчика выигрывает."
charTitle[charName.general,language.english] = "General";
charDesc[charName.general,language.english] = "Each night, you learn which alignment the Storyteller believes is winning: good, evil, or neither.";
charSet[charName.general] = setName.experimental;
group[charName.general] = charGroup.townsfolk;
f_night[charName.general] = 51;
o_night[charName.general] = 68;
amy_order[charName.general] = amyOrder.everyNight

charCode[charName.goblin] = "goblin"
charIcon[charName.goblin] = SprGoblin
charTitle[charName.goblin,language.russian] = "Гоблин"
charDesc[charName.goblin,language.russian] = "Если, когда вас номинируют, вы публично объявите, что вы Гоблин, и вас казнят в этот день, ваша команда побеждает."
charTitle[charName.goblin,language.english] = "Goblin";
charDesc[charName.goblin,language.english] = "If you publicly claim to be the Goblin when nominated & are executed that day, your team wins.";
charSet[charName.goblin] = setName.experimental;
group[charName.goblin] = charGroup.minion;
f_night[charName.goblin] = 0;
o_night[charName.goblin] = 0;
amy_order[charName.goblin] = amyOrder.dayActions

charCode[charName.golem] = "golem"
charIcon[charName.golem] = SprGolem
charTitle[charName.golem,language.russian] = "Голем"
charDesc[charName.golem,language.russian] = "Вы можете номинировать только один раз за игру. Если вы номинировали игрока и он не Демон, он умирает."
charTitle[charName.golem,language.english] = "Golem";
charDesc[charName.golem,language.english] = "You may only nominate once per game. When you do, if the nominee is not the Demon, they die.";
charSet[charName.golem] = setName.experimental;
group[charName.golem] = charGroup.outsider;
f_night[charName.golem] = 0;
o_night[charName.golem] = 0;
amy_order[charName.golem] = amyOrder.dayOncePerGame

charCode[charName.heretic] = "heretic"
charIcon[charName.heretic] = SprHeretic
charTitle[charName.heretic,language.russian] = "Еретик"
charDesc[charName.heretic,language.russian] = "Тот, кто проигрывает, побеждает, и наоборот, даже если вы мертвы."
charTitle[charName.heretic,language.english] = "Heretic";
charDesc[charName.heretic,language.english] = "Whoever wins, loses & whoever loses, wins, even if you are dead.";
charSet[charName.heretic] = setName.experimental;
group[charName.heretic] = charGroup.outsider;
f_night[charName.heretic] = 0;
o_night[charName.heretic] = 0;
amy_order[charName.heretic] = amyOrder.passive

charCode[charName.huntsman] = "huntsman"
charIcon[charName.huntsman] = SprHuntsman
charTitle[charName.huntsman,language.russian] = "Охотник"
charDesc[charName.huntsman,language.russian] = "Раз за игру, ночью, выберите игрока: если выбрана Мадам, она становится Горожанином, которого нет в игре. [+Мадам]"
charTitle[charName.huntsman,language.english] = "Huntsman";
charDesc[charName.huntsman,language.english] = "Once per game, at night, choose a living player: the Damsel, if chosen, becomes a not-in-play Townsfolk. [+the Damsel]";
charSet[charName.huntsman] = setName.experimental;
group[charName.huntsman] = charGroup.townsfolk;
f_night[charName.huntsman] = 29;
o_night[charName.huntsman] = 44;
amy_order[charName.huntsman] = amyOrder.oncePerGame

charCode[charName.king] = "king"
charIcon[charName.king] = SprKing
charTitle[charName.king,language.russian] = "Король"
charDesc[charName.king,language.russian] = "Каждую ночь, если мёртвых столько же или больше, чем живых, вы узнаёте 1 персонажа живого игрока. Демон знает, кто вы."
charTitle[charName.king,language.english] = "King";
charDesc[charName.king,language.english] = "Each night, if the dead equal or outnumber the living, you learn 1 alive character. The Demon knows who you are.";
charSet[charName.king] = setName.experimental;
group[charName.king] = charGroup.townsfolk;
f_night[charName.king] = 9;
o_night[charName.king] = 62;
amy_order[charName.king] = amyOrder.everyNight

charCode[charName.legion] = "legion"
charIcon[charName.legion] = SprLegion
charTitle[charName.legion,language.russian] = "Легион"
charDesc[charName.legion,language.russian] = "Каждую ночь* может умереть игрок. Номинации на казнь не срабатывают, если проголосуют только Злодеи. Вы также считаетесь Приспешником. [Большая часть игроков - Легион]"
charTitle[charName.legion,language.english] = "Legion";
charDesc[charName.legion,language.english] = "Each night*, a player might die. Executions fail if only evil voted. You register as a Minion too. [Most players are Legion]";
charSet[charName.legion] = setName.experimental;
group[charName.legion] = charGroup.demon;
f_night[charName.legion] = 0;
o_night[charName.legion] = 22;
amy_order[charName.legion] = amyOrder.everyNightAsterisk

charCode[charName.leviathan] = "leviathan"
charIcon[charName.leviathan] = SprLeviathan
charTitle[charName.leviathan,language.russian] = "Левиафан"
charDesc[charName.leviathan,language.russian] = "Если казнено больше 1 Доброго игрока, Зло побеждает. Все игроки знают, что вы в игре. После 5 дня Зло побеждает."
charTitle[charName.leviathan,language.english] = "Leviathan";
charDesc[charName.leviathan,language.english] = "If more than 1 good player is executed, evil wins. All players know you are in play. After day 5, evil wins.";
charSet[charName.leviathan] = setName.experimental;
group[charName.leviathan] = charGroup.demon;
f_night[charName.leviathan] = 56;
o_night[charName.leviathan] = 72;
amy_order[charName.leviathan] = amyOrder.passive

charCode[charName.lilmonsta] = "lil_monsta"
charIcon[charName.lilmonsta] = SprLilMonsta
charTitle[charName.lilmonsta,language.russian] = "Монстр Джуниор"
charDesc[charName.lilmonsta,language.russian] = "Каждую ночь Приспешники выбирают, кто из них нянчит Монстра Джуниора и \"является Демоном\". Игрок умирает каждую ночь*. [+1 Приспешник]"
charTitle[charName.lilmonsta,language.english] = "Lil' Monsta";
charDesc[charName.lilmonsta,language.english] = "Each night, Minions choose who babysits Lil' Monsta's token & " + "\"is the demon\"" + ". A player dies each night*. [+1 Minion]";
charSet[charName.lilmonsta] = setName.experimental;
group[charName.lilmonsta] = charGroup.demon;
f_night[charName.lilmonsta] = 14;
o_night[charName.lilmonsta] = 34;
amy_order[charName.lilmonsta] = amyOrder.everyNight

charCode[charName.lleech] = "lleech"
charIcon[charName.lleech] = SprLleech
charTitle[charName.lleech,language.russian] = "Ллич"
charDesc[charName.lleech,language.russian] = "Каждую ночь* вы выбираете игрока: он умирает. В начале игры вы выбираете живого игрока: он отравлен, вы умираете если (и только если) он умрёт."
charTitle[charName.lleech,language.english] = "Lleech";
charDesc[charName.lleech,language.english] = "Each night*, choose a player: they die. You start by choosing an alive player: they are poisoned - you die if (& only if) they die.";
charSet[charName.lleech] = setName.experimental;
group[charName.lleech] = charGroup.demon;
f_night[charName.lleech] = 15;
o_night[charName.lleech] = 33;
amy_order[charName.lleech] = amyOrder.everyNight

charCode[charName.lycanthrope] = "lycanthrope"
charIcon[charName.lycanthrope] = SprLycanthrope
charTitle[charName.lycanthrope,language.russian] = "Ликантроп"
charDesc[charName.lycanthrope,language.russian] = "Каждую ночь* вы выбираете живого игрока: если он Добрый, он умирает, но это единственный игрок, который может умереть этой ночью."
charTitle[charName.lycanthrope,language.english] = "Lycanthrope";
charDesc[charName.lycanthrope,language.english] = "Each night*, choose an alive player. If good, they die, but they are the only player that can die tonight.";
charSet[charName.lycanthrope] = setName.experimental;
group[charName.lycanthrope] = charGroup.townsfolk;
f_night[charName.lycanthrope] = 0;
o_night[charName.lycanthrope] = 21;
amy_order[charName.lycanthrope] = amyOrder.everyNightAsterisk

charCode[charName.magician] = "magician"
charIcon[charName.magician] = SprMagician
charTitle[charName.magician,language.russian] = "Фокусник"
charDesc[charName.magician,language.russian] = "Демон думает, что вы - Приспешник. Приспешники думают, что вы - Демон."
charTitle[charName.magician,language.english] = "Magician";
charDesc[charName.magician,language.english] = "The Demon thinks you are a Minion. Minions think you are a Demon.";
charSet[charName.magician] = setName.experimental;
group[charName.magician] = charGroup.townsfolk;
f_night[charName.magician] = 4;
o_night[charName.magician] = 0;
amy_order[charName.magician] = amyOrder.passive

charCode[charName.marionette] = "marionette"
charIcon[charName.marionette] = SprMarionette
charTitle[charName.marionette,language.russian] = "Марионетка"
charDesc[charName.marionette,language.russian] = "Вы думаете, что вы - Добрый персонаж, но это не так. Демон знает, кто вы. [Демон - ваш сосед]"
charTitle[charName.marionette,language.english] = "Marionette";
charDesc[charName.marionette,language.english] = "You think you are a good character, but you are not. The Demon knows who you are. [You neighbor the Demon]";
charSet[charName.marionette] = setName.experimental;
group[charName.marionette] = charGroup.minion;
f_night[charName.marionette] = 11;
o_night[charName.marionette] = 0;
amy_order[charName.marionette] = amyOrder.passive

charCode[charName.mezepheles] = "mezepheles"
charIcon[charName.mezepheles] = SprMezepheles
charTitle[charName.mezepheles,language.russian] = "Мезефель"
charDesc[charName.mezepheles,language.russian] = "В начале вы узнаёте секретное слово. Первый Добрый игрок, который произнесёт это слово становится Злым ночью."
charTitle[charName.mezepheles,language.english] = "Mezepheles";
charDesc[charName.mezepheles,language.english] = "You start knowing a secret word. The 1st good player to say this word becomes evil that night.";
charSet[charName.mezepheles] = setName.experimental;
group[charName.mezepheles] = charGroup.minion;
f_night[charName.mezepheles] = 26;
o_night[charName.mezepheles] = 18;
amy_order[charName.mezepheles] = amyOrder.oncePerGame

charCode[charName.nightwatchman] = "nightwatchman"
charIcon[charName.nightwatchman] = SprNightwatchman
charTitle[charName.nightwatchman,language.russian] = "Ночной сторож"
charDesc[charName.nightwatchman,language.russian] = "Раз в игру, ночью, выберите игрока. Этот игрок узнаёт, кто вы."
charTitle[charName.nightwatchman,language.english] = "Nightwatchman";
charDesc[charName.nightwatchman,language.english] = "Once per game, at night, choose a player: they learn who you are.";
charSet[charName.nightwatchman] = setName.experimental;
group[charName.nightwatchman] = charGroup.townsfolk;
f_night[charName.nightwatchman] = 48;
o_night[charName.nightwatchman] = 64;
amy_order[charName.nightwatchman] = amyOrder.oncePerGame

charCode[charName.noble] = "noble"
charIcon[charName.noble] = SprNoble
charTitle[charName.noble,language.russian] = "Знать"
charDesc[charName.noble,language.russian] = "В начале вы знаете 3 игроков. Один и только один из них - Злодей."
charTitle[charName.noble,language.english] = "Noble";
charDesc[charName.noble,language.english] = "You start knowing 3 players, 1 and only 1 of which is evil.";
charSet[charName.noble] = setName.experimental;
group[charName.noble] = charGroup.townsfolk;
f_night[charName.noble] = 45;
o_night[charName.noble] = 0;
amy_order[charName.noble] = amyOrder.firstNight

charCode[charName.pixie] = "pixie"
charIcon[charName.pixie] = SprPixie
charTitle[charName.pixie,language.russian] = "Пикси"
charDesc[charName.pixie,language.russian] = "В начале вы знаете 1 персонажа Горожанина, который есть в игре. Если вы \"спятили\", что вы - этот персонаж, то получите его способность, когда он умрёт."
charTitle[charName.pixie,language.english] = "Pixie";
charDesc[charName.pixie,language.english] = "You start knowing 1 in-play Townsfolk. If you were mad that you were this character, you gain their ability when they die.";
charSet[charName.pixie] = setName.experimental;
group[charName.pixie] = charGroup.townsfolk;
f_night[charName.pixie] = 28;
o_night[charName.pixie] = 3;
amy_order[charName.pixie] = amyOrder.firstNight

charCode[charName.politician] = "politician"
charIcon[charName.politician] = SprPolitician
charTitle[charName.politician,language.russian] = "Политик"
charDesc[charName.politician,language.russian] = "Если вы больше всех ответственны за то, что ваша команда проиграла, вы меняете сторону и побеждаете, даже если мертвы."
charTitle[charName.politician,language.english] = "Politician";
charDesc[charName.politician,language.english] = "If you were the player most responsible for your team losing, you change alignment & win, even if dead.";
charSet[charName.politician] = setName.experimental;
group[charName.politician] = charGroup.outsider;
f_night[charName.politician] = 43;
o_night[charName.politician] = 0;
amy_order[charName.politician] = amyOrder.passive

charCode[charName.poppygrower] = "poppy_grower"
charIcon[charName.poppygrower] = SprPoppyGrower
charTitle[charName.poppygrower,language.russian] = "Маковод"
charDesc[charName.poppygrower,language.russian] = "Приспешники и Демоны друг друга не знают. Если вы умираете, в эту ночь они узнают друг друга."
charTitle[charName.poppygrower,language.english] = "Poppy Grower";
charDesc[charName.poppygrower,language.english] = "Minions & Demons do not know each other. If you die, they learn who each other are that night.";
charSet[charName.poppygrower] = setName.experimental;
group[charName.poppygrower] = charGroup.townsfolk;
f_night[charName.poppygrower] = 3;
o_night[charName.poppygrower] = 0;
amy_order[charName.poppygrower] = amyOrder.passive

charCode[charName.preacher] = "preacher"
charIcon[charName.preacher] = SprPreacher
charTitle[charName.preacher,language.russian] = "Проповедник"
charDesc[charName.preacher,language.russian] = "Каждую ночь выберите игрока: если выбран Приспешник, он об этом узнаёт. Все выбранные Приспешники теряют способности."
charTitle[charName.preacher,language.english] = "Preacher";
charDesc[charName.preacher,language.english] = "Each night, choose a player: a Minion, if chosen, learns this. All chosen Minions have no ability.";
charSet[charName.preacher] = setName.experimental;
group[charName.preacher] = charGroup.townsfolk;
f_night[charName.preacher] = 13;
o_night[charName.preacher] = 5;
amy_order[charName.preacher] = amyOrder.everyNight

charCode[charName.psychopath] = "psychopath"
charIcon[charName.psychopath] = SprPsychopath
charTitle[charName.psychopath,language.russian] = "Психопат"
charDesc[charName.psychopath,language.russian] = "Каждый день, перед номинациями, публично выберите игрока. Этот игрок умирает. Если вы казнены, вы умираете только если проиграете в камень-ножницы-бумага."
charTitle[charName.psychopath,language.english] = "Psychopath";
charDesc[charName.psychopath,language.english] = "Each day, before nominations, you may publicly choose a player: they die. If executed, you only die if you lose roshambo.";
charSet[charName.psychopath] = setName.experimental;
group[charName.psychopath] = charGroup.minion;
f_night[charName.psychopath] = 0;
o_night[charName.psychopath] = 0;
amy_order[charName.psychopath] = amyOrder.dayActions

charCode[charName.puzzlemaster] = "puzzlemaster"
charIcon[charName.puzzlemaster] = SprPuzzlemaster
charTitle[charName.puzzlemaster,language.russian] = "Мастер головоломок"
charDesc[charName.puzzlemaster,language.russian] = "1 игрок пьян, даже если вы мертвы. Если вы угадаете кто (один раз за игру), узнаете, кто Демон. Если вы угадали неправильно, получите ложную информацию."
charTitle[charName.puzzlemaster,language.english] = "Puzzlemaster";
charDesc[charName.puzzlemaster,language.english] = "1 player is drunk, even if you die. If you guess (once) who it is, learn the Demon player, but guess wrong & get false info.";
charSet[charName.puzzlemaster] = setName.experimental;
group[charName.puzzlemaster] = charGroup.outsider;
f_night[charName.puzzlemaster] = 0;
o_night[charName.puzzlemaster] = 0;
amy_order[charName.puzzlemaster] = amyOrder.oncePerGame

charCode[charName.riot] = "riot"
charIcon[charName.riot] = SprRiot
charTitle[charName.riot,language.russian] = "Бунт"
charDesc[charName.riot,language.russian] = "Номинированные умирают, но могут сразу же номинировать снова (на 3 день, они обязаны). После 3 дня Зло побеждает. [Все Приспещники - Бунт]"
charTitle[charName.riot,language.english] = "Riot";
charDesc[charName.riot,language.english] = "Nominees die, but may nominate again immediately (on day 3, they must). After day 3, evil wins. [All Minions are Riot]";
charSet[charName.riot] = setName.experimental;
group[charName.riot] = charGroup.demon;
f_night[charName.riot] = 0;
o_night[charName.riot] = 0;
amy_order[charName.riot] = amyOrder.passive

charCode[charName.snitch] = "snitch"
charIcon[charName.snitch] = SprSnitch
charTitle[charName.snitch,language.russian] = "Стукач"
charDesc[charName.snitch,language.russian] = "Приспешники в начале знают 3 персонажей, которых нет в игре."
charTitle[charName.snitch,language.english] = "Snitch";
charDesc[charName.snitch,language.english] = "Minions start knowing 3 not-in-play characters.";
charSet[charName.snitch] = setName.experimental;
group[charName.snitch] = charGroup.outsider;
f_night[charName.snitch] = 6;
o_night[charName.snitch] = 0;
amy_order[charName.snitch] = amyOrder.firstNight

charCode[charName.widow] = "widow"
charIcon[charName.widow] = SprWidow
charTitle[charName.widow,language.russian] = "Вдова"
charDesc[charName.widow,language.russian] = "В первую ночь посмотрите Гримуар и выберите игрока: этот игрок отравлен. 1 Добрый игрок знает, что в игре есть Вдова."
charTitle[charName.widow,language.english] = "Widow";
charDesc[charName.widow,language.english] = "On your first night, look at the Grimoire & choose a player: they are poisoned. 1 good player knows a Widow is in play.";
charSet[charName.widow] = setName.experimental;
group[charName.widow] = charGroup.minion;
f_night[charName.widow] = 17;
o_night[charName.widow] = 0;
amy_order[charName.widow] = amyOrder.firstNight

charCode[charName.organgrinder] = "organ_grinder"
charIcon[charName.organgrinder] = SprOrganGrinder
charTitle[charName.organgrinder,language.russian] = "Шарманщик"
charDesc[charName.organgrinder,language.russian] = "Все игроки голосуют с закрытыми глазами. Подсчёт голосов скрыт. Голоса за вас засчитываются, только если вы сами проголосуете."
charTitle[charName.organgrinder,language.english] = "Organ Grinder";
charDesc[charName.organgrinder,language.english] = "All players keep their eyes closed when voting & the vote tally is secret. Votes for you only count if you vote.";
charSet[charName.organgrinder] = setName.experimental;
group[charName.organgrinder] = charGroup.minion;
f_night[charName.organgrinder] = 0;
o_night[charName.organgrinder] = 0;
amy_order[charName.organgrinder] = amyOrder.passive

charCode[charName.vizier] = "vizier"
charIcon[charName.vizier] = SprVizier
charTitle[charName.vizier,language.russian] = "Визирь"
charDesc[charName.vizier,language.russian] = "Все игроки знают кто вы. Вы не можете умереть днём. Если добрый игрок проголосовал, вы можете заставить сразу же казнить номинированного."
charTitle[charName.vizier,language.english] = "Vizier";
charDesc[charName.vizier,language.english] = "All players know who you are. You can not die during the day. If good voted, you may choose to execute immediately.";
charSet[charName.vizier] = setName.experimental;
group[charName.vizier] = charGroup.minion;
f_night[charName.vizier] = 55;
o_night[charName.vizier] = 0;
amy_order[charName.vizier] = amyOrder.passive

charCode[charName.knight] = "knight"
charIcon[charName.knight] = SprKnight
charTitle[charName.knight,language.russian] = "Рыцарь"
charDesc[charName.knight,language.russian] = "В начале вы знаете 2 игроков, которые не являются Демоном."
charTitle[charName.knight,language.english] = "Knight";
charDesc[charName.knight,language.english] = "You start knowing 2 players that are not the Demon.";
charSet[charName.knight] = setName.experimental;
group[charName.knight] = charGroup.townsfolk;
f_night[charName.knight] = 44;
o_night[charName.knight] = 0;
amy_order[charName.knight] = amyOrder.firstNight

charCode[charName.steward] = "steward"
charIcon[charName.steward] = SprSteward
charTitle[charName.steward,language.russian] = "Стюард"
charDesc[charName.steward,language.russian] = "В начале вы знаете 1 Доброго игрока."
charTitle[charName.steward,language.english] = "Steward";
charDesc[charName.steward,language.english] = "You start knowing 1 good player.";
charSet[charName.steward] = setName.experimental;
group[charName.steward] = charGroup.townsfolk;
f_night[charName.steward] = 43;
o_night[charName.steward] = 0;
amy_order[charName.steward] = amyOrder.firstNight

charCode[charName.highPriestess] = "high_priestess"
charIcon[charName.highPriestess] = SprHighPriestess
charTitle[charName.highPriestess,language.russian] = "Верховная жрица"
charDesc[charName.highPriestess,language.russian] = "Каждую ночь вы узнаёте с каким игроком, по мнению Рассказчика, вам стоит поговорить больше всего."
charTitle[charName.highPriestess,language.english] = "High Priestess";
charDesc[charName.highPriestess,language.english] = "Each night, learn which player the Storyteller believes you should talk to most.";
charSet[charName.highPriestess] = setName.experimental;
group[charName.highPriestess] = charGroup.townsfolk;
f_night[charName.highPriestess] = 51;
o_night[charName.highPriestess] = 68;
amy_order[charName.highPriestess] = amyOrder.everyNight

charCode[charName.harpy] = "harpy"
charIcon[charName.harpy] = SprHarpy
charTitle[charName.harpy,language.russian] = "Гарпия"
charDesc[charName.harpy,language.russian] = "Каждую ночь выберите 2 игроков: на следующий день первый игрок должен спятить, что второй - Злодей, иначе оба могут умереть."
charTitle[charName.harpy,language.english] = "Harpy";
charDesc[charName.harpy,language.english] = "Each night, choose 2 players: tomorrow, the 1st player is mad that the 2nd is evil, or both might die.";
charSet[charName.harpy] = setName.experimental;
group[charName.harpy] = charGroup.minion;
f_night[charName.harpy] = -1;
o_night[charName.harpy] = -1;
amy_order[charName.harpy] = amyOrder.everyNight

charCode[charName.plagueDoctor] = "plague_doctor"
charIcon[charName.plagueDoctor] = SprPlagueDoctor
charTitle[charName.plagueDoctor,language.russian] = "Чумной доктор"
charDesc[charName.plagueDoctor,language.russian] = "Когда вы умираете, Рассказчик получает способность Приспешника, которого нет в игре."
charTitle[charName.plagueDoctor,language.english] = "Plague Doctor";
charDesc[charName.plagueDoctor,language.english] = "If you die, the Storyteller gains a not-in-play Minion ability.";
charSet[charName.plagueDoctor] = setName.experimental;
group[charName.plagueDoctor] = charGroup.outsider;
f_night[charName.plagueDoctor] = -1;
o_night[charName.plagueDoctor] = -1;
amy_order[charName.plagueDoctor] = amyOrder.triggerOncePerGame;

charCode[charName.shugenja] = "shugenja"
charIcon[charName.shugenja] = SprShugenja
charTitle[charName.shugenja,language.russian] = "Cюгэндзя"
charDesc[charName.shugenja,language.russian] = "В начале вы знаете, с какой стороны ближайший к вам Злодей, по часовой или против часовой. Если одинаково, информация даётся по решению ведущего."
charTitle[charName.shugenja,language.english] = "Shugenja";
charDesc[charName.shugenja,language.english] = "You start knowing if your closest evil player is clockwise or anti-clockwise. If equidistant, this info is arbitrary.";
charSet[charName.shugenja] = setName.experimental;
group[charName.shugenja] = charGroup.townsfolk;
f_night[charName.shugenja] = 44;
o_night[charName.shugenja] = 0;
amy_order[charName.shugenja] = amyOrder.firstNight

charCode[charName.ojo] = "ojo"
charIcon[charName.ojo] = SprOjo
charTitle[charName.ojo,language.russian] = "Оджо"
charDesc[charName.ojo,language.russian] = "Каждую ночь* вы выбираете персонажа: он умирает. Если такого персонажа нет в игре, Рассказчик выбирает, кто умрёт."
charTitle[charName.ojo,language.english] = "Ojo";
charDesc[charName.ojo,language.english] = "Each night*, choose a character: they die. If they are not in play, the Storyteller chooses who dies.";
charSet[charName.ojo] = setName.experimental;
group[charName.ojo] = charGroup.demon;
f_night[charName.ojo] = 0;
o_night[charName.ojo] = 32;
amy_order[charName.ojo] = amyOrder.everyNightAsterisk;

charCode[charName.hatter] = "hatter"
charIcon[charName.hatter] = SprHatter
charTitle[charName.hatter,language.russian] = "Шляпник"
charDesc[charName.hatter,language.russian] = "Если сегодня днём или ночью вы умерли, Приспешники и Демоны могут выбрать себе новых персонажей Приспешников и Демонов, чтобы стать ими."
charTitle[charName.hatter,language.english] = "Hatter";
charDesc[charName.hatter,language.english] = "If you died today or tonight, the Minion & Demon players may choose new Minion & Demon characters to be.";
charSet[charName.hatter] = setName.experimental;
group[charName.hatter] = charGroup.outsider;
f_night[charName.hatter] = 0;
o_night[charName.hatter] = 32;
amy_order[charName.hatter] = amyOrder.triggerOncePerGame;

charCode[charName.kazali] = "kazali"
charIcon[charName.kazali] = SprKazali
charTitle[charName.kazali,language.russian] = "Казали"
charDesc[charName.kazali,language.russian] = "Каждую ночь*, вы выбираете игрока: он умирает. [Вы выбираете какие игроки какими приспешниками становятся. От -? до +? Посторонних]"
charTitle[charName.kazali,language.english] = "Kazali";
charDesc[charName.kazali,language.english] = "Each night*, choose a player: they die. [You choose which players are which Minions. -? to +? Outsiders]";
charSet[charName.kazali] = setName.experimental;
group[charName.kazali] = charGroup.demon;
f_night[charName.kazali] = 0;
o_night[charName.kazali] = 32;
amy_order[charName.kazali] = amyOrder.everyNightAsterisk;

charCode[charName.village_idiot] = "village_idiot"
charIcon[charName.village_idiot] = SprVillageIdiot
charTitle[charName.village_idiot,language.russian] = "Деревенский Дурачок"
charDesc[charName.village_idiot,language.russian] = "Каждую ночь, вы выбираете игрока: вы узнаёте на какой стороне он играет. [От +0 до +2 Деревенских Дурачков. Один из них пьян]"
charTitle[charName.village_idiot,language.english] = "Village Idiot";
charDesc[charName.village_idiot,language.english] = "Each night, choose a player: you learn their alignment. [+0 to +2 Village Idiots. 1 of the extras is drunk]";
charSet[charName.village_idiot] = setName.experimental;
group[charName.village_idiot] = charGroup.townsfolk;
f_night[charName.village_idiot] = 0;
o_night[charName.village_idiot] = 32;
amy_order[charName.village_idiot] = amyOrder.everyNight;

charCode[charName.yaggababble] = "yaggababble"
charIcon[charName.yaggababble] = SprYaggababble
charTitle[charName.yaggababble,language.russian] = "Яга Болтунья"
charDesc[charName.yaggababble,language.russian] = "В начале вы узнаёте секретную фразу. Каждый раз, когда вы днём говорите эту фразу публично, ночью может умереть игрок."
charTitle[charName.yaggababble,language.english] = "Yaggababble";
charDesc[charName.yaggababble,language.english] = "You start knowing a secret phrase. For each time you said it publicly today, a player might die.";
charSet[charName.yaggababble] = setName.experimental;
group[charName.yaggababble] = charGroup.demon;
f_night[charName.yaggababble] = 0;
o_night[charName.yaggababble] = 32;
amy_order[charName.yaggababble] = amyOrder.firstAndEveryNight;

charCode[charName.banshee] = "banshee"
charIcon[charName.banshee] = SprBanshee
charTitle[charName.banshee,language.russian] = "Банши"
charDesc[charName.banshee,language.russian] = "Если Демон убьёт вас, все игроки узнают об этом. С этого момента вы можете номинировать дважды в день и голосовать дважды за номинацию."
charTitle[charName.banshee,language.english] = "Banshee";
charDesc[charName.banshee,language.english] = "If the Demon kills you, all players learn this. From now on, you may nominate twice per day and vote twice per nomination.";
charSet[charName.banshee] = setName.experimental;
group[charName.banshee] = charGroup.townsfolk;
f_night[charName.banshee] = 0;
o_night[charName.banshee] = 32;
amy_order[charName.banshee] = amyOrder.triggerOncePerGame;

charCode[charName.summoner] = "summoner"
charIcon[charName.summoner] = SprSummoner
charTitle[charName.summoner,language.russian] = "Призыватель"
charDesc[charName.summoner,language.russian] = "Вы получаете 3 блефа. В 3-ю ночь вы выбираете игрока: он становится Злым Демоном по вашему выбору. [Нет Демона]"
charTitle[charName.summoner,language.english] = "Summoner";
charDesc[charName.summoner,language.english] = "You get 3 bluffs. On the 3rd night, choose a player: they become an evil Demon of your choice. [No Demon]";
charSet[charName.summoner] = setName.experimental;
group[charName.summoner] = charGroup.minion;
f_night[charName.summoner] = 0;
o_night[charName.summoner] = 32;
amy_order[charName.summoner] = amyOrder.triggerOncePerGame;

charCode[charName.ogre] = "ogre"
charIcon[charName.ogre] = SprOgre
charTitle[charName.ogre,language.russian] = "Огр"
charDesc[charName.ogre,language.russian] = "В первую ночь вы выбираете игрока (не себя): вы переходите на его сторону (но не знаете какую), даже если вы пьяны или отравлены."
charTitle[charName.ogre,language.english] = "Ogre";
charDesc[charName.ogre,language.english] = "On your 1st night, choose a player (not yourself): you become their alignment (you don't know which) even if drunk or poisoned.";
charSet[charName.ogre] = setName.experimental;
group[charName.ogre] = charGroup.outsider;
f_night[charName.ogre] = 0;
o_night[charName.ogre] = 32;
amy_order[charName.ogre] = amyOrder.firstNight;

/// Fabled

fabledCode[fabledName.angel] = "angel"
fabledIcon[fabledName.angel] = SprAngel
fabledTitle[fabledName.angel,language.russian] = "Ангел"
fabledDesc[fabledName.angel,language.russian] = "Что-то плохое может случится с тем, кто больше всего ответственен за смерть нового игрока."
fabledTitle[fabledName.angel,language.english] = "Angel"
fabledDesc[fabledName.angel,language.english] = "Something bad might happen to whoever is most responsible for the death of a new player."

fabledCode[fabledName.buddhist] = "buddhist"
fabledIcon[fabledName.buddhist] = SprBuddhist
fabledTitle[fabledName.buddhist,language.russian] = "Буддист"
fabledDesc[fabledName.buddhist,language.russian] = "Первые 2 минуты каждого дня игроки-ветераны не могут разговаривать."
fabledTitle[fabledName.buddhist,language.english] = "Buddhist"
fabledDesc[fabledName.buddhist,language.english] = "For the first 2 minutes of each day, veteran players may not talk."

fabledCode[fabledName.djinn] = "djinn"
fabledIcon[fabledName.djinn] = SprDjinn
fabledTitle[fabledName.djinn,language.russian] = "Джинн"
fabledDesc[fabledName.djinn,language.russian] = "Используйте специальное правило Джинна. Все игроки знают это правило."
fabledTitle[fabledName.djinn,language.english] = "Djinn"
fabledDesc[fabledName.djinn,language.english] = "Use the Djinn's special rule. All players know what it is."

fabledCode[fabledName.doomsayer] = "doomsayer"
fabledIcon[fabledName.doomsayer] = SprDoomsayer
fabledTitle[fabledName.doomsayer,language.russian] = "Пророк конца света"
fabledDesc[fabledName.doomsayer,language.russian] = "Если 4+ игроков живы, каждый живой игрок может публично выбрать (раз за игру), что игрок его стороны умирает."
fabledTitle[fabledName.doomsayer,language.english] = "Doomsayer"
fabledDesc[fabledName.doomsayer,language.english] = "If 4 or more players live, each living player may publicly choose (once per game) that a player of their own alignment dies."

fabledCode[fabledName.duchess] = "duchess"
fabledIcon[fabledName.duchess] = SprDuchess
fabledTitle[fabledName.duchess,language.russian] = "Герцогиня"
fabledDesc[fabledName.duchess,language.russian] = "Каждый день 3 игрока могут выбрать посетить вас. Каждую ночь* каждый посетитель узнаёт, сколько из них было Злодеями, но один из них получает ложную информацию."
fabledTitle[fabledName.duchess,language.english] = "Duchess"
fabledDesc[fabledName.duchess,language.english] = "Each day, 3 players may choose to visit you. At night*, each visitor learns how many visitors are evil, but 1 gets false info."

fabledCode[fabledName.fibbin] = "fibbin"
fabledIcon[fabledName.fibbin] = SprFibbin
fabledTitle[fabledName.fibbin,language.russian] = "Трепач"
fabledDesc[fabledName.fibbin,language.russian] = "Один раз за игру, 1 Добрый игрок может получить неверную информацию."
fabledTitle[fabledName.fibbin,language.english] = "Fibbin"
fabledDesc[fabledName.fibbin,language.english] = "Once per game, 1 good player might get incorrect information."

fabledCode[fabledName.ferryman] = "ferryman"
fabledIcon[fabledName.ferryman] = SprFerryman
fabledTitle[fabledName.ferryman,language.russian] = "Паромщик"
fabledDesc[fabledName.ferryman,language.russian] = "На последний день, все мёртвые игроки возвращают себе жетон голоса."
fabledTitle[fabledName.ferryman,language.english] = "Ferryman"
fabledDesc[fabledName.ferryman,language.english] = "On the final day, all dead players regain their vote token."

fabledCode[fabledName.fiddler] = "fiddler"
fabledIcon[fabledName.fiddler] = SprFiddler
fabledTitle[fabledName.fiddler,language.russian] = "Скрипач"
fabledDesc[fabledName.fiddler,language.russian] = "Раз за игру Демон в закрытую выбирает игрока противоположной стороны: все игроки выбирают, кто из них двоих побеждает."
fabledTitle[fabledName.fiddler,language.english] = "Fiddler"
fabledDesc[fabledName.fiddler,language.english] = "Once per game, the Demon secretly chooses an opposing player: all players choose which of these 2 players win."

fabledCode[fabledName.hellslibrarian] = "hells_librarian"
fabledIcon[fabledName.hellslibrarian] = SprHellsLibrarian
fabledTitle[fabledName.hellslibrarian,language.russian] = "Библиотекарь Ада"
fabledDesc[fabledName.hellslibrarian,language.russian] = "Что-то плохое может случиться с тем, кто разговаривает, когда Рассказчик попросил тишины."
fabledTitle[fabledName.hellslibrarian,language.english] = "Hell's Librarian"
fabledDesc[fabledName.hellslibrarian,language.english] = "Something bad might happen to whoever talks when the Storyteller has asked for silence."

fabledCode[fabledName.revolutionary] = "revolutionary"
fabledIcon[fabledName.revolutionary] = SprRevolutionary
fabledTitle[fabledName.revolutionary,language.russian] = "Революционер"
fabledDesc[fabledName.revolutionary,language.russian] = "Все в игре знают, что 2 соседствующих игрока на одной стороне. Раз в игру один из них считается неправильно для другой способности."
fabledTitle[fabledName.revolutionary,language.english] = "Revolutionary"
fabledDesc[fabledName.revolutionary,language.english] = "2 neighboring players are known to be the same alignment. Once per game, 1 of them registers falsely."

fabledCode[fabledName.spiritofivory] = "spirit_of_ivory"
fabledIcon[fabledName.spiritofivory] = SprSpiritOfIvory
fabledTitle[fabledName.spiritofivory,language.russian] = "Костянной дух"
fabledDesc[fabledName.spiritofivory,language.russian] = "В игре не может быть больше 1 лишнего Злодея."
fabledTitle[fabledName.spiritofivory,language.english] = "Spirit Of Ivory"
fabledDesc[fabledName.spiritofivory,language.english] = "There can't be more than 1 extra evil player."

fabledCode[fabledName.sentinel] = "sentinel"
fabledIcon[fabledName.sentinel] = SprSentinel
fabledTitle[fabledName.sentinel,language.russian] = "Часовой"
fabledDesc[fabledName.sentinel,language.russian] = "В игре может быть на 1 больше или на 1 меньше Постороннего."
fabledTitle[fabledName.sentinel,language.english] = "Sentinel"
fabledDesc[fabledName.sentinel,language.english] = "There might be 1 extra or 1 fewer Outsider in play."

fabledCode[fabledName.stormcatcher] = "storm_catcher"
fabledIcon[fabledName.stormcatcher] = SprStormCatcher
fabledTitle[fabledName.stormcatcher,language.russian] = "Ловец молний"
fabledDesc[fabledName.stormcatcher,language.russian] = "Назовите Доброго персонажа. Если этот персонаж в игре, он может умереть только через казнь. Злодеи знают, какой это игрок."
fabledTitle[fabledName.stormcatcher,language.english] = "Storm Catcher"
fabledDesc[fabledName.stormcatcher,language.english] = "Name a good character. If in play, they can only die by execution, but evil players learn which player it is."

fabledCode[fabledName.toymaker] = "toymaker"
fabledIcon[fabledName.toymaker] = SprToymaker
fabledTitle[fabledName.toymaker,language.russian] = "Создатель игрушек"
fabledDesc[fabledName.toymaker,language.russian] = "Демон может выбрать не атаковать и обязан так сделать хотя бы раз за игру. Злодеи получают нормальную начальную информацию."
fabledTitle[fabledName.toymaker,language.english] = "Toymaker"
fabledDesc[fabledName.toymaker,language.english] = "The Demon may choose not to attack & must do this at least once per game. Evil players get normal starting info."

fabledCode[fabledName.gardener] = "gardener"
fabledIcon[fabledName.gardener] = SprGardener
fabledTitle[fabledName.gardener,language.russian] = "Садовник"
fabledDesc[fabledName.gardener,language.russian] = "Рассказчик назначает персонажей одному или более игрокам."
fabledTitle[fabledName.gardener,language.english] = "Gardener"
fabledDesc[fabledName.gardener,language.english] = "The Storyteller assigns 1 or more players' characters."

fabledCode[fabledName.bootlegger] = "bootlegger"
fabledIcon[fabledName.bootlegger] = SprBootlegger
fabledTitle[fabledName.bootlegger,language.russian] = "Контрабандист"
fabledDesc[fabledName.bootlegger,language.russian] = "В сценарии присутствуют неофициальные персонажи или правила."
fabledTitle[fabledName.bootlegger,language.english] = "Bootlegger"
fabledDesc[fabledName.bootlegger,language.english] = "This script has homebrew characters or rules."

/// Travellers

travellerCode[travellerName.apprentice] = "apprentice"
travellerIcon[travellerName.apprentice] = SprApprentice
travellerTitle[travellerName.apprentice,language.russian] = "Подмастерье"
travellerDesc[travellerName.apprentice,language.russian] = "В вашу первую ночь вы получаете способность Горожанина (если Добрый) или способность Приспешника (если Злодей)."
travellerTitle[travellerName.apprentice,language.english] = "Apprentice"
travellerDesc[travellerName.apprentice,language.english] = "On your 1st night, you gain a Townsfolk ability (if good) or a Minion ability (if evil)."

travellerCode[travellerName.barista] = "barista"
travellerIcon[travellerName.barista] = SprBarista
travellerTitle[travellerName.barista,language.russian] = "Бариста"
travellerDesc[travellerName.barista,language.russian] = "Каждую ночь до заката: 1) игрок становится трезв, здоров и получает верную информацию или 2) их способность срабатывает дважды. Этот игрок узнаёт что именно произошло."
travellerTitle[travellerName.barista,language.english] = "Barista"
travellerDesc[travellerName.barista,language.english] = "Each night, until dusk, 1) a player becomes sober, healthy & gets true info, or 2) their ability works twice. They learn which."

travellerCode[travellerName.beggar] = "beggar"
travellerIcon[travellerName.beggar] = SprBeggar
travellerTitle[travellerName.beggar,language.russian] = "Попрошайка"
travellerDesc[travellerName.beggar,language.russian] = "Вы обязаны использовать жетон голоса, чтобы голосовать. Если мёртвый игрок отдаст вам свой жетон, вы узнаёте его сторону. Вы трезвы и здоровы."
travellerTitle[travellerName.beggar,language.english] = "Beggar"
travellerDesc[travellerName.beggar,language.english] = "You must use a vote token to vote. If a dead player gives you theirs, you learn their alignment. You are sober and healthy."

travellerCode[travellerName.bishop] = "bishop"
travellerIcon[travellerName.bishop] = SprBishop
travellerTitle[travellerName.bishop,language.russian] = "Епископ"
travellerDesc[travellerName.bishop,language.russian] = "Только рассказчик может номинировать. Каждый день должен быть номинирован хотя бы 1 игрок противоположной команды."
travellerTitle[travellerName.bishop,language.english] = "Bishop"
travellerDesc[travellerName.bishop,language.english] = "Only the Storyteller can nominate. At least 1 opposing player must be nominated each day."

travellerCode[travellerName.bonecollector] = "bone_collector"
travellerIcon[travellerName.bonecollector] = SprBoneCollector
travellerTitle[travellerName.bonecollector,language.russian] = "Собиратель костей"
travellerDesc[travellerName.bonecollector,language.russian] = "Раз за игру ночью* выберите мёртвого игрока: этот игрок возвращает свою способность до заката."
travellerTitle[travellerName.bonecollector,language.english] = "Bone Collector"
travellerDesc[travellerName.bonecollector,language.english] = "Once per game, at night, choose a dead player: they regain their ability until dusk."

travellerCode[travellerName.bureaucrat] = "bureaucrat"
travellerIcon[travellerName.bureaucrat] = SprBureaucrat
travellerTitle[travellerName.bureaucrat,language.russian] = "Бюрократ"
travellerDesc[travellerName.bureaucrat,language.russian] = "Каждую ночь вы выбираете игрока (не себя), днём его голос будет считаться за 3 голоса."
travellerTitle[travellerName.bureaucrat,language.english] = "Bureaucrat"
travellerDesc[travellerName.bureaucrat,language.english] = "Each night, choose a player (not yourself): their vote counts as 3 votes tomorrow."

travellerCode[travellerName.butcher] = "butcher"
travellerIcon[travellerName.butcher] = SprButcher
travellerTitle[travellerName.butcher,language.russian] = "Мясник"
travellerDesc[travellerName.butcher,language.russian] = "Каждый день после первой казни, вы можете номинировать снова."
travellerTitle[travellerName.butcher,language.english] = "Butcher"
travellerDesc[travellerName.butcher,language.english] = "Each day, after the 1st execution, you may nominate again."

travellerCode[travellerName.deviant] = "deviant"
travellerIcon[travellerName.deviant] = SprDeviant
travellerTitle[travellerName.deviant,language.russian] = "Девиант"
travellerDesc[travellerName.deviant,language.russian] = "Если днём вы были смешными, вы не умираете от изгнания."
travellerTitle[travellerName.deviant,language.english] = "Deviant"
travellerDesc[travellerName.deviant,language.english] = "If you were funny today, you cannot be exiled."

travellerCode[travellerName.gangster] = "gangster"
travellerIcon[travellerName.gangster] = SprGangster
travellerTitle[travellerName.gangster,language.russian] = "Гангстер"
travellerDesc[travellerName.gangster,language.russian] = "Раз в день можете убить своего живого соседа, если другой живой сосед согласен."
travellerTitle[travellerName.gangster,language.english] = "Gangster"
travellerDesc[travellerName.gangster,language.english] = "Once per day, you may choose to kill an alive neighbor, if your other alive neighbor agrees."

travellerCode[travellerName.gunslinger] = "gunslinger"
travellerIcon[travellerName.gunslinger] = SprGunslinger
travellerTitle[travellerName.gunslinger,language.russian] = "Стрелок"
travellerDesc[travellerName.gunslinger,language.russian] = "Каждый день, после того как засчитается первый голос, можете выбрать игрока, который голосовал, он умирает."
travellerTitle[travellerName.gunslinger,language.english] = "Gunslinger"
travellerDesc[travellerName.gunslinger,language.english] = "Each day, after the 1st vote has been tallied, you may choose a player that voted: they die."

travellerCode[travellerName.harlot] = "harlot"
travellerIcon[travellerName.harlot] = SprHarlot
travellerTitle[travellerName.harlot,language.russian] = "Блудница"
travellerDesc[travellerName.harlot,language.russian] = "Каждую ночь* выбираете живого игрока: если он согласен, узнайте его сторону, но вы оба можете умереть."
travellerTitle[travellerName.harlot,language.english] = "Harlot"
travellerDesc[travellerName.harlot,language.english] = "Each night*, choose a living player: if they agree, you learn their character, but you both might die."

travellerCode[travellerName.judge] = "judge"
travellerIcon[travellerName.judge] = SprJudge
travellerTitle[travellerName.judge,language.russian] = "Судья"
travellerDesc[travellerName.judge,language.russian] = "Раз за игру, если номинировал другой игрок, можете сделать текущую номинацию на казнь успешной и окончательной или отменить её."
travellerTitle[travellerName.judge,language.english] = "Judge"
travellerDesc[travellerName.judge,language.english] = "Once per game, if another player nominated, you may choose to force the current execution to pass or fail."

travellerCode[travellerName.matron] = "matron"
travellerIcon[travellerName.matron] = SprMatron
travellerTitle[travellerName.matron,language.russian] = "Надзирательница"
travellerDesc[travellerName.matron,language.russian] = "Каждый день можете выбрать до 3 наборов из 2 игроков: они меняются местами в кругу игроков. Игроки не могут вставать, чтобы приватно общаться."
travellerTitle[travellerName.matron,language.english] = "Matron"
travellerDesc[travellerName.matron,language.english] = "Each day, you may choose up to 3 sets of 2 players to swap seats. Players may not leave their seats to talk in private."

travellerCode[travellerName.scapegoat] = "scapegoat"
travellerIcon[travellerName.scapegoat] = SprScapegoat
travellerTitle[travellerName.scapegoat,language.russian] = "Козёл отпущения"
travellerDesc[travellerName.scapegoat,language.russian] = "Если игрок на вашей стороне казнён, вас могут казнить вместо него."
travellerTitle[travellerName.scapegoat,language.english] = "Scapegoat"
travellerDesc[travellerName.scapegoat,language.english] = "If a player of your alignment is executed, you might be executed instead."

travellerCode[travellerName.thief] = "thief"
travellerIcon[travellerName.thief] = SprThief
travellerTitle[travellerName.thief,language.russian] = "Вор"
travellerDesc[travellerName.thief,language.russian] = "Каждую ночь выбираете игрока (не себя): днём его голос засчитывается в минус."
travellerTitle[travellerName.thief,language.english] = "Thief"
travellerDesc[travellerName.thief,language.english] = "Each night, choose a player (not yourself): their vote counts negatively tomorrow."

travellerCode[travellerName.voudon] = "voudon"
travellerIcon[travellerName.voudon] = SprVoudon
travellerTitle[travellerName.voudon,language.russian] = "Вудон"
travellerDesc[travellerName.voudon,language.russian] = "Только вы и мёртвые можете голосовать. Мёртвым не нужны жетоны голосов для этого. Правило о половине голосов для казни не работает."
travellerTitle[travellerName.voudon,language.english] = "Voudon"
travellerDesc[travellerName.voudon,language.english] = "Only you & the dead can vote. They don't need a vote token to do so. A 50% majority isn't required."


/// First night Other night

first_night_order_array = scr_make_array(
    -999,
    -travellerName.barista,
    -travellerName.apprentice,
    -travellerName.thief,
    -travellerName.bureaucrat,
    charName.philosopher,
    charName.kazali,
    charName.alchemist,
    charName.poppygrower,
    charName.yaggababble,
    charName.magician,
    -999,
    charName.snitch,
    charName.lunatic,
    -999,
    charName.king,
    charName.sailor,
    charName.marionette,
    charName.engineer,
    charName.preacher,
    charName.lilmonsta,
    charName.lleech,
    charName.poisoner,
    charName.widow,
    charName.courtier,
    charName.snakecharmer,
    charName.godfather,
    charName.devilsadvocate,
    charName.eviltwin,
    charName.witch,
    charName.cerenovus,
    charName.fearmonger,
    charName.harpy,
    charName.mezepheles,
    charName.pukka,
    charName.pixie,
    charName.huntsman,
    charName.damsel,
    charName.amnesiac,
    charName.washerwoman,
    charName.librarian,
    charName.investigator,
    charName.chef,
    charName.empath,
    charName.fortuneteller,
    charName.butler,
    charName.grandmother,
    charName.clockmaker,
    charName.dreamer,
    charName.seamstress,
    charName.steward,
    charName.knight,
    charName.noble,
    charName.balloonist,
    charName.shugenja,
    charName.village_idiot,
    charName.bountyhunter,
    charName.nightwatchman,
    charName.cultleader,
    charName.spy,
    charName.ogre,
    charName.highPriestess,
    charName.general,
    charName.chambermaid,
    charName.mathematician,
    -999,
    charName.vizier,
    charName.leviathan
)
first_night_order_array_length = array_length_1d(first_night_order_array)

other_night_order_array = scr_make_array(
    -999,
    -travellerName.bureaucrat,
    -travellerName.thief,
    -travellerName.barista,
    -travellerName.harlot,
    -travellerName.bonecollector,
    charName.philosopher,
    charName.poppygrower,
    charName.sailor,
    charName.pixie,
    charName.engineer,
    charName.preacher,
    charName.poisoner,
    charName.courtier,
    charName.innkeeper,
    charName.gambler,
    charName.snakecharmer,
    charName.monk,
    charName.devilsadvocate,
    charName.witch,
    charName.cerenovus,
    charName.pithag,
    charName.fearmonger,
    charName.harpy,
    charName.mezepheles,
    charName.scarletwoman,
    charName.summoner,
    charName.lunatic,
    charName.exorcist,
    charName.lycanthrope,
    charName.legion,
    charName.imp,
    charName.zombuul,
    charName.pukka,
    charName.shabaloth,
    charName.po,
    charName.fanggu,
    charName.nodashii,
    charName.vortox,
    charName.vigormortis,
    charName.ojo,
    charName.alhadikhia,
    charName.lleech,
    charName.lilmonsta,
    charName.yaggababble,
    charName.kazali,
    charName.assassin,
    charName.godfather,
    charName.gossip,
    charName.acrobat,
    charName.hatter,
    charName.barber,
    charName.sweetheart,
    charName.sage,
    charName.banshee,
    charName.professor,
    charName.choirboy,
    charName.huntsman,
    charName.damsel,
    charName.amnesiac,
    charName.farmer,
    charName.tinker,
    charName.moonchild,
    charName.grandmother,
    charName.ravenkeeper,
    charName.empath,
    charName.fortuneteller,
    charName.undertaker,
    charName.dreamer,
    charName.flowergirl,
    charName.towncrier,
    charName.oracle,
    charName.seamstress,
    charName.juggler,
    charName.balloonist,
    charName.village_idiot,
    charName.king,
    charName.bountyhunter,
    charName.nightwatchman,
    charName.cultleader,
    charName.butler,
    charName.spy,
    charName.highPriestess,
    charName.general,
    charName.chambermaid,
    charName.mathematician,
    -999,
    charName.leviathan
)
other_night_order_array_length = array_length_1d(other_night_order_array)

f_night_demon_info = 14;
f_night_minion_info = 11;
f_night_dawn_order = 65;
o_night_dawn_order = 86;

for(i=0; i<charName.lastChar; i++) {
    for(j=1;j<first_night_order_array_length;j++) {
        f_night[i] = 0;
        if (first_night_order_array[j] = i) {
            f_night[i] = j;
            break;
        }
    }
    for(j=1;j<other_night_order_array_length;j++) {
        o_night[i] = 0;
        if (other_night_order_array[j] = i) {
            o_night[i] = j;
            break;
        }
    }
}

for(i=1; i<travellerName.lastChar; i++) {
    for(j=1;j<first_night_order_array_length;j++) {
        traveller_f_night[i] = 0;
        if (first_night_order_array[j] = -i) {
            traveller_f_night[i] = j;
            break;
        }
    }
    for(j=1;j<other_night_order_array_length;j++) {
        traveller_o_night[i] = 0;
        if (other_night_order_array[j] = -i) {
            traveller_o_night[i] = j;
            break;
        }
    }
}

/// Tags

tag_filter_amount = 44;
tag_filter_mode = 0; // 0 - sum, join
for(i=0;i<tag_filter_amount;i++) {
    tag_filter_enable[i] = 0;
    tag_filter_disable[i] = 0;
}

tag_filter_desc[0,language.russian] = "Меняют кол-во посторонних на сетапе игры";
tag_filter_name[0,language.russian] = "Счёт Посторонних";
tag_filter_desc[0,language.english] = "Changes amount of Outsiders on game setup";
tag_filter_name[0,language.english] = "Outsider Count";
tag_filter_arr[0] = scr_make_array(charName.huntsman,charName.balloonist,charName.vigormortis,charName.fanggu,charName.godfather,charName.baron,charName.kazali);

tag_filter_desc[1,language.russian] = "Всё, что меняет голосование, силу голоса, триггерится за счёт голосов";
tag_filter_name[1,language.russian] = "Голосование";
tag_filter_desc[1,language.english] = "Everything affecting voting, power of vote or triggers by votes";
tag_filter_name[1,language.english] = "Voting";
tag_filter_arr[1] = scr_make_array(charName.banshee,charName.organgrinder,charName.legion,charName.cultleader,charName.flowergirl,charName.butler);

tag_filter_desc[2,language.russian] = "Персонажи зависящие от расположения игроков в кругу";
tag_filter_name[2,language.russian] = "Позиционирование";
tag_filter_desc[2,language.english] = "Characters, that depend on/tied with player position in circle";
tag_filter_name[2,language.english] = "Positioning";
tag_filter_arr[2] = scr_make_array(charName.marionette,charName.acrobat,charName.nodashii,charName.clockmaker,charName.tealady,charName.chef,charName.empath,charName.shugenja);

tag_filter_desc[42,language.russian] = "Персонажи, получающие информацию в первую ночь, или дающие другим информацию в первую ночь";
tag_filter_name[42,language.russian] = "Инфо в первую ночь";
tag_filter_desc[42,language.english] = "Characters, that gain information first night or give others information on the first night";
tag_filter_name[42,language.english] = "First Night Info";
tag_filter_arr[42] = scr_make_array(charName.steward,charName.knight,charName.snitch,charName.pixie,charName.noble,charName.bountyhunter,charName.clockmaker,charName.grandmother,charName.godfather,charName.chef,charName.investigator,charName.librarian,charName.washerwoman,charName.shugenja);

tag_filter_desc[3,language.russian] = "Всё, что может помочь вычислить злодеев";
tag_filter_name[3,language.russian] = "Скан Злодеев";
tag_filter_desc[3,language.english] = "Everything, that helps finding out Evil";
tag_filter_name[3,language.english] = "Evil Scan";
tag_filter_arr[3] = scr_make_array(charName.poppygrower,charName.village_idiot,charName.noble,charName.magician,charName.lycanthrope,charName.king,charName.bountyhunter,charName.seamstress,charName.oracle,charName.klutz,charName.juggler,charName.dreamer,charName.clockmaker,charName.tealady,charName.moonchild,charName.chef,charName.empath,charName.shugenja);

tag_filter_desc[4,language.russian] = "Всё, что может помочь определить кто приспешник, какие приспешники в игре и т. д.";
tag_filter_name[4,language.russian] = "Скан Приспешников";
tag_filter_desc[4,language.english] = "Everything, that helps find out Minions, which Minions are in play or Minion-related information";
tag_filter_name[4,language.english] = "Minion Scan";
tag_filter_arr[4] = scr_make_array(charName.preacher,charName.engineer,charName.balloonist,charName.alchemist,charName.towncrier,charName.juggler,charName.minstrel,charName.investigator);

tag_filter_desc[5,language.russian] = "Всё, что может помочь определить кто демон, какой демон в игре и т. д.";
tag_filter_name[5,language.russian] = "Скан Демона";
tag_filter_desc[5,language.english] = "Everything, that helps find out Demon, which Demon is in play or Demon-related information";
tag_filter_name[5,language.english] = "Demon Scan";
tag_filter_arr[5] = scr_make_array(charName.knight,charName.puzzlemaster,charName.golem,charName.engineer,charName.choirboy,charName.balloonist,charName.snakecharmer,charName.sage,charName.juggler,charName.flowergirl,charName.exorcist,charName.fortuneteller,charName.slayer);

tag_filter_desc[6,language.russian] = "Использует механику опьянения (опьянение чаще связано с Добрыми персонажами)";
tag_filter_name[6,language.russian] = "Пьянство";
tag_filter_desc[6,language.english] = "Using the drunk mechanic (generally connected to Good characters)";
tag_filter_name[6,language.english] = "Drunk";
tag_filter_arr[6] = scr_make_array(charName.puzzlemaster,charName.village_idiot,charName.acrobat,charName.sweetheart,charName.snakecharmer,charName.philosopher,charName.mathematician,charName.sailor,charName.minstrel,charName.innkeeper,charName.goon,charName.drunk,charName.courtier);

tag_filter_desc[7,language.russian] = "Персонажи, которые думают, что они другие персонажи, заставляют других думать что-то или механики около этого";
tag_filter_name[7,language.russian] = "Думает что";
tag_filter_desc[7,language.english] = "Characters, who think they are other characters, make other people think something or don't know something about their ability";
tag_filter_name[7,language.english] = "Thinks, that...";
tag_filter_arr[7] = scr_make_array(charName.marionette,charName.cannibal,charName.amnesiac,charName.zombuul,charName.lunatic,charName.drunk);

tag_filter_desc[8,language.russian] = "Персонажи, просыпающиеся каждую ночь";
tag_filter_name[8,language.russian] = "Каждую ночь";
tag_filter_desc[8,language.english] = "Characters, who wake up every night";
tag_filter_name[8,language.english] = "Every night";
tag_filter_arr[8] = scr_make_array(charName.harpy,charName.yaggababble,charName.kazali,charName.village_idiot,charName.highPriestess,charName.preacher,charName.nightwatchman,charName.cultleader,charName.lleech,charName.lilmonsta,charName.king,charName.huntsman,charName.general,charName.fearmonger,charName.engineer,charName.bountyhunter,charName.balloonist,charName.witch,charName.snakecharmer,charName.seamstress,charName.philosopher,charName.mathematician,charName.dreamer,charName.cerenovus,charName.sailor,charName.pukka,charName.devilsadvocate,charName.chambermaid,charName.empath, charName.fortuneteller, charName.poisoner, charName.spy);

tag_filter_desc[9,language.russian] = "Персонажи, просыпающиеся каждую ночь, кроме первой";
tag_filter_name[9,language.russian] = "Каждую ночь*";
tag_filter_desc[9,language.english] = "Characters, who wake up every night, but not the first night";
tag_filter_name[9,language.english] = "Every night*";
tag_filter_arr[9] = scr_make_array(charName.ojo,charName.lycanthrope,charName.lilmonsta,charName.legion,charName.alhadikhia,charName.acrobat,charName.vortox,charName.vigormortis,charName.towncrier,charName.pithag,charName.oracle,charName.nodashii,charName.flowergirl,charName.fanggu,charName.zombuul,charName.shabaloth,charName.professor,charName.po,charName.innkeeper,charName.gambler, charName.exorcist,charName.assassin,charName.imp, charName.monk, charName.undertaker);

tag_filter_desc[10,language.russian] = "Персонажи, которые могут выбирать своих жертв";
tag_filter_name[10,language.russian] = "Убивает сам";
tag_filter_desc[10,language.english] = "Characters, who are capable of targeting their kills";
tag_filter_name[10,language.english] = "Killers";
tag_filter_arr[10] = scr_make_array(charName.ojo,charName.kazali,charName.harpy,charName.psychopath, charName.lycanthrope,charName.lleech,charName.golem,charName.alhadikhia,charName.witch,charName.vortox,charName.vigormortis,charName.nodashii,charName.fanggu,charName.zombuul,charName.shabaloth,charName.pukka,charName.po,charName.godfather, charName.assassin,charName.imp, charName.slayer, charName.moonchild);

tag_filter_desc[11,language.russian] = "Из-за этих персонажей Демон может поменяться или игрок может стать демоном";
tag_filter_name[11,language.russian] = "Смена демона";
tag_filter_desc[11,language.english] = "These characters make Demon swap players or make someone a new Demon";
tag_filter_name[11,language.english] = "Demon swap";
tag_filter_arr[11] = scr_make_array(charName.summoner, charName.legion,charName.engineer,charName.snakecharmer,charName.pithag,charName.fanggu,charName.imp,charName.scarletwoman);

tag_filter_desc[12,language.russian] = "Добавляют причину, по которой ночью мог умереть злодей (помимо блефа)";
tag_filter_name[12,language.russian] = "Ночью умер злодей";
tag_filter_desc[12,language.english] = "Adds a reason, why an Evil player can die at night (aside from bluffing and strategy)";
tag_filter_name[12,language.english] = "Evil Night Death";
tag_filter_arr[12] = scr_make_array(charName.ojo,charName.magician,charName.legion,charName.bountyhunter,charName.alhadikhia,charName.vigormortis,charName.snakecharmer,charName.pithag,charName.fanggu,charName.zombuul,charName.shabaloth,charName.lunatic,charName.goon,charName.imp,charName.scarletwoman);

tag_filter_desc[13,language.russian] = "Используют посторонних для своих способностей, находят их, связаны с ними (необязательно посторонние)";
tag_filter_name[13,language.russian] = "Что-то с Посторонними";
tag_filter_desc[13,language.english] = "Characters, that use Outsiders for their abilities, find them, or somehow connected to them (aside from Outsider count)";
tag_filter_name[13,language.english] = "Outsider";
tag_filter_arr[13] = scr_make_array(charName.huntsman,charName.balloonist,charName.mutant,charName.fanggu,charName.godfather, charName.librarian);

tag_filter_desc[14,language.russian] = "Персонажи, которые срабатывают на казнях, из-за казней или их отсутствия, пассивно влияют на казни";
tag_filter_name[14,language.russian] = "Казни";
tag_filter_desc[14,language.english] = "Characters, that are triggered by executions, lack of executions, trigger executions or affect executions";
tag_filter_name[14,language.english] = "Executions";
tag_filter_arr[14] = scr_make_array(charName.vizier,charName.riot,charName.psychopath, charName.leviathan,charName.legion,charName.goblin,charName.fearmonger,charName.cannibal,charName.boomdandy,charName.atheist,charName.vortox,charName.cerenovus,charName.mutant,charName.eviltwin,charName.pacifist, charName.minstrel,charName.mastermind,charName.godfather, charName.devilsadvocate, charName.mayor, charName.saint, charName.undertaker);

tag_filter_desc[15,language.russian] = "Персонажи, защищающие себя/других игроков от смерти ночью";
tag_filter_name[15,language.russian] = "Защита ночью";
tag_filter_desc[15,language.english] = "Characters, who can defend themselves/others from death at night";
tag_filter_name[15,language.english] = "Night Defense";
tag_filter_arr[15] = scr_make_array(charName.lycanthrope,charName.lleech,charName.tealady,charName.sailor, charName.innkeeper,charName.goon,charName.fool, charName.mayor, charName.monk, charName.soldier);

tag_filter_desc[16,language.russian] = "Персонажи, которые могут срабатывать или не срабатывать, а также требующие объективной оценки игры / идей от рассказчика";
tag_filter_name[16,language.russian] = "Решение рассказчика";
tag_filter_desc[16,language.english] = "Characters, that might work, or might not. Also characters, that rely on Storyteller's decisions and ideas";
tag_filter_name[16,language.english] = "Storyteller's Judge";
tag_filter_arr[16] = scr_make_array(charName.ojo,charName.village_idiot,charName.legion,charName.lilmonsta,charName.pithag,charName.amnesiac,charName.highPriestess,charName.general,charName.fisherman,charName.atheist,charName.tinker,charName.pacifist, charName.mayor, charName.recluse, charName.spy, charName.plagueDoctor, charName.shugenja);

tag_filter_desc[17,language.russian] = "Используют механику отравления (отравление чаще связано со Злодеями)";
tag_filter_name[17,language.russian] = "Отравление";
tag_filter_desc[17,language.english] = "Using the poison mechanic (generally connected to Evil characters)";
tag_filter_name[17,language.english] = "Poison";
tag_filter_arr[17] = scr_make_array(charName.widow,charName.lleech,charName.cannibal,charName.acrobat,charName.vigormortis,charName.nodashii,charName.mathematician,charName.pukka,charName.poisoner);

tag_filter_desc[18,language.russian] = "Срабатывают из-за своей смерти или смерти других игроков";
tag_filter_name[18,language.russian] = "Триггер на смерть";
tag_filter_desc[18,language.english] = "Works by own death or other's death";
tag_filter_name[18,language.english] = "Death Trigger";
tag_filter_arr[18] = scr_make_array(charName.banshee, charName.pixie,charName.hatter,charName.lleech,charName.leviathan,charName.king,charName.fearmonger,charName.farmer,charName.choirboy,charName.cannibal,charName.bountyhunter,charName.boomdandy,charName.vigormortis,charName.sweetheart,charName.sage,charName.klutz,charName.barber,charName.zombuul,charName.moonchild,charName.undertaker,charName.godfather,charName.minstrel,charName.grandmother,charName.ravenkeeper,charName.plagueDoctor);

tag_filter_desc[19,language.russian] = "Эти персонажи делают так, что они или кто-то ещё узнают точного персонажа какого-то игрока (или одного из игроков)";
tag_filter_name[19,language.russian] = "Узнаёт персонажа";
tag_filter_desc[19,language.english] = "These character learn particular characters of players or make others learn particular characters of players";
tag_filter_name[19,language.english] = "Learns Character";
tag_filter_arr[19] = scr_make_array(charName.ojo,charName.nightwatchman,charName.king,charName.eviltwin,charName.grandmother,charName.gambler, charName.exorcist, charName.ravenkeeper, charName.undertaker, charName.washerwoman, charName.librarian, charName.investigator);

tag_filter_desc[20,language.russian] = "Из-за этих способностей другие способности и правила могут посчитать игрока неправильно (не та сторона, не та группа персонажей, не то состояние)";
tag_filter_name[20,language.russian] = "Регистрируется не так";
tag_filter_desc[20,language.english] = "These abilities make other abilities and/or rules register player/character falsely (as another alignment, another group, another character, etc)";
tag_filter_name[20,language.english] = "Registers as";
tag_filter_arr[20] = scr_make_array(charName.poppygrower,charName.magician,charName.legion,charName.atheist,charName.zombuul, charName.recluse, charName.spy);

tag_filter_desc[21,language.russian] = "Способности добавляющие моментальное окончание игры победой или поражением одной из команд";
tag_filter_name[21,language.russian] = "Поражение/победа";
tag_filter_desc[21,language.english] = "Abilities, that add instant win or loss conditions.";
tag_filter_name[21,language.english] = "Win/Loss";
tag_filter_arr[21] = scr_make_array(charName.riot,charName.politician,charName.leviathan,charName.heretic,charName.goblin,charName.fearmonger,charName.damsel,charName.cultleader,charName.atheist,charName.vortox,charName.klutz,charName.eviltwin,charName.mastermind,charName.mayor, charName.saint);

tag_filter_desc[22,language.russian] = "Способности работающие сами по себе, не требующие решений игрока";
tag_filter_name[22,language.russian] = "Пассивки";
tag_filter_desc[22,language.english] = "Abilities that just work and do not make player do anything or choose anyone";
tag_filter_name[22,language.english] = "Passive";
tag_filter_arr[22] = scr_make_array(charName.poppygrower,charName.yaggababble,charName.magician,charName.lleech,charName.leviathan,charName.legion,charName.heretic,charName.atheist,charName.vortox,charName.mutant,charName.nodashii,charName.eviltwin,charName.zombuul,charName.tinker,charName.tealady, charName.sailor, charName.pacifist,charName.minstrel,charName.mastermind,charName.grandmother,charName.goon,charName.godfather, charName.fool, charName.scarletwoman,charName.saint,charName.mayor,charName.recluse,charName.drunk, charName.soldier, charName.spy);

tag_filter_desc[23,language.russian] = "Способности срабатывающие днём (но не касающиеся номинаций и казни)";
tag_filter_name[23,language.russian] = "Работает днём";
tag_filter_name[23,language.english] = "Day";
tag_filter_desc[23,language.english] = "Abilities, that occur during the day (not connected to nominations and executions)";
tag_filter_arr[23] = scr_make_array(charName.banshee,charName.psychopath,charName.yaggababble,charName.fisherman,charName.amnesiac,charName.savant,charName.juggler,charName.artist, charName.slayer, charName.gossip);

tag_filter_desc[24,language.russian] = "Способности которые срабатывают только раз за игру (не считая те, которые срабатывают от смерти персонажа)";
tag_filter_name[24,language.russian] = "Раз в игру";
tag_filter_name[24,language.english] = "Once Per Game";
tag_filter_desc[24,language.english] = "Abilities, that occur only once per game (death trigger abilities are not included)";
tag_filter_arr[24] = scr_make_array(charName.summoner, charName.ogre, charName.puzzlemaster,charName.mezepheles,charName.huntsman,charName.golem,charName.fisherman,charName.engineer,charName.damsel,charName.seamstress,charName.philosopher,charName.juggler,charName.fanggu, charName.artist, charName.fool,charName.zombuul,charName.professor,charName.courtier,charName.assassin,charName.slayer, charName.virgin);

tag_filter_desc[25,language.russian] = "Персонажи, которые объявляются публично (или слишком очевидные), а также персонажи, которые должны в открытую использовать свои способности";
tag_filter_name[25,language.russian] = "Публично";
tag_filter_name[25,language.english] = "Public";
tag_filter_desc[25,language.english] = "Characters, that make public claims or automatically outted Evil";
tag_filter_arr[25] = scr_make_array(charName.banshee, charName.psychopath,charName.yaggababble,charName.vizier, charName.goblin,charName.damsel,charName.klutz,charName.juggler,charName.moonchild,charName.slayer,charName.gossip);

tag_filter_desc[26,language.russian] = "Персонажи, способные заглянуть в гримуар ведущего";
tag_filter_name[26,language.russian] = "Видит гримуар";
tag_filter_name[26,language.english] = "Sees Grimoir";
tag_filter_desc[26,language.english] = "Characters, that may see the Grimoir";
tag_filter_arr[26] = scr_make_array(charName.spy,charName.widow);

tag_filter_desc[27,language.russian] = "Всё, что меняет то, как работают номинации, триггерятся от номинаций, зависят от номинаций или упомянающие номинанта/номинируемого";
tag_filter_name[27,language.russian] = "Номинации";
tag_filter_name[27,language.english] = "Nominations";
tag_filter_desc[27,language.english] = "Characters, that affect nominations, triggered by nominations or nominating.";
tag_filter_arr[27] = scr_make_array(charName.banshee, charName.vizier,charName.riot,charName.psychopath, charName.golem,charName.goblin,charName.fearmonger,charName.witch,charName.towncrier,charName.virgin);

tag_filter_desc[28,language.russian] = "Персонажи, убивающие кого-то, но не способные выбрать жертву";
tag_filter_name[28,language.russian] = "Убивает косвенно";
tag_filter_desc[28,language.english] = "Characters, that cause killing, but cannot target their kills";
tag_filter_name[28,language.english] = "Indirect Killer";
tag_filter_arr[28] = scr_make_array(charName.lilmonsta,charName.yaggababble,charName.legion,charName.boomdandy,charName.pithag,charName.virgin,charName.gossip);

tag_filter_desc[29,language.russian] = "Способности, определяющие персонажей Добрых игроков, помогающие найти Добрых игроков или доказать, что вы Добрый";
tag_filter_name[29,language.russian] = "Скан Добрых";
tag_filter_desc[29,language.english] = "Abilities, that help finding Good players, learn Good characters or prove yourself as Good";
tag_filter_name[29,language.english] = "Good Scan";
tag_filter_arr[29] = scr_make_array(charName.ojo,charName.village_idiot,charName.godfather,charName.steward,charName.pixie,charName.noble,charName.lycanthrope,charName.king,charName.farmer,charName.cannibal,charName.balloonist,charName.seamstress,charName.oracle,charName.juggler,charName.dreamer,charName.tealady,charName.professor,charName.pacifist,charName.moonchild,charName.grandmother,charName.virgin,charName.washerwoman,charName.librarian,charName.empath);

tag_filter_desc[30,language.russian] = "Все способности, из-за которых ночью будет больше одной смерти";
tag_filter_name[30,language.russian] = "Дополнительные смерти";
tag_filter_desc[30,language.english] = "Abilities, that cause additional deaths at night";
tag_filter_name[30,language.english] = "Extra Death";
tag_filter_arr[30] = scr_make_array(charName.alhadikhia,charName.yaggababble,charName.acrobat,charName.tinker,charName.shabaloth,charName.po,charName.moonchild,charName.grandmother,charName.gossip,charName.godfather, charName.gambler, charName.assassin);

tag_filter_desc[31,language.russian] = "Персонажи, получающие информацию разного рода, не связанную напрямую с тем, кто Добрый, а кто Злодей (или информация неопределённая)";
tag_filter_name[31,language.russian] = "Всякая информация";
tag_filter_desc[31,language.english] = "Characters, who gather non-straightforward and miscellanious information";
tag_filter_name[31,language.english] = "Other Information";
tag_filter_arr[31] = scr_make_array(charName.highPriestess,charName.king,charName.general,charName.fisherman,charName.amnesiac,charName.acrobat,charName.vortox,charName.savant,charName.mathematician,charName.artist,charName.chambermaid,charName.gossip);

tag_filter_desc[32,language.russian] = "Персонажи, которые могут не умереть днём (например, от казни)";
tag_filter_name[32,language.russian] = "Не умирает днём";
tag_filter_desc[32,language.english] = "Characters, who cannot die during the day (executions too)";
tag_filter_name[32,language.english] = "Day Immortal";
tag_filter_arr[32] = scr_make_array(charName.vizier,charName.psychopath, charName.lleech,charName.tealady,charName.sailor,charName.pacifist,charName.devilsadvocate, charName.fool);

tag_filter_desc[33,language.russian] = "Персонажи, способные заблокировать убийства демона (не защита, именно ход демона, отмена, опьянение/отравление)";
tag_filter_name[33,language.russian] = "Блок демона";
tag_filter_desc[33,language.english] = "Characters, who are capable of blocking Demon move or kills (not defense)";
tag_filter_name[33,language.english] = "Demon Block";
tag_filter_arr[33] = scr_make_array(charName.lycanthrope,charName.po,charName.minstrel,charName.courtier,charName.exorcist,charName.poisoner);

tag_filter_desc[34,language.russian] = "Способности, ведущие к смене команды посреди игры или на сетапе";
tag_filter_name[34,language.russian] = "Смена сторон";
tag_filter_desc[34,language.english] = "Abilities, that cause alignment change in any way";
tag_filter_name[34,language.english] = "Alignment Change";
tag_filter_arr[34] = scr_make_array(charName.summoner, charName.ogre, charName.politician,charName.kazali,charName.mezepheles,charName.legion,charName.cultleader,charName.bountyhunter,charName.snakecharmer,charName.fanggu,charName.goon);

tag_filter_desc[35,language.russian] = "Способности, требующие нестандартного подхода (иногда) со стороны игроков или рассказчика";
tag_filter_name[35,language.russian] = "Креатив";
tag_filter_desc[35,language.english] = "Abilities, which demand creative thinking from Characters or Storyteller";
tag_filter_name[35,language.english] = "Creative";
tag_filter_arr[35] = scr_make_array(charName.yaggababble,charName.highPriestess,charName.mezepheles,charName.fisherman,charName.engineer,charName.atheist,charName.amnesiac,charName.alchemist,charName.artist,charName.gossip,charName.artist,charName.juggler);

tag_filter_desc[36,language.russian] = "Способности, дающие о себе знать кому-то за столом";
tag_filter_name[36,language.russian] = "Знают что вы в игре";
tag_filter_desc[36,language.english] = "Characters, that make themselves known to other players";
tag_filter_name[36,language.english] = "Knows You";
tag_filter_arr[36] = scr_make_array(charName.banshee, charName.vizier,charName.organgrinder,charName.widow,charName.preacher,charName.nightwatchman,charName.marionette,charName.leviathan,charName.king,charName.fearmonger,charName.damsel,charName.alhadikhia,charName.eviltwin,charName.lunatic,charName.exorcist);

tag_filter_desc[37,language.russian] = "Способности, которые могут возвращать из мёртвых";
tag_filter_name[37,language.russian] = "Возрождение";
tag_filter_desc[37,language.english] = "Abilities, that may resurrect dead players";
tag_filter_name[37,language.english] = "Resurrection";
tag_filter_arr[37] = scr_make_array(charName.alhadikhia,charName.shabaloth,charName.professor);

tag_filter_desc[38,language.russian] = "Всё, что может привести к смене персонажей у игроков";
tag_filter_name[38,language.russian] = "Смена персонажей";
tag_filter_desc[38,language.english] = "Abilities, that cause character change";
tag_filter_name[38,language.english] = "Character Change";
tag_filter_arr[38] = scr_make_array(charName.summoner, charName.hatter,charName.kazali,charName.riot,charName.legion,charName.huntsman,charName.farmer,charName.engineer,charName.snakecharmer,charName.pithag,charName.fanggu,charName.barber);

tag_filter_desc[39,language.russian] = "Затрагивает механику сумасшествия (вы спятили, что вы...)";
tag_filter_name[39,language.russian] = "Сумасшествие";
tag_filter_desc[39,language.english] = "Uses madness mechanic";
tag_filter_name[39,language.english] = "Madness";
tag_filter_arr[39] = scr_make_array(charName.harpy,charName.pixie,charName.cerenovus,charName.mutant);

tag_filter_desc[40,language.russian] = "Способности, зависящие от мёртвых игроков, работающие даже после смерти, позволяющие выбирать только мёртвых";
tag_filter_name[40,language.russian] = "Мёртвые";
tag_filter_desc[40,language.english] = "Abilities, affected by dead players, work after death or let you target specifically dead players";
tag_filter_name[40,language.english] = "Dead";
tag_filter_arr[40] = scr_make_array(charName.banshee, charName.king,charName.heretic,charName.cannibal,charName.atheist,charName.vigormortis,charName.oracle,charName.undertaker,charName.recluse,charName.spy,charName.professor,charName.zombuul,charName.politician);

tag_filter_desc[41,language.russian] = "Персонажи, получающие способности, дающие способности и забирающие способности. Также всё, что модифицирует способности";
tag_filter_name[41,language.russian] = "Способности";
tag_filter_desc[41,language.english] = "Characters, that gain abilities, give abilities, modify abilities or remove abilities. Does not include droisoning";
tag_filter_name[41,language.english] = "Abilities";
tag_filter_arr[41] = scr_make_array(charName.preacher,charName.pixie,charName.cannibal,charName.amnesiac,charName.alchemist,charName.vortox,charName.vigormortis,charName.philosopher,charName.plagueDoctor);

tag_filter_desc[43,language.russian] = "Персонажи, которые могут повлиять на сетап игры (включая счёт посторонних)";
tag_filter_name[43,language.russian] = "Меняет сетап";
tag_filter_desc[43,language.english] = "Characters, that affect game setup (including outsider count and token distribution during setup)";
tag_filter_name[43,language.english] = "Setup Change";
tag_filter_arr[43] = scr_make_array(charName.summoner, charName.kazali,charName.village_idiot,charName.huntsman,charName.balloonist,charName.vigormortis,charName.fanggu,charName.godfather,charName.baron,charName.marionette,charName.legion,charName.riot,charName.choirboy,charName.atheist,charName.bountyhunter,charName.lilmonsta);


/// Jynx

// Outsider jynx
scr_jynx(charName.lunatic,charName.mathematician,"К информации Математика добавляется 1, если Лунатик и Демон выбрали разных игроков","Lunatic and Mathematician: The Mathematician learns if the Lunatic attacks a different player(s) than the real Demon attacks")
scr_jynx(charName.cannibal,charName.butler,"Если Каннибал получает способность Дворецкого, он об этом узнаёт","If the Cannibal gains the Butler ability, the Cannibal learns this");
scr_jynx(charName.ogre,charName.recluse,"Если Отшельник посчитался злым для Огра, Огр узнаёт что он Злой","If the Recluse registers as evil to the Ogre, the Ogre learns that they are evil.");
scr_jynx(charName.philosopher,charName.bountyhunter,"Если Философ получает способность Охотника за Головами, Горожанин может стать Злым","If the Philosopher gains the Bounty Hunter ability, a Townsfolk might turn evil.");

scr_jynx(charName.cannibal,charName.juggler,"Если Жонглёр угадывал в свой первый день и умирает от казни, в эту ночь живой Каннибал узнает, сколько тот угадал","If the Juggler guesses on their first day and dies by execution, tonight the living Cannibal learns how many guesses the Juggler got correct.");
scr_jynx(charName.chambermaid,charName.mathematician,"Служанка узнаёт, проснулся ли Математик, хотя ходит раньше него","The Chambermaid learns if the Mathematician wakes tonight or not, even though the Chambermaid wakes first")
scr_jynx(charName.fanggu,charName.scarletwoman,"Если Фэнг Гу умирает, выбрав Постороннего, Алая Дама не становится Фэнг Гу","If the Fang Gu chooses an outsider and dies, the Scarlet Woman does not become the Fang Gu")
scr_jynx(charName.godfather,charName.heretic,"Эти персонажи не могут быть в одной игре","Only one jinxed character can be in play")
scr_jynx(charName.widow,charName.heretic,"Эти персонажи не могут быть в одной игре","Only one jinxed character can be in play")
scr_jynx(charName.widow,charName.damsel,"Если Вдова есть (или была) в игре, Мадам отравлена.","If the Widow is (or has been) in play, the Damsel is poisoned.")
scr_jynx(charName.spy,charName.heretic,"Эти персонажи не могут быть в одной игре","Only one jinxed character can be in play")
scr_jynx(charName.spy,charName.damsel,"Если Шпион есть (или был) в игре, Мадам отравлена.","If the Spy is (or has been) in play, the Damsel is poisoned.")
scr_jynx(charName.spy,charName.ogre,"Шпион всегда считается Злым для Огра","The Spy registers as evil to the Ogre.");

scr_jynx(charName.summoner,charName.alchemist,"Алхимик-Призыватель не убирает Демона на старте. Выбирая игрока Алхимик-Призыватель выбирает Демона, но не меняет сторону.","If there is an Alchemist-Summoner in play, the game starts with a Demon in play, as normal. If the Alchemist-Summoner chooses a player, they make that player a Demon but do not change their alignment.");
scr_jynx(charName.summoner,charName.clockmaker,"Если Призыватель в игре, Часовщик не получает свою информацию, пока не будет создан Демон","If the Summoner is in play, the Clockmaker does not receive their information until a Demon is created.");
scr_jynx(charName.summoner,charName.courtier,"Если Призыватель пьян на 3-ю ночь, он выбирает какого Демона создаёт, а Рассказчик выбирает игрока","If the Summoner is drunk on the 3rd night, the Summoner chooses which Demon, but the Storyteller chooses which player.");
scr_jynx(charName.summoner,charName.engineer,"Если Инженер убирает Призывателя из игры, Призыватель сразу же использует свою способность","If the Engineer removes a Summoner from play before that Summoner uses their ability, the Summoner uses their ability immediately.");
scr_jynx(charName.summoner,charName.hatter,"Призыватель не может создать Демона, который уже есть в игре. Если Призыватель создаёт Демона, которого нет в игре, смерти этой ночью выбирает ведущий","The Summoner cannot create an in-play Demon. If the Summoner creates a not-in-play Demon, deaths tonight are arbitrary.");
scr_jynx(charName.summoner,charName.kazali,"Призыватель не может создать Демона, который уже есть в игре. Если Призыватель создаёт Демона, которого нет в игре, смерти этой ночью выбирает ведущий","The Summoner cannot create an in-play Demon. If the Summoner creates a not-in-play Demon, deaths tonight are arbitrary.");
scr_jynx(charName.summoner,charName.legion,"Если Призыватель создаёт Легион, большинство игроков (включая всех Злых) становится Злым Легионом","If the Summoner creates Legion, most players (including all evil players) become evil Legion.");
scr_jynx(charName.summoner,charName.marionette,"Марионетка сидит по соседству с Призывателем. Призыватель знает Марионетку","The Marionette neighbors the Summoner. The Summoner knows who the Marionette is.");
scr_jynx(charName.summoner,charName.pithag,"Призыватель не может создать Демона, который уже есть в игре. Если Призыватель создаёт Демона, которого нет в игре, смерти этой ночью выбирает ведущий","The Summoner cannot create an in-play Demon. If the Summoner creates a not-in-play Demon, deaths tonight are arbitrary.");
scr_jynx(charName.summoner,charName.poppygrower,"Если Маковод жив, когда Призыватель действует, Призыватель выбирает какого Демона создаёт, а Рассказчик выбирает игрока.","If the Poppy Grower is alive when the Summoner acts, the Summoner chooses which Demon, but the Storyteller chooses which player.");
scr_jynx(charName.summoner,charName.pukka,"Призыватель может выбрать игрока для превращения в Пукку на вторую ночь","The Summoner may choose a player to become the Pukka on the 2nd night.");
scr_jynx(charName.summoner,charName.riot,"Если Призыватель создаёт Бунт, все Приспешники становятся Бунтом","If the Summoner creates Riot, all Minions also become Riot.");
scr_jynx(charName.summoner,charName.zombuul,"Если Призыватель превращает мёртвого игрока в Зомбуула, Рассказчик ведёт игру так, как-будто это Зомбуул который однажды умер.","If the Summoner turns a dead player into the Zombuul, the Storyteller treats that player as a Zombuul that has died once.");
//scr_jynx(charName.summoner,charName.,"","");

scr_jynx(charName.legion,charName.preacher,"Эти персонажи не могут быть в одной игре","Only one jinxed character can be in play")
scr_jynx(charName.lilmonsta,charName.magician,"Эти персонажи не могут быть в одной игре","Only one jinxed character can be in play")
scr_jynx(charName.riot,charName.exorcist,"Эти персонажи не могут быть в одной игре","Only one jinxed character can be in play")
scr_jynx(charName.riot,charName.flowergirl,"Эти персонажи не могут быть в одной игре","Only one jinxed character can be in play")
scr_jynx(charName.riot,charName.minstrel,"Эти персонажи не могут быть в одной игре","Only one jinxed character can be in play")
scr_jynx(charName.alhadikhia,charName.mastermind,"Только 1 из персонажей может быть в игре, Злодеи в начале знают какой и у какого игрока","Only one jinxed character can be in play, Evil players start knowing which player and character it is")

scr_jynx(charName.pithag,charName.damsel,"Если Колдунья создаёт мадам, рассказчик выбирает игрока сам","If a Pit-Hag creates a Damsel, the Storyteller chooses which player it is")
scr_jynx(charName.pithag,charName.heretic,"Колдунья не может создать Еретика","A Pit-Hag cannot create a Heretic")
scr_jynx(charName.pithag,charName.politician,"Если Колдунья создала превратила Злого игрока в Политика, тот не может стать Добрым из-за своей способности","If the Pit-Hag turns an evil player into the Politician, they can't turn good due to their own ability.")
scr_jynx(charName.pithag,charName.goon,"Если Колдунья создала превратила Злого игрока в Наёмника, тот не может стать Добрым из-за своей способности","If the Pit-Hag turns an evil player into the Goon, they can't turn good due to their own ability.")
scr_jynx(charName.pithag,charName.cultleader,"Если Колдунья создала превратила Злого игрока в Лидера Культа, тот не может стать Добрым из-за своей способности","If the Pit-Hag turns an evil player into the Cult Leader, they can't turn good due to their own ability.")
scr_jynx(charName.pithag,charName.riot,"Если Колдунья создаёт Бунт, все Злодеи становятся Бунтом. Если это произошло после 3 дня, игра длится ещё 1 день","If the Pit-Hag creates Riot, all evil players become Riot. If the Pit-Hag creates Riot after day 3, the game continues for one more day")
scr_jynx(charName.pithag,charName.ogre,"Если Колдунья превращает Злого игрока в Огра, тот не сможет стать Добрым из-за своей способности","If the Pit-Hag turns an evil player into the Ogre, they can't turn good due to their own ability.")

scr_jynx(charName.engineer,charName.legion,"Эти персонажи не могут быть в начале игры одновременно","Legion and the Engineer cannot both be in play at the start of the game. If the Engineer creates Legion, most players (including all evil players) become evil Legion")
scr_jynx(charName.engineer,charName.riot,"Эти персонажи не могут быть в начале игры одновременно","Riot and the Engineer cannot both be in play at the start of the game. If the Engineer creates Riot, the evil players become Riot")
scr_jynx(charName.village_idiot,charName.pithag,"Если остались жетоны, Колдунья может создавать Деревенских Дурачков. Сразу после этого может поменяться, кто из них пьян.","If there is a spare token, the Pit-Hag can create an extra Village Idiot. If so, the drunk Village Idiot might change.");

scr_jynx(charName.widow,charName.alchemist,"Алхимик не может получить способность Вдовы","The Alchemist cannot have the Widow ability");
scr_jynx(charName.spy,charName.alchemist,"Алхимик не может получить способность Шпиона","The Alchemist cannot have the Spy ability");
scr_jynx(charName.spy,charName.magician,"Когда Шпион смотрит гримуар, в нём убираются персонажи Демона и Фокусника","When the Spy sees the Grimoire, the Demon and the Magician's character tokens are removed");
scr_jynx(charName.widow,charName.magician,"Когда Вдова смотрит гримуар, в нём убираются персонажи Демона и Фокусника","When the Widow sees the Grimoire, the Demon and the Magician's character tokens are removed")
scr_jynx(charName.spy,charName.poppygrower,"Пока Маковод жив, Шпион не смотрит гримуар","If the Poppy Grower is in play, the Spy does not see the Grimoire until the Poppy Grower dies")
scr_jynx(charName.widow,charName.poppygrower,"Пока Маковод жив, Вдова не смотрит гримуар","If the Poppy Grower is in play, the Widow does not see the Grimoire until the Poppy Grower dies")
scr_jynx(charName.lycanthrope,charName.gambler,"Если Ликантроп жив и Картёжник умирает от своей способности, никто из игроков в эту ночь больше не умрёт","If the Lycanthrope is alive and the Gambler kills themselves at night, no other players can die tonight")

scr_jynx(charName.marionette,charName.balloonist,"Если Марионетка думает, что он Аэронавт, +1 Посторонний","If the Marionette thinks that they are the Balloonist, +1 Outsider was added")
scr_jynx(charName.marionette,charName.huntsman,"Если Марионетка думает, что он Охотник, +Мадам","If the Marionette thinks that they are the Huntsman, the Damsel was added")
scr_jynx(charName.marionette,charName.poppygrower,"Когда умирает Маковод, Демон узнаёт Марионетку, но Марионетка не узнаёт никого","When the Poppy Grower dies, the Demon learns the Marionette but the Marionette learns nothing")
scr_jynx(charName.marionette,charName.damsel,"Марионетка не узнаёт, что в игре есть Мадам","The Marionette does not learn that a Damsel is in play")
scr_jynx(charName.marionette,charName.snitch,"Марионетка не узнаёт 3 персонажей, которых нет в игре, а Демон узаёт на 3 больше","The Marionette does not learn three not-in-play characters, the Demon learns an extra three instead")
scr_jynx(charName.marionette,charName.lilmonsta,"Марионетка не просыпается из-за Монстра Джуниора, Марионетка сидит по соседству с Приспешником","The Marionette neighbours a Minion, not the Demon. The Marionette is not woken to choose who takes the Lil' Monsta token")

scr_jynx(charName.baron,charName.heretic,"Барон может добавить только 1 Постороннего","The Baron might only add one outsider, not two")
scr_jynx(charName.cerenovus,charName.goblin,"Манипулятор может заставить игрока спятить, что он Гоблин","The Cerenovus may choose to make a player mad that they are the Goblin")
scr_jynx(charName.alhadikhia,charName.scarletwoman,"Если в живых 2 Аль-Хадика, тот, что был Алой Дамой снова становится Алой Дамой","If there are two living Al-Hadikhias, the Scarlet Woman Al-Hadikhia becomes the Scarlet Woman again")
scr_jynx(charName.lilmonsta,charName.scarletwoman,"Если в живых 5+ игроков, когда умирает тот, кто нянчит Монстра Джуниора, в эту ночь его будет нянчить Алая Дама","If there are five or more players alive and the player holding the Lil' Monsta token dies, the Scarlet Woman is given the Lil' Monsta token tonight")
scr_jynx(charName.mastermind,charName.lleech,"Если Руководитель жив, когда носитель Пиявки умирает через казнь, Пиявка выживает, но теряет свою способность","If the Mastermind is alive and the Lleech's host dies by execution, the Lleech lives but loses their ability")
scr_jynx(charName.lilmonsta,charName.poppygrower,"Если в игре Маковод, Приспешники просыпаются по очереди, пока один из них не согласится нянчить Монстра Джуниора","If the Poppy Grower is in play, Minions don't wake together. They are woken one by one, until one of them chooses to take the Lil' Monsta token")

scr_jynx(charName.leviathan,charName.soldier,"Если Левиафан номинирует Солдата и тот казнён, Солдат не умирает","If Leviathan nominates and executes the Soldier, the Soldier does not die");
scr_jynx(charName.leviathan,charName.monk,"Если Левиафан номинирует цель Монаха и та казнена, она не умирает","If Leviathan nominates and executes the player the Monk chose, that player does not die");
scr_jynx(charName.leviathan,charName.innkeeper,"Если Левиафан номинирует цель Трактирщика и та казнена, она не умирает","If Leviathan nominates and executes a player the Innkeeper chose, that player does not die");
scr_jynx(charName.leviathan,charName.ravenkeeper,"Если Левиафан в игре и Хранитель Ворона умирает через казнь, ночью он использует свою способность","If Leviathan is in play and the Ravenkeeper dies by execution, they wake that night to use their ability");
scr_jynx(charName.leviathan,charName.sage,"Если Левиафан в игре и Мудрец умирает через казнь, ночью он использует свою способность","If Leviathan is in play and the Sage dies by execution, they wake that night to use their ability");
scr_jynx(charName.leviathan,charName.mayor,"Если Левиафан в игре и на 5-ый день не происходит казни, Добро побеждает","If Leviathan is in play and no execution occurs on day 5, good wins");
scr_jynx(charName.leviathan,charName.farmer,"Если Левиафан в игре и Фермер умирает через казнь, Добрый игрок станет Фермером этой ночью","If Leviathan is in play and a Farmer dies by execution, a good player becomes a Farmer that night");
scr_jynx(charName.leviathan,charName.banshee,"Если Левиафан в игре и Банши умирает через казнь, все игроки об этом узнают и Банши получает свою способность","If Leviathan is in play, and the Banshee dies by execution, all players learn that the Banshee has died, and the Banshee gains their ability.");

scr_jynx(charName.lleech,charName.slayer,"Если Убийца демонов выбирает для способности носителя Пиявки, носитель умирает","If the Slayer shoots the Lleech's host, the host dies");
scr_jynx(charName.lleech,charName.heretic,"Если Пиявка отравляет Еретика, Еретик остаётся отравлен, а Пиявка умирает","If the Lleech has poisoned the Heretic then the Lleech dies, the Heretic remains poisoned");

scr_jynx(charName.riot,charName.clockmaker,"Бунт считается Приспешником для Часовщика","Riot registers as a Minion to the Clockmaker")
scr_jynx(charName.riot,charName.investigator,"Бунт считается Приспешником для Следователя","Riot registers as a Minion to the Investigator")
scr_jynx(charName.riot,charName.preacher,"Бунт считается Приспешником для Проповедника","Riot registers as a Minion to the Preacher")
scr_jynx(charName.riot,charName.towncrier,"Бунт считается Приспешником для Глашатая","Riot registers as a Minion to the Town Crier")
scr_jynx(charName.riot,charName.damsel,"Бунт считается Приспешником для Мадам","Riot registers as a Minion to the Damsel")
scr_jynx(charName.riot,charName.cannibal,"Игроки умирающие от номинации, считаются казнёнными для Каннибала","Players that die by nomination register as executed to the Cannibal")
scr_jynx(charName.riot,charName.undertaker,"Игроки умирающие от номинации, считаются казнёнными для Гробовщика","Players that die by nomination register as executed to the Undertaker")
scr_jynx(charName.riot,charName.pacifist,"Игроки умирающие от номинации, считаются казнёнными для Пацифиста","Players that die by nomination register as executed to the Pacifist")
scr_jynx(charName.riot,charName.devilsadvocate,"Игроки умирающие от номинации, считаются казнёнными для Адвоката Дьявола","Players that die by nomination register as executed to the Devil's Advocate")
scr_jynx(charName.riot,charName.grandmother,"Если Бунт номинирует и убивает внука Бабушки, Бабушка умирает","If a Riot player nominates and kills the grandchild, the Grandmother dies too")
scr_jynx(charName.riot,charName.king,"Если Бунт номинирует и убивает Короля и в игре живой Мальчик из Хора, его способность сработает ночью","If a Riot player nominates and kills the King and the Choirboy is alive, the Choirboy uses their ability tonight")
scr_jynx(charName.riot,charName.sage,"Если Бунт номинирует и убивает Мудреца, его способность срабатывает ночью","If a Riot player nominates and kills the Sage, the Sage uses their ability tonight")
scr_jynx(charName.riot,charName.ravenkeeper,"Если Бунт номинирует и убивает Хозяина Ворона, его способность срабатывает ночью","If a Riot player nominates and kills the Ravenkeeper, the Ravenkeeper uses their ability tonight")
scr_jynx(charName.riot,charName.farmer,"Если Бунт номинирует и убивает Фермера, его способность срабатывает ночью","If a Riot player nominates and kills a Farmer, the Farmer uses their ability tonight")
scr_jynx(charName.riot,charName.soldier,"Если Бунт номинирует Солдата, тот не умирает","If a Riot player nominates the Soldier, the Soldier does not die")
scr_jynx(charName.riot,charName.innkeeper,"Если Бунт номинирует цель Трактирщика, она не умирает","If a Riot player nominates an Innkeeper-protected player, the protected player does not die")
scr_jynx(charName.riot,charName.monk,"Если Бунт номинирует цель Монаха, она не умирает","If a Riot player nominates a Monk-protected player, the protected player does not die")
scr_jynx(charName.riot,charName.mayor,"Если Мэр жив и 3-ий день начался только с 3 живыми игроками, если игроки никого не номинировали, Мэр и его команда побеждают","If the third day begins with just three players alive, the players may choose (as a group) not to nominate at all. If so (and a Mayor is alive) the Mayor's team wins.")
scr_jynx(charName.riot,charName.saint,"Если Добрый игрок номинирует и убивает Святого, команда Святого проигрывает","If a good player nominates and kills the Saint, the Saint's team loses")
scr_jynx(charName.riot,charName.butler,"Дворецкий не может номинировать хозяина","The Butler cannot nominate their master")
scr_jynx(charName.riot,charName.snitch,"Если Стукач в игре, каждый Бунт получает 3 дополнительных блефа","If the Snitch is in play, each Riot player gets an extra three bluffs")
scr_jynx(charName.riot,charName.golem,"Если Голем номинирует Бунт, тот не умирает","If the Golem nominates Riot, the Riot player does not die")
scr_jynx(charName.riot,charName.banshee,"Если Бунт номинирует и убивает Банши, об этом все узнают и Банши сразу же может номинировать двоих игроков","If Riot nominates and kills the Banshee, all players learn that the Banshee has died, and the Banshee may nominate two players immediately.")

scr_jynx(charName.organgrinder,charName.butler,"Если голосование с закрытыми глазами, Дворецкий может голосовать, но засчитается это, только если его хозяин тоже проголосует","If the Organ Grinder is causing eyes closed voting, the Butler may raise their hand to vote but their vote is only counted if their master voted too");
scr_jynx(charName.organgrinder,charName.flowergirl,"Если Шарманщик сделал голосование в закрытую, Цветочница просыпается ночью и выбирает игрока: она узнаёт, голосовал ли этот игрок сегодня (вместо своей обычной способности)","If the Organ Grinder is causing eyes-closed voting, the Flowergirl wakes tonight to choose a player: they learn if that player voted today. (instead of their normal ability)");
scr_jynx(charName.organgrinder,charName.minstrel,"Только 1 из персонажей может быть в игре, Злодеи в начале знают какой и у какого игрока","Only 1 jinxed character can be in play. Evil players start knowing which player and character it is");
scr_jynx(charName.organgrinder,charName.preacher,"Только 1 из персонажей может быть в игре, Злодеи в начале знают какой и у какого игрока","Only 1 jinxed character can be in play. Evil players start knowing which player and character it is");
scr_jynx(charName.organgrinder,charName.lilmonsta,"Голоса за Шарманщика засчитываются, если он нянчит Монстра Джуниора","Votes for the Organ Grinder count if the Organ Grinder is babysitting Lil' Monsta");

scr_jynx(charName.vizier,charName.investigator,"Если Следователь узнал, что в игре есть Визирь, рассказчик не объявит о существовании Визиря","If the Investigator learns that the Vizier is in play, the existence of the Vizier is not announced by the Storyteller");
scr_jynx(charName.vizier,charName.preacher,"Потеряв способность, Визирь узнаёт об этом. Если Визиря казнить, когда у него есть способность, его команда побеждает","If the Vizier loses their ability, they learn this and if the Vizier is executed while they have their ability, their team wins");
scr_jynx(charName.vizier,charName.courtier,"Потеряв способность, Визирь узнаёт об этом. Если Визиря казнить, когда у него есть способность, его команда побеждает","If the Vizier loses their ability, they learn this and if the Vizier is executed while they have their ability, their team wins");
scr_jynx(charName.vizier,charName.alchemist,"Если у Алхимика способность Визиря, он может заставить казнить только если хотя бы 3 игрока проголосовали","If the Alchemist has the Vizier ability, they may only choose to execute immediately if three or more players voted");
scr_jynx(charName.vizier,charName.magician,"Если Визирь и Фокусник одновременно в игре, Демон не узнаёт Приспешников.","If the Vizier and Magician are both in play, the Demon does not learn the Minions.");
scr_jynx(charName.vizier,charName.fearmonger,"Визирь просыпается со Страшилой и знает его выбор. Визирь не может казнить выбранного игрока","The Vizier wakes with the Fearmonger, learns who they choose and cannot choose to execute that player");
scr_jynx(charName.vizier,charName.lilmonsta,"Визирь может умереть от казни, если он нянчит Монстра Джуниора","The Vizier can die by execution if they are babysitting Lil' Monsta");
scr_jynx(charName.vizier,charName.politician,"Политик может посчитаться Злым для Визиря","The Politician might register as evil to the Vizier.");

scr_jynx(charName.plagueDoctor,charName.baron,"Если Рассказчик получает способность Барона, до 2 игроков становятся Посторонними, которых нет в игре.","If the Storyteller gains the Baron ability, up to two players become out-of-play Outsiders.");
scr_jynx(charName.plagueDoctor,charName.boomdandy,"Если Чумного доктора казнят и Рассказчик получает способность Подрывника, вместо этого способность сразу же срабатывает.","If the Plague Doctor is executed and the Storyteller would gain the Boomdandy ability, the Boomdandy ability triggers immediately.");
scr_jynx(charName.plagueDoctor,charName.eviltwin,"Рассказчик не может получить способность Злого близнеца, если Чумной доктор умрёт.","The Storyteller cannot gain the Evil Twin ability if the Plague Doctor dies.");
scr_jynx(charName.plagueDoctor,charName.fearmonger,"Если Чумной доктор умирает, живой Приспешник получает способность Страшилы и узнаёт об этом. (старая способность остаётся)","If the Plague Doctor dies, a living Minion gains the Fearmonger ability in addition to their own ability, and learns this.");
scr_jynx(charName.plagueDoctor,charName.goblin,"Если Чумной доктор умирает, живой Приспешник получает способность Гоблина и узнаёт об этом. (старая способность остаётся)","If the Plague Doctor dies, a living Minion gains the Goblin ability in addition to their own ability, and learns this.");
scr_jynx(charName.plagueDoctor,charName.marionette,"Если у Демона есть живой сосед Горожанин или Посторонний и в игре не добавлялся Злой игрок, когда Чумной доктор умирает этот сосед становится Марионеткой.","If the Demon has a neighbour who is alive and a Townsfolk or Outsider when the Plague Doctor dies, that player becomes an evil Marionette. If there is already an extra evil player, this does not happen.");
scr_jynx(charName.plagueDoctor,charName.scarletwoman,"Если Чумной доктор умирает, живой Приспешник получает способность Алой Дамы и узнаёт об этом. (старая способность остаётся)","If the Plague Doctor dies, a living Minion gains the Scarlet Woman ability in addition to their own ability, and learns this.");
scr_jynx(charName.plagueDoctor,charName.spy,"Если Чумной доктор умирает, живой Приспешник получает способность Шпиона и узнаёт об этом. (старая способность остаётся)","If the Plague Doctor dies, a living Minion gains the Spy ability in addition to their own ability, and learns this.");

scr_jynx(charName.hatter,charName.legion,"Если в игре Легион, у Шляпника нет способности. Если Злой игрок после смерти Шляпника выбрал Легион, все Злые игроки становятся легионом.","If Legion is in play, Hatter has no ability. If an evil player chooses Legion after Hatter's death, all evil players become Legion.");
scr_jynx(charName.hatter,charName.leviathan,"Если Шляпник умер на 5 день или после него, Демон не может выбрать Левиафана.","If the Hatter dies on or after day 5, the Demon cannot choose Leviathan.");
scr_jynx(charName.hatter,charName.lilmonsta,"Если Демон выбрал Монстра Джуниора, он также выбирает каким Приспешником стать и держит Монстра Джуниора этой ночью.","If a Demon chooses Lil' Monsta, they also choose a Minion to become and babysit Lil' Monsta tonight.");
scr_jynx(charName.hatter,charName.riot,"Если Бунт выбирает другого Демона, создаётся нормальная злая команда. Если Демон выбирает Бунт, приспешники тоже становятся Бунтом.","If Riot chooses a different Demon, a normal evil team is created. If the Demon chooses Riot, Minions become Riot too.");

scr_jynx(charName.kazali,charName.bountyhunter,"Злой Горожанин создаётся только если Охотник за Головами остался после выбора Казали.","An evil Townsfolk is only created if the Bounty Hunter is still in play after the Kazali acts.");
scr_jynx(charName.kazali,charName.choirboy,"Казали не может выбрать Короля в команду, если в игре есть Мальчик Хорист.","The Kazali can not choose the King to become a Minion if a Choirboy is in play.");
scr_jynx(charName.kazali,charName.goon,"Если Казали выбирает Наёмника в команду, Рассказчик определяет оставшихся Приспешников сам.","If the Kazali chooses the Goon to become a Minion, remaining Minions choices are decided by the Storyteller.");
scr_jynx(charName.kazali,charName.huntsman,"Если Казали выбирает Мадам в команду и в игре есть Охотник, Добрый игрок становится Мадам.","If the Kazali chooses the Damsel to become a Minion, and a Huntsman is in play, a good player becomes the Damsel.");
scr_jynx(charName.kazali,charName.marionette,"Если Казали выбрал создать Марионетку, то он обязан выбрать соседнего игрока для неё.","If the Kazali chooses to create a Marionette, they must choose one of their neighbors.");
scr_jynx(charName.yaggababble,charName.exorcist,"Если Экзорцист выбрал Ягу Болтунью, её способность никого не убивает этой ночью.","If the Exorcist chooses the Yaggababble, the Yaggababble ability does not kill tonight.");

scr_jynx(charName.banshee,charName.vortox,"Если в игре Вортокс и Демон убивает Банши, игроки всё ещё узнают что Банши умерла.","If the Vortox is in play and the Demon kills the Banshee, the players still learn that the Banshee has died.")

/// late init

for(i=0; i<=setName.experimental; i++)
    filter_set[i] = 1;
for(i=1; i<travellerName.lastChar; i++)
    traveller_pick[i] = 0;
for(i=0; i<fabledName.lastChar; i++)
    fabled_pick[i] = 0;
scr_refresh();

