DROP DATABASE IF EXISTS questdb;

create database IF NOT EXISTS questdb;

use questdb;

DROP TABLE IF EXISTS quest_flow;
DROP TABLE IF EXISTS quest_contract;
DROP TABLE IF EXISTS quest_proposal;
DROP TABLE IF EXISTS quest_requirement;
DROP TABLE IF EXISTS quest_user_concern;
DROP TABLE IF EXISTS quest;

create table IF NOT EXISTS quest (
    id int not null auto_increment,
    title varchar(255) not null,
    description varchar(1000) null,
    category tinyint(3) null,
    location varchar(100) null,
    difficulty_level integer null,
    status varchar(20) null,
    skill_required varchar(500) null,
    awarded tinyint(1) default false,
    awarded_to integer null,
    requestor integer not null,
    reward_type tinyint(3) null,
    reward varchar(255) null,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    primary key(id)
) character set utf8 collate utf8_general_ci;


create table IF NOT EXISTS quest_proposal (
    id int not null auto_increment,
    proposal_json text null,
    proposal_details varchar(1000) null,
    proposal_score double not null default 0,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    username varchar(100) not null,
    cost varchar(255) null,
    quest_id int not null,
    primary key(id),
    foreign key (quest_id) references quest(id) on delete cascade
) character set utf8 collate utf8_general_ci;

create table IF NOT EXISTS quest_flow (
    id int not null auto_increment,
    quest_id int not null,
    stage varchar(10) null,
    requestor_remarks varchar(360) null,
    taker_remarks varchar(360) null,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    primary key(id),
    foreign key (quest_id) references quest(id) on delete cascade
) character set utf8 collate utf8_general_ci;

create table IF NOT EXISTS quest_requirement (
    id int not null auto_increment,
    requirement varchar(1000) null,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    quest_id int not null,
    primary key(id),
    foreign key (quest_id) references quest(id) on delete cascade
) character set utf8 collate utf8_general_ci;

create table IF NOT EXISTS quest_user_concern (
    id int not null auto_increment,
    context varchar(255) not null,
    concern_validation text null,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    quest_id int not null,
    primary key(id),
    foreign key (quest_id) references quest(id) on delete cascade
) character set utf8 collate utf8_general_ci;

create table IF NOT EXISTS location (
    id int not null auto_increment,
    longitude varchar(20) null,
    latitude varchar(20) null,
    unit_no varchar(40) null,
    address1 varchar(255) null,
    address2 varchar(255) null,
    postal_code varchar(10) null,
    state varchar(255) null,
    country varchar(255) null,
    quest_id int not null,
    primary key(id),
    foreign key(quest_id) references quest(id) on delete cascade
) character set utf8 collate utf8_general_ci;

create table IF NOT EXISTS quest_taker_request (
    id int not null auto_increment,
    quest_id int not null,
    username varchar(120) not null,
    status varchar(20) null,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    foreign key (quest_id) references quest(id) on delete cascade,
  	primary key(id)
) character set utf8 collate utf8_general_ci;
