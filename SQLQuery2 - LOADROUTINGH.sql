--LOADROUTINGH Script

truncate table stLOADROUTEH

create table #tempRoutingHeader
(
RoutingNumber int identity(600001,1)
,RoutingDesc varchar(250)
,CostCenter int
,Part varchar(50)
,RoutingVersion int
,RoutingStatus int
,RoutingYield int
,RoutingSeq int
,RoutingItem int
,DivisionCode varchar(5)
,Machine varchar(50)
,UnitsPerHour int
)


insert into #tempRoutingHeader (Part,CostCenter, RoutingDesc,RoutingVersion,RoutingStatus,RoutingYield
								,RoutingSeq,RoutingItem,DivisionCode,Machine)
	select SKU, 10, 'MFG ' + substring(SKU, 8,6) + ' Piece of Art', 1, 1, 1, 1, 10, 'MFG', 'ARTASSBLY'
		from Item
		where  (substring(SKU, 8,1) = 'A' and right(SKU, 1) = 'W')
			or (substring(SKU, 8,1) = 'A' and right(SKU, 1) = 'F')
			or (substring(SKU, 8,1) = 'A' and right(SKU, 1) = 'R')
			or (substring(SKU, 8,1) = 'A' and right(SKU, 1) = 'P')

	update #tempRoutingHeader
		set UnitsPerHour = xref.UnitsPerHour
		from #tempRoutingHeader t
			left outer join stRoutingCrossReference xref
				on SUBSTRING(t.Part, 8,6) = xref.PartCode

insert into stLOADROUTEH
select * from #tempRoutingHeader

drop table #tempRoutingHeader

select CostCenter as COST_CTR, Part as PART_CODE, RoutingNumber as ROUTING_NUMB,
			RoutingDesc as ROUTING_DESC, RoutingVersion as ROUTING_VERSION, RoutingStatus as ROUTING_STATUS,
			RoutingYield as ROUTING_YIELD, RoutingSeq as ROUTING_SEQ, RoutingItem as ROUTING_ITEM, DivisionCode as DIVISION_CODE,
			Machine as ITEM_MACHINE, UnitsPerHour as UNITS_PER_HOUR
  from stLOADROUTEH
--where right(part, 1) = 'W'


