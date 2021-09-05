-- create schema shm

create table shm.Dish_Type (
Type_id int primary key not null,
Name varchar(255),
)

create table shm.Dish (
Dish_id int primary key not null,
Name varchar(255),
Description varchar(255),
Calories int,
Cost float,
Type_id int,
FOREIGN KEY (Type_id) REFERENCES shm.Dish_Type(Type_id) ON DELETE CASCADE
)

create table shm.Menu (
Dish_id int NOT NULL,
Date date NOT NULL,
constraint PK_Tmp primary key (Dish_id, Date),
FOREIGN KEY (Dish_id) REFERENCES shm.Dish(Dish_id) ON DELETE CASCADE
)

create table shm.Job (
Job_id int primary key not null,
Description varchar(255)
)

create table shm.Employee (
Employee_id int primary key not null,
First_name varchar(255),
Last_name varchar(255),
Salary float,
Job_id int,
FOREIGN KEY (Job_id) REFERENCES shm.Job(Job_id) ON DELETE CASCADE
)

create table shm.Warehouse (
Warehouse_id int primary key not null,
Employee_id int,
FOREIGN KEY (Employee_id) REFERENCES shm.Employee(Employee_id) ON DELETE CASCADE
)

create table shm.Category (
Category_id int primary key not null,
Name varchar(255),
Warehouse_id int,
FOREIGN KEY (Warehouse_id) REFERENCES shm.Warehouse(Warehouse_id) ON DELETE CASCADE
)

create table shm.Product (
Product_id int primary key not null,
Description varchar(255),
Category_id int,
FOREIGN KEY (Category_id) REFERENCES shm.Category(Category_id) ON DELETE CASCADE
)

create table shm.Dish_Contains (
Dish_id  int NOT NULL,
Product_id int NOT NULL,
constraint PK_Tmp_ primary key (Dish_id, Product_id),
FOREIGN KEY (Product_id) REFERENCES shm.Product(Product_id) ON DELETE CASCADE,
FOREIGN KEY (Dish_id) REFERENCES shm.Dish(Dish_id) ON DELETE CASCADE
)

create table shm.Item (
Item_id int primary key not null,
Sum float,
Product_id int,
FOREIGN KEY (Product_id) REFERENCES shm.Product(Product_id) ON DELETE CASCADE
)

create table shm.Discond_Card (
Card_id int primary key not null,
Percentage int,
Valid_from date,
Valid_to date
)

create table shm.Client (
Client_id int primary key not null,
Name varchar(255),
Phone_number varchar(255),
Card_id int,
FOREIGN KEY (Card_id) REFERENCES shm.Discond_Card(Card_id) ON DELETE CASCADE
)

create table shm.Order_Table (
Order_id int primary key not null,
Date date,
Sum float,
Client_id int,
Employee_id int,
FOREIGN KEY (Client_id) REFERENCES shm.Client(Client_id) ON DELETE CASCADE,
FOREIGN KEY (Employee_id) REFERENCES shm.Employee(Employee_id) ON DELETE CASCADE
)



--new table for triggers

drop table shm.Salary

create table shm.Salary (
Job_id int primary key not null,
Sum_Salary int
)

go
DECLARE @sal1 int, @sal2 int, @sal3 int, @sal4 int, @sal5 int, @sal6 int, @sal7 int, @sal8 int, @sal9 int, @sal10 int
set @sal1 = (select sum(t.Salary) from shm.Employee as t where t.Job_id = 1)
set @sal2 = (select sum(t.Salary) from shm.Employee as t where t.Job_id = 2)
set @sal3 = (select sum(t.Salary) from shm.Employee as t where t.Job_id = 3)
set @sal4 = (select sum(t.Salary) from shm.Employee as t where t.Job_id = 4)
set @sal5 = (select sum(t.Salary) from shm.Employee as t where t.Job_id = 5)
set @sal6 = (select sum(t.Salary) from shm.Employee as t where t.Job_id = 6)
set @sal7 = (select sum(t.Salary) from shm.Employee as t where t.Job_id = 7)
set @sal8 = (select sum(t.Salary) from shm.Employee as t where t.Job_id = 8)
set @sal9 = (select sum(t.Salary) from shm.Employee as t where t.Job_id = 9)
set @sal10 = (select sum(t.Salary) from shm.Employee as t where t.Job_id = 10);

select @sal1

