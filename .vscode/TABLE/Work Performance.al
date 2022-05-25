table 50099 "Work performance"
//ED 01 START
{
    Caption = 'Work performance';
    DrillDownPageID = "Work performance";
    LookupPageID = "Work performance";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                /*IF Approved = true then
                    error(Text006);*/

                Employee.GET("Employee No.");
                "First Name" := Employee."First Name";
                "Last Name" := Employee."Last Name";
            end;
        }
        field(3; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(4; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
        }
        field(5; "Quality of performed work"; Option)
        {
            Caption = 'Quality of performed work';
            OptionCaption = '1,2,3,4,5';
            OptionMembers = "1","2","3","4","5";
        }
        field(6; "Scope of performed work"; Option)
        {
            Caption = 'Scope of performed work';
            OptionCaption = '1,2,3,4,5';
            OptionMembers = "1","2","3","4","5";
        }
        field(7; "Deadline for completion of work"; Option)
        {
            Caption = 'Deadline for completion of work';
            OptionCaption = '1,2,3,4,5';
            OptionMembers = "1","2","3","4","5";
        }
        field(8; "Attitude towards work obligations"; Option)
        {
            Caption = 'Attitude towards work obligations';
            OptionCaption = '1,2,3,4,5';
            OptionMembers = "1","2","3","4","5";
        }
        field(9; "Grade"; Decimal)
        {
            Caption = 'Grade';
        }
        field(10; "Increase in basic salary(%)"; Integer)
        {
            Caption = 'Increase in basic salary(%)';
        }
        field(11; Approved; Boolean)
        {
            Caption = 'Approved';
        }






        /*field(3; "Quantity"; Integer)
        {
            Caption = 'Quantity';
        }
        field(4; Approved; Boolean)
        {
            Caption = 'Approved';

            trigger OnValidate()
            var
            /*AbsenceFIll: Codeunit "Absence Fill";
            EmployeeA: Record Employee;*/
        //begin

        /*IF Rec."Approved" = true then begin
            IF "From Date" <> "To Date" then begin
                EmployeeAbsence.SetFilter("Employee No.", '%1', "Employee No.");
                EmployeeAbsence.SetFilter("From Date", '%1..%2', Rec."From Date", Rec."To Date");
                if EmployeeAbsence.FindFirst() then begin

                    CauseOfAbsence.Reset();
                    CauseOfAbsence.Get(EmployeeAbsence."Cause of Absence Code");
                    if CauseOfAbsence.Holiday = false then
                        Error(Text005);
                end;
            end;

            IF "From Date" = "To Date" then begin
                EmployeeAbsence.SetFilter("From Date", '%1', Rec."From Date");
                if EmployeeAbsence.FindFirst() then begin

                    CauseOfAbsence.Reset();
                    CauseOfAbsence.Get(EmployeeAbsence."Cause of Absence Code");
                    if CauseOfAbsence.Holiday = false then
                        Error(Text005);
                end;
            end;

            EmployeeA.GET(Rec."Employee No.");
            AbsenceFIll.EmployeeAbsence("From Date", "To Date", EmployeeA, Rec."Cause of Absence Code");
        end;

        If Rec."Approved" = false then begin
            EmployeeAbsence.SetFilter("Employee No.", "Employee No.");
            EmployeeAbsence.SetFilter("From Date", '%1..%2', Rec."From Date", Rec."To Date");

            if EmployeeAbsence.FindFirst() then
                repeat
                    CauseOfAbsence.Reset();
                    CauseOfAbsence.Get(EmployeeAbsence."Cause of Absence Code");
                    if CauseOfAbsence.Holiday = false then
                        EmployeeAbsence.Delete();
                until EmployeeAbsence.Next() = 0;

        end;*/

        /*end;
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
        begin
            IF Approved = true then
                error(Text006);

            IF "To Date" <> 0D THEN BEGIN
                IF "From Date" = 0D THEN
                    ERROR(Text001);

                IF "From Date" > "To Date" then
                    ERROR(Text002);

                if EmployeeAbsence.FindFirst() then begin

                    CauseOfAbsence.Get(EmployeeAbsence."Cause of Absence Code");
                    if CauseOfAbsence.Holiday = false then
                        Error(Text005);
                end;
            END;

        end;
    }
    field(9; "To Date"; Date)
    {
        Caption = 'To Date';
        trigger OnValidate()
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
                if EmployeeAbsence.FindFirst() then begin

                    CauseOfAbsence.Get(EmployeeAbsence."Cause of Absence Code");
                    if CauseOfAbsence.Holiday = false then
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
    }*/
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
        /*if rec."Cause of Absence Code" = '' then
            Error(Text007);

        EmployeeAbsenceReg.Reset();
        EmployeeAbsenceReg.SetCurrentKey("Entry No.");
        if EmployeeAbsenceReg.FindLast then
            "Entry No." := EmployeeAbsenceReg."Entry No." + 1
        else begin
            "Entry No." := 1;
        end;*/
    end;

    trigger OnDelete()
    begin

    end;
    //ED 01 END
}





