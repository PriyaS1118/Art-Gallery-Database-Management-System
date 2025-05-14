/*buan_6320_001_group_11
Group Members:
Aarushi Sharma
Camille Favela
Gladys Masomera
Priya Samal
Sankalp Sawant
*/


-- Total 17 tables can be categorised into 5 types
/*
1. Core Entity tables (Artist, Emp Info etc)
2. Art Management (Inventory, contract etc)
3. Event and Collaboration
4. Finance
5. Audit Tracking
*/


drop database if exists buan_6320_001_group_11;
create database buan_6320_001_group_11;

use buan_6320_001_group_11;

-- Below two Tables ArtistInfoTable and EventTable are created by Priya Samal
-- ArtistInfoTable Stores information about artists, such as their name, birthdate, contact details, and address.
drop table if exists ArtistInfoTable;
CREATE TABLE ArtistInfoTable (
    artistID INT NOT NULL AUTO_INCREMENT,
    artistName VARCHAR(255) NOT NULL,
    artistDOB DATE,
    artistApt VARCHAR(255),
    artistStreet VARCHAR(255),
    artistCountry VARCHAR(255),
    artistState VARCHAR(255),
    artistZip VARCHAR(255),
    artistEmail VARCHAR(255) NOT NULL,
    artistPhone VARCHAR(255) NOT NULL,
    PRIMARY KEY (artistID)
);

-- Stores details about events, including event names, descriptions, and the start/end dates and times.
drop table if exists EventTable;
CREATE TABLE EventTable (
    eventID INT NOT NULL AUTO_INCREMENT,
    
    eventName VARCHAR(255) NOT NULL,
    eventDesc LONGTEXT,
    eventStartDate DATE NOT NULL,
    eventEndDate DATE,
    eventStartTime TIME NOT NULL,
    eventEndTime TIME NOT NULL,
    PRIMARY KEY (eventID)
);

-- Below two Tables EmployeeInfoTable and CustomerInfoTable are created by Sankalp Sawant
-- Stores information about employees, such as personal details, job title, salary, and employment dates.
drop table if exists EmployeeInfoTable;
CREATE TABLE EmployeeInfoTable (
    empID INT NOT NULL AUTO_INCREMENT,
    empName VARCHAR(255) NOT NULL,
    empDOB DATE NOT NULL,
    empApt VARCHAR(255) NOT NULL,
    empStreet VARCHAR(255) NOT NULL,
    empCountry VARCHAR(255) NOT NULL,
    empState VARCHAR(255) NOT NULL,
    empZip VARCHAR(255) NOT NULL,
    empEmail VARCHAR(255) NOT NULL,
    empPhone VARCHAR(255) NOT NULL,
    empStartDate DATE NOT NULL,
    empEndDate DATE DEFAULT NULL,
    empSalary DECIMAL(15 , 2 ) NOT NULL,
    empTitle VARCHAR(255) NOT NULL,
    PRIMARY KEY (empID)
);

-- Stores details about customers, such as their name, date of birth, contact information, and address.
drop table if exists CustomerInfoTable;
CREATE TABLE CustomerInfoTable (
    custID INT NOT NULL AUTO_INCREMENT,
    custName VARCHAR(255) NOT NULL,
    custDOB DATE,
    custPhone VARCHAR(255),
    custEmail VARCHAR(255),
    custStreet VARCHAR(255),
    custApt VARCHAR(255),
    custCountry VARCHAR(255),
    custstate VARCHAR(255),
    custzip VARCHAR(255),
    PRIMARY KEY (custID)
);

-- Below two Tables ProductInfoTable and CustomerInterestTable are created by Aarushi Sharma
-- ProductInfoTable stores information about products being sold, such as product name.
drop table if exists ProductInfoTable;
CREATE TABLE ProductInfoTable (
    prodID INT NOT NULL AUTO_INCREMENT,
    prodname VARCHAR(255) NOT NULL,
    PRIMARY KEY (prodID)
);

-- Tracks which customers are interested in which products, creating a many-to-many relationship between CustomerInfoTable and ProductInfoTable
drop table if exists CustomerInterestTable;
CREATE TABLE CustomerInterestTable (
    custID INT NOT NULL,
    prodID INT NOT NULL,
    FOREIGN KEY (prodID)
        REFERENCES ProductInfoTable (prodID),
    FOREIGN KEY (custID)
        REFERENCES CustomerInfoTable (custID)
);

-- Below three Tables InventoryArtTable, PartnerOrgTable and DisplayArtTable are created by Gladys 
-- InventoryArtTable stores information about art items in inventory, including item name, artist, creation date, and move-in/out dates.
drop table if exists InventoryArtTable;
CREATE TABLE InventoryArtTable (
    itemID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    itemName VARCHAR(50) NOT NULL,
    artistID INT,
    itemCreateDate DATE,
    itemMoveInDate DATE NOT NULL,
    itemMoveoutDate DATE,
    FOREIGN KEY (artistID)
        REFERENCES ArtistInfoTable (artistID)
); 
select * from inventoryarttable;
select * from artistinfotable;
-- PartnerOrgTable Stores details about partner organizations, including their contact information, start date, and type.
-- Includes a check constraint to ensure partorgType is one of ('janitorial', 'catering', 'waste disposal')
drop table if exists PartnerOrgTable;
CREATE TABLE PartnerOrgTable (
    partorgID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    partorgName VARCHAR(50) NOT NULL,
    partorgApt VARCHAR(50) NOT NULL,
    partorgStreet VARCHAR(50) NOT NULL,
    partorgCountry VARCHAR(50) NOT NULL,
    partorgState VARCHAR(50) NOT NULL,
    partorgZip VARCHAR(50) NOT NULL,
    partorgEmail VARCHAR(50) NOT NULL,
    partorgPhone VARCHAR(50) NOT NULL,
    partorgStartDate DATE,
    partorgType VARCHAR(50),
    constraint check_type check (partOrgType in ('janitorial','catering','waste disposal'))
);

-- Tracks where art items are displayed. It links to InventoryArtTable to identify the item and includes a location constraint with locations 'H1', 'H2' and 'H3'
drop table if exists DisplayArtTable;
CREATE TABLE DisplayArtTable (
    itemID INT NOT NULL,
    displayLocation VARCHAR(50) NOT NULL,
    FOREIGN KEY (itemID)
        REFERENCES InventoryArtTable (itemID),
	CONSTRAINT display CHECK (displayLocation in ('H1','H2','H3'))
); 

-- Below three Tables LedgerTable,CreditTable and DebitTable are created by Camille
-- Stores transaction details for all financial transactions, including the amount and timestamp
drop table if exists LedgerTable;
CREATE TABLE LedgerTable (
    transactionID INT AUTO_INCREMENT PRIMARY KEY ,
    transactionAmt DECIMAL(10 , 2 ) NOT NULL,
    transactionTS DATETIME
);  
ALTER TABLE LedgerTable AUTO_INCREMENT = 12000;

