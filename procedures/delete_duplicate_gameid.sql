create or replace procedure delete_duplicate_gameid(p_gameid in number) is
    CURSOR cur_trophylist_gameid is 
        SELECT tl.game_gameid, ut.trophylist_trophyid
        from trophylist tl
        JOIN usertrophy ut 
        ON tl.trophyid = ut.trophylist_trophyid
        where game_gameid = p_gameid;

    v_gameid trophylist.game_gameid%type;
    v_user_trophyid usertrophy.trophylist_trophyid%type;
begin
    OPEN cur_trophylist_gameid;
    loop
        FETCH cur_trophylist_gameid into v_gameid, v_user_trophyid;
        EXIT WHEN cur_trophylist_gameid%notfound;
        DELETE from usertrophy where trophylist_trophyid = v_user_trophyid;
        DELETE from trophylist where game_gameid = v_gameid;
    end loop;
    close cur_trophylist_gameid;
end;