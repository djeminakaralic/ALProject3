table 50099 "Work Performance"
//ED 01 START
{
    Caption = 'Work Performance';
    DrillDownPageID = "Work Performance";
    LookupPageID = "Work Performance";

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
            OptionMembers = "1","2","3","3.5","4","4.5","5";

            trigger OnValidate()
            begin
                Grade := ("Quality of performed work" + "Scope of performed work" + "Deadline for completion of work" + "Attitude towards work obligations" + 4) / 4;
                CalculateIncrease(Rec."Quality of performed work", Rec."Scope of performed work", Rec."Deadline for completion of work", Rec."Attitude towards work obligations", Rec.Grade);
            end;
        }
        field(6; "Scope of performed work"; Option)
        {
            Caption = 'Scope of performed work';
            OptionMembers = "1","2","3","3.5","4","4.5","5";

            trigger OnValidate()
            begin
                Grade := ("Quality of performed work" + "Scope of performed work" + "Deadline for completion of work" + "Attitude towards work obligations" + 4) / 4;
                CalculateIncrease(Rec."Quality of performed work", Rec."Scope of performed work", Rec."Deadline for completion of work", Rec."Attitude towards work obligations", Rec.Grade);
            end;
        }
        field(7; "Deadline for completion of work"; Option)
        {
            Caption = 'Deadline for completion of work';
            OptionMembers = "1","2","3","3.5","4","4.5","5";

            trigger OnValidate()
            begin
                Grade := ("Quality of performed work" + "Scope of performed work" + "Deadline for completion of work" + "Attitude towards work obligations" + 4) / 4;
                CalculateIncrease(Rec."Quality of performed work", Rec."Scope of performed work", Rec."Deadline for completion of work", Rec."Attitude towards work obligations", Rec.Grade);
            end;
        }
        field(8; "Attitude towards work obligations"; Option)
        {
            Caption = 'Attitude towards work obligations';
            OptionMembers = "1","2","3","3.5","4","4.5","5";

            trigger OnValidate()
            begin
                Grade := ("Quality of performed work" + "Scope of performed work" + "Deadline for completion of work" + "Attitude towards work obligations" + 4) / 4;
                CalculateIncrease(Rec."Quality of performed work", Rec."Scope of performed work", Rec."Deadline for completion of work", Rec."Attitude towards work obligations", Rec.Grade);
            end;
        }
        field(9; "Grade"; Decimal)
        {
            Caption = 'Grade';
        }
        field(10; "Increase in basic salary(%)"; Decimal)
        {
            Caption = 'Increase in basic salary(%)';
        }
        field(11; Approved; Boolean)
        {
            Caption = 'Approved';

            trigger OnValidate()
            begin
                if Approved then begin

                end;
            end;
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
    */
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

    procedure CalculateIncrease(CurrQuality: Integer; CurrScope: Integer; CurrDeadline: Integer; CurrAttitude: Integer; CurrGrade: Decimal)
    begin
        if CurrQuality <= 2 then
            Rec."Increase in basic salary(%)" := 0
        else
            if CurrScope <= 2 then
                Rec."Increase in basic salary(%)" := 0
            else
                if CurrDeadline <= 2 then
                    Rec."Increase in basic salary(%)" := 0
                else
                    if CurrAttitude <= 2 then
                        Rec."Increase in basic salary(%)" := 0
                    else
                        Rec."Increase in basic salary(%)" := (CurrGrade - 3) * 10;
    end;
    //ED 01 END
}





