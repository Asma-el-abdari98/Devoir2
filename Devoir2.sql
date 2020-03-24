  
             

  // C7

 BEGIN
  open c
  loop
  fetch c into v_nom, v_sal,v_comm;
  exit when c%notfound;
  if v_comm is null then 
  delete pilote where current of c ;
  elsif
    v_comm >v_sal then 
  update pilote 
  set sal=sal+comm,com=null
  where current of c ;
  end if ;
  end loop ;
  close c ;
 END ;
 
 
   //C8
   
 BEGIN
   cursor c is
   select nopilote,nom,sal,comm from pilote
   where nopilote exist;
   v_num pilote.nopilote%type;
   v_nom pilote.nom%type; 
   v_sal pilote.sal%type;
   v_comm pilote.comm%type;
BEGIN
   open c;
   loop
   fetch c into v_num,v_nom,v_sal,v_comm;
   exit when c%notfound;
   if v_nopilote exist
   raise exc1;
   elsif v_nopilote not exit
   raise exc2;
   else(v_sal>v_comm)
   raise exc3;
   exception
   exc1 exception;
   exc2 exception:
   exc3 exception;
   when exc1 then
   dbms_output.put_line(v_nom||'OK')
   when exc2 then
   dbms_output.put_line(v_nom||'INCONNU')
   when exc1 then
   dbms_output.put_line(v_nom||'COMM>SAL')
END;
   
 //   D. Création des vues


D1- 
  create view v_pilote 
  as
  select * from pilote
  where ville=paris;

D2-
  update v_pilote
  set sal=sal*0.1;
  where ville=paris;

D3-
  create view dervol
  as 
  select  avion max(date_vol) from affectation 
  group by avion;

D4-
  create view cr_pilote as
  select * from pilote 
  where(ville='paris' and comm is not null)
  or(ville <>'paris' and comm is null)
  with check option;


D5-
  create view nomcomm as
  select * from pilote 
  where(comm is null
  and nopilot not in(select pilote from affectation))
  or (comm is not null
  and nopilot in(select pilote from affectation))
  with check option;

