create or replace package manage_usertrophy_table as 
    procedure insert_usertrophytable;
    function random_date_in_yyyymmdd return VARCHAR2;
end manage_usertrophy_table;