use [Swiggy Database];

select * from Swiggy_Data;

-- Data Validation & Cleaning
-- Null Check

select 
   Sum(case when state is null then 1 else 0 end) as Null_State,
   Sum(case when city is null then 1 else 0 end) as Null_city,
   Sum(case when Order_Date is null then 1 else 0 end) as Null_order_date,
   Sum(case when Restaurant_Name is null then 1 else 0 end) as Null_restaurant,
   Sum(case when Location is null then 1 else 0 end) as Null_location,
   Sum(case when Category is null then 1 else 0 end) as Null_Category,
   Sum(case when Dish_Name is null then 1 else 0 end) as Null_Dish,
   Sum(case when Price_INR is null then 1 else 0 end) as Null_Price,
   Sum(case when Rating is null then 1 else 0 end) as Null_rating,
   Sum(case when Rating_Count is null then 1 else 0 end) as Null_Rating_count
from Swiggy_Data;

-- Blank or Empty Cells

Select * from Swiggy_Data where City= '' or State= ' ' or Restaurant_Name= ' ' or Location= ' ' or Category= ' ' or Dish_Name= ' ' 

-- Duplicate Cells

Select State, City, Order_Date, Restaurant_Name, Location, Category, Dish_Name, Price_INR, Rating, Rating_Count,COUNT(*) as CNT
from Swiggy_Data
Group by State, City, Order_Date, Restaurant_Name, Location, Category, Dish_Name, Price_INR, Rating, Rating_Count Having COUNT(*)>1

-- Remove Duplicate Cells

With CTE as (
Select *, ROW_NUMBER() Over(Partition by state, City, order_date, Restaurant_Name, Location, 
                                         Category, Dish_Name, Price_INR, Rating, Rating_count order by (Select NULL)) as Rn from Swiggy_Data)
Delete from CTE Where rn>1;

-- Create Snow Flake Schema
-- Dimension Tables 
-- Date Table
create Table Dim_Date (
  date_id int IDENTITY(1,1) Primary Key,
  Full_Date Date,
  Year Int,
  Month Int,
  Month_Name Varchar(20),
  Quarter Int,
  Week int, 
  Day int
  )

-- Location date
create table Dim_Location(
  Location_Id int Identity(1,1) Primary Key,
  State Varchar(100),
  City varchar(100),
  Location Varchar(200)
  )

  -- Restaurant Name
  create table Dim_Restaurant(
     Restaurant_id int identity(1,1) primary key,
     Restaurant_Name Varchar(200)
     )

  -- Category
  create table Dim_Category(
     Category_id int identity(1,1) primary key,
     Category_Name Varchar(200)
     )

  -- Dish Name
  create table Dim_Dish(
     Dish_id int identity(1,1) primary key,
     Dish_Name Varchar(200)
     )

-- fact datatable
Create Table Fact_Swiggy(
order_id int identity(1,1) primary key,

date_id int,
dish_id int,
Category_id int,
Location_id int,
Restaurant_id int,
Price_INR Decimal(10,2),
Rating Decimal(10,2),
Rating_Count int,

foreign key (date_id) references Dim_Date(date_id),
foreign key (dish_id) references Dim_Dish(dish_id),
foreign key (Location_id) references Dim_Location(Location_id),
foreign key (Category_id) references Dim_Category(Category_id),
foreign key (Restaurant_id) references Dim_Restaurant(Restaurant_id))

-- insert data to fact & dimension Tables
-- Dim_Date
insert into Dim_Date(Full_Date, Year, Month, Month_Name, Quarter, Week, Day)
 select Distinct
   Order_Date,
   Year(Order_Date),
   Month(Order_Date),
   DATENAME(Month,Order_Date),
   DATEPART(quarter,Order_Date),
   Datepart(Week,Order_Date),
   Day (Order_Date)
from Swiggy_Data
where Order_Date is not null;

-- Dim_ Location
insert into Dim_Location(State, City, Location)
 select distinct
     state,
     city,
     location
from Swiggy_Data

-- Dim_Category
insert into Dim_Category(Category_Name)
 select distinct
     Category
from Swiggy_Data

-- Dim_Restaurant
insert into Dim_Restaurant(Restaurant_Name)
 select distinct
     Restaurant_Name
from Swiggy_Data

-- Dim_Dish
insert into Dim_Dish(Dish_Name)
 select distinct
     Dish_Name
from Swiggy_Data

-- Fact_Swiggy
INSERT INTO Fact_Swiggy
(
    date_id,
    Price_INR,
    Rating,
    Rating_Count,
    location_id,
    restaurant_id,
    category_id,
    dish_id
)
SELECT
    dd.date_id,
    s.Price_INR,
    s.Rating,
    s.Rating_Count,
    dl.location_id,
    dr.restaurant_id,
    dc.category_id,
    dsh.dish_id
FROM swiggy_data s
JOIN dim_date dd
    ON dd.Full_Date = s.Order_Date
JOIN dim_location dl
    ON dl.State = s.State
    AND dl.City = s.City
    AND dl.Location = s.Location
JOIN dim_restaurant dr
    ON dr.Restaurant_Name = s.Restaurant_Name
JOIN dim_category dc
    ON dc.Category_Name = s.Category
JOIN dim_dish dsh
    ON dsh.Dish_Name = s.Dish_Name;

-- Fact_Swiggy Data
select * from Fact_Swiggy
    
