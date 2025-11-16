-- Analysis of Buying Behaviour Data 

-- creating calculated columns

select Shopping_Frequency  from buying_behaviour

		-- create a table to classify shopping frequency
        
ALTER TABLE buying_behaviour
add column  Frequency_category Varchar (30)

  -- define parameter for set table 
 update buying_behaviour
 set Frequency_category= case 
 
 when Shopping_Frequency >5 then 'Very Often'
 when Shopping_Frequency <2 then 'Not so often'
 when Shopping_Frequency Between 2 and 5 then 'Moderate'
  else 'Unknown'
  end;
  
  select Frequency_category from buying_behaviour
  
  
  -- finding the average monthly spendinng per month 
  -- as these column is a text variable, numeric variable will first be  assigned to each   distinct text 
  
  select distinct Monthly_spending from buying_behaviour
-- assign variable and calculate average  

select avg (
case 
when Monthly_Spending='Less than 100k' then 1
when Monthly_spending ='100-500k' then 2
else null 
end)
as avg_monthly_spending 
from buying_behaviour
  -- this shows that an average respondant spends less than 100k monthly 

-- 2  number of female and male shoppers 

-- male 
select count(*) from buying_behaviour 
where Gender="Male"
-- female 
select count(*) from buying_behaviour 
where Gender="Female"
 
-- finding the total number of response that are Students and from Kwara state 
 select * from buying_behaviour where Occupation= 'Students'and Location ='Kwara'
  select  count(*) from buying_behaviour where Occupation= 'Students'and Location ='Kwara