INSERT INTO shm.Salary VALUES(1, @sal1)
INSERT INTO shm.Salary VALUES(2, @sal2)
INSERT INTO shm.Salary VALUES(3, @sal3)
INSERT INTO shm.Salary VALUES(4, @sal4)
INSERT INTO shm.Salary VALUES(5, @sal5)
INSERT INTO shm.Salary VALUES(6, @sal6)
INSERT INTO shm.Salary VALUES(7, @sal7)
INSERT INTO shm.Salary VALUES(8, @sal8)
INSERT INTO shm.Salary VALUES(9, @sal9)
INSERT INTO shm.Salary VALUES(10, @sal10)

select * from shm.Salary
select * from shm.Employee

----------------------------


INSERT INTO shm.Job VALUES(1, 'Повар горячего цеха')
INSERT INTO shm.Job VALUES(2, 'Повар холодного цеха')
INSERT INTO shm.Job VALUES(3, 'Повар')
INSERT INTO shm.Job VALUES(4, 'Уборщик')
INSERT INTO shm.Job VALUES(5, 'Кассир')
INSERT INTO shm.Job VALUES(6, 'Работник раздачи')
INSERT INTO shm.Job VALUES(7, 'Посудомойщик')
INSERT INTO shm.Job VALUES(8, 'Грузчик')
INSERT INTO shm.Job VALUES(9, 'Разнорабочий')
INSERT INTO shm.Job VALUES(10, 'Шефповар')


INSERT INTO shm.Employee VALUES(1, 'Василий', 'Пупкин', 50000, 3)
INSERT INTO shm.Employee VALUES(2, 'Гордон', 'Рамзи', 100000, 10)
INSERT INTO shm.Employee VALUES(3, 'ДеБлюю', 'Салантин', 80000, 1)
INSERT INTO shm.Employee VALUES(4, 'Оливье', 'Пилевин', 80000, 2)
INSERT INTO shm.Employee VALUES(5, 'Андрей', 'Виноградов', 60000, 3)
INSERT INTO shm.Employee VALUES(6, 'Игорь', 'Журавлёв', 60000, 3)
INSERT INTO shm.Employee VALUES(7, 'Александр', 'Осипов', 60000, 3)
INSERT INTO shm.Employee VALUES(8, 'Олег', 'Пупкин', 40000, 4)
INSERT INTO shm.Employee VALUES(9, 'Никита', 'Горшков', 40000, 4)
INSERT INTO shm.Employee VALUES(10, 'Анна', 'Панова', 50000, 5)
INSERT INTO shm.Employee VALUES(11, 'Анастасия', 'Муравьева', 50000, 5)
INSERT INTO shm.Employee VALUES(12, 'Даниил', 'Михеев', 50000, 6)
INSERT INTO shm.Employee VALUES(13, 'Екатерина', 'Баранова', 50000, 6)
INSERT INTO shm.Employee VALUES(14, 'Алексей', 'Лобанов', 40000, 7)
INSERT INTO shm.Employee VALUES(15, 'Василий', 'Понрягин', 40000, 7)
INSERT INTO shm.Employee VALUES(16, 'Татьяна', 'Пиголкина', 40000, 7)
INSERT INTO shm.Employee VALUES(17, 'Виталий', 'Антонов', 50000, 8)
INSERT INTO shm.Employee VALUES(18, 'Никита', 'Селезнёв', 50000, 8)
INSERT INTO shm.Employee VALUES(19, 'Алексей', 'Яковлев', 40000, 9)
--INSERT INTO shm.Employee(Employee_id, First_name, Last_name, Salary) VALUES(20, 'Алексей', 'Яковлев', 40000)


INSERT INTO shm.Warehouse VALUES(1, 17)
INSERT INTO shm.Warehouse VALUES(2, 17)
INSERT INTO shm.Warehouse VALUES(3, 18)
INSERT INTO shm.Warehouse VALUES(4, 18)


INSERT INTO shm.Category VALUES(1, 'Мясные продукты', 1)
INSERT INTO shm.Category VALUES(2, 'Овощи', 2)
INSERT INTO shm.Category VALUES(3, 'Фрукты', 2)
INSERT INTO shm.Category VALUES(4, 'Непродовольственные продукты', 3)
INSERT INTO shm.Category VALUES(5, 'Консервированные продукты', 4)
INSERT INTO shm.Category VALUES(6, 'Сухие ингридиенты', 4)


