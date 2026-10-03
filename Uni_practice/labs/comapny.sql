-- ################## Queries #############


-- --------------------- 1 ------------------------
select doctor_name,doctor_salary,doctor_profession,dept_no,doctor_comm
from doctor
where doctor_comm<=10000;

-- ----------------------------- 2 -----------------------


select doctor_name,doctor_salary,doctor_profession,dept_no,doctor_comm
from doctor 
where doctor_profession in ('Dentists','Neurologist') and doctor_salary>100000;


-- ----------------------- 3 ---------------------
select doctor_name,
doctor_salary*0.20,
doctor_profession,
dept_no,
doctor_comm
from doctor 
where doctor_profession ='Cardiologist';


-- ---------------- 4--------------------
select doctor_name,doctor_salary,doctor_profession,dept_no,doctor_comm
from doctor 
where doctor_name like '%Shah';


-- -------------- 5 ----------------
select doctor_name,doctor_salary,doctor_profession,dept_no,doctor_comm
from doctor 
where doctor_profession ='Radiologist' and dept_no not in(5,6);

