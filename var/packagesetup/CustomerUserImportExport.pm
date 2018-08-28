# --
# CustomerUserImportExport.pm - code run during package de-/installation
# Copyright (C) 2006-2014 c.a.p.e. IT GmbH, http://www.cape-it.de
#
# written/edited by:
# * Martin(dot)Balzarek(at)cape(dash)it.de
# * Torsten(dot)Thau(at)cape(dash)it.de
# * Anna(dot)Litvinova(at)cape(dash)it.de
# * Frank(dot)Oberender(at)cape(dash)it(dot)de
# * Thomas(dot)Lange(at)cape(dash)it(dot)de
# --
# $Id: CustomerUserImportExport.pm,v 1.12 2015/11/13 15:20:03 tlange Exp $
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package var::packagesetup::CustomerUserImportExport;

use strict;
use warnings;


our @ObjectDependencies = (
    'Kernel::System::ImportExport',
    'Kernel::System::CustomerUser',
    'Kernel::System::Log',
    'Kernel::Config'
);

=head1 NAME

CustomerUserImportExport.pm - code to excecute during package installation

=head1 SYNOPSIS

All functions

=head1 PUBLIC INTERFACE

=over 4

=cut

=item new()

create an object

    use Kernel::Config;
    use Kernel::System::Log;
    use Kernel::System::Main;
    use Kernel::System::Time;
    use Kernel::System::DB;
    use Kernel::System::XML;

    my $ConfigObject = Kernel::Config->new();
    my $LogObject    = Kernel::System::Log->new(
        ConfigObject => $ConfigObject,
    );
    my $MainObject = Kernel::System::Main->new(
        ConfigObject => $ConfigObject,
        LogObject    => $LogObject,
    );
    my $TimeObject = Kernel::System::Time->new(
        ConfigObject => $ConfigObject,
        LogObject    => $LogObject,
    );
    my $DBObject = Kernel::System::DB->new(
        ConfigObject => $ConfigObject,
        LogObject    => $LogObject,
        MainObject   => $MainObject,
    );
    my $XMLObject = Kernel::System::XML->new(
        ConfigObject => $ConfigObject,
        LogObject    => $LogObject,
        DBObject     => $DBObject,
        MainObject   => $MainObject,
    );
    my $CodeObject = var::packagesetup::OTRS-CiCS-ITSM.pm->new(
        ConfigObject => $ConfigObject,
        LogObject    => $LogObject,
        MainObject   => $MainObject,
        TimeObject   => $TimeObject,
        DBObject     => $DBObject,
        XMLObject    => $XMLObject,
    );

=cut