-- CreditTable Records credit transactions related to sales, including the amount and timestamp.
drop table if exists CreditTable;
CREATE TABLE CreditTable (
    transaction_ID INT,
    credit DECIMAL(10 , 2 ),
    transaction_time DATETIME
);

-- DebitTable records debit transactions related to sales, including the amount and timestamp.
drop table if exists DebitTable;
CREATE TABLE DebitTable (
    transaction_ID INT,
    debit DECIMAL(10 , 2 ),
    transaction_time DATETIME
);

-- Added By Priya Samal
-- SalesTable Tracks sales transactions, linking to art items, customers, salespeople, and artists. It records the sale amount and date.
drop table if exists SalesTable;
CREATE TABLE SalesTable (
    salesID INT AUTO_INCREMENT PRIMARY KEY,
    transactionID INT,
    itemID INT,
    custID INT,
    salesmanID INT,
    salesAmount DECIMAL(10 , 2),
    artistID INT,
    salesDate DATE NOT NULL,
    FOREIGN KEY (itemID)
        REFERENCES InventoryArtTable (itemID),
    FOREIGN KEY (custID)
        REFERENCES CustomerInfoTable (custID),
    FOREIGN KEY (salesmanID)
        REFERENCES EmployeeInfoTable (empID),
    FOREIGN KEY (artistID)
        REFERENCES ArtistInfoTable (artistID)
);
ALTER TABLE SalesTable AUTO_INCREMENT = 10000;


-- Below two tables CollabTable, ArtistContractTable are created by Camille
-- Stores collaboration information such as name, description, and duration.
drop table if exists CollabTable;
CREATE TABLE CollabTable (
    collabID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    collabName LONGTEXT NOT NULL,
    collabDesc LONGTEXT,
    collabStartDate DATE,
    collabEndDate DATE
); 

-- Holds contract information for artists, including commission percentage and contract period
drop table if exists ArtistContractTable;
CREATE TABLE ArtistContractTable (
    contractID INT NOT NULL PRIMARY KEY,
    artistID INT,
    contractSignDate DATE,
    contractStartDate DATE NOT NULL,
    contractEndDate DATE,
    contractComPer INT,
    FOREIGN KEY (artistID)
        REFERENCES ArtistInfoTable (artistID)
); 

-- Below two tables artistcontract_auditTable,partnerOrg_auditTable are created by Sankalp Sawant
-- These tables act as a Audit Log and are accessed via use of Trigger
drop table if exists artistcontract_auditTable;
CREATE TABLE artistcontract_auditTable (
    id INT AUTO_INCREMENT PRIMARY KEY,
    action VARCHAR(50),
    changeTimestamp DATETIME,
    contractID INT,
    artistID INT,
    contractSignDate DATE,
    contractStartDate DATE,
    contractEndDate DATE,
    contractComPer INT,
    currentCommision INT
);

drop table if exists partnerOrg_auditTable;
CREATE TABLE partnerOrg_auditTable (
    id INT AUTO_INCREMENT PRIMARY KEY,
    action VARCHAR(50),
    partorgID INT,
    partorgName VARCHAR(50),
    partorgApt VARCHAR(50),
    partorgStreet VARCHAR(50),
    partorgCountry VARCHAR(50),
    partorgState VARCHAR(50),
    partorgZip VARCHAR(50),
    partorgEmail VARCHAR(50),
    partorgPhone VARCHAR(50),
    partorgStartDate DATE,
    partnerorgEndDate DATE,
    partorgType VARCHAR(50)
);

-- Developed by Sankalp Sawant
-- INDEXES for faster retrieval

-- salesmanID: FK in SalesTable 
-- used in queries multiple times
CREATE INDEX salesmanIDI
ON SalesTable(salesmanID);

-- artistID: FK in SalesTable 
-- used in queries multiple times
CREATE INDEX artistIDI
ON SalesTable(artistID);


show tables;

-- Inserting the data

insert into ArtistInfoTable values ('1001','Leonardo Da Vinci','1980-04-10','4691','490 Elanor Grand St', 'USA', 'Michigan', '4980', 'leodavinci@gmail.com', '972-643-1234');
insert into ArtistInfoTable values ('1002','John V Ram','1966-04-08','7295','3761 N. 14th St', 'Australia', 'Queensland', '4700', 'jon24@gmail.com', '(11) 500 555-0162');
insert into ArtistInfoTable values ('1003','Lauren M Walker','1968-01-18','8370','4785 Scott Street', 'USA', 'Washington', '98312', 'lauren41@gmail.com', '717-555-0164');
insert into ArtistInfoTable values ('1004','Elizabeth Johnson','2001-10-12','4365','7553 Harness Circle', 'Australia', 'New South Wales', '2500', 'elizabeth5@yahoo.co.in', '(11) 500 555-0131');
insert into ArtistInfoTable values ('1005','Trevor Bryant','1996-1-12','1236','5781 Sharon Dr.', 'USA', 'California', '90012', 'trevor18@gmail.com', '853-555-0174');
insert into ArtistInfoTable values ('1006','Latoya C Goel','1978-4-03','0701','8154 Pheasant Circle', 'England', 'London', '7511.55', 'latoya18@gmail.com', '(11) 500 555-0149');
insert into ArtistInfoTable values ('1007','Fernando Barnes','2000-6-14','2209','7633 Greenhills Circle', 'Canada', 'Vancouver', '1500', 'fernando47@yahoo.com', '469-555-0125');
insert into ArtistInfoTable values ('1008','Eduardo Johnson','1951-08-12','8932','Hochstr 8444', 'Germany', 'Hessen', '34117', 'eduardo1@gmail.com', '(11) 500 555-0188');
insert into ArtistInfoTable values ('1009','Monica Kim','1998-12-12','2777','6, rue Philibert-Delorme', 'France', 'Hauts de Seine', '92700', 'monica1@gmail.com', '(11) 500 555-0118');
insert into ArtistInfoTable values ('1010','Shannon C Zhu','1988-10-10','9001','6, rue des Vendangeurs', 'France', 'Val d\'Oise', '95000', 'shannon13@gmail.com', '(11) 500 555-0183');
insert into ArtistInfoTable values ('1011','Kelli I Navarro','1995-04-29','1900','1164 Augustine Drive', 'Australia', 'New South Wales', '4661.5', 'kellie8@gmail.com', '(11) 500 555-0157');
insert into ArtistInfoTable values ('1012','Natalie M James',NULL,'3209','1277 Army Dr.', 'USA', 'California', '91203', 'natlaiej@gmail.com', '344-555-0196');
insert into ArtistInfoTable values ('1013','Marcus L Wood','1999-02-12','9001','8074 Oakmead', 'USA', 'California', '94109', 'marcuswood@gmail.com', '387-555-0136');
insert into ArtistInfoTable values ('1014','Warren Shah','1988-10-10','6932','6144 Rising Dawn Way', 'Australia', 'Queensland', '42170', 'warren41@gmail.com', '(11) 500 555-0193');
insert into ArtistInfoTable values ('1015','Jill Carlsen','2002-03-30','7885','3393 Alpha Way', 'Australia', 'New South Wales', '2300', 'jill28@gmail.com', '(11) 500 555-0176');
insert into ArtistInfoTable values ('1016','Chase Langley','1991-09-12','3002','4144 Mary Dr.', 'Canada', 'British Columbia', '95000', 'chase4@gmail.com', '939-555-0154');
insert into ArtistInfoTable values ('1017','Pearlie Rusek','1993-08-23','6503','5154 Brannan Pl.', 'Australia', 'Victoria', '48871', 'pearliewhirlie@gmail.com', '633-555-0100');
insert into ArtistInfoTable values ('1018','Jay Kapoor','1985-06-10','8410','420 Chandini Chowk. ', 'India', 'New Delhi', '11001', 'jay7@gmail.com', '(11) 500 555-0159');
insert into ArtistInfoTable values ('1019','Tracy Clark','1979-05-19','6001','6045 Elwood Drive', 'Australia', 'New South Wales', '2264', 'tracy3@gmail.com', '(11) 500 555-0157');
insert into ArtistInfoTable values ('1020','Ross Alvarez','1997-05-28','6667','490 Sepulveda Ct.', 'USA', 'California', '92118', 'ross25@gmail.com', '152-555-0151');


