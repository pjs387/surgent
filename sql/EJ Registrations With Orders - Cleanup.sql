  begin transaction
  update [AllStarTax].[dbo].[su_EventResgistration2] set
         cartID = null,
         eCommerceOrderNbr = null,
         packageSNOrID = null,
         FARegistration = 1
  where 
       [Validated] is not null 
          and [FARegistration] is null
       and tempattendeeemail like '%@edwardjones.com' 
  rollback