INSERT INTO shm.Product VALUES(1, 'Говядина', 1)
INSERT INTO shm.Product VALUES(2, 'Курица', 1)
INSERT INTO shm.Product VALUES(3, 'Телятина', 1)
INSERT INTO shm.Product VALUES(4, 'Картофель', 2)
INSERT INTO shm.Product VALUES(5, 'Морковь', 2)
INSERT INTO shm.Product VALUES(6, 'Лук', 2)
INSERT INTO shm.Product VALUES(7, 'Брокколи', 2)
INSERT INTO shm.Product VALUES(8, 'Яблоки', 3)
INSERT INTO shm.Product VALUES(9, 'Апельсины', 3)
INSERT INTO shm.Product VALUES(10, 'Бананы', 3)
INSERT INTO shm.Product VALUES(11, 'Макароны', 6)
INSERT INTO shm.Product VALUES(12, 'Подсолнечное масло', 6)
INSERT INTO shm.Product VALUES(13, 'Тушенка', 5)
INSERT INTO shm.Product VALUES(14, 'Рыбные консервы', 5)
INSERT INTO shm.Product VALUES(15, 'Маринованные огурцы', 5)
INSERT INTO shm.Product VALUES(16, 'Квашенная капуста', 5)
INSERT INTO shm.Product VALUES(17, 'Соль', 6)
INSERT INTO shm.Product VALUES(18, 'Сахар', 6)
INSERT INTO shm.Product VALUES(19, 'Мука', 6)
INSERT INTO shm.Product VALUES(20, 'Салфетки', 4)
INSERT INTO shm.Product VALUES(21, 'Фольга для запекания', 4)


INSERT INTO shm.Item VALUES(1, 10000, 1)
INSERT INTO shm.Item VALUES(2, 60000, 2)
INSERT INTO shm.Item VALUES(3, 8000, 3)
INSERT INTO shm.Item VALUES(4, 2000, 4)
INSERT INTO shm.Item VALUES(5, 1000, 5)
INSERT INTO shm.Item VALUES(6, 1500, 6)
INSERT INTO shm.Item VALUES(7, 3000, 8)
INSERT INTO shm.Item VALUES(8, 2000, 9)
INSERT INTO shm.Item VALUES(9, 2200, 17)
INSERT INTO shm.Item VALUES(10, 1300, 18)
INSERT INTO shm.Item VALUES(11, 3000, 20)
INSERT INTO shm.Item VALUES(12, 3500, 12)


INSERT INTO shm.Discond_Card VALUES(1, NULL, '2018-03-30', '2019-03-26')
INSERT INTO shm.Discond_Card VALUES(2, 2, '2019-05-12', NULL)
INSERT INTO shm.Discond_Card VALUES(3, 5, '2018-08-23', NULL)
INSERT INTO shm.Discond_Card VALUES(4, NULL, '2018-02-19', '2019-10-08')
INSERT INTO shm.Discond_Card VALUES(5, 10, '2018-03-15', NULL)
INSERT INTO shm.Discond_Card VALUES(6, 8, '2018-03-15', NULL)
INSERT INTO shm.Discond_Card VALUES(7, 5, '2018-04-11', NULL)
INSERT INTO shm.Discond_Card VALUES(8, 5, '2018-04-24', NULL)
INSERT INTO shm.Discond_Card VALUES(9, 2, '2018-06-17', NULL)
INSERT INTO shm.Discond_Card VALUES(10, 2, '2018-05-27', NULL)


INSERT INTO shm.Client VALUES(1, 'Татьяна', '88005553535', 1)
INSERT INTO shm.Client VALUES(2, 'Николай', '8705153430', 2)
INSERT INTO shm.Client VALUES(3, 'Алексей', '89857826434', 3)
INSERT INTO shm.Client VALUES(4, 'Александр', '89031924698', 4)
INSERT INTO shm.Client VALUES(5, 'Мария', '89152997101', 5)
INSERT INTO shm.Client VALUES(6, 'Анастасия', '89254458231', 6)
INSERT INTO shm.Client VALUES(7, 'Эльдар', '89857826434', 7)
INSERT INTO shm.Client VALUES(8, 'Виталий', '89154539855', NULL)
INSERT INTO shm.Client VALUES(9, 'Михаил', '89859936720', NULL)
INSERT INTO shm.Client VALUES(10, 'Анна', '89999038755', NULL)
INSERT INTO shm.Client VALUES(11, 'Юлия', '89537184487', NULL)
INSERT INTO shm.Client VALUES(12, 'Александра', '89672380927', 8)
INSERT INTO shm.Client VALUES(13, 'Сергей', '89858437077', 9)
INSERT INTO shm.Client VALUES(14, 'Мария', '89177020980', NULL)
INSERT INTO shm.Client VALUES(15, 'Никита', '89821721164', NULL)
INSERT INTO shm.Client VALUES(16, 'Татьяна', '89266273137', NULL)
INSERT INTO shm.Client VALUES(17, 'Егор', '89197091224', 10)
INSERT INTO shm.Client VALUES(18, 'Любовь', '89197091224', NULL)
INSERT INTO shm.Client VALUES(19, 'Надежда', '89857750388', NULL)
INSERT INTO shm.Client VALUES(20, 'Вероника', '89209287078', NULL)
INSERT INTO shm.Client VALUES(21, 'Павел', '89778275567', NULL)
INSERT INTO shm.Client VALUES(22, 'Александр', '89296284883', NULL)
INSERT INTO shm.Client VALUES(23, 'Михаил', '89876249953', NULL)
INSERT INTO shm.Client VALUES(24, 'Карина', '89266386217', NULL)


