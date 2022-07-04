tableextension 51921 MyExtension extends "Employee Absence"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "RS Code"; Code[20])
        {
            Caption = 'RS Code';
        }
        field(50001; "Statistics Group Code"; Code[20])
        {
            Caption = 'Statistics Group Code';
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
        }
        field(50003; "Vacation from Year"; Integer)
        {
            Caption = 'Vacation from Year';

        }
        field(50004; "First Name"; Text[30])
        {
            Caption = 'First Name';
            Editable = false;
        }
        field(50005; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
            Editable = false;
        }
        field(50126; "Department Code"; Code[50])
        {
            Caption = 'Department Code';
            Editable = true;
        }
        field(50127; Calculated; Boolean)
        {
            Caption = 'Calculated';
        }
        field(50128; "Wage Calculation No."; Code[20])
        {
            Caption = 'Wage Calculaion No.';
        }
        field(50129; "Wage Header No."; Code[20])
        {
            Caption = 'Wage Header No.';
        }
        field(50130; "Cause of Absence Subtype Code"; Code[50])
        {
            Caption = 'Cause of Absence Subtype Code';

            trigger OnValidate()
            begin
                /*COAS.GET("Cause of Absence Code",Rec."Cause of Absence Subtype Code");
                "Cause of Absence Subtype Desc" := COAS.Description;*/

            end;
        }
        field(50131; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            Editable = true;
            FieldClass = Normal;
        }
        field(50132; "B-1 Description"; Text[250])
        {
            Caption = 'B-1 Description';
            Editable = true;
            FieldClass = Normal;
        }
        field(50133; "B-1 (with regions) Description"; Text[250])
        {
            Caption = 'B-1 (with regions) Description';
            Editable = true;
            FieldClass = Normal;
        }
        field(50134; "Stream Description"; Text[250])
        {
            Caption = 'Stream Description';
            Editable = true;
            FieldClass = Normal;
        }
        field(50135; "Cause of Absence Subtype Desc"; Text[250])
        {
            CalcFormula = Lookup("Cause of Absence Subtype".Description WHERE(Code = FIELD("Cause of Absence Subtype Code")));
            Caption = 'Cause of Absence Subtype Desc';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50136; "Full Name"; Text[250])
        {
            Caption = 'Full Name';
        }
        field(50137; "Cause of Absence Subtype Corr."; Code[50])
        {
            Caption = 'Cause of Absence Subtype Code -Corr.';
            NotBlank = false;

            trigger OnValidate()
            begin
                /*COAS.GET("Cause of Absence Code",Rec."Cause of Absence Subtype Code");
                "Cause of Absence Subtype Desc" := COAS.Description;*/

            end;
        }
        field(50138; "Real Date"; Date)
        {
            Caption = 'Real Date';
            NotBlank = false;
        }
        field(50139; "Cause of Absence Code Corr."; Code[50])
        {
            Caption = 'Cause of Absence Code';
            TableRelation = "Cause of Absence";

            trigger OnValidate()
            begin
                CauseOfAbsence.GET("Cause of Absence Code");
                Description := CauseOfAbsence.Description;
                VALIDATE("Unit of Measure Code", CauseOfAbsence."Unit of Measure Code");
                VALIDATE("Short Code Corrections", CauseOfAbsence."Short Code");
            end;
        }
        field(50140; Status; enum "Employee Abs ")
        {
            Caption = 'Status';


        }
        field(50141; "Order"; Integer)
        {
        }
        modify("From Date")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                VacationSetup: Record "Vacation Setup";
            begin

                if "Cause of Absence Code" = VacationSetup."Vacation Code" then
                    "Vacation from Year" := Date2DMY("From Date", 3);
                if "Cause of Absence Code" = VacationSetup."Vacation Code Last Year" then
                    "Vacation from Year" := Date2DMY("From Date", 3) - 1;



            end;
        }

        field(50142; "Short Code"; Code[10])
        {
            Caption = 'Short Code';
            TableRelation = "Cause of Absence"."Short Code";
        }
        field(50143; "Short Code Corrections"; Code[10])
        {
            Caption = 'Short Code Corrections';
            TableRelation = "Cause of Absence"."Short Code";
        }
        field(50144; "Correction Resumed"; Boolean)
        {
            Caption = 'Correction Resumed';
        }
        field(50145; "Comment 2"; Text[250])
        {
            Caption = 'Comment';
        }
        field(50146; "Old Wage Base"; Boolean)
        {
            Caption = 'Old Wage Base';
        }
        field(50147; "Correction Quantity"; Integer)
        {
            Caption = 'Correction Resumed';
        }
        field(50148; Approved; Boolean)
        {
            Caption = 'Approved';
        }

        field(50149; "Bound to Year"; Integer)
        {
            Caption = 'Bound to Year';
        }

        field(50150; "Work Type"; Option)
        {
            Caption = 'Work Type';
            OptionMembers = " ","Vacation";
        }
        field(50151; "Add Hours"; Boolean)
        {
            Caption = 'Add Hours';
            FieldClass = FlowField;
            CalcFormula = lookup("Cause of Absence"."Add Hours" where(Code = field("Cause of Absence Code")));
        }







        modify("Cause of Absence Code")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
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



        }











    }


    var
        myInt: Integer;
        CauseOfAbsence: Record "Cause of Absence";
        Employee: Record "Employee";
}