insert into InventoryArtTable values ('7000', 'Nighthawks', '1020', '2012-10-20', '2013-05-10',Null);
insert into InventoryArtTable values ('7001', 'Shiva as Lord of Dance', '1019', '2006-11-01', '2007-03-15',Null);
insert into InventoryArtTable values ('7002', 'Love Of Winter', '1014', '1999-06-01', '2001-01-01',Null);
insert into InventoryArtTable values ('7003', 'American Gothic', '1013', NULL, '2009-09-22',Null);
insert into InventoryArtTable values ('7004', 'The Bedroom', '1018', '2019-01-22', '2022-02-10',Null);
insert into InventoryArtTable values ('7005', 'Nightlife', '1010', '2020-09-08', '2021-02-19',Null);
insert into InventoryArtTable values ('7006', 'The Old Guitarist', '1017', '1999-04-20', '2007-01-31',Null);
insert into InventoryArtTable values ('7007', 'America Windows', '1016',NULL, '2014-03-05',Null);
insert into InventoryArtTable values ('7008', 'City Landscape', '1015', '2000-08-08', '2010-08-11',Null);
insert into InventoryArtTable values ('7009', 'Target', '1003', '1991-10-20', '2000-07-12',Null);
insert into InventoryArtTable values ('7010', 'Water Lilies', '1002', '2008-11-20', '2008-12-01',Null);
insert into InventoryArtTable values ('7011', 'Two Sisters', '1008', '2002-06-01', '2002-08-24',Null);
insert into InventoryArtTable values ('7012', 'The Rock', '1011', '2004-02-03', '2016-07-16',Null);
insert into InventoryArtTable values ('7013', 'Sky Above the Clouds', '1009', NULL, '2008-01-22',Null);
insert into InventoryArtTable values ('7014', 'Clown Torture', '1007', '2001-11-02', '2002-01-15',NULL);
insert into InventoryArtTable values ('7015', 'Figure With Meat', '1006', '2010-11-23', '2011-09-23',NULL);
insert into InventoryArtTable values ('7016', 'The Red Armchair', '1001', '1998-07-15', '2000-01-01',NULL);
insert into InventoryArtTable values ('7017', 'Self Portrait', '1004', '2017-10-28', '2018-06-21',NULL);
insert into InventoryArtTable values ('7018', 'The Earth is a Man', '1005', '2006-07-20', '2009-02-20',NULL);
insert into InventoryArtTable values ('7019', 'Little Harbour in Normandy', '1012', NULL, '2022-08-12',NULL);
insert into InventoryArtTable values ('7020', 'Ballet at the Paris Opera', '1019', '2016-05-29', '2018-06-30',NULL);

 
insert into EmployeeInfoTable values ('2000','Sarah Kent', '1980-10-05', '7890', '3884 Bates Court', 'USA', 'Oregon', 97355, 'sarah78@gmail.com', '424-555-0137', '2000-11-01', null, 100000.00,'Mrs.');
insert into EmployeeInfoTable values ('2001','Ryan Brown', '1990-03-22', '1209', '2939 Wesley Ct.', 'USA', 'California', 90401, 'ryan90@gmail.com', '539-555-0198', '2000-11-01', null, 94000.00,'Mr.');
insert into EmployeeInfoTable values ('2002','Byron Vasquez', '1993-08-29', '3420', '3187 Hackamore Lane', 'Australia', 'New South Wales', 2055, 'byron9@gmail.com', '(11) 500 555-0136', '2000-11-01', null, 25000.00,'Mr.');
insert into EmployeeInfoTable values ('2003','Jasmine Taylor', '2000-07-13', '1098', '2457 Matterhorn Court', 'USA', 'Washington', 9902, 'jasmineT8@gmail.com', '557-555-0146', '2000-11-01', null, 40000.00,'Ms.');
insert into EmployeeInfoTable values ('2004','Edward Hernandez', '1978-11-16', '9999', '7607 Pine Hollow Road', 'USA', 'Washington', 98107, 'eduhernandez@gmail.com', '178-555-0196', '2000-11-01', null, 22000.00,'Mr.');
insert into EmployeeInfoTable values ('2005','Ashley Henderson', '1992-01-12', '5621', '8834 San Jose Ave.', 'Canada', 'British Columbia', 1616, 'ashleyhendo@gmail.com', '173-555-0121', '2012-11-01', null, 19000.00,'Mrs.');
insert into EmployeeInfoTable values ('2006','Alfredo Romero', '1996-04-22', '8976', '2499 Greendell Pl', 'USA', 'Oregon', 97005, 'alfredo10@gmail.com', '342-555-0110', '2012-11-01', null,28000.00, 'Mr.');
insert into EmployeeInfoTable values ('2007','Daniel Cox', '2003-06-20', '4093', '2346 Wren Ave', 'USA', 'Washington', 98055, 'danicox@gmail.com', '396-555-0158', '2015-11-01', null,42000.00, 'Mr.');
insert into EmployeeInfoTable values ('2008','Jennifer Simmons', '2001-06-30', '2039', '7959 Mt. Wilson Way', 'Canada', 'British Columbia', 11268, 'jenny42@gmail.com', '148-555-0115', '2018-11-01', null, 29000.00,'Ms.');
insert into EmployeeInfoTable values ('2009','Ryan Foster', '1994-02-28', '5860', '5376 Sahara Drive', 'USA', 'California', 94015, 'misterfoster@gmail.com', '961-555-0133', '2019-11-01', null, 30000.00,'Mr.');
insert into EmployeeInfoTable values ('2010','Elizabeth Jones', '1995-09-29', '1356', '2253 Firestone Dr.', 'USA', 'Washington', 98033, 'elijonesey@gmail.com', '941-555-0110', '2020-11-01', null, 41000.00,'Mrs.');
insert into EmployeeInfoTable values ('2011','Lauren Martinez', '1986-12-31', '0395', '4357 Tosca Way', 'USA', 'California', 90210, 'lauram@gmail.com', '977-555-0117', '202-11-01', null, 48000.00,'Mrs.');


