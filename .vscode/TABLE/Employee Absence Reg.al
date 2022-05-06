table 50104 "Employee Absence Reg"
{
    Caption = 'Sample table';
    //DataPerCompany = true;
    //DrillDownPageID = "Employee Absence";
    //LookupPageID = "Employee Absence";

    fields
    {

        field(1; "First Name"; Text[30])
        {
            Caption = 'First Name';
            Editable = false;
        }

        field(2; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
            Editable = false;
        }

        field(3; "Days"; Integer)
        {
        }

        field(4; Approved; Boolean)
        {
            Caption = 'Approved';
        }

        field(5; "Bound to Year"; Integer)
        {
            Caption = 'Bound to Year';
        }

        field(6; "Description"; Code[50])
        {
            Caption = 'Description';
        }

        field(7; "Cause of Absence Code"; Code[10])
        {
            Caption = 'Cause of Absence Code';
            TableRelation = "Cause of Absence";

            /*trigger OnValidate()
            begin
                CauseOfAbsence.GET("Cause of Absence Code");
                Description := CauseOfAbsence.Description;
                VALIDATE("Unit of Measure Code", CauseOfAbsence."Unit of Measure Code");
                VALIDATE("Short Code Corrections", CauseOfAbsence."Short Code");
            end;*/
        }

        field(8; "From Date"; Date)
        {
            Caption = 'From Date';
            NotBlank = false;
        }

        field(9; "To Date"; Date)
        {
            Caption = 'To Date';
            NotBlank = false;
        }

        field(10; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = false;
            TableRelation = Employee."No.";
        }

        field(11; "Quantity"; Integer)
        {
            Caption = 'Quantity';
        }


    }

    keys
    {
        key(PrimaryKey; "Employee No.", "Cause of Absence Code")
        {
            //Clustered = TRUE;
        }
    }

    var
        Msg: Label 'Hello from my method';
        CauseOfAbsence: Record "Cause of Absence";

    procedure MyMethod();
    begin
        Message(Msg);
    end;


    /*modify("Cause of Absence Code")
    {
        trigger OnAfterValidate()
            var myInt: Integer;
            begin
                CauseOfAbsence.reset();
                CauseOfAbsence.SetFilter(Code, '%1', "Cause of Absence Code");
                if CauseOfAbsence.FindFirst() then begin
                    "Short Code" := CauseOfAbsence."Short Code";
                end
                else begin
                    "Short Code" := '';
                end;
            end;
    }*/



}