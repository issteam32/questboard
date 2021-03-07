create database userdb;

use userdb;

create table app_user (
    id int not null auto_increment,
    username varchar(100) not null,
    password varchar(100) not null,
    sso_uid varchar(255) null,
    email varchar(360) null,
    register_type tinyint(3) not null,
    active tinyint(1) default true,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    primary key(id)
) character set utf8 collate utf8_general_ci;

create table social_account (
    id int not null auto_increment,
    social_platform int not null,
    social_acct_link text null,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    user_id int not null,
    primary key(id),
    foreign key (user_id) references app_user(id) on delete cascade
) character set utf8 collate utf8_general_ci;

create table personal_profile (
    id int not null auto_increment,
    first_name varchar(255) null,
    last_name varchar(255) null,
    address_1 varchar(360) null,
    address_2 varchar(360) null,
    postal_code varchar(10) null,
    city varchar(255) null,
    country varchar(255) null,
    mobile varchar(12) null,
    dob datetime null,
    about_me varchar(500) null,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    user_id int not null,
    primary key(id),
    foreign key (user_id) references app_user(id) on delete cascade
) character set utf8 collate utf8_general_ci;

create table skillset_profile (
    id int not null auto_increment,
    skill int not null,
    skill_desc text null,
    skill_endorsed int default 0,
    display tinyint default 1,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    user_id int not null,
    primary key(id),
    foreign key (user_id) references app_user(id) on delete cascade
) character set utf8 collate utf8_general_ci;

create table professional_level (
    id int not null auto_increment,
    lvl int not null default 1,
    exp int not null default 0,
    title varchar(255) null,
    user_id int not null,
    skillset_profile_id int not null,
    primary key(id),
    foreign key (skillset_profile_id) references skillset_profile(id) on delete cascade
) character set utf8 collate utf8_general_ci;

create table novice_level (
    id int not null auto_increment,
    lvl int not null default 1,
    exp int not null default 0,
    title varchar(255) null,
    user_id int not null,
    primary key(id),
    foreign key (user_id) references app_user(id) on delete cascade
) character set utf8 collate utf8_general_ci;