insert into ArtistContractTable values (5001,1001,'2000-01-01','2000-02-01','2040-05-06',50);
insert into ArtistContractTable values (5002,1002,'2006-02-13','2006-03-19','2025-10-12',60);
insert into ArtistContractTable values (5003,1003,'2000-07-01','2005-02-01','2020-01-01',75);
insert into ArtistContractTable values (5004,1004,'2001-01-01','2002-02-05',NULL,20);
insert into ArtistContractTable values (5005,1005,'2015-01-01','2008-02-01',NULL,50);
insert into ArtistContractTable values (5006,1006,'1998-09-12','2016-05-16','2040-10-10',60);
insert into ArtistContractTable values (5007,1007,'1998-09-12', '2000-05-16',NULL,70);
insert into ArtistContractTable values (5008,1008,'2006-03-01','2007-02-01','2010-01-01',60);
insert into ArtistContractTable values (5009,1009,'2007-04-10','2008-0-01','2013-09-08',50);
insert into ArtistContractTable values (5010,1010,'2008-05-20','2009-02-01','2010-02-01',55);
insert into ArtistContractTable values (5011,1011,'2009-12-30','2010-02-01','2015-08-01',35);
insert into ArtistContractTable values (5012,1012,'2010-11-14','2011-02-01','2016-09-01',45);
insert into ArtistContractTable values (5013,1013,'2011-06-18','2012-02-01','2017-11-01',65);
insert into ArtistContractTable values (5014,1014,'2012-02-22','2013-02-01','2015-10-02',70);
insert into ArtistContractTable values (5015,1015,'2000-08-25','2014-02-01','2016-04-01',50);
insert into ArtistContractTable values (5016,1016,'2003-10-26','2015-02-01','2016-02-01',55);
insert into ArtistContractTable values (5017,1017,'2004-02-12','2005-02-01','2030-01-01',80);
insert into ArtistContractTable values (5018,1018,'2002-07-30','2003-02-01','2010-05-01',50);
insert into ArtistContractTable values (5019,1019,'2001-06-30','2005-02-01','2012-10-01',40);
insert into ArtistContractTable values (5020,1020,'2008-08-31','2009-02-01','2025-06-01',40);


insert into DisplayArtTable values ('7000', 'H1');
insert into DisplayArtTable values ('7011', 'H1');
insert into DisplayArtTable values ('7012', 'H1');
insert into DisplayArtTable values ('7013', 'H2');
insert into DisplayArtTable values ('7016', 'H2');
insert into DisplayArtTable values ('7017', 'H2');
insert into DisplayArtTable values ('7019', 'H2');
insert into DisplayArtTable values ('7020', 'H3');


insert into ProductInfoTable values('3003', 'Souveniers');
insert into ProductInfoTable values('3004', 'Art Pieces');
insert into ProductInfoTable values('3005', 'Newsletters');


insert into CustomerInfoTable values ('6001',"Daniel Mcconnell",'1997-10-05',"516-721-3355","montes.nascetur@google.net","199-3334 Nunc Street","7215","South Korea","Seoul Capital","100-015");
insert into CustomerInfoTable values('6002',"Gary Hicks",'2000-04-16',"(473) 604-7051","vel@icloud.couk","Ap #258-6879 Interdum Rd.","1341","USA","NY","10001");
insert into CustomerInfoTable values('6003',"Gabriel Donaldson",'1968-07-13',"(994) 851-7855","aliquet.molestie.tellus@outlook.net","P.O. Box 388, 6448 Turpis Av.","6981","USA","California","90263");
insert into CustomerInfoTable values('6004',"August Gallagher",'1958-03-03',"958-741-9569","non.sapien.molestie@hotmail.ca","P.O. Box 835, 3906 Adipiscing, Rd.","2134","India","Maharashtra","400080");
insert into CustomerInfoTable values('6005',"Tana Burris",'2003-05-26',"932-502-5547","mauris@hotmail.com","Ap #192-2583 Vel Avenue","0987","USA","Texas","75252");
insert into CustomerInfoTable values('6006',"Mira Carrillo",'1971-05-18',"978-463-5356","aliquam.adipiscing.lacus@aol.edu","P.O. Box 522, 7271 Massa. Ave","4150","USA","Texas","75024");
insert into CustomerInfoTable values('6007',"Venus Romero",'1965-12-18',"(734) 225-3477","pede@protonmail.com","702-514 Sed, St.","8591","USA","NY","10002");
insert into CustomerInfoTable values('6008',"Gail Padilla",'1988-07-14',"961-366-5614","natoque.penatibus@outlook.com","1159 Aenean Av.","6908","USA","California","91331");
insert into CustomerInfoTable values('6009',"Ora Cotton",'1959-01-20',"(436) 765-2283","consectetuer.euismod@yahoo.edu","9813 Tristique Avenue","3178","Japan","Tokyo Prefecture","53717");
insert into CustomerInfoTable values('6010',"Chava Hernandez",'2002-01-29',"488-574-2533","mauris.ipsum.porta@hotmail.net","Ap #123-4930 Consectetuer Street","9308","USA","Texas","75080");
insert into CustomerInfoTable values('6011',"Lionel Ronaldo",'1998-01-29',"488-554-1533","lR@hotmail.net","Stillwaterlane","6100","USA","Texas","75020");
insert into CustomerInfoTable values('6012',"Luis Diaz",'1996-01-29',"448-584-2513","ld@hotmail.net","Ap #123-481 Consectetuer Street","9301","USA","Texas","75081");
insert into CustomerInfoTable values('6013',"Christain Pulisic",'1995-01-29',"988-374-2513","CP@hotmail.net","Ap #123-4930 Plaza Street","1502","USA","Texas","75024");
insert into CustomerInfoTable values('6014',"Tyler Adams",'1994-11-29',"448-570-2233","TAa@hotmail.net","Ap #12-430 Consectetuer Street","98","USA","Texas","75025");


insert into LedgerTable(transactionAmt,transactionTS) values (-730, '2022-02-03 13:40:10' );
insert into LedgerTable(transactionAmt,transactionTS) values (1000, '2022-02-26 11:42:21' );
insert into LedgerTable(transactionAmt,transactionTS) values (-200, '2022-03-12 04:10:48' );


