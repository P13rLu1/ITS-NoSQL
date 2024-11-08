select indexname, indexdef
from pg_indexes
where tablename = 'address';

explain select address_id, address, district, phone
from address
where phone = '223664661973';

create index idx_phone on address(phone);