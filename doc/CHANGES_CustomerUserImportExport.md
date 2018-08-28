# Change log of CustomerUserImportExport
* Copyright (C) 2006-2015 c.a.p.e. IT GmbH, http://www.cape-it.de/
* $Id: CHANGES_CustomerUserImportExport.md,v 1.11 2015/11/13 15:20:03 tlange Exp $

# r5.0.0 (2015/11/13)
* (2015/11/13) - CR: T#2015082690000517 (added framework OTRS 5.0.x) (tlange)

# r4.99.80 (2015/11/11)
* (2015/09/04) - CR: T#2015082690000517 (changes for use with OTRS 5.0.x) (tlange)

# r4.0.02 (2015/08(26)
* (2015/04/16) - Bugfix: T#2015041590000581 (fix Description in sopm) (sreiss)

# r1.11.1 (2014/12/03)
* (2014/12/03) - CR: T2014102990000509 (fix package setup) (fober)

# r1.11.0 (2014/12/01)
* (2014/11/03) - CR: T2014102990000509 (changes for use with OTRS 4.0.x) (fober)

# r1.10.0 (2013/10/17)
* (2013/10/16) - CR: (use CustomerKey of backend as identifier) (millinger)
* (2013/10/16) - CR: (changes for use with OTRS 3.3.x) (millinger)

# r1.9.2 (2013/10/16)
* (2013/10/16) - Bugfix: T2013101690000321 (added missing object creation) (tto)

# r1.9.1 (2013/10/14)
* (2013/08/23) - Bugfix: T2013072490000286 (added identifier for import) (smehlig)
* (2013/07/29) - CR: T2013071990000376 (sanitize "Country" field) (tto) => provided by Cyrille Bollu - merci beaucoup!

# r1.9.0 (2013/02/12)
* (2013/02/12) - CR: T2013021290000129 (modifications for ITSM3.1.7 and framework OTRS 3.2.x) (tto)
* (2013/02/12) - CR: T2013021290000129 (added Sysconfig option for auotm. CSV-mapping creation on reinstall/upgrade) (tto)

# r1.8.1 (2013/01/10)
* (2012/12/20) - Bugfix: (fix wrong password set/reset behaviour) (fober) 
* (2012/09/28) - CR: (do not replace UserEmail and UserCustomerID if not given by default values when updating) (tto)
* (2012/09/28) - CR: (removed ValueDefault for default mail address and required flag for customer ID) (tto)

# r1.8.0 (2012/04/13)
* (2012/03/08) - CR: T2012022790000246 (changes for use with OTRS 3.1.x) (alitvinova)
* (2012/03/08) - CR: T2012022790000246 (deleted "identifier" column in mapping configuration) (alitvinova)
* (2012/03/08) - CR: T2012022790000246 (deleted "Export with labels" attribute) (alitvinova)

# r1.7.1 (2011/12/22)
* (2011/12/22) - CR: added option "Force import in configured customer backend" (tto)
* (2011/03/20) - CR: added usage information in pod-file in <OTRS_HOME>/doc/en (tto)

# r1.7.0 (2011/02/16)
* (2011/02/16) - CR: changes for use with OTRS 3.0.x

# r1.5.2 (2010/05/07)
* (2010/05/07) - Bugfix: T2010042890000128(all imported entries are valid ).

# r1.5.1 (2010/05/02)
* (2010/05/01) - Bugfix: T2010042890000128 (export delivers only valid entries)

# r1.5.0 (2010/04/17)
* (2010/04/17) - CR: set correct backend ID in default values on auto mapping creation for multiple customer data backends
* (2010/04/16) - CR: automatic mapping creation on package installation
* (2010/04/15) - CR: reworked template config options
* (2010/04/15) - CR: added unit-test files (preparations only)
* (2010/04/15) - CR: added language file
* (2010/01/26) - Bugfix: ignored import ValidID (always replaced by 1).

# r1.4.2 (2010/01/18)
* (2010/01/18) - Bugfix: ignored configured data backend when adding new CU. 

# r1.4.1 (2009/12/23)
* (2009/12/23) - Bugfix: fixed missing check for EncodeObject. 

# r1.4.0 (2009/09/28)
* (2009/14/10) - CR: First release for framework 2.4.x. 

# r1.3.2 (2009/09/28)
* (2009/09/28) - CR: First relase of general customer user import-/export backend.

