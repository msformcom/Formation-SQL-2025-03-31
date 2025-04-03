SELECT        O.orderid AS IdCommande, O.custid AS IdClient, O.empid AS IdEmploye, O.shipperid AS IdLivreur, O.orderdate AS DateCommande, O.shippeddate AS DateLivraison, SUM(OD.qty * OD.unitprice) AS MontantArticles,
                          O.freight AS PrixLivraison, SUM(OD.qty * OD.unitprice) + O.freight AS MontantTotal, O.shipcountry AS PaysLivraison, O.shipregion AS RegionLivraison, O.shipcity AS VilleLivraison
FROM            Sales.Orders AS O INNER JOIN
                         Sales.OrderDetails AS OD ON OD.orderid = O.orderid
GROUP BY O.orderid, O.custid, O.empid, O.shipperid, O.orderdate, O.freight, O.shippeddate, O.shipcountry, O.shipregion, O.shipcity