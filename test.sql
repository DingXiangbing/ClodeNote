select * from emp

select t.*,rownum from (
	select e.*from emp e
)t where rownum<10