insert into CollabTable(collabID,collabName,collabDesc,collabStartDate,collabEndDate)
values('301','Max Ernst and Dorothea Tanning','the glimpse of war','2022-12-12','2022-12-16'),
       ('302','Marina Ambramović and Ulay','the moon nights','2022-12-08','2022-12-10'),
       ('303','Andy Warhol and Jean-Michel Basquiat','A Crazy Art-World Marriage','2022-11-28','2022-11-30'),
       ('304','Jasper Johns and Robert Rauschenberg','When Abstract Expressionists Meet','2022-11-24','2022-12-06'),
       ('305','Marcel Duchamp and Man Ray','50 Years of Shared Aesthetics','2022-11-28','2022-12-01'),
       ('306','Pablo Picasso and Gjon Mili','Drawing with Pure Light','2022-12-01','2022-12-08'),
       ('307','Frida Kahlo and Diego Rivera','100 years of solitude','2022-11-28','2022-12-07'),
       ('308','Bernd and Hilla Becher','Impression: Sunrise','2022-11-23','2022-11-29'),
       ('309','Georgia O’Keeffe and Alfred Stieglitz','the creative cure','2022-12-20','2022-12-30'),
       ('310','Georgia O’Keeffe and Alfred Stieglitz','the riverdale magic','2022-11-26','2022-12-06'),
       ('311','Christo and Jeanne-Claude',null, '2022-11-27','2022-12-10'),
       ('312','Tim Noble and Sue Webster',null, '2022-11-17','2022-12-01'),
       ('313','Marsha Blaker and Paul DeSomma',null, '2022-11-27','2022-12-05');


insert into PartnerOrgTable(partorgID,partorgName,partorgapt,partorgStreet,partorgCountry,partorgState,partorgZip ,partorgEmail ,partorgPhone,partorgStartDate,partorgType)
values('901','Taste & Fun Catering','Welcome Home','1350 n greenville','usa','texas','76093','cxy@gmail.com','9876789890','2022-11-01','catering'),
	  ('902','Ultimate Food','Relaxing Apartments','TN 37217','usa','arizona','76034','ultimate@gmail.com','4567898765','2022-11-03','catering'),
	  ('903','My Catering Company','Peak Living','80403 golden co','usa','california','75022','my@yahooo.com','988978876','2022-11-03','catering'),
      ('904','The Catering Angels','Sunset Homes','4016 Doane Street','usa','hawaii','75223','angels@gmail.com','7899877890','2022-11-24','catering'),
      ('905','Veolia Environmental Services','Pristine Apartments','2436 Naples Avenue','usa','florida','67598','veolia@gmail.com','8908900988','2022-11-23','waste disposal'),
      ('906','Republic Services Inc','Value Living','2325 Eastridge Circle','usa','washington','75095','republic67@gmail.com','9879876789','2022-11-02','waste disposal'),
      ('907','Waste Connections Inc','Luxe Living','19141 Pine Ridge Circle','usa','nashville','89067','waste@gmail.com','8906789808','2022-11-08','waste disposal'),
      ('908','Stericycle Inc','The Sweetest Homes','915 Heath Drive','usa','ohio','78906','stericycle@gmail.com','9090909090','2022-11-04','waste disposal'),
	  ('909','Maid in Manhattan','Sea View Apartment','1693 Alice Court','usa','colorado','23657','maid@yahoo.com','7878787878','2022-11-06','janitorial'),
      ('910','Deep Clean Office Team','Cozy Nest Apartments','5331 Rexford Court','usa','michigan','45678','deepclean@gmail.com','6767676778','2022-11-23','janitorial'),
      ('911','Fresh Start Office Cleaning','Honest Homes','8642 Yule Street','usa','texes','90876','freash@yahoo.com','8989898909','2022-11-27','janitorial'),
      ('912','Meticulous Maids','Prime Location Apartments','4001 Anderson Road','usa','ohio','77667','maids@gmail.com','9876543212','2022-11-20','janitorial'),
      ('913','Maids on Wheels','Estate Location Apartments','7421 Frankford Road','usa','texas','75252','maidsonwheels@gmail.com','9876544512','2022-11-20','janitorial'),
      ('914','Maids on Wheels','Estate Location Apartments','7421 Frankford Road','usa','texas','75252','maidsonwheels@gmail.com','9876544512','2022-11-20','catering'),
	  ('915','Maids on Wheels','Estate Location Apartments','7421 Frankford Road','usa','texas','75252','maidsonwheels@gmail.com','9876544512','2022-11-20','waste disposal');

insert into EventTable(eventid,eventname,eventdesc,eventstartdate,eventstarttime,eventendtime)     
values('1007','Josephine Durkin: Funeral Flowers','exhibition of new 2D works by Dallas-based sculptor','2022-12-06','09:00:00','21:00:00'),
        ('1008','KEITH CARTER Ghostlight','exhibition in celebration of his recent Lifetime Achievement','2022-12-05','09:00:00','22:30:00'),
        ('1009','Sam Mack buff','the show references the words numerous definitions','2022-12-08','10:00:00','20:00:00'),
        ('1010','József Csató Lush Ferns in Empty Wells','an exhibition of artworks by Budapest based artist József Csató - I','2022-11-06','11:00:00','21:00:00'),
        ('1011','József Csató Lush Ferns in Empty Wells','an exhibition of artworks by Budapest based artist József Csató - II','2022-12-06','05:00:00','09:00:00');
 
insert into CustomerInterestTable values
('6001', '3003'),
('6002', '3003'), 
('6003','3004') , 
('6004','3004'), 
('6005','3003'), 
('6006','3005'), 
('6007','3004'), 
('6008','3005'), 
('6009','3004'), 
('6010','3004'),
('6008','3003'), 
('6003','3005'),
('6014','3005'),
('6011','3005'),
('6012','3003'),
('6013','3005');

insert into SalesTable(itemID, custID, salesmanID, salesAmount, artistID ,salesDate) values
('7001','6001','2001','230.57', '1019' ,'2022-11-11'),
('7002','6002','2002','432.68', '1014','2022-11-1'),
('7003','6003','2003','714.52', '1013','2022-10-25'),
('7004','6004','2004','329', '1018','2022-09-21'),
('7005','6005','2005', '568.23', '1010','2022-07-22'),
('7006','6006','2006','497.82', '1017','2022-06-20'),
('7007','6006','2006','118','1016','2022-11-22'),
('7008','6006','2006','508.45', '1015', '2022-10-01'),
('7009','6006','2006','160', '1003','2022-09-15'),
('7010','6006','2006','665.8', '1002','2022-09-2'),
('7018','6007','2006','685.89', '1005','2021-12-12'),
('7015','6007','2005','585.89','1006','2020-10-01'),
('7014','6008','2007','799.89','1007','2015-10-01');

