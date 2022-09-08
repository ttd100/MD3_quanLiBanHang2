create database quanLiBanHang2;
use quanLiBanHang2;
create table Customer(
cID int primary key auto_increment,
cName varchar(25),
cAge tinyint
);
insert into Customer(cName,cAge) values
('Minh Quan',10),
('Ngoc Oanh',20),
('Hong Ha',50)
;
create table pOrder(
oID int primary key auto_increment,
cID int not null,
oDate Datetime,
oTotalPrice int,
foreign key(cID) references Customer(cId)
);
insert into pOrder(cID,oDate) values
(1,'2006-3-21'),
(2,'2006-3-23'),
(1,'2006-3-16')
;
create table product(
pID int primary key auto_increment,
pName varchar(25),
pPrice int
);
insert into product(pName,pPrice)values
('May Giat',3),
('Tu Lanh',5),
('Dieu Hoa',7),
('Quat',1),
('Bep Dien',2)
;

drop table orderDetail;
create table orderDetail(
oID int not null,
pID int not null,
odQTY int,
foreign key(oID) references pOrder(oID),
foreign key(pID) references product(pID)
);
insert into orderDetail(oID,pID,odQTY) values
(1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3)
;
-- 2 2.	Hiển thị các thông tin  gồm oID, oDate, oPrice
-- của tất cả các hóa đơn trong bảng Order, 
-- danh sách phải sắp xếp theo thứ tự ngày tháng
select * from pOrder
order by oDate desc;
-- Hiển thị tên và giá của các sản phẩm có giá cao nhất 
select max(pName),max(pPrice) from product;
-- 4.	Hiển thị danh sách các khách hàng đã mua hàng,
-- và danh sách sản phẩm được mua bởi các khách đó như sau.
select cName,pName from orderdetail od
join product p on od.pID = p.pID
join porder po on po.oID = od.oID
join customer cu on cu.cID = po.cID;
-- 5.Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select cName from customer
where cid not in (select cid from porder);
-- 6.	Hiển thị chi tiết của từng hóa đơn như sau 
select od.oID,oDate,odQTY,pName,pPrice from orderdetail od
join product p on od.pID = p.pID
join porder po on po.oID = od.oID;
-- 7.7.	Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn
-- (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn.
-- Giá bán của từng loại được tính = odQTY*pPrice
select od.oid,oDate,sum(od.odQTY) as sum,sum(od.odQTY*pPrice) as Total 
from orderdetail od
join product p on p.pID = od.pID
join porder po on po.oID = od.oID
join customer cu on cu.cID = po.cID
group by od.oID
