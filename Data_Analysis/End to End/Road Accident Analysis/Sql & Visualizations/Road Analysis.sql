use Road_Acc;
select top 20 * from dbo.Data;

select SUM(number_of_casualties) as CY_Casualties from Data
where YEAR(accident_date)='2022' and road_surface_conditions='Dry';

select count(distinct accident_index) as CY_Accidents from Data
where YEAR(accident_date)='2022' 

select SUM(number_of_casualties) as CY_Fatal_Casualties 
from Data
where YEAR(accident_date)='2022' and accident_severity='Fatal';

select SUM(number_of_casualties) as CY_Serious_Casualties 
from Data
where YEAR(accident_date)='2022' and accident_severity='Serious';


select SUM(number_of_casualties) as CY_Slight_Casualties 
from Data
where YEAR(accident_date)='2022' and accident_severity='Slight';


select 
cast(SUM(number_of_casualties) as decimal (10,2))*100/(select cast(SUM(number_of_casualties) as decimal (10,2)) from Data)
as CY_Percent_Serious_Casualties
from Data
where accident_severity='Serious';

select 
case
	when vehicle_type in ('Agricultural vehicle') then 'Agricultural'
	when vehicle_type in ('Motorcycle 50cc and under','Motorcycle 125cc and under','Motorcycle over 125cc and up to 500cc','Motorcycle over 500cc') then 'Bikes'
	when vehicle_type in ('Bus or coach (17 or more pass seats)','Minibus (8-16 passenger seats)') then 'Buses'
	when vehicle_type in ('Car','Taxi/Private hire car') then 'Cars'
	when vehicle_type in ('Goods 7.5 tonnes mgw and over','Goods over 3.5t and under 7.5t','Van/Goods 3.5 tonnes mgw or under') then 'Vans'
	Else 'Others'
end as Vehicle_group, 
sum(number_of_casualties) as CY_casualties
from Data
where Year(accident_date)='2022'
group by 
case
	when vehicle_type in ('Agricultural vehicle') then 'Agricultural'
	when vehicle_type in ('Motorcycle 50cc and under','Motorcycle 125cc and under','Motorcycle over 125cc and up to 500cc','Motorcycle over 500cc') then 'Bikes'
	when vehicle_type in ('Bus or coach (17 or more pass seats)','Minibus (8-16 passenger seats)') then 'Buses'
	when vehicle_type in ('Car','Taxi/Private hire car') then 'Cars'
	when vehicle_type in ('Goods 7.5 tonnes mgw and over','Goods over 3.5t and under 7.5t','Van/Goods 3.5 tonnes mgw or under') then 'Vans'
	Else 'Others'
end

select DATENAME(month,accident_date) as Month_Name , sum(number_of_casualties) as Total_Casualties
from Data
where Year(accident_date)='2021'
group by DATENAME(month,accident_date);

select road_type , sum(number_of_casualties) as Total_Casualties
from Data
where Year(accident_date)='2021'
group by road_type;

select urban_or_rural_area ,
cast(sum(number_of_casualties) as decimal (10,2))*100/
(select cast(sum(number_of_casualties) as decimal (10,2)) from Data where year(accident_date)='2022')
as CY_Percent_Area_Casualties
from Data
where year(accident_date)='2022'
group by urban_or_rural_area ;

select Top 10 local_authority, sum(number_of_casualties) as total_casualties
from Data
group by local_authority
order by total_casualties desc

