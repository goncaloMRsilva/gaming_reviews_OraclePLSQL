create or replace FUNCTION getgameslist_trophylistempty RETURN gamelist IS 
   v_gametitles gamelist := gamelist();
BEGIN
   SELECT g.title BULK COLLECT INTO v_gametitles
   FROM game g
   WHERE g.gameid NOT IN (SELECT game_gameid FROM trophylist)
   ORDER BY g.gameid;

   RETURN v_gametitles;
END;