-- To Get Full_Data_in One table
SELECT *
FROM Fact_Swiggy f
JOIN dim_date d 
    ON f.date_id = d.date_id
JOIN dim_location l 
    ON f.location_id = l.location_id
JOIN dim_restaurant r 
    ON f.restaurant_id = r.restaurant_id
JOIN dim_category c 
    ON f.category_id = c.category_id
JOIN dim_dish di 
    ON f.dish_id = di.dish_id;


-- Key Performance Indicators
-- Total Orders
select count(order_id) as Total_Orders from Fact_Swiggy

-- Total Revenue (INR Million)
select 
format(SUM(convert(float,Price_INR)) / 1000000, 'N2') + ' INR Million'
as Total_Revenue 
from Fact_Swiggy

-- Average Dish Price 
select 
format(Avg(convert(float,Price_INR)) , 'N2') + ' INR'
as Average_Dish_Price
from Fact_Swiggy

-- Average Rating
select Avg(rating) as Average_Rating from Fact_Swiggy

-- Deep Dive Analaysis
-- Month Order Trends
select d.Year,d.Month, d.Month_Name, COUNT(*) as Total_orders from Fact_Swiggy f
join Dim_Date d on f.date_id= d.date_id
group by d.Year,d.Month, d.Month_Name

-- Extra *Month Revenue Trends*
select d.Year,d.Month, d.Month_Name, Sum(Price_INR) as Total_Revenue from Fact_Swiggy f
join Dim_Date d on f.date_id= d.date_id
group by d.Year,d.Month, d.Month_Name
order by Sum(Price_INR) desc

-- Quarterly Order Trends
select d.Year,d.Quarter, COUNT(*) as Total_orders from Fact_Swiggy f
join Dim_Date d on f.date_id= d.date_id
group by d.Year, d.Quarter

-- Yearly orders
select d.year, COUNT(*) as Total_Orders from Fact_Swiggy f
join Dim_Date d on d.date_id = f.date_id
group by  d.Year
order by d.year asc

-- orders by day of the week
select 
DATENAME(weekday, d.Full_Date) as Day_Week, COUNT(*) as Total_Orders from Fact_Swiggy f
join Dim_Date d on f.date_id=d.date_id
group by DATENAME(weekday, d.Full_Date), DATEPART(weekday, d.Full_Date)
order by DATEPART(weekday, d.Full_Date)

-- Top 10 cities by Orders 
select top 10 l.City, COUNT(*) as Total_Orders from Fact_Swiggy f
join Dim_Location l on f.Location_id=l.Location_Id
group by l.City
order by COUNT(*) desc

-- Revenue Contribution By states
select l.State, sum(Price_INR) as Total_Revenue from Fact_Swiggy f
join Dim_Location l on f.Location_id =l.Location_Id
group by l.State
order by sum(Price_INR) desc

-- Top 10 Restaurants By Orders
select Top 10 r.Restaurant_Name, COUNT(*) as Total_Orders from Fact_Swiggy f
join Dim_Restaurant r on f.Restaurant_id=r.Restaurant_id
group by r.Restaurant_Name
order by Count(*) Desc

-- Top Categories by Revenue
select top 20 c.Category_Name, Sum(Price_INR) as Total_Revenue from Fact_Swiggy f
join Dim_Category c on f.Category_id=c.Category_id
group by c.Category_Name
order by Sum(Price_INR) desc

-- Top Categories by Orders
select top 20 c.Category_Name, COUNT(*) as Total_Orders from Fact_Swiggy f
join Dim_Category c on f.Category_id=c.Category_id
group by c.Category_Name
order by Total_Orders desc

-- Most ordered dishes
Select d.Dish_Name, count(*) as Total_Orders from Fact_Swiggy f
join Dim_Dish d on f.dish_id=d.Dish_id
group by d.Dish_Name
order by count(*) desc

-- Cuisine performance → Orders + Avg Rating
SELECT c.Category_Name, COUNT(*) AS Total_Orders, AVG(CONVERT(FLOAT, f.rating)) AS Avg_Rating FROM Fact_Swiggy f
JOIN dim_category c  ON f.category_id = c.category_id
GROUP BY  c.Category_Name
ORDER BY  total_orders DESC;

-- Total Orders by Price Range

select 
  CASE 
    when Convert(Float,Price_INR) < 100 Then 'Under 100'
    when Convert(Float,Price_INR) Between 100 and 200 Then 'B/W 100 - 200'
    when Convert(Float,Price_INR) Between 200 and 300 Then 'B/W 200 - 300'
    when Convert(Float,Price_INR) Between 400 and 500 Then 'B/W 400 - 500'
    Else '500+'
  End as Price_range,
  Count(*) as Total_Orders from Fact_Swiggy
Group by   
  CASE 
    when Convert(Float,Price_INR) < 100 Then 'Under 100'
    when Convert(Float,Price_INR) Between 100 and 200 Then 'B/W 100 - 200'
    when Convert(Float,Price_INR) Between 200 and 300 Then 'B/W 200 - 300'
    when Convert(Float,Price_INR) Between 400 and 500 Then 'B/W 400 - 500'
    Else '500+'
  End
  order by Total_Orders Desc


-- Rating Count Distribution
Select Rating, COUNT(Rating_Count) as Rating_Count from Fact_Swiggy 
group by Rating 
order by Rating 
