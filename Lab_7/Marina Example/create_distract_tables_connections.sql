USE [University]
GO

/****** Object:  Table [dbo].[Role_in_the_department]    Script Date: 07.10.2019 13:37:43 ******/
DROP TABLE [Role_in_the_department]
GO

/****** Object:  Table [dbo].[Role_in_the_lab]    Script Date: 07.10.2019 13:41:25 ******/
DROP TABLE [Role_in_the_lab]
GO 


/****** Object:  Table [dbo].[Role_in_the_publication]    Script Date: 07.10.2019 13:44:15 ******/
DROP TABLE [Role_in_the_publication]
GO


/****** Object:  Table [dbo].[Role_of_contributor]    Script Date: 07.10.2019 16:41:33 ******/
DROP TABLE [Role_of_contributor]
GO


/****** Object:  Table [dbo].[Laboratory]    Script Date: 07.10.2019 13:27:01 ******/
DROP TABLE [Laboratory]
GO



/****** Object:  Table [dbo].[Students]    Script Date: 07.10.2019 18:11:54 ******/
DROP TABLE [Students]
GO


/****** Object:  Table [dbo].[Schedule]    Script Date: 07.10.2019 16:44:12 ******/
DROP TABLE [Schedule]
GO


/****** Object:  Table [dbo].[Discipline]    Script Date: 07.10.2019 13:14:01 ******/
DROP TABLE [Discipline]
GO



/****** Object:  Table [dbo].[Groups]    Script Date: 07.10.2019 13:25:02 ******/
DROP TABLE [Groups]
GO

/****** Object:  Table [dbo].[Educational_department]    Script Date: 07.10.2019 13:18:32 ******/
DROP TABLE [Educational_department]
GO


/****** Object:  Table [dbo].[Publications]    Script Date: 07.10.2019 13:32:04 ******/
DROP TABLE [Publications]
GO


/****** Object:  Table [dbo].[Contributors]    Script Date: 06.10.2019 16:18:27 ******/
DROP TABLE [Contributors]
GO


/****** Object:  Table [dbo].[Administration_officer]    Script Date: 07.10.2019 12:30:09 ******/
DROP TABLE [Administration_officer]
GO


/****** Object:  Table [dbo].[Faculty]    Script Date: 07.10.2019 13:22:05 ******/
DROP TABLE [Faculty]
GO

/****** Object:  Table [dbo].[Scientific_officer]    Script Date: 07.10.2019 18:00:21 ******/
DROP TABLE [Scientific_officer]
GO

/****** Object:  Table [dbo].[Common_officer]    Script Date: 07.10.2019 12:45:05 ******/
DROP TABLE [Common_officer]
GO

CREATE TABLE [Contributors](
	[contributor_id] [int] identity(1,1) NOT NULL,
	[contributor_lastname] [nchar](100) NOT NULL,
	[contributor_name] [nchar](100) NOT NULL,
	[contributor_patronymic] [nchar](100) NULL,
	[scientific_degree] [nchar](100) NOT NULL,
	[alma_mater] [nchar](100) NOT NULL,
	primary key(contributor_id)
)
GO

CREATE TABLE [Administration_officer](
	[admin_id] [int] NOT NULL,
	[ad_supervisor_id] [int] NULL,
	[faculty_id] [int] NULL,
	[adm_position] [nchar](30) NOT NULL,
	primary key(admin_id)
)
GO

CREATE TABLE [Common_officer](
	[officer_id] [int] identity(1,1) NOT NULL,
	[officer_lastname] [nchar](35) NOT NULL,
	[officer_name] [nchar](20) NOT NULL,
	[officer_patronymic] [nchar](40) NULL,
	[date_of_birth] [date] NULL,
	primary key(officer_id)
)
GO

CREATE TABLE [Discipline](
	[discipline_id] [int] identity(1,1) NOT NULL,
	[discipline_name] [nvarchar](20) NOT NULL,
	[evaluation_format] [nchar](5) NOT NULL,
	[labouriousness] [int] NOT NULL,
	[department_id] [int] NOT NULL,
	primary key(discipline_id)
	)
GO

CREATE TABLE [Educational_department](
	[department_id] [int] identity(1,1) NOT NULL,
	[department_name] [nchar](45) NOT NULL,
	[type] [nchar](7) NOT NULL,
	[date_of_establishment] [date] NOT NULL,
	primary key(department_id)
	)
GO

CREATE TABLE [Faculty](
	[faculty_id] [int] identity(1,1) NOT NULL,
	[faculty_name] [nchar](40) NOT NULL,
	[date_of_establishment] [date] NOT NULL,
	primary key(faculty_id)
	)
GO

CREATE TABLE [Groups](
	[group_id] [int] identity(1,1) NOT NULL,
	[faculty_id] [int] NOT NULL,
	[faculty_department_id] [int] NOT NULL,
	[year_of_starting] [int] NOT NULL,
	[receiving_degree] [nchar](10) NOT NULL,
	[group_number] [int] NOT NULL,
	primary key(group_id)
	)
GO

CREATE TABLE [Laboratory](
	[lab_id] [int] identity(1,1) NOT NULL,
	[lab_name] [nchar](30) NOT NULL,
	[field_of_science] [nchar](20) NOT NULL,
	[department_id] [int] NULL,
	primary key(lab_id)
	)
GO

CREATE TABLE [Publications](
	[publication_id] [int] identity(1,1) NOT NULL,
	[publication_name] [nchar](100) NOT NULL,
	[date_of_release] [date] NULL,
	primary key(publication_id)
)
GO