-- ---------------------------------------------------------------------------------------


-- Below SQL queries are developed by Aarushi Sharma

-- 1. This query retrieves customers interested in "Art Pieces" along with their details.

SELECT c.custID, c.custName, c.custEmail, c.custCountry, p.prodname
FROM CustomerInfoTable c
JOIN CustomerInterestTable ci ON c.custID = ci.custID
JOIN ProductInfoTable p ON ci.prodID = p.prodID
WHERE p.prodname = 'Art Pieces';
 
 
-- 2. Finds the most popular product by counting customer interests and sorting in descending order.

SELECT p.prodname, COUNT(ci.custID) AS interest_count
FROM ProductInfoTable p
JOIN CustomerInterestTable ci ON p.prodID = ci.prodID
GROUP BY p.prodname
ORDER BY interest_count DESC
LIMIT 1;
 
-- 3. This query retrieves customers who are interested in either Art Pieces or Souvenirs, but not interested in Newsletters.

SELECT c.custname, c.custemail, p.prodname
FROM CustomerInfoTable c
JOIN CustomerInterestTable ci ON c.custid = ci.custid
JOIN ProductInfoTable p ON ci.prodid = p.prodid
WHERE p.prodname IN ('Art Pieces', 'Souveniers') 
  AND c.custid NOT IN (
      SELECT ci.custid
      FROM CustomerInterestTable ci
      JOIN ProductInfoTable p ON ci.prodid = p.prodid
      WHERE p.prodname = 'Newsletters'
  )
ORDER BY c.custname;
 
 
-- 4. Find employees who have worked for more than 5 years and earn a salary greater than $50,000.

SELECT empName, empStartDate, empSalary
FROM EmployeeInfoTable
WHERE empStartDate <= DATE_SUB(CURDATE(), INTERVAL 5 YEAR)
AND empSalary > 50000;
 
 
-- 5. Below SQL queries are executed by Priya Samal

-- Retrieve Artists with Their Art Pieces and Display Locations
SELECT 
    A.artistName AS Artist_Name,
    I.itemName AS Art_Piece_Name,
    D.displayLocation AS Display_Location
FROM 
    ArtistInfoTable A
JOIN 
    InventoryArtTable I ON A.artistID = I.artistID
JOIN 
    DisplayArtTable D ON I.itemID = D.itemID;
    
    
-- 6. Top 5 Selling Employees by Total Sales
SELECT 
    E.empName AS Employee_Name,
    SUM(S.salesAmount) AS Total_Sales_Amount
FROM 
    SalesTable S
JOIN 
    EmployeeInfoTable E ON S.salesmanID = E.empID
GROUP BY 
    E.empName
ORDER BY 
    Total_Sales_Amount DESC
LIMIT 5;
 
-- 7.  Top 5 Most Expensive Art Pieces Sold

SELECT 
    I.itemName AS Art_Piece_Name,
    S.salesAmount AS Sale_Amount,
    S.salesDate AS Sale_Date,
    C.custName AS Customer_Name,
    E.empName AS Salesman_Name
FROM 
    SalesTable S
JOIN 
    InventoryArtTable I ON S.itemID = I.itemID
JOIN 
    CustomerInfoTable C ON S.custID = C.custID
JOIN 
    EmployeeInfoTable E ON S.salesmanID = E.empID
ORDER BY 
    S.salesAmount DESC
LIMIT 5;
 
-- 8. to Retrieve Items Sold Along with Their Artists
SELECT 
   I.itemName AS Item_Name,  
   A.artistName AS Artist_Name,  
   SUM(S.salesAmount) AS Total_Sales_Amount   
FROM   
   SalesTable S   
JOIN   
   InventoryArtTable I ON S.itemID = I.itemID   
JOIN   
   ArtistInfoTable A ON I.artistID = A.artistID   
GROUP BY   
   I.itemName, A.artistName   
ORDER BY   
   Total_Sales_Amount DESC;



-- Below SQL queries are executed by Sankalp Sawant

-- 9. Least performing art pieces 
select * from InventoryArtTable
where itemMoveOutDate is null and itemMoveInDate < (select date_sub(curdate(), interval 1 year))
order by itemMoveInDate
limit 5;


-- 10. List all the customers that belong to a particular area zipcode and are interested in newsletters

select *, ProductInfoTable.prodName
from CustomerInfoTable
left join CustomerInterestTable
on CustomerInfoTable.custID = CustomerInterestTable.custID
inner join ProductInfoTable
on CustomerInterestTable.prodID = ProductInfoTable.prodID
where custCountry = 'USA' and custzip like ('75%') and ProductInfoTable.prodName = 'Newsletters';


-- 11. Find all the customers who have interest in the products of the art gallery and have their birthday today and what product they are interested in

select CustomerInfoTable.custID, CustomerInfoTable.custName, CustomerInfoTable.custDOB, CustomerInfoTable.custPhone, CustomerInterestTable.prodID, ProductInfoTable.prodName from CustomerInfoTable
join CustomerInterestTable
on CustomerInfoTable.custID = CustomerInterestTable.custID
join ProductInfoTable
on CustomerInterestTable.prodID = ProductInfoTable.prodID
where date_format((CustomerInfoTable.custDOB),'%m-%d') = date_format(now(),'%m-%d');


-- Below SQL queries are executed by Gladys Mesomera

-- 12. artist with items in stock who are from Canada?
-- tables (ArtistInfoTable,InventoryArtTable)
 
Select ArtistInfoTable.artistName,ArtistInfoTable.artistStreet,InventoryArtTable.itemName,InventoryArtTable.itemCreateDate
from ArtistInfoTable 
inner join InventoryArtTable 
on ArtistInfoTable.artistID =InventoryArtTable.artistID -- find the common key of ArtistID between InventoryArtTable and ArtistInfoTable table.
Where artistCountry='Canada'
order by artistName desc;

-- 13. tables CustomerInfoTable,ProductInfoTable,CustomerInterestTable
-- Customers who are interested in art pieces who live in Texas and California
select CustomerInfoTable.CustID,CustomerInfoTable.CustName ,concat(CustomerInfoTable.CustCountry, ' ',CustomerInfoTable.custstate) as customerLocation, CustomerInterestTable.custID, ProductInfoTable.prodID,ProductInfoTable.prodname
from CustomerInfoTable
join CustomerInterestTable on CustomerInfoTable.custID = CustomerInterestTable.custID
join ProductInfoTable on ProductInfoTable.prodID = CustomerInterestTable.prodID
where ProductInfoTable.prodID='3004'  -- indicate customers interested in Art pieces
and CustomerInfoTable.custState in ('Texas', 'California');

  -- 14. sales made to customers which are < 400
Select salesmanID,custID,ItemId,salesAmount 
from SalesTable
where not SalesAmount > 400 and custID like '%6';

