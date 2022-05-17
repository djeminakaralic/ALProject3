table 50104 "Employee Absence Reg"
{
    Caption = 'Sample table';
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
            begin

                IF Rec."Approved" = true then begin
                    IF "From Date" <> "To Date" then begin
                        EmployeeAbsence.SetFilter("Employee No.", '%1', "Employee No.");
                        EmployeeAbsence.SetFilter("From Date", '%1..%2', Rec."From Date", Rec."To Date");
                        if EmployeeAbsence.FindFirst() then
                            Error(Text005);
                    end;

                    IF "From Date" = "To Date" then begin
                        EmployeeAbsence.SetFilter("From Date", '%1', Rec."From Date");
                        if EmployeeAbsence.FindFirst() then
                            Error(Text005);
                    end;

                    EmployeeA.GET(Rec."Employee No.");
                    AbsenceFIll.FillAbsence2("From Date", "To Date", EmployeeA, Rec."Cause of Absence Code");
                end;

                If Rec."Approved" = false then begin
                    EmployeeAbsence.SetFilter("Employee No.", "Employee No.");
                    EmployeeAbsence.SetFilter("From Date", '%1..%2', Rec."From Date", Rec."To Date");
                    EmployeeAbsence.DeleteAll();
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

                IF "To Date" <> 0D THEN BEGIN
                    IF "From Date" = 0D THEN
                        ERROR(Text001);

                    IF "From Date" > "To Date" then
                        ERROR(Text002);

                    EmployeeAbsence.SetFilter("Employee No.", '%1', "Employee No.");
                    EmployeeAbsence.SetFilter("From Date", '%1..%2', Rec."From Date", Rec."To Date");
                    if EmployeeAbsence.FindFirst() then
                        Error(Text005);
                END;

            end;
        }
        field(9; "To Date"; Date)
        {
            Caption = 'To Date';
            trigger OnValidate()
            begin

                IF "To Date" <> 0D THEN BEGIN
                    IF "From Date" = 0D THEN
                        ERROR(Text001);

                    IF "From Date" > "To Date" then
                        ERROR(Text003);

                    EmployeeAbsence.SetFilter("Employee No.", '%1', "Employee No.");
                    EmployeeAbsence.SetFilter("From Date", '%1..%2', Rec."From Date", Rec."To Date");
                    if EmployeeAbsence.FindFirst() then
                        Error(Text005);
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
        Text001: Label 'Starting Date field cannot be blank.';
        Text002: Label 'Starting Date field cannot be after Ending Date field.';
        Text003: Label 'Ending Date field cannot be before Starting Date field.';
        Text004: Label 'Ending Date field cannot be blank.';
        Text005: Label 'A leave for this period already exists.';
        Text006: Label 'Selected record has already been approved.';
        Text007: Label 'Cause of absence field cannot be blank.';

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
            /*EmployeeAbsence.SetFilter("Employee No.", "Employee No.");
            EmployeeAbsence.SetFilter("From Date", '%1..%2', Rec."From Date", Rec."To Date");
            EmployeeAbsence.DeleteAll();*/
            Error(Text006);
        end;
    end;
}





