create or replace procedure addgametitle_trophieslist(p_title game.title%type, p_trophynamelist in trophynameslist,
p_trophydescriptionlist in trophydescriptionlist, p_trophytypelist in trophytypelist) IS
    v_gameid number;
    game_notfound exception;
begin
    if p_title = null then
        raise game_notfound;
    else
        SELECT gameid into v_gameid from game where title = p_title;
    end if;

    FOR i IN 1..42 LOOP
        insert into trophylist(trophyid, trophyname, description, type, game_gameid, dlc_dlcid, main_game_trophy)
        values(trophylist_seq.nextval, p_trophynamelist(i), p_trophydescriptionlist(i), p_trophytypelist(i), v_gameid, 251, 1);
    end loop;

EXCEPTION
    WHEN game_notfound then
    dbms_output.put_line('There is no game with ' || p_title || ' name!');
end;