CREATE TABLE [Role_in_the_department](
	[scientific_officer_id] [int] NOT NULL,
	[department_id] [int] NOT NULL,
	[dep_position] [nchar](30) NOT NULL,
	[date_of_recruitment] [date] not null,
	primary key(scientific_officer_id, department_id)
	)
GO

CREATE TABLE [Role_in_the_lab](
	[lab_id] [int] NOT NULL,
	[scientific_officer_id] [int] NOT NULL,
	[lab_position] [nchar](40) NOT NULL,
	[recruitment_date] [date] NULL,
	primary key(scientific_officer_id, lab_id)
	)
GO

CREATE TABLE [Role_in_the_publication](
	[scientific_officer_id] [int] NOT NULL,
	[publication_id] [int] NOT NULL,
	[scientific_role] [nchar](30) NOT NULL,
	primary key(scientific_officer_id, publication_id)
	)
GO

CREATE TABLE [Role_of_contributor](
	[contributor_id] [int] NOT NULL,
	[publication_id] [int] NOT NULL,
	[contributor_role] [nchar](30) NOT NULL,
	primary key(contributor_id, publication_id)
	)
GO

	
CREATE TABLE [Schedule](
	[discipline_id] [int] NOT NULL,
	[scientific_officer_id] [int] NOT NULL,
	[time_start] [time](4) NOT NULL,
	[group_id] [int] NOT NULL,
	[week_day] [nchar](3) NOT NULL,
	[year] [int] NOT NULL,
	[time_end] [time](4) NOT NULL,
	[auditorium] [nchar](7) NOT NULL,
	[semester] [nchar](3) NOT NULL,
	primary key(discipline_id, scientific_officer_id, time_start, group_id, week_day, [year])
	)
GO

CREATE TABLE [Scientific_officer](
	[scientific_officer_id] [int] NOT NULL,
	[scientific_degree] [nchar](20) NOT NULL,
	[citation_index] [int] NULL,
	primary key(scientific_officer_id)
	)
GO

CREATE TABLE [Students](
	[student_id] [int] identity(1,1) NOT NULL,
	[student_lastname] [nchar](35) NOT NULL,
	[student_name] [nchar](20) NOT NULL,
	[student_patronymic] [nchar](25) NULL,
	[group_id] [int] NOT NULL,
	[scientific_adviser_id] [int] NULL,
	[diploma_work_topic] [nchar](80) NULL,
	[medium_entry_standart] [real] NULL,
	primary key(student_id)
	)
GO

alter table [Role_in_the_department]
add constraint roldep_dep foreign key (department_id) references Educational_department(department_id)
GO

alter table [Role_in_the_department]
add constraint rolscientoffdep_scientoff foreign key (department_id) references Scientific_officer(scientific_officer_id) on delete cascade on update cascade
GO

alter table [Role_in_the_lab]
add constraint rollab_lab foreign key (lab_id) references Laboratory(lab_id)
GO

alter table [Role_in_the_lab]
add constraint rolsientofflab_sientoff foreign key (scientific_officer_id) references Scientific_officer(scientific_officer_id) on delete cascade on update cascade
GO

alter table [Role_in_the_publication]
add constraint rolsientofpub_sientoff foreign key (scientific_officer_id) references Scientific_officer(scientific_officer_id) on delete cascade on update cascade
GO

alter table [Role_in_the_publication]
add constraint rolpub_pub foreign key (publication_id) references Publications(publication_id) on delete cascade on update cascade
GO

alter table [Role_of_contributor]
add constraint rolcon_con foreign key (contributor_id) references Contributors(contributor_id) on delete cascade on update cascade
GO

alter table [Role_of_contributor]
add constraint conpub_pub foreign key (publication_id) references Publications(publication_id) on delete cascade on update cascade
GO

alter table [Laboratory]
add constraint labdep1_dep foreign key (department_id) references Educational_department(department_id)
GO

alter table [Students]
add constraint scienadv_scientoff foreign key (scientific_adviser_id) references Scientific_officer(scientific_officer_id) on delete cascade on update cascade
GO

alter table [Students]
add constraint studgroup_group foreign key (group_id) references Groups(group_id)
GO

alter table [Schedule]
add constraint schedgroup_group foreign key (group_id) references Groups(group_id) on delete cascade on update cascade
GO

alter table [Schedule]
add constraint schedscientoff_scientoff foreign key (scientific_officer_id) references Scientific_officer(scientific_officer_id) on delete cascade on update cascade
GO

alter table [Schedule]
add constraint scheddisc_disc foreign key (discipline_id) references Discipline(discipline_id)
GO

alter table [Discipline]
add constraint discdep_dep foreign key (department_id) references Educational_department(department_id)
GO

alter table [Groups]
add constraint groupdep_dep foreign key (faculty_department_id) references Educational_department(department_id)
GO


alter table [Administration_officer]
add constraint admsup_admoff foreign key (ad_supervisor_id) references Administration_officer(admin_id)
GO

alter table [Administration_officer]
add constraint admin_commonoff foreign key (admin_id) references Common_officer(officer_id) on delete cascade on update cascade
GO

alter table [Administration_officer]
add constraint adminfac_fac foreign key (faculty_id) references Faculty(faculty_id)
GO


alter table [Scientific_officer]
add constraint scienoff_commoff foreign key (scientific_officer_id) references Common_officer(officer_id) on delete cascade on update cascade
GO