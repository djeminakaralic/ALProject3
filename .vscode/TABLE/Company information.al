tableextension 51190 CompanyInfExt extends "Company Information"
{
    fields
    {
        // Add changes to table fields here





        field(50000; "Bank No. 1"; Code[10])
        {
            Caption = 'Bank No. 1';
            TableRelation = "Bank Account";
        }
        field(50001; "Bank No. 2"; Code[10])
        {
            Caption = 'Bank No. 2';
        }
        field(50002; "Bank No. 3"; Code[10])
        {
            Caption = 'Bank No. 3';
        }
        field(50003; "Bank No. 4"; Code[10])
        {
            Caption = 'Bank No. 4';
        }
        field(50004; "Municipality Code"; Code[10])
        {
            Caption = 'Municipality Code';
            TableRelation = Municipality;

            trigger OnValidate()
            begin
                IF Municipality.GET("Municipality Code")
                  THEN
                    "Municipality Name" := Municipality.Name;
            end;
        }
        field(50005; "Buss. Scope Description"; Text[80])
        {
            Caption = 'Buss. Scope Description';
        }
        field(50006; "Entity Code"; Code[10])
        {
            Caption = 'Entity Code';
            TableRelation = Entity;
        }
        field(50007; "Employees No."; Integer)
        {
            Caption = 'Employees No.';
        }
        field(50118; CEO; Text[100])
        {
            Caption = 'CEO';
        }
        field(50119; "Employee No."; Code[10])
        {
            TableRelation = Employee."No.";
        }
        field(50120; "Employeess No."; Code[10])
        {
        }
        field(50011; "Municipality Name"; Text[30])
        {
            Caption = 'Municipality name';
            TableRelation = Municipality.Name;
        }
        field(50012; "Code"; Text[30])
        {
            Caption = 'Code';
        }
        field(50013; MBS; Code[50])
        {
        }
        field(50014; "Operater No"; Text[250])
        {
            Caption = 'Operater No';
        }
        field(50015; "Operater E-mail"; Text[250])
        {
            Caption = 'Operater E-mail';
        }
        field(50016; "Prefix for JS"; Text[250])
        {
            Caption = 'Prefix for JS';
        }
        field(50017; "Company Prefix"; Text[100])
        {
            Caption = 'Company Prefix';
        }
        field(50018; Timezone; Integer)
        {
            Caption = 'Timezone';
        }
        field(50019; "Country Prefix"; Text[100])
        {
            Caption = 'Country Prefix';
        }
        field(50020; "Location ID 1"; Text[100])
        {
            Caption = 'Location ID 1';
        }
        field(50021; "Location ID 2"; Text[100])
        {
            Caption = 'Location ID 2';
        }
        field(50022; "Path for export GPS files"; Text[100])
        {
            Caption = 'Path for export GPS files';
        }
        field(50023; "Location ID 1 Code"; Text[100])
        {
            Caption = 'Location ID 1 Code';
        }
        field(50024; "Location ID 2 Code"; Text[100])
        {
            Caption = 'Location ID 2 Code';
        }
        field(50025; "Country Code"; Text[30])
        {
            Caption = 'Country Code';
        }
        field(50026; "Portal"; Boolean)
        {
            Caption = 'Portal';
        }
        field(50008; "Country Name"; Text[50])
        {
            Caption = 'Country Name';
            Editable = false;
        }
        field(50077; "Ekstenzija za e-mail"; Text[1000])
        {

        }
        field(50009; "Chief Executive (Sign.)"; Text[50])
        {
            Caption = 'Chief Executive (Sign.)';
        }
        field(50010; "Assistant Chief Exec. (Sign.)"; Text[50])
        {
            Caption = 'Assistant Chief Exec. (Sign.)';
        }
        field(52015725; "National Classification Number"; Text[30])
        {
            Caption = 'National Classification Number';
            Description = 'SKHR7.00';
        }
        field(52015726; "Note 1"; Text[2000])
        {
            Caption = 'Note 1 for INO customer';
        }
        field(520157267; "Note 2"; Text[2000])
        {
            Caption = 'Note 2 for Sales Header';
        }
        field(520157268; "Path for Documents"; Text[1000])
        {
            Caption = 'Path for Documents';
        }
        field(520157269; "Universal Value for CR"; Text[1000])
        {
            Caption = 'Universal Value for CR';
        }
        field(520157270; "Universal Value for OC"; Text[1000])
        {
            Caption = 'Universal Value for Order Confirmation';
        }
        field(520157271; "Sender Name"; Text[1000])
        {
            Caption = 'Sender';
        }
        field(520157272; "Path Value"; Text[1000])
        {
            Caption = 'Path Value';
        }
        field(520157273; "Logs"; integer)
        {
            Caption = 'KIF/KUF Logs';
            FieldClass = FlowField;
            CalcFormula = count("KIF/KUF Log");

        }
    }

    var
        myInt: Integer;
        Municipality: Record "Municipality";
}