--LOADBASE Script

SELECT SKU as PART_CODE, '' as ALT_PART1, 'A' as PART_STATUS, 
	LEFT(RTRIM(im.Title), 50) + ' ' + substring(SKU, 9,2) + 'x' + substring(SKU,11,2) + ' ' +
	CASE WHEN pt.TypeCode = 'W' THEN 'GWC' WHEN pt.TypeCode = 'F' THEN 'FF' WHEN pt.TypeCode = 'P' THEN 'RWA' END as PART_DESC,
	1 as MAKE_BUY, 'F' as PART_TYPE, '01' as SALE_TYPE, 150 as FREIGHT_CLASS,
	'G' as STORAGE_TYPE, 1 as MRP_INCLUDE, 1 as SELLABLE, 0 as MIN_INV, 0 as MAX_INV,
	1 as MFG_LEAD_TIME, 1 as MIN_BATCH_SZ, 99999 as MAX_WO_PDAY, 3 as MAX_WO_SIZE,
	'ART' as PART_GRP, substring(SKU, 8,6) as PART_SUBGRP, '' as PART_COST, 
	UPC as UPC_CODE, 1 as MTO_FLAG, substring(SKU, 9,2) as PART_WIDTH,
	substring(SKU,11,2) as PART_LENGTH, 'EA' as UOM
FROM Item i
JOIN ProductType pt on i.ProductTypeID = pt.ProductTypeID
left outer join ImageMaster im on i.ImageMasterID = im.ImageMasterID
LEFT OUTER JOIN Artist a on im.ArtistID = a.ArtistID
WHERE pt.SetCode = 'A' and pt.TypeCode IN ('W', 'F', 'R', 'P') AND COALESCE(i.Deleted, 0) = 0
ORDER BY i.SKU