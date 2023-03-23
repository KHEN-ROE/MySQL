drop table if exists user;
create table user (
	uid varchar(20) primary key,
    uname varchar(10),
    email varchar(20),
    rdate timestamp
);

select * from user;
select * from deluser;


drop table if exists delUser;
create table delUser(
	uid varchar(20),
    uname varchar(10),
    email varchar(20),
    wdate timestamp
);

delimiter //
create trigger afterDeleteUser
after delete on user for each row
begin

insert into delUser
values(old.uid, old.uname, old.email, old.rdate);

end
// delimiter ;

call printAllUsers(1);
