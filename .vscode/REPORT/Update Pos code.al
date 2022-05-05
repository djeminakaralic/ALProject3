report 50108 "Update Pos Code"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Update Pos Code.rdlc';
    Caption = 'Update ECL';

    dataset
    {
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        //Code,Description,Department Code,Org. Structure
        PositionMenuTemp.RESET;
        IF PositionMenuTemp.FINDSET THEN
            REPEAT
                IF PositionMenuTemp1.GET(PositionMenuTemp.Code, PositionMenuTemp.Description, PositionMenuTemp."Department Code", PositionMenuTemp."Org. Structure") THEN BEGIN
                    OrgShema.RESET;
                    OrgShema.SETFILTER(Status, '%1', OrgShema.Status::Preparation);
                    IF OrgShema.FINDFIRST THEN BEGIN
                        PositionMenuTemp1.RENAME(PositionMenuTemp.Code, PositionMenuTemp.Description, PositionMenuTemp."Department Code", OrgShema.Code)
                    END;
                END;

            UNTIL PositionMenuTemp.NEXT = 0;
    end;

    var
        OrgShema: Record "ORG Shema";
        ECLOrgKojiSeVidi: Record "Employee Contract Ledger";
        ECLNeVidi: Record "Employee Contract Ledger";
        DeleteUpdate: Record "Employee Contract Ledger";
        DeleteUpdate2: Record "Employee Contract Ledger";
        ECLNeVidi2: Record "Employee Contract Ledger";
        SectorOrginal: Record "Sector";
        DepCatOrginal: Record "Department Category";
        GroupOrginal: Record "Group";
        TeamOrginal: Record "TeamT";
        //ĐK DepartmentOrginal: Record "Record";
        HeadOfOrginal: Record "Head Of's";
        DimensionOrginalPos: Record "Dimension for position";
        BenefitsOrginal: Record "Position Benefits";
        PositionMenuOrginal: Record "Position Menu";
        SectorTemp: Record "Sector temporary";
        SectorOrginal1: Record "Sector";
        DepCatTemp: Record "Department Category temporary";
        DepCatOrginal1: Record "Department Category";
        GroupTemp: Record "Group temporary";
        GroupOrginal1: Record "Group";
        TeamTemp: Record "Team temporary";
        TeamOrginal1: Record "TeamT";
        DepartmentTemp: Record "Department temporary";
        DepartmentOrginal1: Record "Department";
        HeadOfTemp: Record "Head Of's temporary";
        HeadOfOrginal1: Record "Head Of's";
        DimensionTempPos: Record "Dimension temp for position";
        DimensionOrginalPos1: Record "Dimension for position";
        BenefitsTemp: Record "Position Benefits temporery";
        BenefitsOrginal1: Record "Position Benefits";
        PositionMenuOrginal1: Record "Position Menu";
        PositionMenuTemp: Record "Position Menu temporary";
        PoSMenDUp: Record "Position Menu";
        PosMenOrg: Record "Position Menu";
        PositionMenuTemp1: Record "Position Menu temporary";
}

