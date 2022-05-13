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
            begin

                /*IF Rec."Approved" = TRUE THEN BEGIN
                    Days := 3;
                    Employee.Get("Employee No.");
                    Quantity := Employee."Hours In Day" * Days;



                    //REPEAT
                    EmployeeAbsence.INIT;
                    Validate("Employee No.", Rec."Employee No.");
                    Validate("First Name", Rec."First Name");
                    Validate("Last Name", Rec."Last Name");
                    Validate("Cause of Absence Code", Rec."Cause of Absence Code");
                    Validate(Description, Rec.Description);
                    

                    //EmployeeAbsence."Real Date":=
                    EmployeeAbsence.Insert();
                    //UNTIL
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
                //VALIDATE("Unit of Measure Code", CauseOfAbsence."Unit of Measure Code");

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

                    /*Employee.Get("Employee No.");
                    Quantity := Employee."Hours In Day" * ("To Date" - "From Date");*/
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
                END;

                //Days := "To Date" - "From Date";
                /*  Days := 0;
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

                Days := 1;

                CalendarChange.Reset();

                //CalendarChange.SetFilter(CalendarChange.Date, '%1..%2', Format(EmployeeAbsenceReg."From Date"), Format(EmployeeAbsenceReg."To Date"));
                CalendarChange.SetFilter(CalendarChange.Date, '%1..%2', EmployeeAbsenceReg."From Date", EmployeeAbsenceReg."To Date");
                //CalendarChange.SetFilter(CalendarChange.Nonworking, '%1', false);

                //CustomizedCalendarChange.SETRANGE(CustomizedCalendarChange.Date, "From Date", "To Date");

                /*CustomizedCalendarChange.SETFILTER(CustomizedCalendarChange.Date, '>=%1', "From Date");
                CustomizedCalendarChange.SETFILTER(CustomizedCalendarChange.Date, '<=%1', "To Date");*/


                if CalendarChange.FindFirst() then begin
                    Days := CalendarChange.Count;
                end;

                /*CalendarChange.Reset();
                if CalendarChange.FindSet() then
                    repeat

                        Message(Format(CalendarChange.Day));
                    until CalendarChange.Next() = 0;*/

                Employee.Get("Employee No.");
                Quantity := Employee."Hours In Day" * Days;

                //treba otici u table CalendarChange - stavljena u var gdje je boolean field Nonworking



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

    }

    keys
    {
        key(PrimaryKey; "Employee No.", "Entry No.")
        {
            //Clustered = TRUE;
        }
    }

    var
        Days: Integer;
        LoopDate: Date;
        CustomizedCalendarChange: Record "Customized Calendar Change";
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