sub new {
    my ( $Type, %Param ) = @_;

    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

=item CodeInstall()

run the code install part

    my $Result = $CodeObject->CodeInstall();

=cut

sub CodeInstall {
    my ( $Self, %Param ) = @_;
    $Self->_CreateMappings();

    return 1;
}

=item CodeReinstall()

run the code reinstall part

    my $Result = $CodeObject->CodeReinstall();

=cut

sub CodeReinstall {
    my ( $Self, %Param ) = @_;

    $Self->_CreateMappings();

    return 1;
}

=item CodeUpgrade()

run the code upgrade part

    my $Result = $CodeObject->CodeUpgrade();

=cut

sub CodeUpgrade {
    my ( $Self, %Param ) = @_;

    $Self->_CreateMappings();

    return 1;
}

=item CodeUninstall()

run the code uninstall part

    my $Result = $CodeObject->CodeUninstall();

=cut

sub CodeUninstall {
    my ( $Self, %Param ) = @_;

    $Self->_RemoveRelatedMappings();

    return 1;
}

sub _RemoveRelatedMappings() {

    my ( $Self, %Param ) = @_;

    my $TemplateList = $Kernel::OM->Get('Kernel::System::ImportExport')->TemplateList(
        Object => 'CustomerUser',
        Format => 'CSV',
        UserID => 1,
    );

    if ( ref($TemplateList) eq 'ARRAY' && @{$TemplateList} ) {
        $Kernel::OM->Get('Kernel::System::ImportExport')->TemplateDelete(
            TemplateID => $TemplateList,
            UserID     => 1,
        );
    }

    return 1;
}

sub _CreateMappings() {
    my ( $Self, %Param ) = @_;

    my $TemplateObject = "CustomerUser";
    my $TemplateName   = "";
    my %TemplateList   = ();

    my %CSList                       = $Kernel::OM->Get('Kernel::System::CustomerUser')->CustomerSourceList();
    my $ForceCSVMappingConfiguration = $Kernel::OM->Get('Kernel::Config')->Get(
        'ImportExport::CustomerUserImportExport::ForceCSVMappingRecreation'
    ) || '0';

    my $TemplateListRef = $Kernel::OM->Get('Kernel::System::ImportExport')->TemplateList(
        Object => $TemplateObject,
        Format => 'CSV',
        UserID => 1,
    );
    if ( $TemplateListRef && ref($TemplateListRef) eq 'ARRAY' ) {
        for my $CurrTemplateID ( @{$TemplateListRef} ) {
            my $TemplateDataRef = $Kernel::OM->Get('Kernel::System::ImportExport')->TemplateGet(
                TemplateID => $CurrTemplateID,
                UserID     => 1,
            );
            if (
                $TemplateDataRef
                && ref($TemplateDataRef) eq 'HASH'
                && $TemplateDataRef->{Object}
                && $TemplateDataRef->{Name}
                )
            {
                $TemplateList{ $TemplateDataRef->{Object} . '::' . $TemplateDataRef->{Name} }
                    = $CurrTemplateID;
            }
        }
    }

    CUSTOMERUSERBACKEND:
    for my $CurrCUBackendKey ( keys(%CSList) ) {
        $TemplateName =
            $CurrCUBackendKey . " - " . $CSList{$CurrCUBackendKey} . " (auto-created map)";

        #-----------------------------------------------------------------------
        # check if template already exists...
        if ( $TemplateList{ $TemplateObject . '::' . $TemplateName } ) {
            if ($ForceCSVMappingConfiguration) {
                $Kernel::OM->Get('Kernel::System::ImportExport')->TemplateDelete(
                    TemplateID => $TemplateList{ $TemplateObject . '::' . $TemplateName },
                    UserID     => 1,
                );
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'notice',
                    Message  => "CSV mapping deleted for re-creation <"
                        . $TemplateName
                        . ">.",
                );
            }
            else {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => "CSV mapping already exists and not re-created <"
                        . $TemplateName
                        . ">.",
                );
                next CUSTOMERUSERBACKEND;
            }
        }

        #-----------------------------------------------------------------------
        # add a template customer user
        my $TemplateID = $Kernel::OM->Get('Kernel::System::ImportExport')->TemplateAdd(
            Object  => $TemplateObject,
            Format  => 'CSV',
            Name    => $TemplateName,
            Comment => "Automatically created during CustomerUserImportExport installation",
            ValidID => 1,
            UserID  => 1,
        );

        #-----------------------------------------------------------------------
        # create attribute mapping...
        my @ElementList = qw{};
        my @Map =
            @{ $Kernel::OM->Get('Kernel::Config')->{$CurrCUBackendKey}->{'Map'} };

        for my $CurrAttributeMapping (@Map) {
            my $CurrAttribute = {
                Key   => $CurrAttributeMapping->[0],
                Value => $CurrAttributeMapping->[0],
            };

            # if ValidID is available - offer Valid instead..
            if ( $CurrAttributeMapping->[0] eq 'ValidID' ) {
                $CurrAttribute = { Key => 'Valid', Value => 'Validity', };
            }
            push( @ElementList, $CurrAttribute );

        }

        my $ExportDataSets = [
            {
                SourceExportData => {
                    FormatData => {
                        ColumnSeparator => 'Semicolon',
                        Charset         => 'UTF-8',
                    },
                    MappingObjectData => \@ElementList,
                    ExportDataGet     => {
                        TemplateID => $TemplateID,
                        UserID     => 1,
                    },
                },
            }
        ];

        # get object attributes
        my $ObjectAttributeList = $Kernel::OM->Get('Kernel::System::ImportExport')->ObjectAttributesGet(
            TemplateID => $ExportDataSets->[0]->{SourceExportData}->{ExportDataGet}->{TemplateID},
            UserID     => 1,
        );
        my $AttributeValues;
        foreach my $Default ( @{$ObjectAttributeList} ) {
            if ( $Default->{Key} eq 'CustomerBackend' ) {
                $AttributeValues->{ $Default->{Key} } = $CurrCUBackendKey;
            }
            else {
                $AttributeValues->{ $Default->{Key} } = $Default->{Input}->{ValueDefault} || '';
            }

        }
        $ExportDataSets->[0]->{SourceExportData}->{ObjectData} = $AttributeValues;

        # ----------------------------------------------------------------------
        # run general ExportDataGet...
        EXPORTDATASET:
        for my $CurrentExportDataSet ( @{$ExportDataSets} ) {

            # check SourceExportData attribute
            if (
                !$CurrentExportDataSet->{SourceExportData}
                || ref $CurrentExportDataSet->{SourceExportData} ne 'HASH'
                )
            {

                next EXPORTDATASET;
            }

            # set the object data
            if (
                $CurrentExportDataSet->{SourceExportData}->{ObjectData}
                && ref $CurrentExportDataSet->{SourceExportData}->{ObjectData} eq 'HASH'
                && $CurrentExportDataSet->{SourceExportData}->{ExportDataGet}->{TemplateID}
                )
            {

                # save object data
                $Kernel::OM->Get('Kernel::System::ImportExport')->ObjectDataSave(
                    TemplateID =>
                        $CurrentExportDataSet->{SourceExportData}->{ExportDataGet}->{TemplateID},
                    ObjectData => $CurrentExportDataSet->{SourceExportData}->{ObjectData},
                    UserID     => 1,
                );
            }

            # set the format data
            if (
                $CurrentExportDataSet->{SourceExportData}->{FormatData}
                && ref $CurrentExportDataSet->{SourceExportData}->{FormatData} eq 'HASH'
                && $CurrentExportDataSet->{SourceExportData}->{ExportDataGet}->{TemplateID}
                )
            {

                # save format data
                $Kernel::OM->Get('Kernel::System::ImportExport')->FormatDataSave(
                    TemplateID =>
                        $CurrentExportDataSet->{SourceExportData}->{ExportDataGet}->{TemplateID},
                    FormatData => $CurrentExportDataSet->{SourceExportData}->{FormatData},
                    UserID     => 1,
                );
            }

            # set the mapping object data
            if (
                $CurrentExportDataSet->{SourceExportData}->{MappingObjectData}
                && ref $CurrentExportDataSet->{SourceExportData}->{MappingObjectData} eq 'ARRAY'
                && $CurrentExportDataSet->{SourceExportData}->{ExportDataGet}->{TemplateID}
                )
            {

                # delete all existing mapping data
                $Kernel::OM->Get('Kernel::System::ImportExport')->MappingDelete(
                    TemplateID =>
                        $CurrentExportDataSet->{SourceExportData}->{ExportDataGet}->{TemplateID},
                    UserID => 1,
                );

                # add the mapping object rows
                MAPPINGOBJECTDATA:
                for my $MappingObjectData (
                    @{ $CurrentExportDataSet->{SourceExportData}->{MappingObjectData} }
                    )
                {

                    # add a new mapping row
                    my $MappingID = $Kernel::OM->Get('Kernel::System::ImportExport')->MappingAdd(
                        TemplateID =>
                            $CurrentExportDataSet->{SourceExportData}->{ExportDataGet}
                            ->{TemplateID},
                        UserID => 1,
                    );

                    # add the mapping object data
                    $Kernel::OM->Get('Kernel::System::ImportExport')->MappingObjectDataSave(
                        MappingID         => $MappingID,
                        MappingObjectData => $MappingObjectData,
                        UserID            => 1,
                    );
                }
            }

        }    #EO for my $CurrCUBackendKey ( keys( %CSList ) )

    }

    return 1;

}

1;
