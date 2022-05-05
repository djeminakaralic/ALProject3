table 50959 "Employee Absence Registration"
{
    Caption = 'Employee Absence Registration';
    DataCaptionFields = "Employee No.";
    DrillDownPageID = 51129;
    LookupPageID = 51129;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;
        }
        field(2; "First Name"; Text[30])
        {
            Caption = 'First Name';
            Editable = false;
        }

        field(3; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
            Editable = false;
        }

        field(4; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(5; "To Date"; Date)
        {
            Caption = 'To Date';
        }

        field(6; Approved; Boolean)
        {
            Caption = 'Approved';
        }

        field(7; "Cause of Absence Code"; Code[50])
        {
            Caption = 'Cause of Absence Code';

            trigger OnValidate()
            begin

            end;
        }

        field(8; "Quantity"; Integer)
        {
            Caption = 'Line No.';
        }
        field(9; Description; Text[50])
        {
            Caption = 'Description';
        }

        /*field(7; "In Use"; Boolean)
        {
            Caption = 'In Use';
        }
        
        field(9; "Serial No."; Text[30])
        {
            Caption = 'Serial No.';
        }
        field(50000; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(50001; "Position Code"; Code[20])
        {
            Caption = 'Position Code';
        }
        field(50002; "Emp. Contract Ledg. Entry No."; Integer)
        {
            AutoIncrement = false;
            Caption = 'Emp. Contract Ledg. Entry No.';
        }*/
    }

    keys
    {
        key(Key1; "Employee No.")
        {
        }
    }

    fieldgroups
    {

    }

    trigger OnDelete()
    begin

    end;

    trigger OnInsert()
    begin

    end;
    /*var
        MiscArticleInfo: Record "Misc. Article Information";
    begin
        MiscArticleInfo.SETCURRENTKEY("Line No.");
        IF MiscArticleInfo.FINDLAST THEN
            "Line No." := MiscArticleInfo."Line No." + 1
        ELSE
            "Line No." := 1;
    end;*/

    //var
    /*Text000: Label 'You cannot delete information if there are comments associated with it.';
    MiscArticle: Record "Misc. Article";*/
}
