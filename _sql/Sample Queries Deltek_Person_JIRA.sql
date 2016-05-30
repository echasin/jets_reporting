Select p.employee_id, date_trunc('month',d.date_hrs_deltek)as Deltek_Match_Date, date_trunc('month',j.date)as JIRA_Match_Date  from deltek_labor_hours d, person p,jira_logged_work j
where
d.employee_full_name = p.employee_full_name
and 
p.jira_user_name = j.username


Select p.employee_id, date_trunc('month',d.date_hrs_deltek)as Deltek_Match_Date, date_trunc('month',j.date)as JIRA_Match_Date  from deltek_labor_hours d, person p,jira_logged_work j
where
d.employee_full_name = p.employee_full_name
and 
p.jira_user_name = j.username
and
date_trunc('month',d.date_hrs_deltek)= '2016-05-01 00:00:00'
and 
date_trunc('month',j.date)= '2016-04-01 00:00:00'

Select * from deltek_labor_hours d, person p,jira_logged_work j
where
d.employee_full_name = p.employee_full_name
and 
p.jira_user_name = j.username


Select * from deltek_labor_hours d, person p,jira_logged_work j
where
d.employee_full_name = p.employee_full_name
and 
p.jira_user_name = j.username
and 
j.date = to_date('2016-04-20', 'YYYY-MM-DD')


Select * from jira_logged_work j
where
to_char(j.date, 'YYYY-MM-DD') = '2016-04-01'


Select * from deltek_labor_hours d, jira_logged_work j, person p
where
d.employee_full_name = p.employee_full_name
and 
p.jira_user_name = j.username
and
to_char(d.date_hrs_deltek, 'YYYY-MM-DD') = '2016-04-01'
and 
to_char(j.date, 'YYYY-MM-DD') = '2016-04-01'

//Report Summary Hours Deltek, JIRA by Employee, Date

Select p.employee_id, p.employee_full_name, to_char(d.date_hrs_deltek, 'YYYY-MM-DD'), sum(d.entered_labor_hours), sum(j.time_spent_hour) from deltek_labor_hours d, jira_logged_work j, person p
where
d.employee_full_name = p.employee_full_name
and 
p.jira_user_name = j.username
and
to_char(d.date_hrs_deltek, 'YYYY-MM-DD') = to_char(j.date, 'YYYY-MM-DD') 
and 
to_char(j.date, 'YYYY-MM-DD') = '2016-04-04'
and
p.employee_id IS NOT NULL
group by  p.employee_id, p.employee_full_name, to_char(d.date_hrs_deltek, 'YYYY-MM-DD')



//Report Details Hours Deltek, JIRA by Employee, Date

Select p.employee_id, p.employee_full_name, to_char(d.date_hrs_deltek, 'YYYY-MM-DD'), d.entered_labor_hours, j.date, j.time_spent_hour from deltek_labor_hours d, jira_logged_work j, person p
where
d.employee_full_name = p.employee_full_name
and 
p.jira_user_name = j.username
and
to_char(d.date_hrs_deltek, 'YYYY-MM-DD') = to_char(j.date, 'YYYY-MM-DD') 
and 
to_char(j.date, 'YYYY-MM-DD') = '2016-04-01'
and
p.employee_full_name = 'PATEL, SACHIN'


//Report Detail Hours Deltek
Select * from deltek_labor_hours d
where
to_char(d.date_hrs_deltek, 'YYYY-MM-DD') = '2016-04-04'
and
d.employee_full_name = 'PATEL, SACHIN'

//Summary JIRA Hours by Date Filtered by Date
Select sum(j.time_spent_hour) from jira_logged_work j
where
to_char(j.date, 'YYYY-MM-DD') = '2016-04-04'
and
j.username = 'Sachin Patel'
group by to_char(j.date, 'YYYY-MM-DD')


//Summary JIRA Hours by Date Filtered by Username
Select p.employee_id, p.employee_full_name, to_char(j.date, 'YYYY-MM-DD') as JIRA_DATE ,sum(j.time_spent_hour) as JIRA_HOURS from jira_logged_work j, person p
where
j.username = p.jira_user_name
and
j.username = 'Sachin Patel'
group by p.employee_id, p.employee_full_name, to_char(j.date, 'YYYY-MM-DD')
order by to_char(j.date, 'YYYY-MM-DD')
 