INSERT INTO shm.Order_Table VALUES(1, '2018-04-24', 270, NULL, 10)
INSERT INTO shm.Order_Table VALUES(2, '2018-03-21', 210, 1, 10)
INSERT INTO shm.Order_Table VALUES(3, '2019-04-12', 60, NULL, 10)
INSERT INTO shm.Order_Table VALUES(4, '2018-05-02', 340, NULL, 11)
INSERT INTO shm.Order_Table VALUES(5, '2018-08-06', 230, 3, 10)
INSERT INTO shm.Order_Table VALUES(6, '2018-10-24', 375, NULL, 11)
INSERT INTO shm.Order_Table VALUES(7, '2018-10-25', 400, NULL, 10)
INSERT INTO shm.Order_Table VALUES(8, '2018-05-17', 287, 3, 10)
INSERT INTO shm.Order_Table VALUES(9, '2018-07-24', 96, NULL, 11)
INSERT INTO shm.Order_Table VALUES(10, '2018-09-24', 274, NULL, 11)
INSERT INTO shm.Order_Table VALUES(11, '2019-04-24', 281, 15, 11)
INSERT INTO shm.Order_Table VALUES(12, '2019-03-24', 115, NULL, 10)
INSERT INTO shm.Order_Table VALUES(13, '2019-09-24', 200, NULL, 10)
INSERT INTO shm.Order_Table VALUES(14, '2018-04-24', 255, NULL, 10)
INSERT INTO shm.Order_Table VALUES(15, '2018-04-24', 270, 4, 11)
INSERT INTO shm.Order_Table VALUES(16, '2018-12-03', 270, 7, 11)
INSERT INTO shm.Order_Table VALUES(17, '2018-11-24', 270, NULL, 11)
INSERT INTO shm.Order_Table VALUES(18, '2018-02-22', 987, NULL, 11)
INSERT INTO shm.Order_Table VALUES(19, '2018-06-24', 453, NULL, 10)
INSERT INTO shm.Order_Table VALUES(20, '2018-07-17', 370, 10, 11)
INSERT INTO shm.Order_Table VALUES(21, '2018-04-21', 235, NULL, 10)
INSERT INTO shm.Order_Table VALUES(22, '2018-04-04', 270, NULL, 10)
INSERT INTO shm.Order_Table VALUES(23, '2018-08-24', 270, NULL, 11)
INSERT INTO shm.Order_Table VALUES(24, '2018-04-09', 642, 21, 11)
INSERT INTO shm.Order_Table VALUES(25, '2018-03-12', 95, NULL, 11)


INSERT INTO shm.Dish_Type VALUES(1, 'Первое блюдо')
INSERT INTO shm.Dish_Type VALUES(2, 'Второе блюдо')
INSERT INTO shm.Dish_Type VALUES(3, 'Напиток')
INSERT INTO shm.Dish_Type VALUES(4, 'Десерт')
INSERT INTO shm.Dish_Type VALUES(5, 'Закуска')


INSERT INTO shm.Dish VALUES(1, 'Картофель', 'Мягкий отварной картофель с топленным маслом', 400, 80, 2)
INSERT INTO shm.Dish VALUES(2, 'Борщ', 'Украинский домашний борщ с пампушками', 300, 100, 1)
INSERT INTO shm.Dish VALUES(3, 'Рассольник', 'Классический рассольник', 300, 100, 1)
INSERT INTO shm.Dish VALUES(4, 'Макароны по флотски', 'Спагетти с фаршем', 400, 100, 2)
INSERT INTO shm.Dish VALUES(5, 'Компот', 'Компот из сухофруктов', 100, 40, 3)
INSERT INTO shm.Dish VALUES(6, 'Лангет из говядины', 'Запченая говядина', 300, 120, 2)
INSERT INTO shm.Dish VALUES(7, 'Жаренная картошка', 'Жаренный картофель с луком', 250, 110, 2)
INSERT INTO shm.Dish VALUES(8, 'Блины', 'Блины со сгущенкой или сметаной', 200, 150, 4)
INSERT INTO shm.Dish VALUES(9, 'Квашенная капуста', 'Квашенная капуста с морковью', 100, 80, 5)
INSERT INTO shm.Dish VALUES(10, 'Кефир', '5% кефир', 100, 40, 3)
INSERT INTO shm.Dish VALUES(11, 'Рис', 'Отварной рис', 100, 130, 2)
INSERT INTO shm.Dish VALUES(12, 'Жаренная курица', 'Жаренная курица с чесночным соусом', 200, 100, 2)


