--LOADBOM Script
--truncate table stLOADBOM

insert into stLOADBOM 
	select SKU as BM_ASSEMBLY, 1 as BM_VERSION, 10 as BP_ITEM,
		1 as BP_QTY, RIGHT(SKU,5) as BP_PART, 'M' as BP_TYPE, 1 as BM_STATUS
	from Item i
	JOIN ProductType pt on i.ProductTypeID = pt.ProductTypeID
	LEFT JOIN stLOADBOM exist on i.SKU = exist.BM_ASSEMBLY AND exist.BP_ITEM = 10
	WHERE pt.SetCode = 'A' and pt.TypeCode = 'W' AND exist.BP_PART IS NULL
union all
	select SKU as BM_ASSEMBLY, 1 as BM_VERSION, 20 as BP_ITEM,
		((i.Height + 4) * (i.Width + 4)) / 144 as BP_QTY, 
		'DSGSC601503455' as BP_PART, 'M' as BP_TYPE, 1 as BM_STATUS
	from Item i
	JOIN ProductType pt on i.ProductTypeID = pt.ProductTypeID
	LEFT JOIN stLOADBOM exist on i.SKU = exist.BM_ASSEMBLY AND exist.BP_ITEM = 20
	WHERE pt.SetCode = 'A' and pt.TypeCode = 'W' AND exist.BP_PART IS NULL
union all
	select SKU as BM_ASSEMBLY, 1 as BM_VERSION, 10 as BP_ITEM, 1 as BP_QTY, RIGHT(SKU, 5) as BP_PART, 'M' as BP_TYPE, 1 as BM_STATUS
	from Item i
	JOIN ProductType pt on i.ProductTypeID = pt.ProductTypeID
	LEFT JOIN stLOADBOM exist on i.SKU = exist.BM_ASSEMBLY AND exist.BP_ITEM = 10
	WHERE pt.SetCode = 'A' and pt.TypeCode = 'F' AND exist.BP_PART IS NULL
union all
	select SKU as BM_ASSEMBLY, 1 as BM_VERSION, 20 as BP_ITEM,
		(((i.Height - 1.5) + 3) * ((i.Width - 1.5) + 3)) / 144 as BP_QTY,
		'DSGSC601503455' as BP_PART, 'M' as BP_TYPE, 1 as BM_STATUS
	from Item i
	JOIN ProductType pt on i.ProductTypeID = pt.ProductTypeID
	LEFT JOIN stLOADBOM exist on i.SKU = exist.BM_ASSEMBLY AND exist.BP_ITEM = 20
	WHERE pt.SetCode = 'A' and pt.TypeCode = 'F' AND exist.BP_PART IS NULL
union all
	select SKU as BM_ASSEMBLY, 1 as BM_VERSION, 10 as BP_ITEM,
		((i.Height + 4) * (i.Width + 4)) / 144 as BP_QTY, 
		'DSGSC601503455' as BP_PART, 'M' as BP_TYPE, 1 as BM_STATUS
	from Item i
	JOIN ProductType pt on i.ProductTypeID = pt.ProductTypeID
	LEFT JOIN stLOADBOM exist on i.SKU = exist.BM_ASSEMBLY AND exist.BP_ITEM = 10
	WHERE pt.SetCode = 'A' and pt.TypeCode = 'R' AND exist.BP_PART IS NULL
union all
select SKU as BM_ASSEMBLY, 1 as BM_VERSION, 10 as BP_ITEM,
		(i.Height * i.Width) / 144 as BP_QTY, 'PT-60100S' as BP_PART, 'M' as BP_TYPE, 1 as BM_STATUS
	from Item i
	JOIN ProductType pt on i.ProductTypeID = pt.ProductTypeID
	LEFT JOIN stLOADBOM exist on i.SKU = exist.BM_ASSEMBLY AND exist.BP_ITEM = 10
	WHERE pt.SetCode = 'A' and pt.TypeCode = 'P' AND exist.BP_PART IS NULL
order by BM_ASSEMBLY, BP_ITEM

--select * from stLOADBOM
--WHERE BM_ASSEMBLY IN
--(
--	SELECT i.SKU
--	FROM Item i
--	JOIN ProductType pt on i.ProductTypeID = pt.ProductTypeID
--	WHERE pt.SetCode = 'A' AND pt.TypeCode IN ('W', 'F', 'P')
--		AND i.SKU IN (SELECT item_no FROM temp_items)
--)
--order by BM_ASSEMBLY, BP_ITEM

