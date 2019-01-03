--LOADROUTED Script

--truncate table stLOADROUTED

create table #tempRoutingDetail
(
RoutingNumber int
,RoutingVersion int
,RoutingDetailItemNo int
,RoutingType varchar(10)
,PartCode varchar(50)
,QtyUsed decimal(12,6)
,UOM varchar(5)
,RoutingItem int
)

insert into #tempRoutingDetail 
select RoutingNumber, RoutingVersion, Case When Left(b.BP_PART, 1) = 'D' Then 20 Else 10 End as RoutingDetailItemNo,
		 'M' as RoutingType, b.BP_PART, b.BP_QTY, Case When Left(b.BP_PART, 1) = 'D' Then 'SF' Else 'EA' End as UOM,
		r.RoutingItem
	FROM stLOADROUTEH r
		LEFT OUTER JOIN stLOADBOM b
			on r.Part = b.BM_ASSEMBLY
	--where right(r.part,1) = 'W'
union all
select RoutingNumber, RoutingVersion, 30 as RoutingDetailItemNo,
		 'L' as RoutingType, 'STANDARD', x.Labor, 'HR' as UOM,
		r.RoutingItem
	FROM stLOADROUTEH r
		LEFT OUTER JOIN stRoutingCrossReference x
			on substring(Part, 8,6) = x.PartCode
	--where right(r.part,1) = 'W'
union all
select RoutingNumber, RoutingVersion, 40 as RoutingDetailItemNo,
		 'B' as RoutingType, 'STANDARD', x.Burden, 'HR' as UOM,
		r.RoutingItem
	FROM stLOADROUTEH r
		LEFT OUTER JOIN stRoutingCrossReference x
			on substring(Part, 8,6) = x.PartCode		
	--where right(r.part,1) = 'W'


insert into stLOADROUTED
select * From #tempRoutingDetail

select RoutingNumber as ROUTING_NUMB, RoutingVersion as ROUTING_VERSION, RoutingDetailItemNo As ITEM_NO,
		RoutingType as ROUTING_TYPE, PartCode as PART_CODE, QtyUsed as QTY_USED, UOM, RoutingItem as ROUTING_ITEM
	from stLOADROUTED
order by RoutingNumber, RoutingDetailItemNo

drop table #tempRoutingDetail
