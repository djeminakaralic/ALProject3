report 50041 "Update Data"
{
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItemName; "Employee Contract Ledger")
        {
            trigger OnAfterGetRecord()
            begin

                /*   DataItemName.Active := true;
                   DataItemName.Validate("Address CIPS", 'Zagrebačka 27');
                   DataItemName.Address := '';
                   DataItemName.Validate("Municipality Code CIPS", DataItemName."Municipality Code CIPS");
                   DataItemName.Modify();*/

                /*   PosM.Reset();
                   PosM.SetFilter(Description, '%1', DataItemName.Description);
                   PosM.SetFilter("Department Code", '%1', DataItemName."Department Code");
                   if PosM.FindFirst() then begin
                       DataItemName."Management Level" := PosM."Management Level";
                       DataItemName.Modify();
                       HeadOf.Reset();
                       HeadOf.SetFilter("Position Code", '%1', PosM.Code);
                       HeadOf.SetFilter("Department Code", '%1', PosM."Department Code");
                       if HeadOf.FindFirst() then begin
                           if HeadOfOrg.Get(HeadOf."Department Code", HeadOf."ORG Shema", HeadOf."Department Categ.  Description",
                           HeadOf."Group Description", HeadOf."Team Description", HeadOf."Management Level", HeadOf."Position Code")
                       then
                               HeadOfOrg.Rename(HeadOf."Department Code", HeadOf."ORG Shema", HeadOf."Department Categ.  Description",
                                   HeadOf."Group Description", HeadOf."Team Description", PosM."Management Level", HeadOf."Position Code")
                       end;

                   end;
   */
                DataItemName.Validate("Position Description", DataItemName."Position Description");
                DataItemName.Modify();


                /*Emp.Reset();
                Emp.SetFilter("No.", '%1', DataItemName."Employee No.");
                if Emp.FindFirst() then
                    Emp."Hours In Day" := 8;
                Emp.Modify();*/
            end;


            /*    SifraPO := DataItemName.Code;
                if StrPos(SifraPO, 'RM') <> 0 then
                    exit;
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
        }*/

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
        Emp: Record Employee;
        PosR: Record Position;
        alt: Record "Alternative Address";

}