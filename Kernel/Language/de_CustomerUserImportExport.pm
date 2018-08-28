# --
# Kernel/Language/de_CustomerUserImportExport.pm - provides german language
# Copyright (C) 2006-2015 c.a.p.e. IT GmbH, http://www.cape-it.de
#
# translation for CustomerUserImportExport module
# written/edited by:
# * Torsten(dot)Thau(at)cape(dash)it(dot)de
# * Anna(dot)Litvinova(at)cape(dash)it(dot)de
# * Frank(dot)Oberender(at)cape(dash)it(dot)de
# --
# $Id: de_CustomerUserImportExport.pm,v 1.7 2015/11/13 15:20:03 tlange Exp $
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --
package Kernel::Language::de_CustomerUserImportExport;

use strict;
use warnings;
use utf8;

# --
sub Data {
    my $Self = shift;
    my $Lang = $Self->{Translation};
    return if ref $Lang ne 'HASH';

    # possible charsets
    $Self->{Charset} = ['utf-8', ];

    # $$START$$

    # translations missing in ImportExport...
    $Lang->{'Column Seperator'}           = 'Spaltentrenner';
    $Lang->{'Charset'}                    = 'Zeichensatz';
    $Lang->{'Restrict export per search'} = 'Export mittels Suche einschränken';

    $Lang->{'ValidID (not used in import anymore, use Validity instead)'}
        = 'ValidID (wird nicht im Import verwendet, bitte stattdessen Validity nutzen';
    $Lang->{'Default Customer ID'} = 'Standard Kunden-ID';
    $Lang->{'Maildomain-CustomerID Mapping (see SysConfig)'}
        = 'Maildomänen-Kunden-ID Zuordnung (siehe SysConfig)';
    $Lang->{'Default Email'}             = 'Standard Email';
    $Lang->{'Reset password if updated'} = 'Bei Update Passwort zurücksetzen';
    $Lang->{'Password-Suffix (new password = login + suffix)'}
        = 'Passwort-Suffix (neues Passwort = Login+Suffix)';
    $Lang->{'Force import in configured customer backend'} =
        'Erzwinge Import in konfigurierten Backend';

    $Lang->{'Object backend module registration for the import/export modul.'} =
        'Objekt-Backend Modul Registration des Import/Export Moduls.';
    $Lang->{
        'Defines which customer ID to use if no company defined - only relevant for new customer users.'
        } =
        'Definiert welche Kunden-ID genutzt wird, falls nicht in Mapping definiert - nur fuer neue Kundennutzereintraege relevant.';
    $Lang->{
        'Defines which email address to use if not defined - strongly depends on backend configuration!!!.'
        } =
        'Definiert welche Mailadresse genutzt wird, wenn nicht gegeben - stark abhaengig von Backendkonfiguration!!!.';
    $Lang->{
        'Defines a mapping of email domains to customer IDs. A special key value is ANYTHINGELSE, which is similar to default customer ID but also affects updates.'
        } =
        'Definiert das Mapping von EMail-Domains zu KundenIDs. Ein besonderer Schluesselwert ist ANYTHINGELSE, welches sich wie DefaultCustomerID verhaelt, aber auch fuer Aktualisierung verwendet wird.';

    #    $Lang->{''}   = '';
    #    $Lang->{''}   = '';
    #    $Lang->{''}   = '';
    #    $Lang->{''}   = '';

    return 0;

    # $$STOP$$
}

# --
1;