//Summary DELTEK  Hours by Date Filtered by Username
Select p.employee_id, p.employee_full_name, to_char(d.date_hrs_deltek, 'YYYY-MM-DD')as DELTEK_DATE, sum(d.entered_labor_hours) as DELTEK_HOURS from deltek_labor_hours d,  person p
where
d.employee_full_name = p.employee_full_name
and
p.jira_user_name = 'Sachin Patel'
group by p.employee_id, p.employee_full_name, to_char(d.date_hrs_deltek, 'YYYY-MM-DD')
order by to_char(d.date_hrs_deltek, 'YYYY-MM-DD')


//Views Hours Summary 

Drop view JIRA_hours_sum_date;
Create view JIRA_hours_sum_date AS
Select p.employee_id, upper(p.employee_full_name) as employee_full_name, to_char(j.date, 'YYYY-MM-DD') as JIRA_DATE ,sum(j.time_spent_hour) as JIRA_HOURS from jira_logged_work j, person p
where
j.username = p.jira_user_name
group by p.employee_id, p.employee_full_name, to_char(j.date, 'YYYY-MM-DD')
order by upper(p.employee_full_name),to_char(j.date, 'YYYY-MM-DD')


Select * from JIRA_Hours

Drop view DELTEK_hours_sum_date; 
Create view DELTEK_hours_sum_date AS
Select p.employee_id, upper(p.employee_full_name) as employee_full_name, to_char(d.date_hrs_deltek, 'YYYY-MM-DD') as DELTEK_DATE, sum(d.entered_labor_hours) as DELTEK_HOURS from deltek_labor_hours d,  person p
where
d.employee_full_name = p.employee_full_name
group by p.employee_id, p.employee_full_name, to_char(d.date_hrs_deltek, 'YYYY-MM-DD')
order by upper(p.employee_full_name),to_char(d.date_hrs_deltek, 'YYYY-MM-DD')

Select * from DELTEK_Hours

//Joined Views  - THIS WORKS DELTEK IS SYSTEM OF RECORD
Select DELTEK_Hours.employee_id, DELTEK_Hours.employee_full_name, DELTEK_Hours.deltek_date, DELTEK_Hours.deltek_hours, JIRA_Hours.jira_hours from  DELTEK_Hours 
left outer join JIRA_Hours  on DELTEK_Hours.employee_id = JIRA_Hours.employee_id
and DELTEK_Hours.deltek_date = JIRA_Hours.jira_date
order by DELTEK_Hours.employee_full_name, DELTEK_Hours.deltek_date


//Joined Views  - THIS WORKS JIRA IS SYSTEM OF RECORD
Select DELTEK_Hours.employee_id, JIRA_Hours.employee_full_name, JIRA_Hours.jira_date, DELTEK_Hours.deltek_hours, JIRA_Hours.jira_hours from  JIRA_Hours 
left outer join DELTEK_Hours  on JIRA_Hours.employee_id=DELTEK_Hours.employee_id 
and JIRA_Hours.jira_date = DELTEK_Hours.deltek_date
order by JIRA_Hours.employee_full_name, JIRA_Hours.jira_date


//Joined Views  - THIS WORKS JIRA IS SYSTEM OF RECORD
Select DELTEK_Hours.employee_id, JIRA_Hours.employee_full_name, JIRA_Hours.jira_date, DELTEK_Hours.deltek_hours, JIRA_Hours.jira_hours from  JIRA_Hours 
full outer join DELTEK_Hours  on JIRA_Hours.employee_full_name=DELTEK_Hours.employee_full_name
and JIRA_Hours.jira_date = DELTEK_Hours.deltek_date
order by JIRA_Hours.employee_full_name, JIRA_Hours.jira_date


//Missing Data Report
Select name as employee_full_name, date, sum(d_hours) as deltek_hours, sum(j_hours) as jira_hours
FROM (
Select DELTEK_Hours.employee_full_name as name,DELTEK_Hours.deltek_date as Date, DELTEK_Hours.deltek_hours AS D_HOURS, 0 as J_HOURS from  DELTEK_Hours_sum_date DELTEK_HOURS
Union
Select  JIRA_HOURS.employee_full_name as name,JIRA_Hours.jira_date as Date, 0 AS D_HOURS, JIRA_Hours.jira_hours as J_HOURS from  JIRA_Hours_sum_date JIRA_HOURS
order by name,Date
) as missing_data
group by name, date
order by name, date

DELTEK_Hours.employee_full_name, Date





full outer join DELTEK_Hours  on p.employee_full_name=DELTEK_Hours.employee_full_name
and JIRA_Hours.jira_date = DELTEK_Hours.deltek_date
order by JIRA_Hours.employee_full_name, JIRA_Hours.jira_date





Delete from Person where employee_id IS NULL





