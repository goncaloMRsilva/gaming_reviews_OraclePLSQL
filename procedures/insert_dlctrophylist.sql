create or replace procedure insert_dlctrophylist(p_dlcname VARCHAR,  p_trophynamelist in trophynameslist,
p_trophydescriptionlist in trophydescriptionlist, p_trophytypelist in trophytypelist) is
    v_dlcid dlc.dlcid%type;
    v_gameid dlc.game_gameid%type;
begin
    SELECT dlcid into v_dlcid from dlc where dlcname = p_dlcname;
    SELECT game_gameid into v_gameid FROM dlc where dlcname = p_dlcname;

    for i in 1..2 loop
        insert into trophylist(trophyid, trophyname, description, type, game_gameid, dlc_dlcid, main_game_trophy)
        values(trophylist_seq.nextval, p_trophynamelist(i), p_trophydescriptionlist(i), p_trophytypelist(i), v_gameid, v_dlcid, 0);
    end loop;

    dbms_output.put_line('There is no dlc with ' || p_dlcname || ' name');

end;