create or replace procedure insert_usertrophytable(p_userID in userdetails.userid%type, p_min_trophy_id PLS_INTEGER, p_max_trophy_id PLS_INTEGER) is  
    cursor gettrophies is select trophyid FROM trophylist where trophyid BETWEEN p_min_trophy_id and p_max_trophy_id;
    type trophy_id_list is VARRAY(100) of number;
    v_trophylist trophy_id_list := trophy_id_list();
    v_user_count pls_integer;
    v_index pls_integer := 1;
begin
    SELECT count(*) into v_user_count from userdetails where userid = p_userID;

    if v_user_count = 0 then 
        RAISE_APPLICATION_ERROR(-20001, 'User with ID ' || p_userID || ' not found.');
    else

        for x in gettrophies loop
            v_trophylist.extend;
            v_trophylist(v_index) := x.trophyid;
            v_index := v_index + 1;
        end loop;

        for i in 1 .. v_trophylist.count loop
            insert into usertrophy(aquiredDate, trophylist_trophyid, userdetails_userid)
            values(random_date_in_yyyymmdd, v_trophylist(i), p_userID);
        end loop;

    end if;

EXCEPTION
 when others then
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
end;