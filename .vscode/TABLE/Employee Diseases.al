table 50064 "Employee Diseases"
{
    Caption = 'Employee Diseases';
    DrillDownPageID = "Employee Diseases";
    LookupPageID = "Employee Diseases";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            TableRelation = "Types Of Diseases".Code;

            trigger OnValidate()
            begin
                TypesOfDiseases.RESET;
                TypesOfDiseases.SETFILTER(Code, Code);
                IF TypesOfDiseases.FINDFIRST THEN
                    "Disease Name" := TypesOfDiseases.Description
                ELSE
                    "Disease Name" := '';
            end;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";
        }
        field(3; "Disease Name"; Text[50])
        {
            Caption = 'Disease Name';
            Editable = false;
        }
        field(41; "Employee Name"; Text[81])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Employee Name" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Employee Name';

        }
        field(42; "Sector Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Sector Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Sector';
            Editable = false;

        }
        field(43; "Group Name"; Text[250])
        {
            CalcFormula = Lookup("Employee Contract Ledger"."Group Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Group';
            Editable = false;
            FieldClass = FlowField;
        }
        field(45; "Team Name"; Text[250])
        {
            CalcFormula = Lookup("Employee Contract Ledger"."Team Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Team';
            Editable = false;
            FieldClass = FlowField;
        }
        field(46; "Department Name"; Text[250])
        {
            CalcFormula = Lookup("Employee Contract Ledger"."Department Cat. Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Department Category Description';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code", "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'LEGAL' THEN
                ERROR('Rola "Legal" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;
    end;

    trigger OnInsert()
    begin
        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'LEGAL' THEN
                ERROR('Rola "Legal" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;
    end;

    trigger OnModify()
    begin
        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'LEGAL' THEN
                ERROR('Rola "Legal" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;
    end;

    trigger OnRename()
    begin
        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'LEGAL' THEN
                ERROR('Rola "Legal" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;
    end;

    var
        TypesOfDiseases: Record "Types Of Diseases";
        UserPersonalization: Record "User Personalization";
}

