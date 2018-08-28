# --
# ImportExportObjectCustomerUser.t - all import export tests for the CustomerUser object backend
# Copyright (C) 2006-2015 c.a.p.e. IT GmbH, http://www.cape-it.de/
#
# written/edited by:
# * Torsten(dot)Thau(at)cape(dash)it(dot)de
# * Frank(dot)Oberender(at)cape(dash)it(dot)de
#
# --
# $Id: ImportExportObjectCustomerUser.t,v 1.3 2015/11/13 15:20:03 tlange Exp $
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;
use utf8;

use vars qw($Self);


my $ImportExportObject   = $Kernel::OM->Get('Kernel::System::ImportExport');
    

# ------------------------------------------------------------ #
# make preparations
# ------------------------------------------------------------ #

# add some test templates for later checks
my @TemplateIDs;
for ( 1 .. 30 ) {

    # add a test template for later checks
    my $TemplateID = $ImportExportObject->TemplateAdd(
        Object  => 'CustomerUser',
        Format  => 'UnitTest' . int rand 1_000_000,
        Name    => 'UnitTest' . int rand 1_000_000,
        ValidID => 1,
        UserID  => 1,
    );

    push @TemplateIDs, $TemplateID;
}

my $TestCount = 1;


# ------------------------------------------------------------ #
# ObjectList test 1 (check CSV item)
# ------------------------------------------------------------ #

# get object list
my $ObjectList1 = $ImportExportObject->ObjectList();

# check object list
$Self->True(
    $ObjectList1 && ref $ObjectList1 eq 'HASH' && $ObjectList1->{CustomerUser},
    "Test $TestCount: ObjectList() - CustomerUser exists",
);

$TestCount++;


# ------------------------------------------------------------ #
# ObjectAttributesGet test 1 (check attribute hash)
# ------------------------------------------------------------ #

#
#
# TO DO 
#
#


