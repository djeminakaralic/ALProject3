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
                    EmployeeA.GET(Rec."Employee No.");
                    AbsenceFIll.FillAbsence2("From Date", "To Date", EmployeeA);
                end;

                If Rec."Approved" = false then begin

                    EmployeeAbsence.SetFilter("Employee No.", "Employee No.");
                    EmployeeAbsence.SetFilter("From Date", '%1..%2', Rec."From Date", Rec."To Date");
                    EmployeeAbsence.DeleteAll();
                end;


                //test da li ovdje trebam prebaciti u novu tabelu
                /*Days := 3;
                Employee.Get("Employee No.");
                Quantity := Employee."Hours In Day" * Days;*/

                /*HelpDate := "From Date";                 
                REPEAT
                //ovdje provjeriti je li datum radni dan ili neradni,ako je radni spremiti u tabelu + razlog izostanka spremiti u polje Cause of absence code
                    EmployeeAbsence.INIT;
                    Validate("Employee No.", Rec."Employee No.");
                    Validate("First Name", Rec."First Name");
                    Validate("Last Name", Rec."Last Name");
                    Validate("Cause of Absence Code", Rec."Cause of Absence Code");
                    Validate(Description, Rec.Description);

                    EmployeeAbsence."Real Date" := HelpDate;
                    HelpDate += 1;

                    EmployeeAbsence.Insert();
                UNTIL HelpDate = "To Date";*/


                /*IF Rec."Approved" = false THEN BEGIN
                    EmployeeAbsence.SetFilter("Employee No.", "Employee No.");

                    EmployeeAbsence.SetFilter("Cause of Absence Code", "Cause of Absence Code");
                    IF EmployeeAbsence.FindFirst() then begin
                        EmployeeAbsence.DeleteAll();
                    end;

                END;*/

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

                    EmployeeAbsence.SetFilter("From Date", '%1..%2', Rec."From Date", Rec."To Date");
                    if EmployeeAbsence.FindFirst() then
                        Error(Text005);
                END;

                //Days := "To Date" - "From Date";
                /* Days := 0;
                  LoopDate := "From Date";
                  Employee.Get("Employee No.");
                  IF "From Date" = "To Date" then begin
                      Quantity := Employee."Hours In Day";
                  end
                  ELSE begin
                      LoopDate := "From Date";
                      repeat
                      BaseCalendarChange.Reset();
                          BaseCalendarChange.SetCurrentKey(Date);
                          BaseCalendarChange.Get(LoopDate);
                          If BaseCalendarChange.Nonworking = false then
                              Days := Days + 1;
                          LoopDate := LoopDate + 1;
                      until LoopDate > "To Date";
                      Quantity := Employee."Hours In Day" * Days;
                  end;*/


                /*CustomizedCalendarChange.Reset();

                CustomizedCalendarChange.SetFilter(CustomizedCalendarChange.Date, '%1..%2', Rec."From Date", Rec."To Date");
                CustomizedCalendarChange.SetFilter(CustomizedCalendarChange.Nonworking, '%1', false);
                Days := CustomizedCalendarChange.Count;

                /*if CustomizedCalendarChange.FindFirst() then begin 
                    Message(Format(CustomizedCalendarChange.Day));
                    Days := CustomizedCalendarChange.Count;
                end;*/

                /*Employee.Get("Employee No.");
                Quantity := Employee."Hours In Day" * Days;

                //CustomizedCalendarChange.SETRANGE(CustomizedCalendarChange.Date, "From Date", "To Date");

                /*CustomizedCalendarChange.SETFILTER(CustomizedCalendarChange.Date, '>=%1', "From Date");
                CustomizedCalendarChange.SETFILTER(CustomizedCalendarChange.Date, '<=%1', "To Date");*/

                /*CalendarChange.Reset();
                if CalendarChange.FindSet() then
                    repeat

                        Message(Format(CalendarChange.Day));
                    until CalendarChange.Next() = 0;*/

                //treba otici u table gdje je boolean field Nonworking

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
            //Clustered = TRUE;
        }
    }

    var
        HelpDate: Date;
        HumanResUnitOfMeasure: Record "Human Resource Unit of Measure";
        CalendarManagement: Codeunit "Calendar Management";
        Days: Integer;
        WorkingDays: Integer;
        NonWorkingDays: Integer;
        LoopDate: Date;
        CompanyInformation: Record "Company Information";
        CustomizedCalendarChange: Record "Customized Calendar Change";
        CheckDate: Date;
        Calendar: Record "Base Calendar";
        CalendarChange: Record "Base Calendar Change";
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

    trigger OnInsert()
    begin
        EmployeeAbsenceReg.Reset();
        EmployeeAbsenceReg.SetCurrentKey("Entry No.");
        if EmployeeAbsenceReg.FindLast then
            "Entry No." := EmployeeAbsenceReg."Entry No." + 1
        else begin
            "Entry No." := 1;
        end;
    end;
}





