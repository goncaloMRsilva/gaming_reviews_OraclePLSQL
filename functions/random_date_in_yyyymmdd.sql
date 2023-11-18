create or replace FUNCTION random_date_in_yyyymmdd RETURN VARCHAR2 IS
  random_date DATE;
BEGIN
  random_date := TRUNC(SYSDATE) + DBMS_RANDOM.VALUE(-365, 365);

  RETURN TO_CHAR(random_date, 'yyyy-mm-dd');
END random_date_in_yyyymmdd;