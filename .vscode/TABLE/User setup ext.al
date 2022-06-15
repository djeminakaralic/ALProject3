tableextension 50179 User_setup_ext extends "User Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "User Name"; Code[50])
        {
            Caption = 'User Name';
        }
        field(50001; "Date for Training"; Date)
        {
            Caption = 'Date for Training';
        }
        field(50002; "Employee No."; code[20])
        {
            Caption = 'Employee No.';
        }
        field(50003; "UserEmp"; Code[20])
        {

        }
        field(50004; Slovo; Text[250])
        {

        }
        field(50005; "Slovo 2"; Text[250])
        {

        }
        field(50006; "Red"; Text[250])
        {

        }
        field(50007; Final; Text[250])
        {

        }
        field(50070; "Delete Wage"; Boolean)
        {
            Caption = 'Moguće obrisati obračun nakon knjiženja!';
        }
        field(5001; "Wage Allowed"; Boolean)
        {
            Caption = 'Wage Allowed';
        }
        field(5002; "Open Value"; Text[250])
        {

        }


    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        myInt: Integer;
        UserSetup: Record "User Setup";

    begin

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', USERID);
        if UserSetup.FindFirst() then begin
            Rec."Employee No." := UserSetup.UserEmp;

        end;
    end;

    trigger OnModify()
    var
        myInt: Integer;
        UserSetup: Record "User Setup";

    begin

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', USERID);
        if UserSetup.FindFirst() then begin
            Rec."Employee No." := UserSetup.UserEmp;
        end;
    end;

}