with cte1 as (
select a.id as order_id ,
a.tenant_id as tenant_id,
a.created_at at time zone 'utc' at time zone 'Asia/Calcutta' as order_created_at,
b.number as spree_order_number,
b.item_total,b.total,
b.state as order_status,
b.email,
b.channel
from dxc_orders a inner join spree_orders b on a.spree_order_id  = b.id
),
cte2 as (
select a.short_description,
a.created_at at time zone 'utc' at time zone 'Asia/Calcutta' as product_created_at,
a.dxc_tenant_id,
a.schema,
a.pre_entered_inputs,
a.product_type,
b.name as product_name,
b.slug
from dxc_products a inner join spree_products b on a.spree_product_id = b.id 
)
SELECT * FROM cte1 a JOIN cte2 b ON a.tenant_id = b.dxc_tenant_id AND a.order_created_at BETWEEN
     b.product_created_at - INTERVAL '3 minutes'
 AND b.product_created_at + INTERVAL '3 minutes';
