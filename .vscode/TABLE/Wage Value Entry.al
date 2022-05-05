table 50030 "Wage Value Entry"
{
    Caption = 'Wage Value Entry';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            Description = 'Primary Key';
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Description = 'Date of posting to GL';
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Description = 'Wage Header No.';
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(9; "Wage Posting Group"; Code[10])
        {
            Caption = 'Wage Posting Group';
            Description = 'From employee-defines posting accts';
        }
        field(11; "Wage Ledger Entry No."; Integer)
        {
            Caption = 'Wage Ledger Entry No.';
            Description = 'WLE Primary Key';
        }
        field(12; "Wage Header Entry No."; Integer)
        {
            Caption = 'Document Entry No.';
        }
        field(24; "User ID"; Code[50])
        {
            Caption = 'User ID';

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                //đK    LoginMgt.LookupUserID("User ID");
            end;
        }
        field(28; "Applies-to Entry"; Integer)
        {
            Caption = 'Applies-to Entry';
            Description = 'Not Used';
        }
        field(33; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            Description = 'From Employee table';
        }
        field(34; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            Description = 'From Employee table';
        }
        field(43; "Cost Amount (Actual)"; Decimal)
        {
            Caption = 'Cost Amount (Actual)';
            DecimalPlaces = 2 : 2;
        }
        field(45; "Cost Posted to G/L"; Decimal)
        {
            Caption = 'Cost Posted to G/L';
            DecimalPlaces = 2 : 2;
            Description = 'Not used - when GL posting is automated (not through journal) this should be filled in';
        }
        field(48; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            Description = 'Not used - when GL posting is automated (not through journal) this should be filled in';
        }
        field(57; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            Description = 'Not used - when GL posting is automated (not through journal) this should be filled in';
        }
        field(60; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(105; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            Description = 'Tax,Added Tax Per City,Net Wage,Contribution,Sick Leave-Company,Sick Leave-Fund,Reduction,Transport,Not Used-VAT,Meal to pay,Meal to refund';
            OptionCaption = 'Tax,Added Tax Per City,Net Wage,Contribution,Sick Leave-Company,Sick Leave-Fund,Reduction,Transport,VAT,Untaxable,Use,Taxable';
            OptionMembers = Tax,"Added Tax Per City","Net Wage",Contribution,"Sick Leave-Company","Sick Leave-Fund",Reduction,Transport,VAT,"Meal to pay","Meal to refund",Untaxable,Use,Taxable;
        }
        field(106; "Contribution Type"; Code[10])
        {
            Caption = 'Contribution Type';
        }
        field(107; "G/L Entry No. (Account)"; Integer)
        {
            Caption = 'G/L Entry No. (Account)';
            Description = 'Tax,Added Tax Per City,Net Wage,Contribution,Sick Leave-Company,Sick Leave-Fund,Reduction,Transport,Not Used-VAT,Meal to pay,Meal to refund';
        }
        field(108; "G/L Entry No. (Bal. Account)"; Integer)
        {
            Caption = 'G/L Entry No. (Bal. Account)';
            Description = 'Tax,Added Tax Per City,Net Wage,Contribution,Sick Leave-Company,Sick Leave-Fund,Reduction,Transport,Not Used-VAT,Meal to pay,Meal to refund';
        }
        field(109; "Reduction No."; Code[20])
        {
            Caption = 'Reduction No.';
            Description = 'Filled in if Entry Type is Reduction';
        }
        field(110; Status; Option)
        {
            Description = 'Not Used-Open,Posted,Paid,Posted+Paid';
            OptionCaption = 'Open,Posted,Paid,Posted+Paid';
            OptionMembers = Open,Posted,Paid,"Posted+Paid";
        }
        field(115; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            Description = 'Used for reporting-link to tax number and city tax percentage';
        }
        field(120; "AT From"; Boolean)
        {
            Description = 'Is AT entry from or over brutto';
        }
        field(121; "AT From neto"; Boolean)
        {
            Description = 'AT je iz Neta (spec porezi)';
        }
        field(125; Basis; Decimal)
        {
            Caption = 'Basis';
            Description = 'Actual basis used for calculating AT';
        }
        field(130; "Contracted Work"; Boolean)
        {
            Caption = 'Contracted Work';
        }
        field(131; "G/L Account No."; Code[10])
        {
            Caption = 'G/L Account No.';
        }
        field(132; "G/L Bal. Account No."; Code[10])
        {
            Caption = 'G/L Bal. Account No.';
        }
        field(133; "Wage Addition Type"; Code[10])
        {
            Caption = 'Wage Addition Type';
        }
        field(197; "Shortcut Dimension 4 Code"; Code[10])
        {
        }
        field(198; "Reduction Type"; Code[10])
        {
            Caption = 'Reduction Type';
        }
        field(199; "Wage Calculation Entry No."; Code[20])
        {
            Caption = 'No.';
        }
        field(200; "Wage Calculation Type"; Option)
        {
            Caption = 'Wage Calculation Type';
            OptionCaption = 'Regular,Temporary Service Contracts-Residents,Temporary Service Contracts-No Residents,Author Contracts,Additions';
            OptionMembers = Regular,"Temporary Service Contracts-Residents","Temporary Service Contracts-No Residents","Author Contracts",Additions;
        }
        field(201; Round; Integer)
        {
        }
        field(202; "Use Apportionment Account"; Boolean)
        {
            Caption = 'Use Apportionment Account';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Document No.", "Wage Header Entry No.", "Posting Date")
        {
        }
        key(Key3; "Wage Ledger Entry No.", "Entry Type", "AT From")
        {
            SumIndexFields = "Cost Amount (Actual)", "Cost Posted to G/L";
        }
        key(Key4; "Employee No.")
        {
        }
        key(Key5; "Document No.", "Posting Date")
        {
        }
        key(Key6; "Global Dimension 1 Code", "Document No.", "Entry Type")
        {
            SumIndexFields = "Cost Amount (Actual)";
        }
    }

    fieldgroups
    {
    }

    var
        GLSetup: Record "General Ledger Setup";
        DimMgt: Codeunit "DimensionManagement";
        GLSetupRead: Boolean;

    procedure GetCurrencyCode(): Code[10]
    begin
        IF NOT GLSetupRead THEN BEGIN
            GLSetup.GET;
            GLSetupRead := TRUE;
        END;
        EXIT(GLSetup."Additional Reporting Currency");
    end;
}

