CREATE DATABASE db_financial;

USE db_financial;

CREATE TABLE Trader (
    nom varchar(255) NOT NULL,
    classe_actif varchar(255) NOT NULL,
    anneesExperience int(12) NOT NULL,
    nomEquipe varchar(255) NOT NULL,
    PRIMARY KEY (nom),
    FOREIGN KEY (nomEquipe) REFERENCES trader(nomEquipe)
);


CREATE TABLE Equipe (
    nom varchar(255) NOT NULL,
    style varchar(255) NOT NULL,
    chef varchar(255) NOT NULL,
    PRIMARY KEY (nom)
);

CREATE TABLE Transaction (
    nom varchar(255),
    date varchar(255) NOT NULL,
    lieu varchar(255) NOT NULL,
    prix int(12) NOT NULL,
    nomEquipe varchar(255) NOT NULL,
    PRIMARY KEY (nom),
    FOREIGN KEY (nomEquipe) REFERENCES trader(nomEquipe)
);

INSERT INTO Transaction (nom, date, lieu, prix, nomEquipe)
 VALUES
 ('AXA SA', '2021-06-15', 'PARIS', 26, 'Equipe1'),
 ('TotalEnergies', '2004-09-03', 'PARIS', 57, 'Equipe2'),
 ('Apple Inc', '2014-09-05', 'USA', 150, 'Equipe1'),
 ('Dubai Elec', '2020-11-22', 'DUBAI', 1, 'Equipe3'),
 ('Amazon', '2010-07-12', 'USA', 100, 'Equipe3'),
 ('Naspers', '1997-08-16', 'SOUTH AFRICA', 120, 'Equipe2'),
 ('PetroChina', '2019-04-20', 'HONG KONG', 10, 'Equipe5'),
 ('ETF Vanguard', '2015-02-22', 'LA', 200, 'Equipe7'),
 ('DassaultAviation', '2016-01-01', 'PARIS', 140, 'Equipe6');

INSERT INTO Trader (nom, classe_actif, anneesExperience, nomEquipe)
 VALUES
 ('Yannick', 'fixed income', 10, 'Equipe1'),
 ('Patrick', 'action', 10, 'Equipe1'),
 ('Cedrick', 'commodities', 10, 'Equipe1'),
 ('Jordan', 'change', 2, 'Equipe2'),
 ('Gaelle', 'exotic', 4, 'Equipe3'),
 ('Georges', 'CDS', 20, 'Equipe6');

INSERT INTO Equipe (nom, style, chef)
 VALUES
 ('Equipe1', 'marketing making', 'leonardo'),
 ('Equipe2', 'arbitrage', 'michaelgelo'),
 ('Equipe3', 'trading de volatilite', 'raphael'),
 ('Equipe4', 'trading de haute frequence', 'donatello'),
 ('Equipe5', 'arbitrage statistique', 'Smith'),
 ('Equipe6', 'arbitrage statistique', 'Smith'),
 ('Equipe7', 'strategie fond de fond', 'Ray');

--mf01 
select nom , classe_actif
from trader
where anneesExperience < 5 

--mf02
select classe_actif
from trader
where nomEquipe = "Equipe1"

--mf03
select classe_actif
from trader
GROUP BY classe_actif = "commodities"

--mf04
select classe_actif
from trader
where anneesExperience > 20

--mf05
select nom
from trader
where anneesExperience >= 5 AND anneesExperience <= 10

--mf06
select classe_actif
from trader
where classe_actif LIKE 'ch%'

--mf07
select nom
from Equipe
where style = "arbitrage statistique"

--mf08
select nom
from Equipe
where chef = "Smith"

--mf09
select nom
from Transaction
ORDER BY nom ASC

--mf010
select date
from Transaction
where date = "2019-04-20" AND lieu LIKE "HONG KONG"

--mf011
select lieu
from Transaction
where prix > 150

--mf012
select lieu
from Transaction
where prix < 50 AND lieu LIKE "PARIS"

--mf013
select lieu
from Transaction
where year(date) = 2014

--mmtj01 
select trader.nom , trader.classe_actif 
from trader 
join Equipe on trader.nomEquipe = Equipe.nom
where trader.anneesExperience > 3 and Equipe.style = "arbitrage statistique"
ORDER BY trade.nom ASC

--mmtj02
select lieu , Transaction.nom 
from Transaction
join Equipe on Transaction.nomEquipe = Equipe.nom
where Equipe.chef = "Smith" and Transaction.prix < 20
ORDER BY Transaction.nom ASC

--mmtj03
select count(Transaction.nom) 
from Transaction
join Equipe on Transaction.nomEquipe = Equipe.nom
where year(date) = 2021 and Equipe.style = 'marketing making'

--mmtj04
select lieu , AVG(prix) 
from Transaction
join Equipe on Transaction.nomEquipe = Equipe.nom
where Equipe.style = 'marketing making'
GROUP BY Transaction.lieu

--mmtj05
select trader.classe_actif
from Transaction
join trader on Transaction.nomEquipe = trader.nom
join Equipe on trader.nomEquipe = Equipe.nom
where Equipe.chef = "Smith" and Transaction.date = '2016-01-01'

--mmtj21
select AVG(trader.anneesExperience)
from Equipe
join trader on Equipe.nomEquipe = trader.nom
GROUP BY Equipe.style

--mmts01 
select trader.nom , trader.classe_actif 
from trader , Equipe
where Equipe.style = "arbitrage statistique" and trader.anneesExperience > 3
ORDER BY trader.nom ASC

-- ou en requete imbriquer

select trader.nom , trader.classe_actif 
from trader 
where trader.anneesExperience > 3 and nomEquipe IN (
    select nom
    from Equipe
    where Equipe.style = "arbitrage statistique"

)
ORDER BY trader.nom ASC


--mmts02
select lieu 
from Transaction , Equipe
where Equipe.chef = "Smith" and Transaction.prix < 20
ORDER BY Transaction.lieu ASC


-- ou en requete imbriquer

select trader.nom , trader.classe_actif 
from trader 
where trader.anneesExperience > 3 and nomEquipe IN (
    select nom
    from Equipe
    where Equipe.style = "arbitrage statistique"

)
ORDER BY trader.nom ASC

--mmts03
SELECT count(Transaction.lieu) as nb_market
FROM Transaction
WHERE year(Transaction.date) = 2015 AND Transaction.nomEquipe IN  (
    SELECT nom
    FROM Equipe
    WHERE Equipe.style = 'volatilite'
  )


--mmts04
select lieu , AVG(Transaction.prix) 
from Transaction
where Transaction.nomEquipe IN (
    select nom
    from Equipe
    where Equipe.style = 'marketing making'   
)
GROUP BY Transaction.lieu

--mmts05
SELECT Trader.classe_actif
FROM Trader
WHERE  Trader.nomEquipe IN (
    SELECT nom
    FROM Equipe
    WHERE Equipe.chef = "Smith" AND Equipe.nom IN  (
        SELECT nomEquipe
        FROM Transaction
        WHERE Transaction.date = "2016-01-01"
    )
)

