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
                END;

                Employee.Get("Employee No.");
                Quantity := Employee."Hours In Day" * ("To Date" - "From Date");

            end;
        }
        field(9; "To Date"; Date)
        {
            Caption = 'To Date';
            trigger OnValidate()
            begin
                //IF (xRec."To Date" <> "To Date") AND ("To Date" <> 0D) THEN
                //FillHours(FIELDNO("To Date"));

                /*IF "To Date" < "From Date" THEN
                    FIELDERROR("To Date");?*/

                IF "To Date" <> 0D THEN BEGIN
                    IF "From Date" = 0D THEN
                        ERROR(Text001);

                    IF "From Date" > "To Date" then
                        ERROR(Text003);
                END;

                Employee.Get("Employee No.");
                Quantity := Employee."Hours In Day" * ("To Date" - "From Date");

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
        CauseOfAbsence: Record "Cause of Absence";
        Employee: Record "Employee";
        BlockedErr: Label 'You cannot register absence because the employee is blocked due to privacy.';
        EmployeeAbsence: Record "Employee Absence Reg";
        Text001: Label 'Starting Date field cannot be blank.';
        Text002: Label 'Starting Date field cannot be after Ending Date field.';
        Text003: Label 'Ending Date field cannot be before Starting Date field.';

    trigger OnInsert()
    begin
        EmployeeAbsence.Reset();
        EmployeeAbsence.SetCurrentKey("Entry No.");
        if EmployeeAbsence.FindLast then
            "Entry No." := EmployeeAbsence."Entry No." + 1
        else begin
            "Entry No." := 1;
        end;
    end;
}