INSERT INTO shm.Menu VALUES(1, '2019-10-20')
INSERT INTO shm.Menu VALUES(3, '2019-10-20')
INSERT INTO shm.Menu VALUES(5, '2019-10-20')
INSERT INTO shm.Menu VALUES(6, '2019-10-20')
INSERT INTO shm.Menu VALUES(12, '2019-10-20')
INSERT INTO shm.Menu VALUES(9, '2019-10-20')

INSERT INTO shm.Menu VALUES(1, '2019-10-21')
INSERT INTO shm.Menu VALUES(3, '2019-10-21')
INSERT INTO shm.Menu VALUES(5, '2019-10-21')
INSERT INTO shm.Menu VALUES(6, '2019-10-21')
INSERT INTO shm.Menu VALUES(12, '2019-10-21')
INSERT INTO shm.Menu VALUES(9, '2019-10-21')
INSERT INTO shm.Menu VALUES(8, '2019-10-21')
INSERT INTO shm.Menu VALUES(11, '2019-10-21')
INSERT INTO shm.Menu VALUES(2, '2019-10-21')

INSERT INTO shm.Menu VALUES(1, '2019-10-22')
INSERT INTO shm.Menu VALUES(3, '2019-10-22')
INSERT INTO shm.Menu VALUES(5, '2019-10-22')
INSERT INTO shm.Menu VALUES(6, '2019-10-22')
INSERT INTO shm.Menu VALUES(12, '2019-10-22')
INSERT INTO shm.Menu VALUES(9, '2019-10-22')

INSERT INTO shm.Menu VALUES(1, '2019-10-23')
INSERT INTO shm.Menu VALUES(2, '2019-10-23')
INSERT INTO shm.Menu VALUES(3, '2019-10-23')
INSERT INTO shm.Menu VALUES(4, '2019-10-23')
INSERT INTO shm.Menu VALUES(5, '2019-10-23')
INSERT INTO shm.Menu VALUES(6, '2019-10-23')
INSERT INTO shm.Menu VALUES(7, '2019-10-23')
INSERT INTO shm.Menu VALUES(8, '2019-10-23')
INSERT INTO shm.Menu VALUES(9, '2019-10-23')
INSERT INTO shm.Menu VALUES(10, '2019-10-23')
INSERT INTO shm.Menu VALUES(11, '2019-10-23')
INSERT INTO shm.Menu VALUES(12, '2019-10-23')


INSERT INTO shm.Dish_Contains VALUES(1, 4)
INSERT INTO shm.Dish_Contains VALUES(1, 12)

INSERT INTO shm.Dish_Contains VALUES(2, 4)
INSERT INTO shm.Dish_Contains VALUES(2, 12)
INSERT INTO shm.Dish_Contains VALUES(2, 1)
INSERT INTO shm.Dish_Contains VALUES(2, 15)
INSERT INTO shm.Dish_Contains VALUES(2, 16)
INSERT INTO shm.Dish_Contains VALUES(2, 6)

INSERT INTO shm.Dish_Contains VALUES(4, 1)
INSERT INTO shm.Dish_Contains VALUES(4, 2)
INSERT INTO shm.Dish_Contains VALUES(4, 5)
INSERT INTO shm.Dish_Contains VALUES(4, 6)
INSERT INTO shm.Dish_Contains VALUES(4, 11)
INSERT INTO shm.Dish_Contains VALUES(4, 12)

INSERT INTO shm.Dish_Contains VALUES(7, 6)
INSERT INTO shm.Dish_Contains VALUES(7, 4)
INSERT INTO shm.Dish_Contains VALUES(7, 12)


--------------------------------------------------------------------------------------------------


/*
drop table shm.Order_Table
drop table shm.Client
drop table shm.Discond_Card
drop table shm.Dish_Contains
drop table shm.Item
drop table shm.Product
drop table shm.Category
drop table shm.Warehouse
drop table shm.Employee
drop table shm.Job
drop table shm.Menu
drop table shm.Dish
drop table shm.Dish_Type
*/


-----------------------------------------------------------------------------------------------------------------------------


select * from shm.Employee
