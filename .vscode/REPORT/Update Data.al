report 50041 "Update Data"
{
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItemName; "Position Menu")
        {
            trigger OnAfterGetRecord()
            begin

                SifraPO := DataItemName.Code;
                if PosM.Get(DataItemName.Code, DataItemName.Description, DataItemName."Department Code", DataItemName."Org. Structure")
                then
                    PosM.Rename('RM' + DataItemName.Code, DataItemName.Description, DataItemName."Department Code", DataItemName."Org. Structure");

                ECL.Reset();
                ECL.SetFilter("Position Description", '%1', PosM.Description);
                if ECL.FindSet() then
                    repeat
                        ECL."Position Code" := PosM.Code;
                        ECL.Modify();
                    until ECL.Next() = 0;

                //"Department Code", "ORG Shema", "Department Categ.  Description", "Group Description", "Team Description", "Management Level", "Position Code"

                HeadOfOrg.Reset();
                HeadOfOrg.SetFilter("Position Code", '%1', SifraPO);
                if HeadOfOrg.FindFirst() then begin
                    if HeadOf.Get(HeadOfOrg."Department Code", HeadOfOrg."ORG Shema", HeadOfOrg."Department Categ.  Description", HeadOfOrg."Group Description", HeadOfOrg."Team Description", HeadOfOrg."Management Level", HeadOfOrg."Position Code")
                    then
                        HeadOf.Rename(HeadOfOrg."Department Code", HeadOfOrg."ORG Shema", HeadOfOrg."Department Categ.  Description", HeadOfOrg."Group Description", HeadOfOrg."Team Description", HeadOfOrg."Management Level", PosM.Code)

                end;


                // "Code", "Position ID", "Org. Structure", Description
                Pos.reset;
                Pos.SetFilter(Code, '%1', SifraPO);
                if Pos.FindSet() then
                    repeat
                        if PosR.Get(Pos.Code, pos."Position ID", pos."Org. Structure", pos.Description) then
                            PosR.Rename(PosM.Code, Pos."Position ID", pos."Org. Structure", Pos.Description);
                    until Pos.Next() = 0;
            end;
        }

    }




    var
        myInt: Integer;
        SifraPO: Code[20];
        PosM: Record "Position Menu";
        ECL: Record "Employee Contract Ledger";
        HeadOf: Record "Head Of's";
        HeadOfOrg: Record "Head Of's";
        Pos: Record Position;
        PosR: Record Position;

}