-- 15. Number of events hosted after 2022-05-12 with event name 'József Csató Lush Ferns in Empty Wells'
Select eventname,Count(eventID)
   From EventTable
   Where eventstartdate >'2022-05-12'        
   Group By eventname
   Having eventname='József Csató Lush Ferns in Empty Wells';
   
-- Below SQL queries are executed by Camille Favela

-- 16. USA customer and revenue breakdown by state
SELECT 
    CustomerInfoTable.custState, 
    COUNT(*) AS TotalCustomers,
    CONCAT(ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2), '%') AS PercentOfUSACustomers,
    SUM(SalesTable.SalesAmount) AS TotalRevenue,
    CONCAT(ROUND(100.0 * SUM(SalesTable.SalesAmount) / SUM(SUM(SalesTable.SalesAmount)) OVER (), 2), '%') AS PercentOfUSASales
FROM CustomerInfoTable
LEFT JOIN SalesTable ON CustomerInfoTable.custID = SalesTable.custID
WHERE CustomerInfoTable.custCountry = 'USA'
GROUP BY CustomerInfoTable.custState
ORDER BY TotalCustomers DESC;

 
-- 17. How popular is each product type based on customer interest per country
select
productinfotable.prodID,
productinfotable.prodname,
customerinfotable.custCountry,
count(customerinteresttable.custID) as CustomerInterest
from productinfotable
join customerinteresttable on customerinteresttable.prodID = productinfotable.prodID
join customerinfotable on customerinteresttable.custID = customerinfotable.custID
group by productinfotable.prodID, productinfotable.prodname, customerinfotable.custCountry
order by customerinterest desc;
 
-- 18. Lists the top 3 customers based the most artworks purchased
SELECT 
    customerinfotable.custID, 
    customerinfotable.custName, 
    customerinfotable.custEmail, 
    COUNT(salestable.salesID) AS TotalArtworksPurchased
FROM customerinfotable
JOIN salestable ON salestable.custID = customerinfotable.custID
GROUP BY customerinfotable.custID, customerinfotable.custName, customerinfotable.custEmail
ORDER BY TotalArtworksPurchased DESC
LIMIT 3;



/*
TRIGGERS
*/

-- The below two triggers are created by Sankalp Sawant

-- 1. artistcontract_updateTable
drop trigger if exists artistcontract_updateTable;
create trigger artistcontract_updateTable
before update on ArtistContractTable
for each row
	insert into artistcontract_auditTable
    set action = 'update',
    changeTimestamp = now(),
    contractID = old.contractID,
    artistID = old.artistID, 
	contractSignDate = old.contractSignDate,
	contractStartDate = old.contractStartDate,
	contractEndDate = old.contractEndDate,
	contractComPer = old.contractComPer,
	currentCommision = new.contractComPer;

-- Implementation
update ArtistContractTable
set contractcomper = 45
where contractid = 5004;
select * from artistcontract_auditTable;


-- 2. artistcontract_insertTable
DROP TRIGGER IF EXISTS artistcontract_insertTable;

CREATE TRIGGER artistcontract_insertTable
AFTER INSERT ON ArtistContractTable
FOR EACH ROW
INSERT INTO artistcontract_auditTable
SET 
    action = 'insert',
    changeTimestamp = NOW(),
    contractID = NEW.contractID,
    artistID = NEW.artistID,
    contractSignDate = NEW.contractSignDate,
    contractStartDate = NEW.contractStartDate,
    contractEndDate = NEW.contractEndDate,
    contractComPer = NEW.contractComPer,
    currentCommision = NEW.contractComPer;

-- Implementation
insert into ArtistInfoTable values ('1021','Ross Alvarez','1997-05-28','6667','490 Sepulveda Ct.', 'USA', 'California', '92118', 'ross25@gmail.com', '152-555-0151');
insert into ArtistContractTable values (5021,1021,'2008-08-31','2009-02-01','2025-06-01',40);

-- Below two triggers are written by Aarushi Sharma

-- 3. pastPartnerOrg_deleteTable

DROP trigger if exists pastPartnerOrg_deleteTable;
create trigger pastPartnerOrg_deleteTable
before delete on PartnerOrgTable
for each row 
	insert into partnerOrg_auditTable
    set action = 'delete',
	partorgID = old.partorgID,
	partorgName = old.partorgName,
	partorgApt = old.partorgApt, 
	partorgStreet = old.partorgStreet,
	partorgCountry = old.partorgCountry,
	partorgState = old.partorgState,
	partorgZip = old.partorgZip,
	partorgEmail = old.partorgEmail,
	partorgPhone = old.partorgPhone,
	partorgStartDate = old.partorgStartDate,
	partnerorgEndDate = date_format(curdate(), '%Y-%m-%d'),
	partorgType = old.partorgType;

-- Implementation
delete 
from PartnerOrgTable
where partorgID = 913;
select * from partnerOrg_auditTable;


-- 4.This trigger decreases the quantity of an art piece when a sale is made.
DROP TRIGGER IF EXISTS updateInventoryOnSale;
DELIMITER $$
 
CREATE TRIGGER updateInventoryOnSale
AFTER INSERT ON SalesTable
FOR EACH ROW
BEGIN
    UPDATE InventoryArtTable
    SET itemStockQuantity = itemStockQuantity - 1
    WHERE itemID = NEW.itemID;
END$$
 
DELIMITER ;


-- Implementation



ALTER TABLE InventoryArtTable
ADD COLUMN itemStockQuantity INT NOT NULL DEFAULT 0;

UPDATE InventoryArtTable
SET itemStockQuantity = 5
WHERE itemID = 7001;

insert into SalesTable(itemID, custID, salesmanID, salesAmount, salesDate) values ('7001','6001','2001','230.57', '2025-05-11');

SELECT itemStockQuantity FROM InventoryArtTable WHERE itemID = 7001;


 
-- Below two triggers are written by Priya Samal
-- 5. This trigger checks if the artist has any active contracts before allowing deletion from the ArtistInfoTable.
DROP TRIGGER IF EXISTS preventArtistDeletion;
DELIMITER $$
 
CREATE TRIGGER preventArtistDeletion
BEFORE DELETE ON ArtistInfoTable
FOR EACH ROW
BEGIN
    DECLARE activeContracts INT;
    -- Count the number of active contracts
    SELECT COUNT(*) INTO activeContracts
    FROM ArtistContractTable
    WHERE artistID = OLD.artistID
    AND contractEndDate > CURDATE();  -- Only active contracts
 
    -- If there are active contracts, prevent deletion
    IF activeContracts > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete artist with active contracts';
    END IF;
END$$
 
DELIMITER ;

-- Implementation
DELETE FROM ArtistInfoTable WHERE artistID = 1001;
 
-- 6. This trigger will prevent duplicate entries in the SalesTable by checking whether the combination of productID and saleDate,
-- already exists before inserting a new sale record.
 
 
DROP TRIGGER IF EXISTS preventDuplicateSalesEntry;
DELIMITER $$
 
