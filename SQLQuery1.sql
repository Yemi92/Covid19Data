/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [patient_id]
      ,[sex]
      ,[age]
      ,[country]
      ,[province]
      ,[city]
      ,[infection_case]
      ,[infected_by]
      ,[contact_number]
      ,[symptom_onset_date]
      ,[confirmed_date]
      ,[released_date]
      ,[deceased_date]
      ,[state]
  FROM [Module4].[dbo].[PatientInfo]

  use Module4

select * from PatientInfo
select distinct patient_id from PatientInfo

-- Creating ID_table -----

select patient_id, sex, age
into ID_Table 
from PatientInfo

select * from ID_Table

alter table ID_Table
add primary key (patient_id)


--Creating Location Table
select Patient_id, country, province, city 
into Location_Table 
from PatientInfo

alter table Location_Table
add LocationID int identity(1,1)

select* from Location_Table

-- creating infection Table--
select patient_id, infection_case, infected_by
into Infection_Table
from PatientInfo

alter table Infection_Table
add InfectionID int identity(1,1)

select * from Infection_Table

-- creating Actual Location Table--

select Location_Table.patient_id, Location_Table.country, Location_Table.province, Location_Table.city, Location_Table.locationID, Infection_Table.InfectionID
into ActualLocation_Table
from Location_Table
inner join Infection_Table
on Location_Table.patient_id = Infection_Table.patient_id

select * from ActualLocation_Table

alter table ActualLocation_Table
add foreign key(patient_id) references ID_Table(patient_id)

alter table ActualLocation_Table
add primary key (locationID)

alter table ActualLocation_Table
add foreign key(InfectionID) references ActualInfection_Table(InfectionID)


-- creating Infection Table2 note; use to create actual infection table --

select Infection_Table.infection_case, Infection_Table.infected_by, Infection_Table.InfectionID, ActualLocation_Table.LocationID, ActualLocation_Table.patient_id
into Infection_Table2
from Infection_Table
inner join ActualLocation_Table
on Infection_Table.patient_id = ActualLocation_Table.patient_id
select * from Infection_Table2

-- creatin Actual infection Table--

select Infection_Table2.infection_case, Infection_Table2.infected_by, Infection_Table2.InfectionID, Infection_Table2.LocationID, State_Table.stateID 
into ActualInfection_Table
from Infection_Table2
inner join State_Table 
on Infection_Table2.patient_id = State_Table.patient_id

alter table ActualInfection_Table
add primary key (InfectionID)

alter table ActualInfection_Table
add foreign key (StateID) references State_Table(StateID)

alter table ActualInfection_Table
add foreign key (LocationID) references ActualLocation_Table(LocationID)

select * from ActualInfection_Table

--creating State Table--
select patient_id, state, symptom_onset_date, confirmed_date, released_date, deceased_date  
into State_Table 
from PatientInfo

alter table State_Table
add StateID int identity(1,1)

alter table State_Table
add primary key (StateID)

alter table State_Table
add foreign key (patient_id) references ID_table(patient_id)

select * from State_Table

------------------------------------------------------------------------------------------------
select * from ID_Table
select * from ActualLocation_Table
select * from ActualInfection_Table
select * from State_Table