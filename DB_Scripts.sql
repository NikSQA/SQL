
--Тестовые запросы к БД которые были написаны для тестирования нового функционала (Все запросы обезличены)

--update:

update NOTIF_Z.PROCEDUR
set OFFER_END_DATE = to_date ('14.05.2021', 'dd.mm.yyyy'), ACTUAL_OFFER_504_END_DATE = to_date ('14.05.2021', 'dd.mm.yyyy')
where PROCEDURE_ID in (
select distinct pr.PROCEDUR_ID from NOTIF_Z.PROCEDUR pr
join NOTIF_Z.NOTICE n on pr.notice_id = n.notice_id
join NOTIF_Z.ORDERS o on n.order_id = o.order_id
where o.order_num = '0805400000519000013');


update
RGK_Z.rk_base_rule_level po
set
RULE_LEVEL = 'WARNING'
where
po.rk_base_rule_level_id = 981;


update notif_z.stprotocols
set publish_date = to_date ('2021.20.09', 'yyyy.dd.mm HH24:MI:SS')
where stprotocol_id = 75970;

-- Выборка с условием:


select DISTINCT zakupki_dev.users.last_name from zakupki_dev.organization 
left join zakupki_dev.users on zakupki_dev.users.organization_id = zakupki_dev.organization.organization_id
where zakupki_dev.organization.full_name = 'Федеральное казначейство'

--JOIN:
SELECT pfc.* FROM RPEC_Z.CONTRACT_DRAFT cd
JOIN RPEC_Z.CD_REVISION cdr ON cd.LAST_PUBLISHED_REVISION_ID = cdr.ID
JOIN RPEC_Z.PRINT_FORM pf ON cdr.PRINT_FORM_ID = pf.PRINT_FORM_ID
JOIN RPEC_Z.PRINT_FORM_CONTENT pfc ON pf.CONTENT_INTEGRATION_ID = pfc.CONTENT_ID
WHERE cd.REESTR_NUMBER = '01604000002200002130002';


select nc.currency_id, nc.name, nc.code, nc.digital_code, ncr.currency_rate_id, t1.rate_date, ncr.nominal, ncr.rate
from (select currency_id, MAX (Rate_Date) as Rate_Date from zakupki_nsi.NSI_CURRENCY_RATE where is_actual = 1 group by currency_id) t1
left join zakupki_nsi.NSI_CURRENCY_RATE ncr on (t1.currency_id = ncr.currency_id AND t1.rate_date = ncr.rate_date AND ncr.is_actual = 1)
left join zakupki_nsi.NSI_CURRENCY nc on ncr.CURRENCY_ID = nc.CURRENCY_ID
where nc.is_actual = 1 order by nc.name asc