CREATE TRIGGER preventDuplicateSalesEntry
BEFORE INSERT ON SalesTable
FOR EACH ROW
BEGIN
    DECLARE duplicateCount INT;
 
    -- Check if the same itemID is being sold on the same salesDate
    SELECT COUNT(*) INTO duplicateCount
    FROM SalesTable
    WHERE itemID = NEW.itemID
    AND salesDate = NEW.salesDate;
 
    IF duplicateCount > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Duplicate sales entry for the same item on the same date is not allowed';
    END IF;
END$$
 
DELIMITER ;

-- Implementation

insert into SalesTable(itemID, custID, salesmanID, salesAmount, salesDate) values
('7001','6001','2001','230.57', '2022-11-11');


/*
FUNCTIONS
*/

-- Below function is created by Priya Samal

-- 1. totalPurchase()
drop function if exists totalPurchase;
delimiter $$
create function totalPurchase(cust_ID int)
returns decimal(10,2)
deterministic
begin
	declare totalPurchaseAmt decimal(10,2);
    set totalPurchaseAmt = (select sum(salesAmount) from SalesTable where custID = cust_ID);
    return totalPurchaseAmt;
end$$
delimiter ;

select totalPurchase(6001);


-- Below two functions arw written by Gladys
-- 2. getArtistAge()
drop function if exists getArtistAge;
delimiter $$
CREATE FUNCTION getArtistAge(p_dob DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, p_dob, CURDATE());
end$$
delimiter ;

select getArtistAge(1016);

-- 3. getTotalTransactions
-- Function: Get total transactions amount
drop function if exists getTotalTransactions ;
delimiter $$
CREATE FUNCTION getTotalTransactions()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(transactionAmt) INTO total FROM LedgerTable;
    RETURN IFNULL(total, 0);
end$$
delimiter ;

select getTotalTransactions();


-- Below two functions arw written by Sankalp
-- Artist Commission Rate 
-- 4. GetArtistCommissionRate

DELIMITER $$

CREATE FUNCTION GetArtistCommissionRate(a_id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE commission INT;
    
    SELECT contractComPer 
    INTO commission
    FROM ArtistContractTable
    WHERE artistID = a_id
    ORDER BY contractStartDate DESC
    LIMIT 1;
    
    RETURN IFNULL(commission, 0);
END $$

DELIMITER ;

-- Implementation

SELECT GetArtistCommissionRate(1001);

-- Contract Duration from customer id
-- 5. getContractDurationByID

DROP FUNCTION IF EXISTS getContractDurationByID;
DELIMITER $$

CREATE FUNCTION getContractDurationByID(c_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE startDate DATE;
    DECLARE endDate DATE;

    SELECT contractStartDate, contractEndDate
    INTO startDate, endDate
    FROM ArtistContractTable
    WHERE contractID = c_id;

    RETURN DATEDIFF(endDate, startDate);
END$$

SELECT getContractDurationByID(5001);


DELIMITER ;




/* STORED PROCEDURE 
*/


-- Below two procedure are written by Gladys

-- 1.GetCustomerLevel 
-- in - custID, @totalPurchase
-- print customerLevel
drop procedure if exists GetCustomerLevel;
delimiter $$
create procedure GetCustomerLevel(
 in cust_ID int,
 out customerLevel varchar(20)
 )
 begin
	declare totalPurchaseAmt decimal(10,2);
    -- call the function
    set totalPurchaseAmt = totalPurchase(cust_ID);
    if totalPurchaseAmt > 100000 then
		set customerLevel = 'PLATINUM';
	elseif (totalPurchaseAmt > 10000 and totalPurchaseAmt <= 100000) then 
		set customerLevel = 'GOLD';
	elseif (totalPurchaseAmt > 0 and totalPurchaseAmt <= 10000) then
		set customerLevel = 'SILVER';
	else
		set customerLevel = 'Invalid ID';
	end if;
end $$
delimiter ;





-- 2. GetArtistLevel 
-- in - artistID, @totalSales
-- print artistLevel
drop procedure if exists GetArtistLevel;
delimiter $$
create procedure GetArtistLevel(
 in artist_ID int,
 out artistLevel varchar(20)
 )
 begin
	declare totalSalesAmt decimal(10,2);
    -- call the function
    set totalSalesAmt = (select sum(salesAmount) from SalesTable where artistID = artist_ID);
    if totalSalesAmt > 100000 then
		set artistLevel = 'GENIUS';
	elseif (totalSalesAmt > 50000 and totalSalesAmt <= 100000) then 
		set artistLevel = 'EXPERT';
	elseif (totalSalesAmt > 10000 and totalSalesAmt <= 50000) then
		set artistLevel = 'NOVICE';
	elseif (totalSalesAmt > 0 and totalSalesAmt <= 10000) then
		set artistLevel = 'ROOKIE';
	else
		set artistLevel = 'Invalid ID';
	end if;
end $$
delimiter ;

-- 3. GetPlanner
-- this procedure is written by Camille
-- in - date
-- print - all events happening on that date
drop procedure if exists GetPlanner;
delimiter $$
create procedure GetPlanner(
in input_date date

)
begin
	select *
    from EventTable
    where eventStartDate = input_date
    order by eventStartTime, eventEndTime;
end $$
delimiter ;

-- Below two stored procedures are created by Aarushi Sharma
-- 4. Get Customer’s Interested Products

DELIMITER $$

CREATE PROCEDURE GetCustomerInterests(IN p_custID INT)
BEGIN
    SELECT 
        CI.custID,
        P.prodName
    FROM 
        CustomerInterestTable CI
    JOIN 
        ProductInfoTable P ON CI.prodID = P.prodID
    WHERE 
        CI.custID = p_custID;
END $$

DELIMITER ;

-- 5. Insert New Art Item into Inventory

DELIMITER $$

CREATE PROCEDURE InsertInventoryArt(
    IN p_itemName VARCHAR(50),
    IN p_artistID INT,
    IN p_itemCreateDate DATE,
    IN p_itemMoveInDate DATE
)
BEGIN
    INSERT INTO InventoryArtTable(
        itemName, artistID, itemCreateDate, itemMoveInDate
    )
    VALUES(
        p_itemName, p_artistID, p_itemCreateDate, p_itemMoveInDate
    );
END $$

DELIMITER ;


-- IMPLEMENTATION

call GetPlanner('2022-12-06');


call GetCustomerLevel(6001, @customerLevel);
select @customerLevel;

call GetCustomerLevel(-1, @customerLevel);
select @customerLevel;

call GetArtistLevel(1007, @artistLevel);
select @artistLevel;

CALL GetCustomerInterests(6003);

CALL InsertInventoryArt(
'Lover','1014','2024-04-01','2024-04-15'         
);

