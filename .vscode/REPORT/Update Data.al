report 50041 "Update Data"
{
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItemName; "Employee Contract Ledger")
        {


            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetCurrentKey(Order);
                Ascending;

            end;

            trigger OnAfterGetRecord()
            begin
                /*                Brojac := Brojac + 1;
                                OldNumber := DataItemName."No.";

                                Evaluate(CodeS, format(Brojac));

                                EmpOLD.Reset();
                                EmpOLD.SetFilter("No.", '%1', CodeS);
                                if EmpOLD.FindFirst() then begin
                                    if EmpOLD2.get(EmpOLD."No.") then
                                        EmpOLD2.Rename(EmpOLD2."No." + '_' + format(EmpOLD.Count))

                                end;

                                if Emp.Get(DataItemName."No.") then
                                    Emp.Rename(CodeS);


                                Emp.Order := Brojac;
                                Emp.Modify();






                                /* DataItemName.Active := true;
                                 DataItemName.Validate("Address CIPS", 'Zagrebačka 27');
                                 DataItemName.Address := '';
                                 DataItemName.Validate("Municipality Code CIPS", DataItemName."Municipality Code CIPS");
                                 DataItemName.Modify();
                 */
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


                /*      Emp.Reset();
                      Emp.SetFilter("No.", '%1', DataItemName."Employee No.");
                      if Emp.FindFirst() then
                          Emp."Hours In Day" := 8;
                      Emp.Modify();
                  end;
      */

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


                /*if Brojac = 322 then
                    CurrReport.Break();*/
                /*       if copystr(DataItemName."No.", StrLen(DataItemName."No.") - 2, StrLen(DataItemName."No.")) <> '_1' then begin

                           Emp.Reset();
                           Emp.SetFilter("No.", '%', DataItemName."No." + '_1');
                           if not Emp.FindFirst() then begin
                               if EmpOLD.get(DataItemName."No.") then
                                   EmpOLD.Rename(DataItemName."No." + '_1');

                           end
                           else begin
                               if EmpOLD.get(DataItemName."No.") then
                                   EmpOLD.Rename(DataItemName."No." + '__1');

                           end;
                       end;

                       Brojac := Brojac + 1;
                       if Brojac = 319 then
                           CurrReport.Break();
                   end;*/
            end;
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        Brojac := 0;



    end;


    var
        myInt: Integer;
        CodeS: Code[20];
        Brojac: Integer;
        SifraPO: Code[20];
        OldNumber: Code[20];
        PosM: Record "Position Menu";
        AdditionalEd: Record "Additional Education";

        EL: Record "Employee Level Of Disability";
        EQ: Record "Employee Qualification";
        EmpOLD: Record Employee;
        EmpOLD2: Record Employee;
        ContractP: Record "Contract Phase t";
        EmployeeRelative: Record "Employee Relative";
        PersonalD: Record "Personal Documents";
        ECL: Record "Employee Contract Ledger";
        HeadOf: Record "Head Of's";
        HeadOfOrg: Record "Head Of's";
        Pos: Record Position;
        WB: Record "Work Booklet";
        ECLE: Record "Employee Contract Ledger";

        Alternative: Record "Alternative Address";

        PersonalTrack: Record "Personal track report";

        PlanGO: Record "Vacation Grounds";
        PlanGO2: Record "Vacation Ground 2";
        Order2: Integer;


        Emp: Record Employee;
        PosR: Record Position;
        alt: Record "Alternative Address";

}