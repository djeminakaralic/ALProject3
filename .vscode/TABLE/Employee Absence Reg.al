table 50104 "Employee Absence Reg"
//ED 01 START
{
    Caption = 'Employee Absence Reg';
    DrillDownPageID = "Employee Absence";
    LookupPageID = "Employee Absence";

    fields
    {
        field(1; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(2; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
        }
        field(3; "Quantity"; Integer)
        {
            Caption = 'Quantity';
        }
        field(4; Approved; Boolean)
        {
            Caption = 'Approved';

            trigger OnValidate()
            var
                AbsenceFIll: Codeunit "Absence Fill";
                EmployeeA: Record Employee;
                Preko: Record "Cause of Absence";
                DateFind: Record date;
            begin

                IF Rec."Approved" = true then begin
                    IF "From Date" <> "To Date" then begin
                        EmployeeAbsence.SetFilter("Employee No.", '%1', "Employee No.");
                        EmployeeAbsence.SetFilter("From Date", '%1..%2', Rec."From Date", Rec."To Date");
                        EmployeeAbsence.SetFilter("Add Hours", '%1', false);
                        if EmployeeAbsence.FindFirst() then begin
                            /*WageSetup.Get();
                            if not (EmployeeAbsence."Cause of Absence Code" = WageSetup."Holiday Code") then
                                Error(Text005);*/
                            CauseOfAbsence.Reset();
                            EmployeeA.Get("Employee No.");
                            CauseOfAbsence.Get(EmployeeAbsence."Cause of Absence Code");
                            Preko.Get(Rec."Cause of Absence Code");
                            if (CauseOfAbsence.Holiday = false) and (EmployeeAbsence.Quantity >= EmployeeA."Hours In Day")
                            and (Preko."Added To Hour Pool" = false) then
                                Error(Text005);
                        end;
                    end;

                    IF "From Date" = "To Date" then begin
                        EmployeeAbsence.SetFilter("From Date", '%1', Rec."From Date");
                        EmployeeAbsence.SetFilter("Add Hours", '%1', false);
                        EmployeeAbsence.SetFilter("Employee No.", '%1', Rec."Employee No.");
                        if EmployeeAbsence.FindFirst() then begin

                            //??K
                            /*WageSetup.Get();
                            if not (EmployeeAbsence."Cause of Absence Code" = WageSetup."Holiday Code") then
                                Error(Text005);*/
                            CauseOfAbsence.Reset();
                            EmployeeA.get(Rec."Employee No.");
                            CauseOfAbsence.Get(EmployeeAbsence."Cause of Absence Code");
                            Preko.Get(Rec."Cause of Absence Code");

                            if (CauseOfAbsence.Holiday = false) and (Preko."Added To Hour Pool" = false)
                            and (EmployeeAbsence.Quantity >= EmployeeA."Hours In Day") then
                                Error(Text005);
                        end;
                    end;

                    EmployeeA.GET(Rec."Employee No.");
                    //Hours
                    AbsenceFIll.EmployeeAbsence("From Date", "To Date", EmployeeA, Rec."Cause of Absence Code", Rec.Hours);
                end;

                If Rec."Approved" = false then begin
                    EmployeeAbsence.SetFilter("Employee No.", "Employee No.");
                    EmployeeAbsence.SetFilter("From Date", '%1..%2', Rec."From Date", Rec."To Date");
                    EmployeeAbsence.SetFilter("Add Hours", '%1', false);
                    //iz kalendara ??e svaki postavljeni praznik imati u ??iframa izostanaka za holiday true
                    //dakle trebam ostaviti samo odsustva gdje je causeofabsence.holiday = false
                    if EmployeeAbsence.FindFirst() then
                        repeat
                            CauseOfAbsence.Reset();
                            CauseOfAbsence.Get(EmployeeAbsence."Cause of Absence Code");
                            if CauseOfAbsence.Holiday = false then
                                EmployeeAbsence.Delete();
                        until EmployeeAbsence.Next() = 0;
                    /*WageSetup.Get();
                    EmployeeAbsence.SetFilter("Cause of Absence Code", '<>%1', WageSetup."Holiday Code");
                    EmployeeAbsence.DeleteAll();*/
                end;

                if Hours = 0 then begin
                    if ("Cause of absence on-call" = true) and (Approved = true) then begin
                        DateFind.Reset();

                        CauseOfAbsence.Reset();
                        CauseOfAbsence.Get(rec."Cause of Absence Code");
                        if CauseOfAbsence.Weekend = false then
                            DateFind.SetFilter("Period No.", '<>%1 & <>%2', 6, 7);
                        DateFind.SetFilter("Period Type", '%1', DateFind."Period Type"::Date);
                        DateFind.SetFilter("Period Start", '%1..%2', "From Date", "To Date");
                        if DateFind.FindFirst() then begin
                            EmployeeA.GET(Rec."Employee No.");
                            Rec.Hours := EmployeeA."Hours In Day" * DateFind.Count;

                        end;






                    end;

                end;

            end;
        }
        field(5; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(6; "Description"; Code[50])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(7; "Cause of Absence Code"; Code[10])
        {
            Caption = 'Cause of Absence Code';
            TableRelation = "Cause of Absence";

            trigger OnValidate()
            begin
                IF Approved = true then
                    error(Text006);

                CauseOfAbsence.GET("Cause of Absence Code");
                "Cause of absence on-call" := CauseOfAbsence."Cause of Absence On-Call";
                Description := CauseOfAbsence.Description;
                VALIDATE("Unit of Measure Code", CauseOfAbsence."Unit of Measure Code");

                IF "From Date" = 0D then
                    Error(Text001);

                IF "To Date" = 0D then
                    ERROR(Text004);
            end;
        }
        field(8; "From Date"; Date)
        {
            Caption = 'From Date';

            trigger OnValidate()
            var
                Preko: Record "Cause of Absence";
            begin
                IF Approved = true then
                    error(Text006);

                IF "To Date" <> 0D THEN BEGIN
                    IF "From Date" = 0D THEN
                        ERROR(Text001);

                    IF "From Date" > "To Date" then
                        ERROR(Text002);
                    EmployeeAbsence.Reset();
                    EmployeeAbsence.SetFilter("Employee No.", '%1', "Employee No.");
                    EmployeeAbsence.SetFilter("From Date", '%1..%2', Rec."From Date", Rec."To Date");
                    EmployeeAbsence.SetFilter("Add Hours", '%1', false);

                    if EmployeeAbsence.FindFirst() then begin
                        /*WageSetup.Get();
                        if not (EmployeeAbsence."Cause of Absence Code" = WageSetup."Holiday Code") then
                            Error(Text005);*/
                        CauseOfAbsence.Get(EmployeeAbsence."Cause of Absence Code");
                        Preko.Get(Rec."Cause of Absence Code");

                        // EmployeeAbsence.SetFilter("Add Hours", '%1', false);
                        if (CauseOfAbsence.Holiday = false) and (Preko."Added To Hour Pool" = false) then
                            Error(Text005);
                    end;
                END;

            end;
        }
        field(9; "To Date"; Date)
        {
            Caption = 'To Date';
            trigger OnValidate()
            var
                Preko: Record "Cause of Absence";
            begin
                IF Approved = true then
                    error(Text006);

                IF "To Date" <> 0D THEN BEGIN
                    IF "From Date" = 0D THEN
                        ERROR(Text001);

                    IF "From Date" > "To Date" then
                        ERROR(Text003);

                    EmployeeAbsence.SetFilter("Employee No.", '%1', "Employee No.");
                    EmployeeAbsence.SetFilter("From Date", '%1..%2', Rec."From Date", Rec."To Date");
                    EmployeeAbsence.SetFilter("Add Hours", '%1', false);
                    if EmployeeAbsence.FindFirst() then begin
                        /*WageSetup.Get();
                        if not (EmployeeAbsence."Cause of Absence Code" = WageSetup."Holiday Code") then
                            Error(Text005);*/
                        CauseOfAbsence.Get(EmployeeAbsence."Cause of Absence Code");
                        Preko.Get(Rec."Cause of Absence Code");

                        if (CauseOfAbsence.Holiday = false) and (Preko."Added To Hour Pool" = false) then
                            Error(Text005);
                    end;

                END;
            end;
        }
        field(10; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF Approved = true then
                    error(Text006);

                Employee.GET("Employee No.");
                "First Name" := Employee."First Name";
                "Last Name" := Employee."Last Name";
            end;
        }

        field(11; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Human Resource Unit of Measure";

            trigger OnValidate()
            begin
                HumanResUnitOfMeasure.Get("Unit of Measure Code");
                "Qty. per Unit of Measure" := HumanResUnitOfMeasure."Qty. per Unit of Measure";
                Validate(Quantity);
            end;
        }

        field(12; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }

        field(13; "Hours"; Integer)
        {
            Caption = 'Hours';
        }
        field(14; "Cause of absence on-call"; Boolean)
        {
            Caption = 'Pripravnost';
        }

    }

    keys
    {
        key(PrimaryKey; "Employee No.", "Entry No.")
        {

        }
    }

    var
        HumanResUnitOfMeasure: Record "Human Resource Unit of Measure";
        CauseOfAbsence: Record "Cause of Absence";
        Employee: Record "Employee";
        BlockedErr: Label 'You cannot register absence because the employee is blocked due to privacy.';
        EmployeeAbsenceReg: Record "Employee Absence Reg";
        EmployeeAbsence: Record "Employee Absence";
        WageSetup: Record "Wage Setup";
        Text001: Label 'Starting Date field cannot be blank.';
        Text002: Label 'Starting Date field cannot be after Ending Date field.';
        Text003: Label 'Ending Date field cannot be before Starting Date field.';
        Text004: Label 'Ending Date field cannot be blank.';
        Text005: Label 'A leave for this period already exists.';
        Text006: Label 'Selected record has already been approved.';
        Text007: Label 'Cause of absence field cannot be blank.';
        VisibleHours: Boolean;

    trigger OnInsert()
    begin
        if rec."Cause of Absence Code" = '' then
            Error(Text007);

        EmployeeAbsenceReg.Reset();
        EmployeeAbsenceReg.SetCurrentKey("Entry No.");
        if EmployeeAbsenceReg.FindLast then
            "Entry No." := EmployeeAbsenceReg."Entry No." + 1
        else begin
            "Entry No." := 1;
        end;
    end;

    trigger OnDelete()
    begin
        if Rec.Approved = true then begin
            Error(Text006);
        end;
    end;
    //ED 01 END
}





