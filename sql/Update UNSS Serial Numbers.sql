BEGIN TRANSACTION
update surgentweb_shared.dbo.su_tblSerialNumber_Active set Expires = '2016-12-31 00:00:00.000', updated = getdate()
where ordersku like 'UNSS%'
ROLLBACK
